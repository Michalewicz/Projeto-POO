<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Learning with RMS</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }
        body {
            background-color: #ffffff;
            color: #000;
            font-size: 16px;
            line-height: 1.6;
        }
        header {
            background: #0011FF;
            width: 100%;
            padding: 10px 4%;
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
        }
        .menu nav {
            display: flex;
            gap: 20px;
            align-items: center;
            width: 100%;
            justify-content: center;
        }
        .menu nav a img {
            width: 40px;
            height: 40px;
            object-fit: contain;
            border-radius: 50%;
        }
        main {
            padding: 10px 20px;
            max-width: 800px;
            margin: 0 auto;
            padding-top: 0;
        }
        .carousel-container {
            display: flex;
            justify-content: center;
            align-items: center;
            position: relative;
        }
        .carousel {
            display: flex;
            gap: 10px;
            overflow-x: auto;
            width: 100%;
            max-width: 100%;
            border-radius: 10px;
            border: 2px solid #0011FF;
        }
        .carousel .item {
            width: calc(33.33% - 10px);
            height: 100px;
            display: flex;
            justify-content: center;
            align-items: center;
            border-radius: 5px;
            border: 2px solid #0011FF;
            cursor: pointer;
            transition: transform 0.3s ease, opacity 0.3s ease;
            font-size: 20px;
            font-weight: bold;
            color: #0011FF;
        }
        .carousel .item:hover {
            transform: scale(1.05);
            opacity: 0.8;
        }
        .carousel-button {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            background: #0011FF;
            color: white;
            border: none;
            border-radius: 50%;
            cursor: pointer;
            font-size: 18px;
            width: 40px;
            height: 40px;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .carousel-button.left {
            left: 10px;
        }
        .carousel-button.right {
            right: 10px;
        }
        .load-more {
            margin-top: 20px;
            padding: 10px 20px;
            background: #0011FF;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }
        .load-more:hover {
            background: #0033FF;
        }
        .options, .list-area, .difficulty-options, .dialogue {
            display: none;
            margin-top: 20px;
            padding: 10px;
            border: 1px solid #0011FF;
            border-radius: 5px;
            background: #f9f9f9;
        }
        .options button, .list-area textarea, .difficulty-options button {
            display: block;
            width: 100%;
            margin: 10px 0;
        }
        .options button {
            padding: 10px;
            background: #0011FF;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .options button:hover {
            background: #0033FF;
        }
        .difficulty-options button {
            padding: 10px;
            background: #0011FF;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .difficulty-options button:hover {
            background: #0033FF;
        }
        .list-area textarea {
            padding: 10px;
            border: 1px solid #0011FF;
            border-radius: 5px;
            font-size: 16px;
        }

        /* Caixa de Diálogo */
        .dialogue-box {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0, 0, 0, 0.5);
            justify-content: center;
            align-items: center;
        }
        .dialogue-box-content {
            background: white;
            padding: 20px;
            border-radius: 10px;
            text-align: center;
            width: 400px;
        }
        .dialogue-box-content h2 {
            margin-bottom: 10px;
            font-size: 24px;
        }
        .dialogue-box-content textarea {
            width: 100%;
            height: 150px;
            padding: 10px;
            border: 1px solid #0011FF;
            border-radius: 5px;
            font-size: 16px;
        }
        .dialogue-box-content button {
            margin-top: 10px;
            padding: 10px 20px;
            background: #0011FF;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .dialogue-box-content button:hover {
            background: #0033FF;
        }

        .activity-area {
            display: none;
            margin-top: 20px;
            padding: 20px;
            background: #f0f0f0;
            border-radius: 8px;
            border: 2px solid #0011FF;
        }
        .activity-area h3 {
            font-size: 22px;
            margin-bottom: 15px;
        }
        .activity-area .question {
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <header>
        <div class="logo">
            <!-- Caminho da imagem do logo sendo passado dinamicamente -->
            <img src="<%= request.getAttribute("logoImagePath") != null ? request.getAttribute("logoImagePath").toString() : "default_logo.png" %>" alt="Página Principal">
        </div>
        <div class="menu">
            <nav>
                <a href="#perfil"><img src="<%= request.getAttribute("perfilImagePath") != null ? request.getAttribute("perfilImagePath").toString() : "default_perfil.png" %>" alt="Perfil"></a>
                <a href="#estatisticas"><img src="<%= request.getAttribute("estatisticaImagePath") != null ? request.getAttribute("estatisticaImagePath").toString() : "default_estatistica.png" %>" alt="Estatísticas"></a>
                <a href="#historico"><img src="<%= request.getAttribute("historicoImagePath") != null ? request.getAttribute("historicoImagePath").toString() : "default_historico.png" %>" alt="Histórico"></a>
                <a href="#biblioteca"><img src="<%= request.getAttribute("bibliotecaImagePath") != null ? request.getAttribute("bibliotecaImagePath").toString() : "default_biblioteca.png" %>" alt="Biblioteca"></a>
                <a href="#avatar"><img src="<%= request.getAttribute("avatarImagePath") != null ? request.getAttribute("avatarImagePath").toString() : "default_avatar.png" %>" alt="Avatar"></a>
                <a href="#loja"><img src="<%= request.getAttribute("lojaImagePath") != null ? request.getAttribute("lojaImagePath").toString() : "default_loja.png" %>" alt="Loja"></a>
                <a href="#config"><img src="<%= request.getAttribute("configImagePath") != null ? request.getAttribute("configImagePath").toString() : "default_config.png" %>" alt="Configurações"></a>
            </nav>
        </div>
    </header>

    <main>
        <div class="carousel-container">
            <button class="carousel-button left" onclick="previous()">❮</button>
            <div class="carousel">
                <div class="item" onclick="showDialogue('Fácil')">Fácil</div>
                <div class="item" onclick="showDialogue('Médio')">Médio</div>
                <div class="item" onclick="showDialogue('Difícil')">Difícil</div>
            </div>
            <button class="carousel-button right" onclick="next()">❯</button>
        </div>

        <!-- Caixa de Diálogo -->
        <div class="dialogue-box" id="dialogue-box">
            <div class="dialogue-box-content">
                <h2>Responda à questão</h2>
                <textarea id="response" placeholder="Sua resposta aqui..."></textarea>
                <button onclick="closeDialogue()">Fechar</button>
            </div>
        </div>

        <!-- Área de Atividades -->
        <div class="activity-area" id="activity-area">
            <h3>Atividades</h3>
            <div class="question">
                <label for="question-1">Questão 1</label>
                <textarea id="question-1" placeholder="Responda aqui..."></textarea>
            </div>
        </div>
    </main>

    <script>
        let currentIndex = 0;
        const items = document.querySelectorAll('.carousel .item');
        function next() {
            currentIndex = (currentIndex + 1) % items.length;
            updateCarousel();
        }
        function previous() {
            currentIndex = (currentIndex - 1 + items.length) % items.length;
            updateCarousel();
        }
        function updateCarousel() {
            const width = items[0].offsetWidth + 10;
            document.querySelector('.carousel').style.transform = `translateX(-${currentIndex * width}px)`;
        }

        // Caixa de Diálogo
        function showDialogue(difficulty) {
            document.getElementById('dialogue-box').style.display = 'flex';
            document.getElementById('activity-area').style.display = 'block';
            console.log("Dificuldade selecionada:", difficulty);
        }
        function closeDialogue() {
            document.getElementById('dialogue-box').style.display = 'none';
            document.getElementById('activity-area').style.display = 'none';
        }
    </script>
</body>
</html>
