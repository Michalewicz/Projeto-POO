<%-- 
    Document   : registro
    Created on : 23 de nov. de 2024, 17:11:45
    Author     : Rafael
--%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="Learning_POO_DB.DataBank" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Login</title>
</head>
<body>
    <h2>Login</h2>
    <form method="POST">
        <label>Email:</label>
        <input type="text" name="email" required />
        <br><br>
        <label>Senha:</label>
        <input type="password" name="senha" required />
        <br><br>
        <input type="submit" value="Entrar" />
    </form>
    <a href="index.jsp">Voltar</a>
    <% 
        String email = request.getParameter("email");
        String senha = request.getParameter("senha");
        String mensagemErro = null;

        if (email != null && senha != null) {
            if (DataBank.verificarCredenciais(email, senha)) {
                response.sendRedirect("index.jsp");
            } else {
                mensagemErro = "Email ou senha inválidos. Por favor, tente novamente.";
            }
        }

        if (mensagemErro != null) {
    %>
        <p style="color: red;"><%= mensagemErro %></p>
    <% 
        }
    %>
</body>
</html>