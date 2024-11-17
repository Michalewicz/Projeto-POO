<%-- 
    Document   : tarefaIA
    Created on : 16 de nov. de 2024, 15:02:19
    Author     : Rafael
--%>
<%@page import="org.json.JSONArray"%>
<%@page import="Learning_POO_IA.WebIA"%>
<%@page import="Learning_POO_Logica.Logica_tarefaIA"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%
    
    // Obtém o histórico da sessão (se houver) ou cria um novo
    String promptIA = (String) session.getAttribute("historico");
    Integer contRes = (Integer) session.getAttribute("contagem");
 

    // Inicializa PromptIA e contRes seja null
    if (promptIA == null) {
        promptIA = "";
    }
    if (contRes == null) {
        contRes = 0;
    // Reseta PromptIA e contRes quando somados.
    } else if (contRes == 11){
        promptIA ="";
        contRes = 0;
    }
    
    if (request.getParameter("enviar") != null) {
        try {
            String promptM = request.getParameter("materias");
            String prompt = request.getParameter("escolhas");
            String completion = WebIA.getCompletion(promptM, promptIA, prompt, contRes);
            session.setAttribute("historico", completion);
            session.setAttribute("contagem", contRes+1);
            request.setAttribute("completion", completion);
        } catch (Exception ex) {
            request.setAttribute("error", ex.getMessage());
            session.removeAttribute("historico");
            session.removeAttribute("contagem");
        }
    }
%>


<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>RMS - Questionário</title>
    </head>
    <body>
        <h1>Questionário</h1>

        <% if (request.getAttribute("error") != null) {%>
        <div>ERRO: <%= request.getAttribute("error")%></div>
        <hr/>
        <% } else if (request.getAttribute("completion") != null) {%>
        <h2>MATÉRIA - <%=request.getParameter("materias").toUpperCase()%></h2>
        <h2>Completion</h2>
        <div><pre><%= request.getAttribute("completion")%></pre></div>
        <hr/>
        <% }%>
        MATÉRIA<br/>
        <form>
            <select name="materias" id="materias">
                <optgroup label="Exatas">
                    <option value="matemática">Matemática</option>
                    <option value="biologia">Biologia</option>
                    <option value="quimíca">Quimíca</option>
                    <option value="física">Física</option>
                </optgroup>
                <optgroup label="Humanas">
                    <option value="sociologia">Sociologia</option>
                    <option value="história">História</option>
                    <option value="geografia">Geografia</option>
                    <option value="filosofia">Filosofia</option>
                </optgroup>
            </select>
            <div>
                <input type="radio" id="escolhaA" name="escolhas" value="A">
                <label for="escolhaA">A.</label>
            </div>
            <div>
                <input type="radio" id="escolhaB" name="escolhas" value="B">
                <label for="escolhaB">B.</label>
            </div>
            <div>
                <input type="radio" id="escolhaC" name="escolhas" value="C">
                <label for="escolhaC">C.</label>
            </div>
            <div>
                <input type="radio" id="escolhaD" name="escolhas" value="D">
                <label for="escolhaD">D.</label>
            </div>
            <div>
                <input type="radio" id="escolhaE" name="escolhas" value="E">
                <label for="escolhaE">E.</label>
            </div><br>
            <input type="submit" name="enviar" value="Enviar"/>
        </form>
    </body>
</html>
