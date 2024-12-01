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
<%
    session.setAttribute("contagem", null);
    session.setAttribute("acerto", null);
%>
<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Learning with RMS</title>
        <link rel="stylesheet" type="text/css" href="CSS/estilos_gerais.css"/>
        <link rel="stylesheet" type="text/css" href="CSS/estilos_index.css"/>
        <link rel="icon" href="images/icone.png" type="image/png">
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
                    Integer idUsuario = (Integer) session.getAttribute("idUsuario");
                    idUsuario = DataBank.buscarIdUsuarioPorEmail(emailUsuario);

                    // Verifica se o ID do usuário foi encontrado
                    if (idUsuario != -1) {
                        session.setAttribute("idUsuario", idUsuario);
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