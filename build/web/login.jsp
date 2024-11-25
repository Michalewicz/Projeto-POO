<%-- 
    Document   : login
    Created on : 23 de nov. de 2024, 17:11:45
    Author     : Rafael
--%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="Learning_POO_DB.DataBank" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Learning with RMS</title>
    <link rel="stylesheet" type="text/css" href="CSS/estilos.css"/>
        <style>

    </style>
</head>
<body>
    <header>
            <%@include file="WEB-INF/JSPF/menu.jspf"%>
    </header>
    <main>
    <h2>Entrar com sua conta</h2>
    <form class="login-form" method="POST">
        <label>Email:</label>
        <input type="text" name="email" required />
        <br><br>
        <label>Senha:</label>
        <input type="password" name="senha" required />
        <br><br>
        <input type="submit" value="Entrar"/>
    </form>
    <a title="Registrar" href="registro.jsp">N�o t�m uma conta? Clique aqui para registrar</a>
    <% 
        String email = request.getParameter("email");
        String senha = request.getParameter("senha");
        String mensagemErro = null;

        if (email != null && senha != null) {
            if (DataBank.verificarCredenciais(email, senha)) {
                response.sendRedirect("index.jsp");
            } else {
                mensagemErro = "Email ou senha inv�lidos. Por favor, tente novamente.";
            }
        }

        if (mensagemErro != null) {
    %>
        <p class="error-message" style="color: red;"><%= mensagemErro %></p>
    <% 
        }
    %>
    </main>
</body>
</html>