<%-- 
    Document   : perfil
    Created on : 26 de nov. de 2024, 21:49:59
    Author     : Rafael
--%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@ page import="Learning_POO_DB.DataBank" %>
<%
    session.setAttribute("contagem", null);
    session.setAttribute("acerto", null);
    // Vari�veis para exibir mensagens de feedback
    String mensagemSucesso = null;
    String mensagemErro = null;

    // Obter sess�o e dados do usu�rio logado
    String email = (String) session.getAttribute("email");

    // Vari�veis para preencher o formul�rio
    String nomeUsuario = "";
    String senhaUsuario = "";

    // Obter dados do banco para exibir no formul�rio
    if (email != null) {
        try {
            nomeUsuario = DataBank.buscarAtributo("nm_usuario", "usuario", "nm_email_usuario", email);
            senhaUsuario = DataBank.buscarAtributo("nm_senha_usuario", "usuario", "nm_email_usuario", email);

            if (nomeUsuario == null || senhaUsuario == null) {
                mensagemErro = "Erro: N�o foi poss�vel recuperar os dados do usu�rio.";
            }
        } catch (Exception e) {
            e.printStackTrace(); // Para depura��o
            mensagemErro = "Erro ao acessar o banco de dados: " + e.getMessage();
        }
    } else {
        mensagemErro = "Erro: Sess�o inv�lida ou usu�rio n�o autenticado.";
    }

    // Atualizar perfil se o formul�rio for submetido
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String novoNome = request.getParameter("nome");
        String novaSenha = request.getParameter("senha");

        if (email != null && novoNome != null && novaSenha != null) {
            try {
                boolean atualizado = DataBank.atualizarUsuario(email, novoNome, novaSenha);
                if (atualizado) {
                    mensagemSucesso = "Perfil atualizado com sucesso!";
                    nomeUsuario = novoNome; // Atualiza as vari�veis locais
                    senhaUsuario = novaSenha;
                } else {
                    mensagemErro = "N�o foi poss�vel atualizar o perfil.";
                }
            } catch (Exception e) {
                e.printStackTrace();
                mensagemErro = "Erro ao atualizar o perfil: " + e.getMessage();
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
        <link rel="stylesheet" type="text/css" href="CSS/estilos_gerais.css"/>
        <link rel="stylesheet" type="text/css" href="CSS/estilos_perfil.css"/>
        <link rel="icon" href="images/icone.png" type="image/png">
    </head>
    <body>
        <header>
            <%@include file="WEB-INF/JSPF/menu.jspf"%>
        </header>
        <main>
            <h2>Meu Perfil</h2>
            <h4>E-mail: <%= email%></h4>
            <h4>Nome: <%= nomeUsuario%></h4>
            <div class="top-divider"></div>
            <% if (mensagemSucesso != null) {%>
            <p class="mensagem"><%= mensagemSucesso%></p>
            <% } %>
            <% if (mensagemErro != null) {%>
            <p class="erro"><%= mensagemErro%></p>
            <% } %>
            <br>
            <h3>Alterar dados</h3>
            <div class="profile-grid">
                <form method="post">
                    <label for="nome">Nome:</label>
                    <input type="text" id="nome" name="nome" placeholder="Nome" required>
                    <br><br>
                    <label for="senha">Senha:</label>
                    <input type="password" id="senha" name="senha" placeholder="Senha" required>
                    <br><br>
                    <button class="save-button" type="submit">Salvar altera��es</button>
                </form>
                <br>
                <a href="perfil.jsp?action=logout"><button class="disco-button" type="button">Desconectar da conta</button></a>
            </div>
            <%
                // Verifica se o par�metro "action" � "logout"
                if ("logout".equals(request.getParameter("action"))) {
                    session.invalidate();
                    response.sendRedirect("index.jsp");
                }
            %>
        </main>
    </body>
</html>
