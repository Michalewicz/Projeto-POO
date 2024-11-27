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
        try (Connection conexao = DriverManager.getConnection(dbUrl, dbUser, dbPassword)) {
            String sql = "SELECT nm_usuario, ds_senha_usuario FROM usuario WHERE nm_email_usuario = ?";
            PreparedStatement ps = conexao.prepareStatement(sql);
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
            mensagemErro = "Erro ao carregar dados do perfil.";
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
    <title>Perfil do Usuário</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #fcfbff;
        }
        .container {
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            background-color: white;
            border: 1px solid #ccc;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        h1 {
            text-align: center;
            color: rgb(0, 17, 255);
        }
        .mensagem {
            text-align: center;
            margin-bottom: 20px;
            color: green;
        }
        .erro {
            text-align: center;
            margin-bottom: 20px;
            color: red;
        }
        form {
            display: flex;
            flex-direction: column;
        }
        label {
            margin: 10px 0 5px;
            font-weight: bold;
        }
        input {
            padding: 10px;
            font-size: 16px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        button {
            background-color: rgb(0, 17, 255);
            color: white;
            padding: 10px;
            font-size: 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        button:hover {
            background-color: #0000cc;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Meu Perfil</h1>
        <% if (mensagemSucesso != null) { %>
            <p class="mensagem"><%= mensagemSucesso %></p>
        <% } %>
        <% if (mensagemErro != null) { %>
            <p class="erro"><%= mensagemErro %></p>
        <% } %>
        <form method="post">
            <label for="nome">Nome:</label>
            <input type="text" id="nome" name="nome" value="<%= nomeUsuario %>" required>

            <label for="senha">Senha:</label>
            <input type="password" id="senha" name="senha" value="<%= senhaUsuario %>" required>

            <button type="submit">Salvar Alterações</button>
        </form>
    </div>
</body>
</html>
