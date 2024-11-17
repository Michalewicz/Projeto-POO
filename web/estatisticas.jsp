<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Estatísticas</title>
<link rel="stylesheet" href="styles.css"/>
</head>
<body>
<aside class="sidebar" id="sidebar">
<nav>
<ul>
<li><a href="#Perfil">Perfil</a></li>
<li><a href="#Tarefas">Tarefas</a></li>
<li><a href="#Provas">Provas</a></li>
<li><a href="#Estatisticas">Estatísticas</a></li>
<li><a href="#Opcoes">Opções</a></li>
</ul>
</nav>
</aside>

<button class="toggle-button" id="toggleButton">
    <img src="https://cdn-icons-png.flaticon.com/512/1/1112.png" alt="Toggle Sidebar" class="arrow-icon">
</button>

    <div class="top-rectangle"><a href="index.jsp">Learning with RMS</a></div>

<main class="statistics-content">
    <div class="statistics-card">
        <h2>Total de Tarefas Realizadas</h2>
        <p><span class="highlight">42</span> tarefas completadas até agora.</p>
    </div>
    <div class="statistics-card">
        <h2>Pontuação Média</h2>
        <p>Sua pontuação média é de <span class="highlight">88%</span>.</p>
    </div>
    <div class="statistics-card">
        <h2>Tempo Médio por Tarefa</h2>
        <p>Você gasta, em média, <span class="highlight">15 minutos</span> por tarefa.</p>
    </div>
    <div class="statistics-card">
        <h2>Progresso por Área</h2>
        <p>Matemática: <span class="highlight">75%</span> | Programação: <span class="highlight">60%</span> | Alemão: <span class="highlight">50%</span></p>
    </div>
</main>
</body>
</html>