<!DOCTYPE html>
<html lang="pt-br">
<head>
    <script src="https://kit.fontawesome.com/6dda5f6271.js" crossorigin="anonymous"></script>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tarefas | Learning with RMS</title>
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

        .tasks-container {
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .tasks-header {
            text-align: center;
            font-weight: bold;
        }

        .task button {
            display: block;
            margin: 0 auto;
            padding: 20px 30px;
            background: #ccc;
            color: #fff;
            border: none;
            border-radius: 10px;
            cursor: not-allowed;
            font-size: 20px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .task button.active {
            background: #0011FF;
            cursor: pointer;
        }

        .arrow {
            text-align: center;
            font-size: 40px;
            color: #0011FF;
        }

        .exercise-container {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 80%;
            max-width: 600px;
            padding: 20px;
            background: #fff;
            border: 1px solid #ccc;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            border-radius: 10px;
            z-index: 1000;
            text-align: center;
        }

        .exercise-container h2 {
            margin-bottom: 10px;
            color: #0011FF;
        }

        .exercise-container textarea {
            width: 100%;
            height: 150px;
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 5px;
            resize: none;
        }

        .overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            z-index: 999;
        }
    </style>
</head>
<body>
    <header>
        <nav>
            <a href="index.html">Início</a>
            <a href="sobre.html">Sobre</a>
            <a href="servicos.html">Serviços</a>
            <a href="contato.html">Contato</a>
        </nav>
    </header>
    <main>
        <h1>Suas Tarefas</h1>
        <p>Acesse as tarefas que você atualmente está fazendo.</p>
        <br>
        <div class="tasks-container" id="tasksContainer">
            <div class="task">
                <button class="active" onclick="completeTask(0)">Tarefa 1</button>
            </div>
            <div class="arrow">↓</div>
            <div class="task">
                <button disabled onclick="completeTask(1)">Tarefa 2</button>
            </div>
            <div class="arrow">↓</div>
            <div class="task">
                <button disabled onclick="completeTask(2)">Tarefa 3</button>
            </div>
            <div class="arrow">↓</div>
            <div class="task">
                <button disabled onclick="completeTask(3)">Tarefa 4</button>
            </div>
            <div class="arrow">↓</div>
            <div class="task">
                <button disabled onclick="completeTask(4)">Exame Final</button>
            </div>
        </div>

        <!-- Tela escura de fundo -->
        <div class="overlay" id="overlay"></div>

        <!-- Área de escrita dinâmica -->
        <div class="exercise-container" id="exerciseContainer">
            <h2 id="exerciseTitle">Aqui onde a I.A coloca exer</h2>
            <textarea id="exerciseText" placeholder="Escreva algo aqui..."></textarea>
        </div>

        <script>
            function completeTask(taskNumber) {
                const tasks = document.querySelectorAll('.task button');
                const exerciseContainer = document.getElementById('exerciseContainer');
                const exerciseTitle = document.getElementById('exerciseTitle');
                const overlay = document.getElementById('overlay');

                if (taskNumber < tasks.length - 1) {
                    tasks[taskNumber].disabled = true;
                    tasks[taskNumber + 1].disabled = false;
                    tasks[taskNumber + 1].classList.add('active');
                    
                    // Exibir a área de escrita no centro da tela
                    exerciseContainer.style.display = 'block';
                    overlay.style.display = 'block';
                    exerciseTitle.innerText = `Tarefa ${taskNumber + 1} - Aqui onde a I.A coloca exer`;
                } else {
                    alert('Você concluiu todas as tarefas!');
                }

                // Clique fora para fechar
                overlay.addEventListener('click', () => {
                    exerciseContainer.style.display = 'none';
                    overlay.style.display = 'none';
                });
            }
        </script>
    </main>
</body>
</html>
