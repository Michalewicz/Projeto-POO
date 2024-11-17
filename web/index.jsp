<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>inicio</title>
<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    body {
        font-family: Arial, sans-serif;
        line-height: 1.6;
        background-color: #f4f4f4;
        color: #333;
        display: flex;
        flex-direction: column;
        align-items: center;
    }

    .sidebar {
        width: 200px;
        background-color: #00509E;
        padding-top: 40px;
        height: 100vh;
        position: fixed;
        left: 0;
        top: 0;
        display: flex;
        flex-direction: column;
        align-items: center;
        transition: transform 0.3s;
    }

    .sidebar ul {
        list-style-type: none;
    }

    .sidebar li {
        margin-bottom: 30px;
    }

    .sidebar li a {
        color: #fff;
        text-decoration: none;
        font-weight: bold;
    }

    .sidebar.hidden {
        transform: translateX(-100%);
    }
    .sidebar nav ul {
        margin-top: 200px;
    }

    .toggle-button {
        position: absolute;
        top: 80px;
        left: 200px;
        background-color: #0073e6;
        border: none;
        width: 40px;
        height: 40px;
        cursor: pointer;
        display: flex;
        align-items: center;
        justify-content: center;
        transition: left 0.3s ease, background 0.3s;
    }

    .sidebar.hidden + .toggle-button {
        left: 0px;
    }

    .toggle-button:hover {
        background-color: #00509E;
    }

    .arrow-icon {
        width: 30px;
        height: auto;
        transition: transform 0.5s;
    }

    .rotate {
        transform: rotate(180deg);
    }

    .top-rectangle {
        width: 100%;
        height: 80px;
        background-color: #00509E;
        display: flex;
        align-items: center;
        justify-content: center;
        color: #ffffff;
        font-weight: bold;
        margin-bottom: 20px;
    }

    .main-content {
        margin-left: 220px;
        padding: 20px;
        width: calc(100% - 220px);
        display: flex;
        justify-content: space-around;
        align-items: center;
        height: calc(100vh - 100px);
        flex-wrap: wrap;
    }

    .rectangle {
        width: 157px;
        height: 300px;
        background-color: #ffffff;
        border-radius: 5px;
        overflow: hidden;
        border: none;
        cursor: pointer;
        outline: none;
        transition: transform 0.2s;
    }

    .rectangle:hover {
        transform: scale(1.05);
    }

    .rectangle img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }
</style>
</head>
<body>
<aside class="sidebar" id="sidebar">
<nav>
<ul>
<li><a href="#Perfil">Perfil</a></li>
<li><a href="#Provas">Provas</a></li>
<li><a href="#Estatisticas">Estatisticas</a></li>
<li><a href="#Opçoes">Opcoes</a></li>
</ul>
</nav>
</aside>

<button class="toggle-button" id="toggleButton">
    <img src="https://cdn-icons-png.flaticon.com/512/1/1112.png" alt="Toggle Sidebar" class="arrow-icon">
</button>

<div class="top-rectangle">Tendencia</div>

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

<script>
    document.addEventListener('DOMContentLoaded', () => {
        const sidebar = document.getElementById('sidebar');
        const toggleButton = document.getElementById('toggleButton');

        toggleButton.addEventListener('click', () => {
            sidebar.classList.toggle('hidden');
            toggleButton.classList.toggle('hidden');
        });
    });

    document.querySelector('.toggle-button').addEventListener('click', function() {
        const icon = this.querySelector('.arrow-icon');
        icon.classList.toggle('rotate');
    });
</script>
</body>
</html>
