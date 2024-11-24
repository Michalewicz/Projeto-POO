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
        <h1 class="stats-header">Estat�sticas Gerais</h1>
        <p>Acompanhe as estat�sticas gerais de suas tarefas.</p>
        <div class="stats-grid">
            <div class="stats-item">
                <h3>Tarefas Conclu�das</h3>
                <p>45</p>
            </div>
            <div class="stats-item">
                <h3>Precis�o M�dia</h3>
                <p>87%</p>
            </div>
            <div class="stats-item">
                <h3>Tempo M�dio por Tarefa</h3>
                <p>5 min</p>
            </div>
            <div class="stats-item">
                <h3>�reas Estudadas</h3>
                <p>4</p>
            </div>
        </div>
    </main>
</body>
</html>