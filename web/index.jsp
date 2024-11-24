<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <script src="https://kit.fontawesome.com/6dda5f6271.js"></script>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Learning with RMS</title>
        <link rel="stylesheet" href="https://unpkg.com/swiper@8.4.7/swiper-bundle.min.css" />
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
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

        main {
            width: 100%;
            max-width: 1000px;
            margin: 50px auto;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        /* Container principal */
        main {
            width: 100%;
            max-width: 1000px;
            margin: 50px auto;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        /* Estilo do carrossel */
        .swiper {
            width: 100%;
            max-width: 600px;
            height: auto;
            margin: 0 auto;
            position: relative;
            padding: 20px 0;
        }

        .swiper-slide {
            text-align: center;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .swiper-button-next,
        .swiper-button-prev {
            width: 350px;
        }

        .progress-bar-container {
            width: 100%;
            margin-top: 100px; /* Aumente esse valor para mover a barra de progresso mais para baixo */
            text-align: center;
            position: relative;
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
            <%@include file="WEB-INF/JSPF/menu.jspf"%>
        </header>
        <main>
            <h1>Selecione a matéria que deseja estudar</h1>
            <div class="swiper">
                <div class="swiper-wrapper">
                    <h2 class="swiper-slide" value="matematica">Matemática</h2>
                    <h2 class="swiper-slide" value="biologia">Biologia</h2>
                    <h2 class="swiper-slide" value="quimica">Química</h2>
                    <h2 class="swiper-slide" value="fisica">Física</h2>
                    <h2 class="swiper-slide" value="historia">História</h2>
                    <h2 class="swiper-slide" value="geografia">Geografia</h2>
                    <h2 class="swiper-slide" value="sociologia">Sociologia</h2>
                    <h2 class="swiper-slide" value="filosofia">Filosofia</h2>
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
                <div class="progress-text">Matéria selecionada: [placeholder] - 0%</div>
            </div>
        </main>
        <script src="https://unpkg.com/swiper@8/swiper-bundle.min.js"></script>
        <script>
            // Configuracao do carrossel
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
                progressText.textContent = `Matéria selecionada: [placeholder] - ${currentPercentage}%`;
                if (currentPercentage < 100) {
                    setTimeout(updateProgress, totalDuration / 100);
                }
            }
            updateProgress();
        </script>
    </body>
</html>