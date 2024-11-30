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
                // Obtendo o e-mail do usuário da sessão
                String emailUsuario = (String) session.getAttribute("email");

                // Buscando o ID do usuário baseado no e-mail
                int idUsuario = DataBank.buscarIdUsuarioPorEmail(emailUsuario);

                // Obtendo os IDs das matérias matriculadas pelo usuário
                List<Integer> idsMaterias = DataBank.listarMatriculaUsuario(idUsuario);

                // Iterando sobre os IDs das matérias
                for (int idMateria : idsMaterias) {
                    String nomeMateria = DataBank.buscarNomeMateriaPorId(idMateria);

                    // Obter as tarefas associadas à matéria
                    List<String> tarefas = DataBank.listarTarefasPorMateria(idMateria, idUsuario); // Aqui cada tarefa é um List de nomes de dificuldades

            %>
            <div class="tasks-container">
                <h2><%= nomeMateria %></h2>
                <%
                    if (tarefas.isEmpty()) {
                %>
                <p>Nenhuma tarefa disponível.</p>
                <%
                    } else {
                        for (String dificuldade : tarefas) { // Cada tarefa é uma dificuldade, já que o método retorna dificuldades
                %>
                <div class="task">
                    <!-- Aqui o link que leva para tarefaIA.jsp, passando os parâmetros da matéria e dificuldade -->
                    <a href="tarefaIA.jsp?materia=<%= nomeMateria %>&dificuldade=<%= dificuldade %>">
                        <button class="active"><%= dificuldade %></button>
                        <br>
                    </a>
                </div>
                <%
                        }
                    }
                %>
            </div>
            <%
                }
            %>
        </div>
    </main>
</body>
</html>