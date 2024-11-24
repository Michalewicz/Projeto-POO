<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <script src="https://kit.fontawesome.com/6dda5f6271.js" crossorigin="anonymous"></script>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Learning with RMS</title>
    <link rel="stylesheet" type="text/css" href="https://unpkg.com/swiper@8/swiper-bundle.min.css"/>
    <link rel="stylesheet" type="text/css" href="CSS/estilos.css"/>
</head>
<body>
    <header>
        <%@include file="WEB-INF/JSPF/menu.jspf"%>
    </header>

<main>
    <section class="history">
        <h1>Histórico de Tarefas</h1>
        <p>Acompanhe as tarefas que você já concluiu e veja seus avanços.</p>

        <div class="tasks-container">
            <div class="task-item">
                <h2>Tarefa 1: [Placeholder]</h2>
                <p><strong>Nível de Dificuldade:</strong> Médio</p>
                <p><strong>Pontuação Obtida:</strong> 85%</p>
                <p><strong>Descrição:</strong> [Descrição breve da tarefa, como "Responder perguntas sobre conceitos básicos de matemática."]</p>
            </div>
            <div class="task-item">
                <h2>Tarefa 2: [Placeholder]</h2>
                <p><strong>Nível de Dificuldade:</strong> Difícil</p>
                <p><strong>Pontuação Obtida:</strong> 70%</p>
                <p><strong>Descrição:</strong> [Descrição breve da tarefa, como "Resolver problemas avançados de física."]</p>
            </div>
            <div class="task-item">
                <h2>Tarefa 3: [Placeholder]</h2>
                <p><strong>Nível de Dificuldade:</strong> Fácil</p>
                <p><strong>Pontuação Obtida:</strong> 95%</p>
                <p><strong>Descrição:</strong> [Descrição breve da tarefa, como "Identificar os elementos da tabela periódica."]</p>
            </div>
        </div>
    </section>
</body>
</html>