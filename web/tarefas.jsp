<%-- 
    Document   : historico
    Created on : 15 de nov. de 2024, 16:01:35
    Author     : Miguel e Sandro
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
        </style>
    </head>
    <body>
        <header>
            <%@include file="WEB-INF/JSPF/menu.jspf"%>
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
                    <div class="arrow">↓</div>
                    <div class="task">
                        <button disabled onclick="completeTask(3)">Tarefa 4</button>
                        <div class="arrow">↓</div>
                        <div class="task">
                            <button disabled onclick="completeTask(4)">Exame Final</button>
                        </div>
                    </div>
                </div>
            </div>
            <script>
                <!-- O que faz os botoes "ligarem" (essa funcionalidade ainda é placeholder) -->
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
        </main>
    </body>
</html>