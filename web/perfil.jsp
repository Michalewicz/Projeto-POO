<%-- 
    Document   : perfil
    Created on : 26 de nov. de 2024, 21:49:59
    Author     : Rafael
--%>

<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%
    // Configurações do banco de dados
    String dbUrl = "jdbc:derby://localhost:1527/POOPROJECT";
    String dbUser = "usuario";
    String dbPassword = "123";

    // Variáveis para exibir mensagens de feedback
    String mensagemSucesso = null;
    String mensagemErro = null;

    // Obter sessão e dados do usuário logado
    String email = (String) session.getAttribute("email");

    // Obter dados do banco para exibir no formulário
    String nomeUsuario = "";
    String senhaUsuario = "";

    if (email != null) {
        String query = "SELECT nm_usuario, ds_senha_usuario FROM usuario WHERE nm_email_usuario = ?";
        try (Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword); PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                nomeUsuario = rs.getString("nm_usuario");
                senhaUsuario = rs.getString("senha_usuario");
            }

            rs.close();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Atualizar perfil se o formulário for submetido
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String novoNome = request.getParameter("nome");
        String novaSenha = request.getParameter("senha");

        if (email != null && novoNome != null && novaSenha != null) {
            try (Connection conexao = DriverManager.getConnection(dbUrl, dbUser, dbPassword)) {
                String sql = "UPDATE usuario SET nm_usuario = ?, senha_usuario = ? WHERE nm_email_usuario = ?";
                PreparedStatement ps = conexao.prepareStatement(sql);
                ps.setString(1, novoNome);
                ps.setString(2, novaSenha);
                ps.setString(3, email);
                int linhasAfetadas = ps.executeUpdate();

                if (linhasAfetadas > 0) {
                    mensagemSucesso = "Perfil atualizado com sucesso!";
                    nomeUsuario = novoNome; // Atualizar as variáveis exibidas no formulário
                    senhaUsuario = novaSenha;
                } else {
                    mensagemErro = "Não foi possível atualizar o perfil.";
                }

                ps.close();
            } catch (SQLException e) {
                e.printStackTrace();
                mensagemErro = "Erro ao atualizar o perfil.";
            }
        } else {
            mensagemErro = "Preencha todos os campos.";
        }
    }
%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Perfil | Learning with RMS</title>
    <link rel="stylesheet" type="text/css" href="CSS/estilos.css"/>
</head>
<body>
    <header>
        <%@include file="WEB-INF/JSPF/menu.jspf"%>
    </header>
    <main>
        <h2>Meu Perfil</h2>
        <% if (mensagemSucesso != null) { %>
            <p class="mensagem"><%= mensagemSucesso %></p>
        <% } %>
        <% if (mensagemErro != null) { %>
            <p class="erro"><%= mensagemErro %></p>
        <% } %>
        <form class="prof-form" method="post">
            <label for="nome">Nome:</label>
            <input type="text" id="nome" name="nome" value="<%= nomeUsuario %>" placeholder="Nome" required>
            <br><br>
            <label for="senha">Senha:</label>
            <input type="password" id="senha" name="senha" value="<%= senhaUsuario %>" placeholder="Senha" required>
            <br><br>
            <button class="save-button" type="submit">Salvar alterações</button>
            <br>
        </form>
            <br>
            <a href="index.jsp"><button class="disco-button">Desconectar da conta<%session.setAttribute("email", null);%></button></a>
    </main>
</body>
</html>
