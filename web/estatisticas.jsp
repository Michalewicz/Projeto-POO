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

    // Total de tarefas conclu�das
    int totalConcluidas = DataBank.obterTotalTarefasConcluidas(idUsuario);

    // Precis�o m�dia
    double precisaoMedia = DataBank.obterPrecisaoMedia(idUsuario);

    // Quantidade de mat�rias matriculadas
    int totalMaterias = DataBank.obterTotalMateriasMatriculadas(idUsuario);

    // Quantidade de acertos e m�ximos
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
        <title>Estat�sticas | Learning with RMS</title>
        <link rel="stylesheet" type="text/css" href="CSS/estilos.css"/>
        <link rel="icon" href="images/icone.png" type="image/png">
    </head>
    <body>
        <header>
            <%@include file="WEB-INF/JSPF/menu.jspf"%>
        </header>
        <main>
            <h1>Estat�sticas Gerais</h1>
            <p>Acompanhe as estat�sticas gerais de suas tarefas.</p>
            <div class="top-divider"></div>
            <br>
            <div class="stats-grid">
                <div class="stats-item">
                    <h3>Tarefas Conclu�das</h3>
                    <p><%= totalConcluidas%></p>
                </div>
                <div class="stats-item">
                    <h3>Precis�o M�dia</h3>
                    <p><%= String.format("%.2f", precisaoMedia)%>%</p>
                </div>
                <div class="stats-item">
                    <h3>Mat�rias matriculadas</h3>
                    <p><%= totalMaterias%></p>
                </div>
                <div class="stats-item">
                    <h3>Quantidade de acertos</h3>
                    <p><%= totalAcertos%></p>
                </div>
                <div class="stats-item">
                    <h3>Quantidade de acertos m�ximos</h3>
                    <p><%= totalMaximos%></p>
                </div>
            </div>
        </main>
    </body>
</html>