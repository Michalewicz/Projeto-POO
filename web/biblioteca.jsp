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
                <img src="${pageContext.request.contextPath}/images/book_placeholder_1.png" alt="Livro 1">
                <h2>Título do Livro 1</h2>
                <p>Autor: Autor Placeholder</p>
                <p>Preço: R$ 29,90</p>
                <button>Comprar</button>
            </div>
            <%}%>
        </div>
    </section>
</main>
</body>
</html>