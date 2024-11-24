<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <script src="https://kit.fontawesome.com/6dda5f6271.js" crossorigin="anonymous"></script>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Learning with RMS</title>
    <link rel="stylesheet" href="https://unpkg.com/swiper@8/swiper-bundle.min.css" />
    <link rel="stylesheet" href="estilos.css"/>
</head>
<body>
    <header>
        <%@include file="WEB-INF/jspf/menu.jspf"%>
    </header>

<main>
    <section class="avatar-customization">
        <h1>Customiza��o de Avatar</h1>
        <p>Personalize seu avatar com acess�rios incr�veis e �nicos!</p>

        <!-- Pontos do usu�rio -->
        <div class="points-container">
            <p><strong>Pontos dispon�veis:</strong> 1200</p>
        </div>

        <!-- Pr�via do Avatar -->
        <div class="avatar-preview">
            <h2>Pr�via do Avatar</h2>
            <img src="${pageContext.request.contextPath}/images/avatar_placeholder.png" alt="Pr�via do Avatar">
        </div>

        <!-- Itens Dispon�veis -->
        <div class="items-container">
            <h2>Itens Dispon�veis</h2>
            <div class="item">
                <img src="${pageContext.request.contextPath}/images/item_placeholder_1.png" alt="Item 1">
                <p><strong>Nome:</strong> Chap�u Colorido</p>
                <p><strong>Custo:</strong> 300 pontos</p>
                <button>Equipar</button>
            </div>
            <div class="item">
                <img src="${pageContext.request.contextPath}/images/item_placeholder_2.png" alt="Item 2">
                <p><strong>Nome:</strong> �culos Moderno</p>
                <p><strong>Custo:</strong> 200 pontos</p>
                <button>Equipar</button>
            </div>
            <div class="item">
                <img src="${pageContext.request.contextPath}/images/item_placeholder_3.png" alt="Item 3">
                <p><strong>Nome:</strong> Camiseta Descolada</p>
                <p><strong>Custo:</strong> 500 pontos</p>
                <button>Equipar</button>
            </div>
        </div>

        <!-- Op��es adicionais -->
        <div class="additional-options">
            <h2>Op��es Adicionais</h2>
            <ul>
                <li>Alterar cor do fundo do avatar</li>
                <li>Escolher entre diferentes express�es faciais</li>
                <li>Salvar avatar personalizado</li>
            </ul>
            <button>Salvar Avatar</button>
        </div>
    </section>
</body>
</html>