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

        .history {
            text-align: center;
            margin-top: 20px;
        }

        .tasks-container {
            display: flex;
            flex-direction: column;
            gap: 20px;
            margin-top: 20px;
            align-items: center;
        }

        .task-item {
            width: 90%;
            max-width: 600px;
            padding: 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            text-align: left;
            background-color: #fff;
        }

        .task-item h2 {
            font-size: 18px;
            margin-bottom: 10px;
            color: rgb(0, 17, 255);
        }

        .task-item p {
            margin: 5px 0;
            font-size: 14px;
        }

        .task-item strong {
            color: #333;
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
        <div class="logo"><a href="index.jsp"><img src="${pageContext.request.contextPath}/images/logo.png" alt="Pagina principal"></a></div>
        <div class="menu">
            <nav>
                <a href="#perfil"><img src="${pageContext.request.contextPath}/images/perfil.png" alt="Perfil"></a>
                <a href="estatisticas.jsp"><img src="${pageContext.request.contextPath}/images/estatistica.png" alt="Estatisticas"></a>
                <a><img src="${pageContext.request.contextPath}/images/historico.png" alt="Historico"></a>
                <a href="biblioteca.jsp"><img src="${pageContext.request.contextPath}/images/biblioteca.png" alt="Biblioteca"></a>
                <a href="#avatar"><img src="${pageContext.request.contextPath}/images/avatar.png" alt="Avatar"></a>
                <a href="#loja"><img src="${pageContext.request.contextPath}/images/loja.png" alt="Loja"></a>
                <a href="#ajustes"><img src="${pageContext.request.contextPath}/images/configuracoes.png" alt="Ajustes"></a>
                <a href="#contato"><img src="${pageContext.request.contextPath}/images/contato.png" alt="Fale Conosco"></a>
            </nav>
        </div>
    </header>

<main>
    <section class="history">
        <h1>Histórico de Tarefas</h1>
        <p>Acompanhe as tarefas que você já concluiu e veja seus avanços!</p>

        <div class="tasks-container">
            <div class="task-item">
                <h2>Tarefa 1: [Placeholder]</h2>
                <p><strong>Data de Conclusão:</strong> 20/11/2024</p>
                <p><strong>Tempo Gasto:</strong> 15 minutos</p>
                <p><strong>Nível de Dificuldade:</strong> Médio</p>
                <p><strong>Pontuação Obtida:</strong> 85%</p>
                <p><strong>Descrição:</strong> [Descrição breve da tarefa, como "Responder perguntas sobre conceitos básicos de matemática."]</p>
            </div>
            <div class="task-item">
                <h2>Tarefa 2: [Placeholder]</h2>
                <p><strong>Data de Conclusão:</strong> 18/11/2024</p>
                <p><strong>Tempo Gasto:</strong> 25 minutos</p>
                <p><strong>Nível de Dificuldade:</strong> Difícil</p>
                <p><strong>Pontuação Obtida:</strong> 70%</p>
                <p><strong>Descrição:</strong> [Descrição breve da tarefa, como "Resolver problemas avançados de física."]</p>
            </div>
            <div class="task-item">
                <h2>Tarefa 3: [Placeholder]</h2>
                <p><strong>Data de Conclusão:</strong> 15/11/2024</p>
                <p><strong>Tempo Gasto:</strong> 10 minutos</p>
                <p><strong>Nível de Dificuldade:</strong> Fácil</p>
                <p><strong>Pontuação Obtida:</strong> 95%</p>
                <p><strong>Descrição:</strong> [Descrição breve da tarefa, como "Identificar os elementos da tabela periódica."]</p>
            </div>
        </div>
    </section>

    <script src="https://unpkg.com/swiper@8/swiper-bundle.min.js"></script>
    <script>
        // ConfiguraÃ§Ã£o do carrossel
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
            progressText.textContent = `Área selecionada: [placeholder] - ${currentPercentage}%`;
            if (currentPercentage < 100) {
                setTimeout(updateProgress, totalDuration / 100);
            }
        }

        // Inicia a barra de progresso
        updateProgress();
    </script>
</body>
</html>