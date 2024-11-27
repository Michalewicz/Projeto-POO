<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Learning with RMS</title>
    <style>
        /* Estilos gerais */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #ffffff;
        }

        /* Cabeçalho */
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

        /* Layout principal */
        main {
            padding: 20px;
        }

        .container {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
        }

        /* Descrição */
        .site-description {
            flex: 1;
            padding: 10px;
            border: 1px solid #0011FF;
            border-radius: 5px;
            background: #f9f9f9;
        }

        .site-description h4 {
            color: #0011FF;
            margin-bottom: 10px;
        }

        /* Tarefas */
        .tasks-container {
            flex: 1;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .tasks-header {
            text-align: center;
            font-weight: bold;
            margin-bottom: 20px;
        }

        .task {
            text-align: center;
            margin: 20px 0;
        }

        .task button {
            display: block;
            margin: 0 auto;
            padding: 10px 20px;
            background: #ccc;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: not-allowed;
        }

        .task button.active {
            background: #0011FF;
            cursor: pointer;
        }

        .arrow {
            text-align: center;
            font-size: 24px;
            color: #0011FF;
        }

        /* Carrossel */
        .carousel-container {
            text-align: center;
        }

        .carousel {
            display: flex;
            overflow-x: auto;
            gap: 10px;
            justify-content: center;
        }

        .carousel .item {
            background: #0011FF;
            color: #fff;
            padding: 10px 20px;
            border-radius: 5px;
            text-align: center;
            cursor: pointer;
        }

        /* Barra de progresso */
        .progress-container {
            margin: 20px 0;
            text-align: center;
        }

        .progress-bar {
            width: 80%;
            margin: 0 auto;
            height: 20px;
            background: #ccc;
            border-radius: 10px;
            overflow: hidden;
            position: relative;
        }

        .progress-bar span {
            display: block;
            height: 100%;
            width: 60%; /* Progresso inicial */
            background: #0011FF;
        }

        .progress-text {
            margin-top: 10px;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <!-- Cabeçalho -->
    <header>
        <div class="logo"><img src="<%= request.getContextPath() %>/images/logo.png" alt="Página Principal"></div>
        <div class="menu">
            <nav>
                <a href="#perfil"><img src="<%= request.getContextPath() %>/images/perfil.png" alt="Perfil"></a>
                <a href="#estatisticas"><img src="<%= request.getContextPath() %>/images/estatistica.png" alt="Estatísticas"></a>
                <a href="#historico"><img src="<%= request.getContextPath() %>/images/historico.png" alt="Histórico"></a>
                <a href="#biblioteca"><img src="<%= request.getContextPath() %>/images/biblioteca.png" alt="Biblioteca"></a>
                <a href="#avatar"><img src="<%= request.getContextPath() %>/images/avatar.png" alt="Avatar"></a>
                <a href="#loja"><img src="<%= request.getContextPath() %>/images/loja.png" alt="Loja"></a>
                <a href="#ajustes"><img src="<%= request.getContextPath() %>/images/configuracoes.png" alt="Ajustes"></a>
            </nav>
        </div>
    </header>

    <!-- Conteúdo principal -->
    <main>
        <!-- Carrossel -->
        <div class="carousel-container">
            <h2>Carrossel com as Matérias</h2>
            <div class="carousel" id="subjectCarousel">
                <div class="item" onclick="selectSubject('Matemática')">Matemática</div>
                <div class="item" onclick="selectSubject('Português')">Português</div>
                <div class="item" onclick="selectSubject('Ciências')">Ciências</div>
                <div class="item" onclick="selectSubject('História')">História</div>
                <div class="item" onclick="selectSubject('Geografia')">Geografia</div>
                <div class="item" onclick="selectSubject('Inglês')">Inglês</div>
                <div class="item" onclick="selectSubject('Artes')">Artes</div>
                <div class="item" onclick="selectSubject('Educação Física')">Educação Física</div>
                <div class="item" onclick="selectSubject('Música')">Música</div>
            </div>
        </div>

        <!-- Barra de progresso -->
        <div class="progress-container">
            <div class="progress-bar">
                <span></span>
            </div>
            <div class="progress-text">60% - Assunto sendo lecionado</div>
        </div>

        <div class="container">
            <!-- Descrição -->
            <aside class="site-description">
                <h4>Descrição Sobre o Site</h4>
                <p>Bem-vindo ao Learning with RMS! Aqui, você poderá realizar testes de proficiência, acompanhar o progresso das suas matérias e desbloquear tarefas de forma sequencial e organizada.</p>
            </aside>

            <!-- Tarefas -->
            <div class="tasks-container" id="tasksContainer">
                <div class="tasks-header">Organizar as Tarefas</div>

                <!-- Tarefa 0 -->
                <div class="task">
                    <button class="active" onclick="completeTask(0)">Tarefa 0 (Exame de Proficiência)</button>
                </div>

                <!-- Seta -->
                <div class="arrow">↓</div>

                <!-- Tarefa 1 -->
                <div class="task">
                    <button disabled onclick="completeTask(1)">Tarefa 1</button>
                </div>

                <!-- Seta -->
                <div class="arrow">↓</div>

                <!-- Tarefa 2 -->
                <div class="task">
                    <button disabled onclick="completeTask(2)">Tarefa 2</button>
                </div>
            </div>
        </div>
    </main>

    <script>
        function selectSubject(subject) {
            alert(`Matéria selecionada: ${subject}`);
        }

        function completeTask(taskNumber) {
            const tasks = document.querySelectorAll('.task button');
            if (taskNumber < tasks.length - 1) {
                tasks[taskNumber].disabled = true;
                tasks[taskNumber + 1].disabled = false;
                tasks[taskNumber + 1].classList.add('active');
                alert(`Tarefa ${taskNumber} concluída!`);
            } else {
                alert('Você concluiu todas as tarefas!');
            }
        }
    </script>
</body>
</html>
