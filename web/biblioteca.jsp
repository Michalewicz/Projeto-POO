<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <script src="https://kit.fontawesome.com/6dda5f6271.js" crossorigin="anonymous"></script>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Learning with RMS</title>
    <link rel="stylesheet" href="https://unpkg.com/swiper@8/swiper-bundle.min.css" />
    <link rel="stylesheet" href="estilos.css"/>
</head>
<body>
    <header>
        <%@include file="WEB-INF/jspf/menu.jspf"%>
    </header>

<main>
    <section class="library">
        <h1>Biblioteca</h1>
        <p>Explore uma variedade de livros e encontre seu próximo aprendizado!</p>

        <div class="books-container">
            <div class="book-item">
                <img src="${pageContext.request.contextPath}/images/book_placeholder_1.png" alt="Livro 1">
                <h2>Título do Livro 1</h2>
                <p>Autor: Autor Placeholder</p>
                <p>Preço: R$ 29,90</p>
                <button>Comprar</button>
            </div>
            <div class="book-item">
                <img src="${pageContext.request.contextPath}/images/book_placeholder_2.png" alt="Livro 2">
                <h2>Título do Livro 2</h2>
                <p>Autor: Autor Placeholder</p>
                <p>Preço: R$ 39,90</p>
                <button>Comprar</button>
            </div>
            <div class="book-item">
                <img src="${pageContext.request.contextPath}/images/book_placeholder_3.png" alt="Livro 3">
                <h2>Título do Livro 3</h2>
                <p>Autor: Autor Placeholder</p>
                <p>Preço: R$ 49,90</p>
                <button>Comprar</button>
            </div>
        </div>
    </section>
</main>
</body>
</html>