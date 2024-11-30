<%-- 
    Document   : tarefaIA
    Created on : 16 de nov. de 2024, 15:02:19
    Author     : Rafael
--%>

<%@page import="java.util.regex.Pattern"%>
<%@page import="java.util.regex.Matcher"%>
<%@page import="org.json.JSONArray"%>
<%@page import="Learning_POO_IA.WebIA"%>
<%@page import="org.json.JSONObject"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%
    // Obt�m ou inicializa os valores na sess�o
    String promptIA = (String) session.getAttribute("historico");
    Integer contRes = (Integer) session.getAttribute("contagem");
    Integer contAcer = (Integer) session.getAttribute("acerto");
    Integer contAcerMax = (Integer) session.getAttribute("acertomaximo");

    // Inicializa��o de vari�veis da sess�o, se necess�rio
    if (contAcer == null) {
        contAcer = 0;
    }
    if (contAcerMax == null) {
        contAcerMax = 0;
    }
    if (promptIA == null) {
        promptIA = "[]";
    }
    if (contRes == null) {
        contRes = 0;
    }

    // Verifica se o usu�rio enviou uma requisi��o
        try {
            // Obt�m os par�metros enviados pelo formul�rio
            String promptM = request.getParameter("materia");
            String promptDif = request.getParameter("dificuldade");
            String prompt = request.getParameter("escolhas");

            // Converte o hist�rico de string para JSONArray
            JSONArray historico = new JSONArray(promptIA);

            // Adiciona as novas mensagens ao hist�rico
            if (contRes == 0) {
                // Primeira intera��o
                historico.put(new JSONObject().put("role", "system").put("content",
                        "FUN��O: PROFESSOR\nMAT�RIA: " + promptM
                        + "\nDIFICULDADE: " + promptDif
                        + "\nM�TODO: QUESTION�RIO DE 5 PERGUNTAS (UMA DE CADA VEZ) COM ALTERNATIVAS: 'A', 'B', 'C', 'D', 'E'"
                        + "\nOBJETIVO FINAL: DIZER AO USU�RIO ONDE ELE DEVE APRIMORAR SEUS CONHECIMENTOS E MOSTRAR SEMPRE A QUANTIDADE DE ACERTOS DELE.\n"
                        + "OBSERVA��O: SEMPRE EXIBA O TOTAL DE PONTOS E NUNCA SUBTRA�A OS PONTOS."));
                historico.put(new JSONObject().put("role", "user").put("content",
                        "Ol�! Desejo saber mais sobre " + promptM + "!"));
            } else {
                // Intera��o subsequente
                historico.put(new JSONObject().put("role", "user").put("content",
                        "� a alternativa letra " + prompt + "!"));
            }

            // Chama o m�todo da IA com o hist�rico completo
            String completion = WebIA.getCompletion(promptM, historico.toString(), promptDif, prompt, contRes);

            // Express�o regular para capturar n�meros de acertos
            String regex = "(Voc� acertou (\\d+) das (\\d+) perguntas)"
                    + "|(Voc� acertou (\\d+) de (\\d+) perguntas, com (\\d+) pontos totais)"
                    + "|(Voc� obteve (\\d+) pontos de (\\d+) poss�veis)";
            Pattern pattern = Pattern.compile(regex);
            Matcher matcher = pattern.matcher(completion);

            // Captura e soma os acertos com base no texto da IA
            while (matcher.find()) {
                // Itera sobre os grupos encontrados e verifica se o n�mero de pontos foi capturado
                for (int i = 1; i <= matcher.groupCount(); i++) {
                    String group = matcher.group(i);  // Captura o grupo
                    if (group != null && !group.isEmpty()) {
                        try {
                            // Verifica se o grupo i realmente cont�m o n�mero de pontos
                            if (i % 2 == 0) {  // Os grupos pares s�o os que cont�m os n�meros
                                int pontos = Integer.parseInt(group); // Converte para int
                                contAcer = pontos; // Soma os acertos ao total
                            }
                        } catch (NumberFormatException e) {
                            // Em caso de erro de convers�o, continua
                            System.err.println("Erro ao converter n�mero: " + e.getMessage());
                        }
                    }
                }
            }

            // Adiciona a resposta da IA ao hist�rico
            historico.put(new JSONObject().put("role", "assistant").put("content", completion));

            // Atualiza os atributos da sess�o
            session.setAttribute("historico", historico.toString());
            session.setAttribute("contagem", contRes + 1);
            session.setAttribute("acerto", contAcer);
            request.setAttribute("completion", completion);
        } catch (Exception ex) {
            // Em caso de erro, reseta a sess�o
            request.setAttribute("error", ex.getMessage());
            session.setAttribute("contagem", contRes = 0);
            session.setAttribute("acerto", contAcer = 0);
        }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Question�rio | Learning with RMS</title>
        <link rel="stylesheet" type="text/css" href="CSS/estilos.css"/>
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
                max-width: 500px;
                margin: 50px auto;
                display: flex;
                flex-direction: column;
                align-items: center;
            }

            pre {
                width: 100%;
                justify-content: center;
                text-align: center;
                background-color: #fff;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            }

            .quiz-options {
                display: flex;
                flex-direction: column;
                align-items: center;
            }

            input[name="enviar"] {
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
        </style>
    </head>
    <body>
        <header>
            <%@include file="WEB-INF/JSPF/menu.jspf"%>
        </header>
        <main>
            <h1>Question�rio</h1>
            <% if (request.getAttribute("error") != null) {%>
            <div style="color: red;">ERRO: <%= request.getAttribute("error")%></div>
            <% } else if (request.getAttribute("completion") != null) {%>
            <h2>Mat�ria - <%= request.getParameter("materia").toUpperCase()%></h2>
            <div><pre><%= request.getAttribute("completion")%></pre></div>
            <% }%>
            <br>
            <b> <%= contAcer%> </b>
            <hr>
            <%if(contRes < 5){%>
            <form>
                <input type="hidden" name="materia" value="<%= request.getParameter("materia") %>">
                <input type="hidden" name="dificuldade" value="<%= request.getParameter("dificuldade") %>">
                <div class="quiz-options">
                    <p>Escolha uma alternativa:</p>
                    <div>
                        <input type="radio" id="escolhaA" name="escolhas" value="A" required>
                        <label for="escolhaA">A</label>
                    </div>
                    <div>
                        <input type="radio" id="escolhaB" name="escolhas" value="B" required>
                        <label for="escolhaB">B</label>
                    </div>
                    <div>
                        <input type="radio" id="escolhaC" name="escolhas" value="C" required>
                        <label for="escolhaC">C</label>
                    </div>
                    <div>
                        <input type="radio" id="escolhaD" name="escolhas" value="D" required>
                        <label for="escolhaD">D</label>
                    </div>
                    <div>
                        <input type="radio" id="escolhaE" name="escolhas" value="E" required>
                        <label for="escolhaE">E</label>
                    </div>
                </div>
                <br>
                <input type="submit" name="enviar" value="Enviar">
            </form>
            <%} else if (contRes == 5){%>
            <a href="tarefas.jsp">Finalizar teste</a>
            
            
            <% promptIA = "[]";
            contRes = 0; }%>
            
        </main>
    </body>
</html>