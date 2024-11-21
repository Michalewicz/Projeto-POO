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

        .stats-header {
            font-size: 1.8rem;
            color: #0011ff;
            margin-bottom: 10px;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            width: 100%;
        }

        .stats-item {
            background: #f4f4f4;
            padding: 15px;
            text-align: center;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .stats-item h3 {
            font-size: 1.5rem;
            color: #0011ff;
            margin-bottom: 5px;
        }

        .stats-item p {
            font-size: 1rem;
            color: #333;
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
                <a><img src="${pageContext.request.contextPath}/images/estatistica.png" alt="Estatisticas"></a>
                <a href="historico.jsp"><img src="${pageContext.request.contextPath}/images/historico.png" alt="Historico"></a>
                <a href="biblioteca.jsp"><img src="${pageContext.request.contextPath}/images/biblioteca.png" alt="Biblioteca"></a>
                <a href="avatar.jsp"><img src="${pageContext.request.contextPath}/images/avatar.png" alt="Avatar"></a>
                <a href="#loja"><img src="${pageContext.request.contextPath}/images/loja.png" alt="Loja"></a>
                <a href="#ajustes"><img src="${pageContext.request.contextPath}/images/configuracoes.png" alt="Ajustes"></a>
            </nav>
        </div>
    </header>

    <main>
        <h1 class="stats-header">Estatísticas Gerais</h1>
        <p>Acompanhe as estatísticas gerais de suas tarefas.</p>
        <div class="stats-grid">
            <div class="stats-item">
                <h3>Tarefas Concluídas</h3>
                <p>45</p>
            </div>
            <div class="stats-item">
                <h3>Precisão Média</h3>
                <p>87%</p>
            </div>
            <div class="stats-item">
                <h3>Tempo Médio por Tarefa</h3>
                <p>5 min</p>
            </div>
            <div class="stats-item">
                <h3>Áreas Estudadas</h3>
                <p>4</p>
            </div>
        </div>
    </main>
</body>
</html>