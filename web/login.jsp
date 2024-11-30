<%-- 
    Document   : perfil
    Created on : 23 de nov. de 2024, 17:11:45
    Author     : Rafael
--%>

<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@ page import="Learning_POO_DB.DataBank" %>
<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <title>Log-in | Learning with RMS</title>
        <link rel="stylesheet" type="text/css" href="CSS/estilos.css"/>
    </head>
    <body>
        <header>
            <%@include file="WEB-INF/JSPF/menu.jspf"%>
        </header>
        <main>
            <h2>Entrar com sua conta</h2>
            <form method="POST">
                <label>Email:</label>
                <input type="text" name="email" placeholder="E-mail" required />
                <br><br>
                <label>Senha:</label>
                <input type="password" name="senha" placeholder="Senha" required />
                <br><br>
                <input type="submit" value="Entrar"/>
            </form>
            <a title="Registrar" href="registro.jsp">Não têm uma conta? Clique aqui para registrar</a>
            <%
                String email = request.getParameter("email");
                String senha = request.getParameter("senha");
                String mensagemErro = null;
                boolean loginSucesso = false;

                if (email != null && senha != null) {
                    if (DataBank.verificarCredenciais(email, senha)) {
                        session.setAttribute("email", email);
                        session.setAttribute("loginSucesso", true);
                        response.sendRedirect("index.jsp");
                        return;
                    } else {
                        session.setAttribute("loginSucesso", false);
                        mensagemErro = "Email ou senha inválidos. Por favor, tente novamente.";
                    }
                }

                if (mensagemErro != null) {
            %>
            <p class="error-message" style="color: red;"><%= mensagemErro%></p>
            <%
                }
            %>
        </main>
    </body>
</html>