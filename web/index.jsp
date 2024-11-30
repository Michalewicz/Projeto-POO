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
                    <p>Aqui, voc� pode focar totalmente em seus estudos, com a ajuda da nossa Intelig�ncia Artificial integrada! Comece no n�vel b�sico, e avance cada vez mais at� 
                        atingir o n�vel m�ximo! Crie uma conta para armazenar seus dados, explore a vasta gama de livros dispon�veis em nossa biblioteca, acompanhe suas estat�sticas, 
                        e muito mais!</p>
                </div>
            </div>
            <%// Recupera o email do usu�rio
                String emailUsuario = (String) session.getAttribute("email");
                if (emailUsuario != null) {%>
            <h2>Selecione a mat�ria que deseja estudar</h2>
            <%
                // Recupera as mat�rias selecionadas
                String[] materiasSelecionadas = request.getParameterValues("materias");

                if (materiasSelecionadas != null && materiasSelecionadas.length > 0) {
                    // Cria uma lista com os nomes das mat�rias selecionadas
                    List<String> listaMaterias = Arrays.asList(materiasSelecionadas);

                    // Busca os IDs das mat�rias com base nos nomes
                    List<Integer> idsMaterias = DataBank.buscarIdsMateriaPorNomes(listaMaterias);

                    // Recupera o ID do usu�rio
                    int idUsuario = DataBank.buscarIdUsuarioPorEmail(emailUsuario);

                    // Verifica se o ID do usu�rio foi encontrado
                    if (idUsuario != -1) {
                        // Insere as mat�rias selecionadas na tabela usuario_materia
                        DataBank.matricularMaterias(idUsuario, idsMaterias);
                        out.println("Mat�rias matriculadas com sucesso!");
                    } else {
                        out.println("Erro ao encontrar o usu�rio.");
                    }
                }
            %>

            <form method="POST" id="formMatricula">
                <div class="subjects">
                    <%
                        // Recupera o ID do usu�rio para verificar suas mat�rias j� matriculadas
                        int idUsuario = DataBank.buscarIdUsuarioPorEmail(emailUsuario);

                        // Busca as mat�rias j� matriculadas pelo usu�rio
                        List<Integer> materiasMatriculadas = DataBank.buscarMateriasMatriculadas(idUsuario);

                        // Obt�m o n�mero total de mat�rias dispon�veis
                        int qtdMateria = DataBank.quantidadeMateria();

                        // Se o usu�rio estiver matriculado em todas as mat�rias
                        if (materiasMatriculadas.size() == qtdMateria) {
                            // Exibe a mensagem de dedica��o
                            out.println("<h3>Voc� se matriculou em todas as mat�rias! Acesse a p�gina <a href='tarefas.jsp'>tarefas</a> para v�-las.</h3>");
                        } else {
                            // Exibe as checkboxes de mat�rias restantes
                            for (int i = 1; i <= qtdMateria; i++) {
                                String materiaNome = DataBank.buscarMateriaPorId(i);

                                // Verifica se a mat�ria j� foi matriculada pelo usu�rio
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
                <input type="submit" value="Selecionar mat�ria(s)">
                <% } %>
                <br>
            </form>
            <%} else {%>
            <h3>Antes de mais nada, <a href="registro.jsp">crie uma conta</a> ou <a href="login.jsp">entre</a> se j� tiver uma!</h3>
            <%}%>
        </main>
    </body>
</html>