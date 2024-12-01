<%-- 
    Document   : tarefas
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
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Tarefas | Learning with RMS</title>
        <link rel="stylesheet" type="text/css" href="CSS/estilos_gerais.css"/>
        <link rel="stylesheet" type="text/css" href="CSS/estilos_tarefas.css"/>
        <link rel="icon" href="images/icone.png" type="image/png">
    </head>
    <body>
        <header>
            <%@include file="WEB-INF/JSPF/menu.jspf"%>
        </header>
        <main>
            <h1>Suas Tarefas</h1>
            <p>Acesse as tarefas que você atualmente está fazendo.</p>
            <div class="top-divider"></div>
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
                    <br>
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
                        <% } else {%>
                        <!-- Tarefa bloqueada -->
                        <button disabled style="background-color: #ccc; cursor: not-allowed;"><%= dificuldade%></button>
                        <% } %>
                        <% if (i < tarefas.size() - 1) { %>
                        <div class="arrow">↓</div>
                        <% } %>
                    </div>
                    <%
                            }
                        }
                    %>
                    <br>
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
