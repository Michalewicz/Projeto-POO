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
                max-width: 1500px;
                margin: 50px auto;
                display: flex;
                flex-direction: column;
                align-items: center;
            }

            .top-grid{
                display: flex;
                flex-wrap: wrap;
                justify-content: center;
                gap: 20px;
                margin-top: 20px;
            }

            .top-grid img{
                transform: translate(-23%, -21%);
            }

            .site-description {
                flex: 1;
                padding: 10px;
                border: 1px solid #0011FF;
                border-radius: 5px;
                transform: translate(-30%, -10%);
            }

            .site-description h1 {
                color: #0011FF;
                margin-bottom: 10px;
                text-align: center;
            }

            /* Estilo do carrossel */
            .swiper {
                width: 100%;
                max-width: 250px;
                height: auto;
                margin: 0 auto;
                padding: 20px 0;
                user-select: text;
            }

            .swiper-slide {
                text-align: center;
                display: flex;
                align-items: center;
                justify-content: center;
                font-weight: normal;
                font-size: 25px;
            }

            .swiper-button-next,
            .swiper-button-prev{
                transform: translateY(-50%);
            }

            .swiper-pagination {
                transform: translateY(-280%);
            }

            .swiper-sub{
                padding: 10px 20px;
                font-size: 16px;
                cursor: pointer;
                background-color: rgb(0, 17, 255);
                border: none;
                color: #fff;
                border-radius: 5px;
                transform: translateY(40%);
            }

            .swiper-sub:hover {
                background-color: rgb(0, 13, 204);
            }

            input[type="radio"] {
                display: none;
                cursor: pointer;
            }

            input[type="radio"]:checked {
                color: #fff;
            }

            /* Estilo da barra de progresso */
            .progress-bar-container {
                width: 50%;
                margin-top: 20px;
                text-align: center;
            }

            .progress-bar {
                width: 100%;
                height: 20px;
                background-color: #e0e0e0;
                border-radius: 10px;
                overflow: hidden;
                position: relative;
            }

            .progress-bar .progress {
                height: 100%;
                background-color: rgb(0, 17, 255);
                width: <%= "0"%>%;
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
            <div class="top-grid">
                <div>
                    <img src="${pageContext.request.contextPath}/images/padrao.png">
                </div>
                <div class="site-description">
                    <h1>Bem-vindo ao Learning with RMS!</h1>
                    <p>Aqui, você pode focar totalmente em seus estudos, com a ajuda da nossa Inteligência Artificial integrada! Começe no nível básico, e avance cada vez mais até 
                        atingir o nível máximo! Crie uma conta para armazenar seus dados, explore a vasta gama de livros disponiveis em nossa biblioteca, acompanhe suas estatísticas, 
                        e muito mais!</p>
                </div>
            </div>
            <h2>Antes de mais nada, selecione a matéria que deseja estudar</h2>
            <!-- Para ver o "prototipo de logica" funcinando, retire a linha 186 e descomente a linha de baixo. Lembrando que: clicar no botao nao vai mandar a variavel do texto; primeiro clique no texto, e so depois no botao
            <form action="tarefaIA.jsp" class="swiper" method="GET">-->
            <form  class="swiper" method="GET">
                <div name="materias" class="swiper-wrapper">
                    <label class="swiper-slide">
                        <input type="radio" name="materias" value="matematica" required> Matemática
                    </label>
                    <label class="swiper-slide">
                        <input type="radio" name="materias" value="biologia" required> Biologia
                    </label>
                    <label class="swiper-slide">
                        <input type="radio" name="materias" value="quimica" required> Química
                    </label>
                    <label class="swiper-slide">
                        <input type="radio" name="materias" value="fisica" required> Física
                    </label>
                    <label class="swiper-slide">
                        <input type="radio" name="materias" value="historia" required> História
                    </label>
                    <label class="swiper-slide">
                        <input type="radio" name="materias" value="geografia" required> Geografia
                    </label>
                    <label class="swiper-slide">
                        <input type="radio" name="materias" value="sociologia" required> Sociologia
                    </label>
                    <label class="swiper-slide">
                        <input type="radio" name="materias" value="filosofia" required> Filosofia
                    </label>
                </div>
                <input type="hidden" name="dificuldade" value="muito fácil">
                <div class="swiper-button-next"></div>
                <div class="swiper-button-prev"></div>
                <div class="swiper-pagination"></div>
                <div style="margin-top: 20px; text-align: center;">
                    <button class="swiper-sub" type="submit" name="enviar" value="Enviar">
                        Enviar Seleção
                    </button>
                </div>
            </form>
            <!-- Barra de progresso -->
            <div class="progress-bar-container">
                <div class="progress-bar">
                    <div class="progress"></div>
                </div>
                <div class="progress-text">Sua progressão em <%="placeholder"%>: <%="0"%>%</div>
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