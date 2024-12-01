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
    // Variáveis para exibir mensagens de feedback
    String mensagemSucesso = null;
    String mensagemErro = null;

    // Obter sessão e dados do usuário logado
    String email = (String) session.getAttribute("email");

    // Variáveis para preencher o formulário
    String nomeUsuario = "";
    String senhaUsuario = "";

    // Obter dados do banco para exibir no formulário
    if (email != null) {
        try {
            nomeUsuario = DataBank.buscarAtributo("nm_usuario", "usuario", "nm_email_usuario", email);
            senhaUsuario = DataBank.buscarAtributo("nm_senha_usuario", "usuario", "nm_email_usuario", email);

            if (nomeUsuario == null || senhaUsuario == null) {
                mensagemErro = "Erro: Não foi possível recuperar os dados do usuário.";
            }
        } catch (Exception e) {
            e.printStackTrace(); // Para depuração
            mensagemErro = "Erro ao acessar o banco de dados: " + e.getMessage();
        }
    } else {
        mensagemErro = "Erro: Sessão inválida ou usuário não autenticado.";
    }

    // Atualizar perfil se o formulário for submetido
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String novoNome = request.getParameter("nome");
        String novaSenha = request.getParameter("senha");

        if (email != null && novoNome != null && novaSenha != null) {
            try {
                boolean atualizado = DataBank.atualizarUsuario(email, novoNome, novaSenha);
                if (atualizado) {
                    mensagemSucesso = "Perfil atualizado com sucesso!";
                    nomeUsuario = novoNome; // Atualiza as variáveis locais
                    senhaUsuario = novaSenha;
                } else {
                    mensagemErro = "Não foi possível atualizar o perfil.";
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
        <link rel="icon" href="images/icone.png" type="image/png">
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: Arial, sans-serif;
            }

            body {
                min-height: 100vh;
                background: linear-gradient(180deg, #FCFBFF, #D9F6FF);
            }

            main {
                width: 100%;
                max-width: 1500px;
                margin: 50px auto;
                display: flex;
                flex-direction: column;
                align-items: center;
            }
            main h4{
                font-weight: normal;
            }

            .top-divider {
                width: 95%;
                height: 3px;
                background-color: rgb(0, 17, 255);
                margin: 20px;
                border-radius: 2px;
            }

            input[name="nome"],
            input[name="senha"] {
                width: 100%;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
            }

            .disco-button,
            .save-button{
                background-color: rgb(0, 17, 255);
                color: #fff;
                border: none;
                padding: 10px 20px;
                border-radius: 5px;
                cursor: pointer;
                font-size: 16px;
            }

            .disco-button:hover,
            .save-button:hover {
                background-color: rgb(0, 13, 204);
            }
        </style>
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
                    <button class="save-button" type="submit">Salvar alterações</button>
                </form>
                <br>
                <a href="perfil.jsp?action=logout"><button class="disco-button" type="button">Desconectar da conta</button></a>
            </div>
            <%
                // Verifica se o parâmetro "action" é "logout"
                if ("logout".equals(request.getParameter("action"))) {
                    session.invalidate();
                    response.sendRedirect("index.jsp");
                }
            %>
        </main>
    </body>
</html>
