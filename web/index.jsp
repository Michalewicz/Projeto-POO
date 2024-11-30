<%-- 
    Document   : index
    Created on : 15 de nov. de 2024, 16:01:35
    Author     : Rafael, Miguel e Sandro
--%>

<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@ page import="Learning_POO_DB.DataBank" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <script src="https://kit.fontawesome.com/6dda5f6271.js"></script>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Learning with RMS</title>
        <link rel="stylesheet" href="https://unpkg.com/swiper@8.4.7/swiper-bundle.min.css" />
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

            .top-grid{
                display: flex;
                flex-wrap: wrap;
                justify-content: center;
                gap: 20px;
                margin-top: 20px;
            }

            .top-grid img{
                transform: translate(-23%, -21%);
            }

            .site-description {
                flex: 1;
                padding: 10px;
                border: 1px solid #0011FF;
                border-radius: 5px;
                transform: translate(-30%, -10%);
            }

            .site-description h1 {
                color: #0011FF;
                margin-bottom: 10px;
                text-align: center;
            }

            .subjects {
                display: flex;
                flex-direction: column;
                align-items: center;
            }

            .subjects h3{
                font-weight: normal;
            }

            input[type="submit"] {
                display: block;
                margin: 5px auto;
                background-color: rgb(0, 17, 255);
                color: #fff;
                border: none;
                padding: 10px 20px;
                border-radius: 5px;
                cursor: pointer;
                font-size: 16px;
            }

            input[type="submit"]:hover {
                background-color: rgb(0, 13, 204);
            }
        </style>
    </head>
    <body>
        <header>
            <%@include file="WEB-INF/JSPF/menu.jspf"%>
        </header>
        <main>
            <div class="top-grid">
                <div>
                    <img src="${pageContext.request.contextPath}/images/padrao.png">
                </div>
                <div class="site-description">
                    <h1>Bem-vindo ao Learning with RMS!</h1>
                    <p>Aqui, você pode focar totalmente em seus estudos, com a ajuda da nossa Inteligência Artificial integrada! Comece no nível básico, e avance cada vez mais até 
                        atingir o nível máximo! Crie uma conta para armazenar seus dados, explore a vasta gama de livros disponíveis em nossa biblioteca, acompanhe suas estatísticas, 
                        e muito mais!</p>
                </div>
            </div>
            <%// Recupera o email do usuário
                String emailUsuario = (String) session.getAttribute("email");
                if (emailUsuario != null) {%>
            <h2>Selecione a matéria que deseja estudar</h2>
            <%
                // Recupera as matérias selecionadas
                String[] materiasSelecionadas = request.getParameterValues("materias");

                if (materiasSelecionadas != null && materiasSelecionadas.length > 0) {
                    // Cria uma lista com os nomes das matérias selecionadas
                    List<String> listaMaterias = Arrays.asList(materiasSelecionadas);

                    // Busca os IDs das matérias com base nos nomes
                    List<Integer> idsMaterias = DataBank.buscarIdsMateriaPorNomes(listaMaterias);

                    // Recupera o ID do usuário
                    int idUsuario = DataBank.buscarIdUsuarioPorEmail(emailUsuario);

                    // Verifica se o ID do usuário foi encontrado
                    if (idUsuario != -1) {
                        // Insere as matérias selecionadas na tabela usuario_materia
                        DataBank.matricularMaterias(idUsuario, idsMaterias);
                        out.println("Matérias matriculadas com sucesso!");
                    } else {
                        out.println("Erro ao encontrar o usuário.");
                    }
                }
            %>

            <form method="POST" id="formMatricula">
                <div class="subjects">
                    <%
                        // Recupera o ID do usuário para verificar suas matérias já matriculadas
                        int idUsuario = DataBank.buscarIdUsuarioPorEmail(emailUsuario);

                        // Busca as matérias já matriculadas pelo usuário
                        List<Integer> materiasMatriculadas = DataBank.buscarMateriasMatriculadas(idUsuario);

                        // Obtém o número total de matérias disponíveis
                        int qtdMateria = DataBank.quantidadeMateria();

                        // Se o usuário estiver matriculado em todas as matérias
                        if (materiasMatriculadas.size() == qtdMateria) {
                            // Exibe a mensagem de dedicação
                            out.println("<h3>Você se matriculou em todas as matérias! Acesse a página <a href='tarefas.jsp'>tarefas</a> para vê-las.</h3>");
                        } else {
                            // Exibe as checkboxes de matérias restantes
                            for (int i = 1; i <= qtdMateria; i++) {
                                String materiaNome = DataBank.buscarMateriaPorId(i);

                                // Verifica se a matéria já foi matriculada pelo usuário
                                boolean isMatriculada = materiasMatriculadas.contains(i);
                    %>
                    <label>
                        <h3>
                            <input type="checkbox" name="materias" value="<%= materiaNome%>" <%= isMatriculada ? "disabled" : ""%> <%= isMatriculada ? "checked" : ""%>> 
                            <%= materiaNome%>
                        </h3>
                    </label>
                    <%
                            }
                        }
                    %>
                </div>
                <% if (materiasMatriculadas.size() < qtdMateria) { %>
                <input type="submit" value="Selecionar matéria(s)">
                <% } %>
                <br>
            </form>
            <%} else {%>
            <h3>Antes de mais nada, <a href="registro.jsp">crie uma conta</a> ou <a href="login.jsp">entre</a> se já tiver uma!</h3>
            <%}%>
        </main>
    </body>
</html>