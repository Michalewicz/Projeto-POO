<%-- 
    Document   : historico
    Created on : 15 de nov. de 2024, 16:01:35
    Author     : Miguel e Sandro
--%>

<%@page import="java.util.List"%>
<%@page import="Learning_POO_DB.DataBank"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    session.setAttribute("contagem", null);
    session.setAttribute("acerto", null);
%>
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

            main {
                width: 100%;
                max-width: 1500px;
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
                background: #0011FF;
                color: #fff;
                border: none;
                border-radius: 10px;
                cursor: pointer;
                font-size: 20px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            }

            /* Estilo da barra de progresso */
            .progress-bar {
                width: 100%;
                height: 20px;
                background-color: #e0e0e0;
                border-radius: 10px;
                overflow: hidden;
                position: relative;
                margin: 10px 0;
            }

            .progress-bar .progress {
                height: 100%;
                background-color: rgb(0, 17, 255);
                transition: width 0.3s ease-in-out;
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
            <%@include file="WEB-INF/JSPF/menu.jspf"%>
        </header>
        <main>
            <h1>Suas Tarefas</h1>
            <p>Acesse as tarefas que você atualmente está fazendo.</p>
            <br>
            <div class="tasks-grid">
                <%
                    // Obtendo o e-mail do usuário da sessão
                    String emailUsuario = (String) session.getAttribute("email");

                    // Buscando o ID do usuário baseado no e-mail
                    int idUsuario = DataBank.buscarIdUsuarioPorEmail(emailUsuario);

                    // Obtendo os IDs das matérias matriculadas pelo usuário
                    List<Integer> idsMaterias = DataBank.listarMatriculaUsuario(idUsuario);

                    // Iterando sobre os IDs das matérias
                    for (int idMateria : idsMaterias) {
                        String nomeMateria = DataBank.buscarMateriaPorId(idMateria);

                        // Obter as tarefas associadas à matéria
                        List<String> tarefas = DataBank.listarTarefasPorMateria(idMateria, idUsuario);

                        // Verifica quais tarefas estão concluídas
                        List<Boolean> tarefasConcluidas = DataBank.verificarTarefasConcluidas(idUsuario, idMateria);

                        // Calcula o progresso na matéria com base nas tarefas concluídas
                        int totalTarefas = tarefas.size();
                        int tarefasConcluidasCount = 0;
                        for (boolean concluida : tarefasConcluidas) {
                            if (concluida) {
                                tarefasConcluidasCount++;
                            }
                        }

                        // Calcula a porcentagem de progresso
                        int progresso = totalTarefas > 0 
                            ? (int) ((tarefasConcluidasCount / (double) totalTarefas) * 100) 
                            : 0;
                %>
                <div class="tasks-container">
                    <h2><%= nomeMateria%></h2>
                    <%
                        if (tarefas.isEmpty()) {
                    %>
                    <p>Nenhuma tarefa disponível.</p>
                    <%
                        } else {
                            for (int i = 0; i < tarefas.size(); i++) {
                                String dificuldade = tarefas.get(i);
                                boolean desbloqueada = (i == 0) || (tarefasConcluidas.size() > i - 1 && tarefasConcluidas.get(i - 1));
                    %>
                    <div class="task">
                        <% if (desbloqueada) {%>
                        <!-- Tarefa desbloqueada -->
                        <a href="tarefaIA.jsp?materia=<%= nomeMateria%>&dificuldade=<%= dificuldade%>">
                            <button><%= dificuldade%></button>
                        </a>
                        <br>
                        <% } else {%>
                        <!-- Tarefa bloqueada -->
                        <button disabled style="background-color: #ccc; cursor: not-allowed;"><%= dificuldade%></button>
                        <br>
                        <% } %>
                    </div>
                    <%
                            }
                        }
                    %>
                    <div class="progress-bar">
                        <div class="progress" style="width: <%= progresso%>%"></div>
                    </div>
                    <div class="progress-text">
                        Progressão na matéria: <%= progresso%>%
                    </div>
                </div>
                <%
                    }
                %>
            </div>
        </main>
    </body>
</html>
