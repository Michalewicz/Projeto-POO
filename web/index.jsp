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
                    Integer idUsuario = (Integer) session.getAttribute("idUsuario");
                    idUsuario = DataBank.buscarIdUsuarioPorEmail(emailUsuario);

                    // Verifica se o ID do usu�rio foi encontrado
                    if (idUsuario != -1) {
                        session.setAttribute("idUsuario", idUsuario);
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