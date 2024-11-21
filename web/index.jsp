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

        @media (max-width: 450px) {
            .swiper {
                height: 270px;
            }
        }

        /* Estilo da barra de progresso */
        .progress-bar-container {
            width: 100%;
            margin-top: 20px;
            text-align: center;
            position: relative;
        }

        .progress-bar {
            width: 100%;
            height: 10px;
            background-color: #e0e0e0;
            border-radius: 5px;
            overflow: hidden;
            position: relative;
        }

        .progress-bar .progress {
            height: 100%;
            background-color: rgb(0, 17, 255);
            width: 0%;
            transition: width 0.1s ease-in-out;
        }

        .progress-text {
            margin-top: 10px;
            font-size: 16px;
            color: #333;
        }
    </style>
</head>
<body>
    <header>
        <div class="logo"><img src="${pageContext.request.contextPath}/images/logo.png" alt="Pagina principal"></div>
        <div class="menu">
            <nav>
                <a href="#perfil"><img src="${pageContext.request.contextPath}/images/perfil.png" alt="Perfil"></a>
                <a href="estatisticas.jsp"><img src="${pageContext.request.contextPath}/images/estatistica.png" alt="Estatisticas"></a>
                <a href="historico.jsp"><img src="${pageContext.request.contextPath}/images/historico.png" alt="Historico"></a>
                <a href="biblioteca.jsp"><img src="${pageContext.request.contextPath}/images/biblioteca.png" alt="Biblioteca"></a>
                <a href="avatar.jsp"><img src="${pageContext.request.contextPath}/images/avatar.png" alt="Avatar"></a>
                <a href="#loja"><img src="${pageContext.request.contextPath}/images/loja.png" alt="Loja"></a>
                <a href="#ajustes"><img src="${pageContext.request.contextPath}/images/configuracoes.png" alt="Ajustes"></a>
            </nav>
        </div>
    </header>

    <main>
        <div class="swiper">
            <div class="swiper-wrapper">
                <div class="swiper-slide"><img src="${pageContext.request.contextPath}/images/foto_01.png" alt="Foto 01"></div>
                <div class="swiper-slide"><img src="${pageContext.request.contextPath}/images/foto_02.png" alt="Foto 02"></div>
                <div class="swiper-slide"><img src="${pageContext.request.contextPath}/images/foto_03.png" alt="Foto 03"></div>
            </div>
            <div class="swiper-button-next"></div>
            <div class="swiper-button-prev"></div>
            <div class="swiper-pagination"></div>
        </div>

        <!-- Barra de progresso -->
        <div class="progress-bar-container">
            <div class="progress-bar">
                <div class="progress"></div>
            </div>
            <div class="progress-text">¡rea selecionada: [placeholder] - 0%</div>
        </div>
    </main>

    <script src="https://unpkg.com/swiper@8/swiper-bundle.min.js"></script>
    <script>
        // Configura√ß√£o do carrossel
        var swiper = new Swiper(".swiper", {
            cssMode: true,
            loop: true,
            navigation: {
                nextEl: ".swiper-button-next",
                prevEl: ".swiper-button-prev"
            },
            pagination: {
                el: ".swiper-pagination"
            },
            keyboard: true
        });

        // Animacao da barra de progresso
        const progressElement = document.querySelector(".progress");
        const progressText = document.querySelector(".progress-text");
        const totalDuration = 5000; // Duracao total em milissegundos
        let currentPercentage = 0;

        function updateProgress() {
            currentPercentage += 1;
            progressElement.style.width = `${currentPercentage}%`;
            progressText.textContent = `¡rea selecionada: [placeholder] - ${currentPercentage}%`;
            if (currentPercentage < 100) {
                setTimeout(updateProgress, totalDuration / 100);
            }
        }

        // Inicia a barra de progresso
        updateProgress();
    </script>
</body>
</html>
