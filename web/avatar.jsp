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

        .avatar-customization {
            text-align: center;
            margin-top: 20px;
        }

        .points-container {
            margin: 20px 0;
            font-size: 16px;
            color: #333;
        }

        .avatar-preview {
            margin: 20px 0;
        }

        .avatar-preview img {
            width: 200px;
            height: 200px;
            border-radius: 10px;
            border: 2px solid #ddd;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .items-container {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 20px;
            margin: 20px 0;
        }

        .item {
            width: 150px;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            text-align: center;
            background-color: #fff;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .item img {
            width: 100px;
            height: 100px;
            margin-bottom: 10px;
        }

        .item p {
            margin: 5px 0;
            font-size: 14px;
        }

        .item button {
            padding: 8px 12px;
            background-color: rgb(0, 17, 255);
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .item button:hover {
            background-color: #0039cb;
        }

        .additional-options {
            margin-top: 30px;
            text-align: left;
            display: inline-block;
        }

        .additional-options ul {
            list-style: none;
            padding: 0;
        }

        .additional-options li {
            margin: 10px 0;
            font-size: 14px;
        }

        .additional-options button {
            padding: 10px 20px;
            background-color: rgb(0, 17, 255);
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .additional-options button:hover {
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
                <a href="biblioteca.jsp"><img src="${pageContext.request.contextPath}/images/biblioteca.png" alt="Biblioteca"></a>
                <a><img src="${pageContext.request.contextPath}/images/avatar.png" alt="Avatar"></a>
                <a href="#loja"><img src="${pageContext.request.contextPath}/images/loja.png" alt="Loja"></a>
                <a href="#ajustes"><img src="${pageContext.request.contextPath}/images/configuracoes.png" alt="Ajustes"></a>
            </nav>
        </div>
    </header>

<main>
    <section class="avatar-customization">
        <h1>Customização de Avatar</h1>
        <p>Personalize seu avatar 2D com acessórios incríveis e únicos!</p>

        <!-- Pontos do usuário -->
        <div class="points-container">
            <p><strong>Pontos disponíveis:</strong> 1200</p>
        </div>

        <!-- Prévia do Avatar -->
        <div class="avatar-preview">
            <h2>Prévia do Avatar</h2>
            <img src="${pageContext.request.contextPath}/images/avatar_placeholder.png" alt="Prévia do Avatar">
        </div>

        <!-- Itens Disponíveis -->
        <div class="items-container">
            <h2>Itens Disponíveis</h2>
            <div class="item">
                <img src="${pageContext.request.contextPath}/images/item_placeholder_1.png" alt="Item 1">
                <p><strong>Nome:</strong> Chapéu Colorido</p>
                <p><strong>Custo:</strong> 300 pontos</p>
                <button>Equipar</button>
            </div>
            <div class="item">
                <img src="${pageContext.request.contextPath}/images/item_placeholder_2.png" alt="Item 2">
                <p><strong>Nome:</strong> Óculos Moderno</p>
                <p><strong>Custo:</strong> 200 pontos</p>
                <button>Equipar</button>
            </div>
            <div class="item">
                <img src="${pageContext.request.contextPath}/images/item_placeholder_3.png" alt="Item 3">
                <p><strong>Nome:</strong> Camiseta Descolada</p>
                <p><strong>Custo:</strong> 500 pontos</p>
                <button>Equipar</button>
            </div>
        </div>

        <!-- Opções adicionais -->
        <div class="additional-options">
            <h2>Opções Adicionais</h2>
            <ul>
                <li>Alterar cor do fundo do avatar</li>
                <li>Escolher entre diferentes expressões faciais</li>
                <li>Salvar avatar personalizado</li>
            </ul>
            <button>Salvar Avatar</button>
        </div>
    </section>
</body>
</html>