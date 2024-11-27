<%-- 
    Document   : biblioteca
    Created on : 15 de nov. de 2024, 16:01:35
    Author     : Rafael, Miguel e Sandro
--%>

<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <script src="https://kit.fontawesome.com/6dda5f6271.js" crossorigin="anonymous"></script>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Learning with RMS</title>
    <link rel="stylesheet" type="text/css" href="CSS/estilos.css"/>
</head>
<body>
    <header>
        <%@include file="WEB-INF/JSPF/menu.jspf"%>
    </header>

<main>
    <section class="library">
        <h1>Biblioteca</h1>
        <p>Explore uma variedade de livros e encontre seu próximo aprendizado!</p>

        <div class="books-container">
            <%for(int i = 0; i<12;i++){%>
            <div class="book-item">
                <img src="${pageContext.request.contextPath}/images/livro_placeholder.png" alt="Livro 1">
                <h2>Física 1: Mecânica</h2>
                <p>Autor: Gref</p>
                <p>Preço: R$ 40,00</p>
                <a href="https://www.amazon.com.br/F%C3%ADsica-1-Mec%C3%A2nica-V%C3%A1rios-Autores/dp/8531400147" target="_blank"><button>Comprar</button></a>
            </div>
            <%}%>
        </div>
    </section>
</main>
</body>
</html>