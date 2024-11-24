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
