<%-- 
    Document   : tarefaIA
    Created on : 16 de nov. de 2024, 15:02:19
    Author     : Rafael
--%>
<%@page import="org.json.JSONArray"%>
<%@page import="Learning_POO_IA.WebIA"%>
<%@page import="org.json.JSONObject"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%
    // Obt�m o hist�rico da sess�o (se houver) ou cria um novo
    String promptIA = (String) session.getAttribute("historico");
    Integer contRes = (Integer) session.getAttribute("contagem");

    // Inicializa PromptIA e contRes se forem nulos
    if (promptIA == null) {
        promptIA = "[]";
    }
    if (contRes == null) {
        contRes = 0;
    } else if (contRes > 11) {
        // Reseta PromptIA e contRes ap�s o question�rio
        promptIA = "[]";
        contRes = 0;
    }

    // Verifica se o usu�rio enviou uma requisi��o
    if (request.getParameter("enviar") != null) {
        try {
            // Obt�m os par�metros enviados pelo formul�rio
            String promptM = request.getParameter("materias");
            String promptDif = request.getParameter("dificuldade");
            String prompt = request.getParameter("escolhas");

            // Converte o hist�rico de string para JSONArray
            JSONArray historico = new JSONArray(promptIA);

            // Adiciona as novas mensagens ao hist�rico
            if (contRes == 0) {
                // Primeira intera��o
                historico.put(new JSONObject().put("role", "system").put("content", 
                    "FUN��O: PROFESSOR\nMAT�RIA: " + promptM + 
                    "\nDIFICULDADE: " + promptDif + 
                    "\nM�TODO: QUESTION�RIO DE 10 PERGUNTAS COM ALTERNATIVAS: 'A', 'B', 'C', 'D', 'E'" +
                    "\nOBJETIVO FINAL: DIZER AO USU�RIO ONDE ELE DEVE APRIMORAR SEUS CONHECIMENTOS E MOSTRAR SEMPRE A QUANTIDADE DE ACERTOS DELE.\n" +
                    "OBSERVA��O: SEMPRE EXIBA O TOTAL DE PONTOS E NUNCA SUBTRA�A OS PONTOS."));
                historico.put(new JSONObject().put("role", "user").put("content", 
                    "Ol�! Desejo saber mais sobre " + promptM + "!"));
            } else {
                // Intera��o subsequente
                historico.put(new JSONObject().put("role", "user").put("content", 
                    "� a alternativa letra " + prompt + "!"));
            }

            // Chama o m�todo da IA com o hist�rico completo
            String completion = WebIA.getCompletion(promptM, historico.toString(), promptDif, prompt, contRes);

            // Adiciona a resposta da IA ao hist�rico
            historico.put(new JSONObject().put("role", "assistant").put("content", completion));

            // Atualiza os atributos da sess�o
            session.setAttribute("historico", historico.toString());
            session.setAttribute("contagem", contRes + 1);
            request.setAttribute("completion", completion);
        } catch (Exception ex) {
            // Em caso de erro, reseta os dados da sess�o
            request.setAttribute("error", ex.getMessage());
            session.removeAttribute("historico");
            session.removeAttribute("contagem");
        }
    }
%>


<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>RMS - Question�rio</title>
    </head>
    <body>
        <h1>Question�rio</h1>

        <% if (request.getAttribute("error") != null && contRes <= 10) {%>
        <div>ERRO: <%= request.getAttribute("error")%></div>
        <hr/>
        <% } else if (request.getAttribute("completion") != null && contRes <= 10) {%>
        <h2>MAT�RIA - <%=request.getParameter("materias").toUpperCase()%></h2>
        <div><pre><%= request.getAttribute("completion")%></pre></div>
        <hr/>
        <% }%>
        MAT�RIA DIFICULDADE<br/>
        <form>
            <select name="materias" id="materias">
                <optgroup label="Exatas">
                    <option value="matematica">Matem�tica</option>
                    <option value="biologia">Biologia</option>
                    <option value="quimica">Quim�ca</option>
                    <option value="fisica">F�sica</option>
                </optgroup>
                <optgroup label="Humanas">
                    <option value="sociologia">Sociologia</option>
                    <option value="historia">Hist�ria</option>
                    <option value="geografia">Geografia</option>
                    <option value="filosofia">Filosofia</option>
                </optgroup>
            </select>
            <select name="dificuldade" id="dificuldade">
                    <option value="muito facil">Muito f�cil</option>
                    <option value="facil">F�cil</option>
                    <option value="medio">M�dio</option>
                    <option value="dificil">Dif�cil</option>
                    <option value="muito dificil">Muito dif�cil</option>
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
