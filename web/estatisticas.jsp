<%-- 
    Document   : estatisticas
    Created on : 15 de nov. de 2024, 16:01:35
    Author     : Rafael, Miguel e Sandro
--%>

<%@page import="java.util.Map"%>
<%@page import="Learning_POO_DB.DataBank"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    session.setAttribute("contagem", null);
    session.setAttribute("acerto", null);
%>
<%
    String emailUsuario = (String) session.getAttribute("email");
    int idUsuario = DataBank.buscarIdUsuarioPorEmail(emailUsuario);

    // Total de tarefas concluídas
    int totalConcluidas = DataBank.obterTotalTarefasConcluidas(idUsuario);

    // Precisão média
    double precisaoMedia = DataBank.obterPrecisaoMedia(idUsuario);

    // Quantidade de matérias matriculadas
    int totalMaterias = DataBank.obterTotalMateriasMatriculadas(idUsuario);

    // Quantidade de acertos e máximos
    Map<String, Integer> pontos = DataBank.obterPontosUsuario(idUsuario);
    int totalAcertos = pontos.get("total_acertos");
    int totalMaximos = pontos.get("total_maximos");
%>
<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Estatísticas | Learning with RMS</title>
        <link rel="stylesheet" type="text/css" href="CSS/estilos.css"/>
        <link rel="icon" href="images/icone.png" type="image/png">
    </head>
    <body>
        <header>
            <%@include file="WEB-INF/JSPF/menu.jspf"%>
        </header>
        <main>
            <h1>Estatísticas Gerais</h1>
            <p>Acompanhe as estatísticas gerais de suas tarefas.</p>
            <div class="top-divider"></div>
            <br>
            <div class="stats-grid">
                <div class="stats-item">
                    <h3>Tarefas Concluídas</h3>
                    <p><%= totalConcluidas%></p>
                </div>
                <div class="stats-item">
                    <h3>Precisão Média</h3>
                    <p><%= String.format("%.2f", precisaoMedia)%>%</p>
                </div>
                <div class="stats-item">
                    <h3>Matérias matriculadas</h3>
                    <p><%= totalMaterias%></p>
                </div>
                <div class="stats-item">
                    <h3>Quantidade de acertos</h3>
                    <p><%= totalAcertos%></p>
                </div>
                <div class="stats-item">
                    <h3>Quantidade de acertos máximos</h3>
                    <p><%= totalMaximos%></p>
                </div>
            </div>
        </main>
    </body>
</html>