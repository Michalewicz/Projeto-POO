<%-- 
    Document   : historico
    Created on : 15 de nov. de 2024, 16:01:35
    Author     : Miguel e Sandro
--%>

<%@page import="java.util.List"%>
<%@page import="Learning_POO_DB.DataBank"%>
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
                max-width: 2000px;
                margin: 50px auto;
                display: flex;
                flex-direction: column;
                align-items: center;
            }

            .tasks-grid {
                display: flex;
                flex-wrap: wrap;
                justify-content: center;
                gap: 20px;
                margin-top: 20px;
            }

            .tasks-container {
                flex-direction: column;
                align-items: center;
                width: 350px;
                padding: 15px;
                border: 1px solid #ddd;
                border-radius: 10px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                text-align: center;
                background-color: #fff;
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
            <div class="tasks-grid">
                <%
                    String emailUsuario = (String) session.getAttribute("email");
                    int idUsuario = DataBank.buscarIdUsuarioPorEmail(emailUsuario);
                    List<Integer> idsMaterias = DataBank.listarMatriculaUsuario(idUsuario);
                    int qtdMatricula = DataBank.contarMatriculaUsuario(idUsuario);

                    for (int i = 1; i <= qtdMatricula; i++) {

                %>
                <div class="tasks-container" id="tasksContainer">
                    <h2>Matéria: <%=""%></h2>
                    <div class="task">
                        <span href="tarefaIA.jsp"><button class="active">Tarefa 1</button></span>
                    </div>
                    <div class="arrow">↓</div>
                    <div class="task">
                        <span href="tarefaIA.jsp"><button disabled onclick="completeTask(1)">Tarefa 2</button></span>
                    </div>
                    <div class="arrow">↓</div>
                    <div class="task">
                        <span href="tarefaIA.jsp"><button disabled onclick="completeTask(2)">Tarefa 3</button></span>
                        <div class="arrow">↓</div>
                        <div class="task">
                            <span href="tarefaIA.jsp"><button disabled onclick="completeTask(3)">Tarefa 4</button></span>
                            <div class="arrow">↓</div>
                            <div class="task">
                                <span href="tarefaIA.jsp"><button disabled onclick="completeTask(4)">Exame Final</button></span>
                            </div>
                        </div>
                    </div>
                </div>
                <%}%>
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