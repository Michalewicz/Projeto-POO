<%-- 
    Document   : index
    Created on : 15 de nov. de 2024, 16:01:35
    Author     : Rafael, Miguel e Sandro
--%>

<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
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

        /* Estilo do carrossel */
        .swiper {
            width: 100%;
            max-width: 600px;
            height: auto;
            margin: 0 auto;
            padding: 20px 0;
            transform: translateY(50%);
        }

        .swiper-slide {
            text-align: center;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: normal;
        }

        .swiper-button-next,
        .swiper-button-prev {
            width: 350px;
        }
        
        .swiper-pagination {
            transform: translateY(70%);
        }
        
        /* Estilo da barra de progresso */
        .progress-bar-container {
            width: 100%;
            margin-top: 20px;
            text-align: center;
            transform: translateY(150%);
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
            width: <%= "0" %>%;
            transition: width 0.1s ease-in-out;
        }

        .progress-text {
            margin-top: 10px;
            font-size: 16px;
            color: #333;
        }
        
        .desc {
            display: flex;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            width: 100%;
            transform: translateY(300%);
        }
    </style>
    </head>
    <body>
        <header>
            <%@include file="WEB-INF/JSPF/menu.jspf"%>
        </header>
        <main>
            <h1>Selecione a mat�ria que deseja estudar</h1>
            <div class="swiper">
                <div class="swiper-wrapper">
                    <h2 class="swiper-slide" value="matematica">Matem�tica</h2>
                    <h2 class="swiper-slide" value="biologia">Biologia</h2>
                    <h2 class="swiper-slide" value="quimica">Qu�mica</h2>
                    <h2 class="swiper-slide" value="fisica">F�sica</h2>
                    <h2 class="swiper-slide" value="historia">Hist�ria</h2>
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
                <div class="progress-text">Mat�ria selecionada: <%="placeholder"%> - <%="placeholder"%>%</div>
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
        </script>
    </body>
</html>