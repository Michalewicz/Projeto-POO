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
        <h1>Customização de Avatar</h1>
        <p>Personalize seu avatar com acessórios incríveis e únicos!</p>

        <!-- Pontos do usuário -->
        <div class="points-container">
            <p><strong>Pontos disponíveis:</strong> 1200</p>
        </div>

        <!-- Prévia do Avatar -->
        <div class="avatar-preview">
            <h2>Prévia do Avatar</h2>
            <img src="${pageContext.request.contextPath}/images/avatar_placeholder.png" alt="Prévia do Avatar">
        </div>

        <!-- Itens Disponíveis -->
        <div class="items-container">
            <h2>Itens Disponíveis</h2>
            <div class="item">
                <img src="${pageContext.request.contextPath}/images/item_placeholder_1.png" alt="Item 1">
                <p><strong>Nome:</strong> Chapéu Colorido</p>
                <p><strong>Custo:</strong> 300 pontos</p>
                <button>Equipar</button>
            </div>
            <div class="item">
                <img src="${pageContext.request.contextPath}/images/item_placeholder_2.png" alt="Item 2">
                <p><strong>Nome:</strong> Óculos Moderno</p>
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

        <!-- Opções adicionais -->
        <div class="additional-options">
            <h2>Opções Adicionais</h2>
            <ul>
                <li>Alterar cor do fundo do avatar</li>
                <li>Escolher entre diferentes expressões faciais</li>
                <li>Salvar avatar personalizado</li>
            </ul>
            <button>Salvar Avatar</button>
        </div>
    </section>
</body>
</html>