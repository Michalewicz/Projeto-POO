<%-- 
    Document   : biblioteca
    Created on : 15 de nov. de 2024, 16:01:35
    Author     : Rafael, Miguel e Sandro
--%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    session.setAttribute("contagem", null);
    session.setAttribute("acerto", null);
%>
<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Biblioteca | Learning with RMS</title>
        <link rel="stylesheet" type="text/css" href="CSS/estilos_gerais.css"/>
        <link rel="stylesheet" type="text/css" href="CSS/estilos_biblioteca.css"/>
        <link rel="icon" href="images/icone.png" type="image/png">
    </head>
    <body>
        <header>
            <%@include file="WEB-INF/JSPF/menu.jspf"%>
        </header>
        <main>
            <h1>Biblioteca</h1>
            <%// Recupera o email do usuário
                String emailUsuario = (String) session.getAttribute("email");
                if (emailUsuario != null) {%>
            <p>Explore uma variedade de livros e encontre seu próximo aprendizado!</p>
            <div class="top-divider"></div>
            <div class="books-container">
                <%for (int i = 0; i < 12; i++) {%>
                <div class="book-item">
                    <a href="https://www.amazon.com.br/F%C3%ADsica-1-Mec%C3%A2nica-V%C3%A1rios-Autores/dp/8531400147" target="_blank">
                        <img src="${pageContext.request.contextPath}/images/livro_placeholder.png" alt="Livro 1">
                    </a>
                    <h2>Fí­sica 1: Mecânica</h2>
                    <p>Autor: Gref</p>
                    <p>Preço: R$ 40,00</p>
                    <a href="https://www.amazon.com.br/F%C3%ADsica-1-Mec%C3%A2nica-V%C3%A1rios-Autores/dp/8531400147" target="_blank"><button>Comprar</button></a>
                </div>
                <%}%>
                <%} else {%>
                <label>Por favor! Se <a href="registro.jsp">cadastre-se</a> ou <a href="login.jsp">logue</a> aqui para que assim possa ver os livros disponíveis!</label>
                <%}%>
            </div>
        </main>
    </body>
</html>
