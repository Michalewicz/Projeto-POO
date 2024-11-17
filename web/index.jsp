<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>inicio</title>
<link rel="stylesheet" href="styles.css"/>
</head>
<body>
<aside class="sidebar" id="sidebar">
<nav>
<ul>
<li><a href="#Perfil">Perfil</a></li>
<li><a href="#Tarefas">Tarefas</a></li>
<li><a href="#Provas">Provas</a></li>
<li><a href="estatisticas.jsp">Estatísticas</a></li>
<li><a href="#Opcoes">Opções</a></li>
</ul>
</nav>
</aside>

<button class="toggle-button" id="toggleButton">
    <img src="https://cdn-icons-png.flaticon.com/512/1/1112.png" alt="Toggle Sidebar" class="arrow-icon">
</button>

<div class="top-rectangle">Learning with RMS</div>

<main class="main-content">
    <button class="rectangle" type="button">
        <img src="minha-imagem.png" alt="Imagem de capa de matematica">
    </button>
    <button class="rectangle" type="button">
        <img src="minha-imagem2.png" alt="Imagem de capa de programacao">
    </button>
    <button class="rectangle" type="button">
        <img src="minha-imagem3.png" alt="Imagem de capa de Alemao">
    </button>
</main>
</body>
</html>
