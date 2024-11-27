<%-- 
    Document   : registro
    Created on : 23 de nov. de 2024, 17:11:45
    Author     : Rafael
--%>

<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@ page import="Learning_POO_DB.DataBank" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Registro | Learning with RMS</title>
    <link rel="stylesheet" type="text/css" href="CSS/estilos.css"/>
</head>
<body>
    <header>
        <%@include file="WEB-INF/JSPF/menu.jspf"%>
    </header>
    <main>
    <h2>Registro de Usuário</h2>
    <form class="reg-form" method="POST">
        <label>Email:</label>
        <input type="email" name="email" placeholder="E-mail" required />
        <br><br>
        <label>Nome:</label>
        <input type="text" name="nome" placeholder="Nome" required />
        <br><br>
        <label>Senha:</label>
        <input type="password" name="senha" placeholder="Senha" required />
        <br><br>
        <input type="submit" value="Registrar" />
    </form>
    <a href="login.jsp">Já têm uma conta? Clique aqui para entrar</a>
    <% 
        String email = request.getParameter("email");
        String nome = request.getParameter("nome");
        String senha = request.getParameter("senha");
        String mensagem = null;

        if (email != null && nome != null && senha != null) {
            if (DataBank.registrarUsuario(email, nome, senha)) {
                response.sendRedirect("login.jsp");
            } else {
                mensagem = "Falha ao registrar o usuário. Por favor, tente novamente.";
            }
        }

        if (mensagem != null) {
    %>
        <p style="<%= mensagem.contains("sucesso") ? "color: green;" : "color: red;" %>"><%= mensagem %></p>
    <% 
        }
    %>
    </main>
</body>
</html>
