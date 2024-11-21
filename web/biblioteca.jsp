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
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Titillium Web', sans-serif;
        }

        html {
            scroll-behavior: smooth;
        }

        body {
            background-color: #fcfbff;
        }

        header {
            background-color: rgb(0, 17, 255);
            width: 100%;
            padding: 15px 4%;
            position: sticky;
            top: 0;
            z-index: 9999;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .logo img {
            max-width: 150px;
            max-height: 60px;
            width: auto;
            height: auto;
            cursor: pointer;
        }

        .menu {
            width: 100%;
            display: flex;
            justify-content: center;
            align-items: center;
            position: relative;
        }

        .menu nav {
            display: flex;
            gap: 20px;
            align-items: center;
            width: 100%;
            justify-content: center;
        }

        .menu nav a {
            display: inline-block;
            width: 40px;
            height: 40px;
            text-decoration: none;
        }

        .menu nav a img {
            width: 100%;
            height: 100%;
            object-fit: contain;
            transition: transform 0.3s ease, opacity 0.3s ease;
        }

        .menu nav a:hover img {
            transform: scale(1.1);
            opacity: 0.8;
        }

        .menu nav a:first-child {
            position: absolute;
            right: 10px;
            transform: none;
        }

        main {
            width: 100%;
            max-width: 1000px;
            margin: 50px auto;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        span {
            font-size: x-large;
            margin-bottom: 10px;
        }

        .swiper {
            width: 100%;
            max-width: 1000px;
            height: 500px;
            margin-top: -100px;
            z-index: 1;
        }

        .swiper-slide {
            text-align: center;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        img {
            box-shadow: 0 1px 2px #0003;
            width: 100%;
        }

        .library {
            text-align: center;
            margin-top: 20px;
        }

        .books-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
            margin-top: 20px;
        }

        .book-item {
            width: 200px;
            padding: 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            text-align: center;
            background-color: #fff;
        }

        .book-item img {
            width: 100%;
            height: auto;
            margin-bottom: 10px;
        }

        .book-item h2 {
            font-size: 16px;
            margin-bottom: 10px;
        }

        .book-item p {
            margin: 5px 0;
            font-size: 14px;
        }

        .book-item button {
            margin-top: 10px;
            padding: 10px 15px;
            background-color: rgb(0, 17, 255);
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .book-item button:hover {
            background-color: #0039cb;
        }
        
        @media (max-width: 450px) {
            .swiper {
                height: 270px;
            }
        }
    </style>
</head>
<body>
    <header>
        <div class="logo"><a href="index.jsp"><img src="${pageContext.request.contextPath}/images/logo.png" alt="Pagina principal"></a></div>
        <div class="menu">
            <nav>
                <a href="#perfil"><img src="${pageContext.request.contextPath}/images/perfil.png" alt="Perfil"></a>
                <a href="estatisticas.jsp"><img src="${pageContext.request.contextPath}/images/estatistica.png" alt="Estatisticas"></a>
                <a href="historico.jsp"><img src="${pageContext.request.contextPath}/images/historico.png" alt="Historico"></a>
                <a><img src="${pageContext.request.contextPath}/images/biblioteca.png" alt="Biblioteca"></a>
                <a href="avatar.jsp"><img src="${pageContext.request.contextPath}/images/avatar.png" alt="Avatar"></a>
                <a href="#loja"><img src="${pageContext.request.contextPath}/images/loja.png" alt="Loja"></a>
                <a href="#ajustes"><img src="${pageContext.request.contextPath}/images/configuracoes.png" alt="Ajustes"></a>
            </nav>
        </div>
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