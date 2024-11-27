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
    // Obtém ou inicializa os valores na sessão
    String promptIA = (String) session.getAttribute("historico");
    Integer contRes = (Integer) session.getAttribute("contagem");
    Integer contAcer = (Integer) session.getAttribute("acerto");
    Integer contAcerMax = (Integer) session.getAttribute("acertomaximo");

    // Inicialização de variáveis da sessão, se necessário
    if (contAcer == null) contAcer = 0;
    if (contAcerMax == null) contAcerMax = 0;
    if (promptIA == null) promptIA = "[]";
    if (contRes == null) contRes = 0;
    else if (contRes > 5) {
        // Reseta histórico após 5 perguntas
        promptIA = "[]";
        contRes = 0;
    }

    // Verifica se o usuário enviou uma requisição
    if (request.getParameter("enviar") != null) {
        try {
            // Obtém os parâmetros enviados pelo formulário
            String promptM = request.getParameter("materias");
            String promptDif = request.getParameter("dificuldade");
            String prompt = request.getParameter("escolhas");
            
            // Converte o histórico de string para JSONArray
            JSONArray historico = new JSONArray(promptIA);

            // Adiciona as novas mensagens ao histórico
            if (contRes == 0) {
                // Primeira interação
                historico.put(new JSONObject().put("role", "system").put("content",
                        "FUNÇÃO: PROFESSOR\nMATÉRIA: " + promptM
                        + "\nDIFICULDADE: " + promptDif
                        + "\nMÉTODO: QUESTIONÁRIO DE 5 PERGUNTAS (UMA DE CADA VEZ) COM ALTERNATIVAS: 'A', 'B', 'C', 'D', 'E'"
                        + "\nOBJETIVO FINAL: DIZER AO USUÁRIO ONDE ELE DEVE APRIMORAR SEUS CONHECIMENTOS E MOSTRAR SEMPRE A QUANTIDADE DE ACERTOS DELE.\n"
                        + "OBSERVAÇÃO: SEMPRE EXIBA O TOTAL DE PONTOS E NUNCA SUBTRAÍA OS PONTOS."));
                historico.put(new JSONObject().put("role", "user").put("content",
                        "Olá! Desejo saber mais sobre " + promptM + "!"));
            } else {
                // Interação subsequente
                historico.put(new JSONObject().put("role", "user").put("content",
                        "É a alternativa letra " + prompt + "!"));
            }

            // Chama o método da IA com o histórico completo
            String completion = WebIA.getCompletion(promptM, historico.toString(), promptDif, prompt, contRes);

            // Expressão regular para capturar números de acertos
            String regex = "(Você acertou (\\d+) das (\\d+) perguntas)"
                + "|(Você acertou (\\d+) de (\\d+) perguntas, com (\\d+) pontos totais)"
                + "|(Você obteve (\\d+) pontos de (\\d+) possíveis)";
            Pattern pattern = Pattern.compile(regex);
            Matcher matcher = pattern.matcher(completion);

            // Captura e soma os acertos com base no texto da IA
            while (matcher.find()) {
                // Itera sobre os grupos encontrados e verifica se o número de pontos foi capturado
                for (int i = 1; i <= matcher.groupCount(); i++) {
                    String group = matcher.group(i);  // Captura o grupo
                    if (group != null && !group.isEmpty()) {
                        try {
                            // Verifica se o grupo i realmente contém o número de pontos
                            if (i % 2 == 0) {  // Os grupos pares são os que contêm os números
                                int pontos = Integer.parseInt(group); // Converte para int
                                contAcer = pontos; // Soma os acertos ao total
                            }
                        } catch (NumberFormatException e) {
                            // Em caso de erro de conversão, continua
                            System.err.println("Erro ao converter número: " + e.getMessage());
                        }
                    }
                }
            }

            // Adiciona a resposta da IA ao histórico
            historico.put(new JSONObject().put("role", "assistant").put("content", completion));

            // Atualiza os atributos da sessão
            session.setAttribute("historico", historico.toString());
            session.setAttribute("contagem", contRes + 1);
            session.setAttribute("acerto", contAcer); 
            request.setAttribute("completion", completion);
        } catch (Exception ex) {
            // Em caso de erro, reseta a sessão
            request.setAttribute("error", ex.getMessage());
            session.invalidate();
        }
    }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Questionário | Learning with RMS</title>
        <!--<link rel="stylesheet" type="text/css" href="CSS/estilos.css"/>-->
    </head>
    <body>
        <!--<header>
        <%@include file="WEB-INF/JSPF/menu.jspf"%>
        </header>
        <main>-->
        <h1>Questionário</h1>
        <% if (request.getAttribute("error") != null) {%>
        <div style="color: red;">ERRO: <%= request.getAttribute("error")%></div>
        <% } else if (request.getAttribute("completion") != null) {%>
        <h2>MATÉRIA - <%= request.getParameter("materias").toUpperCase()%></h2>
        <div><pre><%= request.getAttribute("completion")%></pre></div>
        <% }%>
        <%= contAcer%>
        <hr>
        <form>
            <label for="materias">MATÉRIA</label>
            <select name="materias" id="materias">
                <optgroup label="Exatas">
                    <option value="matematica">Matemática</option>
                    <option value="biologia">Biologia</option>
                    <option value="quimica">Química</option>
                    <option value="fisica">Física</option>
                </optgroup>
                <optgroup label="Humanas">
                    <option value="sociologia">Sociologia</option>
                    <option value="historia">História</option>
                    <option value="geografia">Geografia</option>
                    <option value="filosofia">Filosofia</option>
                </optgroup>
            </select>
            <label for="dificuldade">DIFICULDADE</label>
            <select name="dificuldade" id="dificuldade">
                <option value="muito facil">Muito fácil</option>
                <option value="facil">Fácil</option>
                <option value="medio">Médio</option>
                <option value="dificil">Difícil</option>
                <option value="muito dificil">Muito difícil</option>
            </select>

            <p>Escolha uma alternativa:</p>
            <div>
                <input type="radio" id="escolhaA" name="escolhas" value="A">
                <label for="escolhaA">A</label>
            </div>
            <div>
                <input type="radio" id="escolhaB" name="escolhas" value="B">
                <label for="escolhaB">B</label>
            </div>
            <div>
                <input type="radio" id="escolhaC" name="escolhas" value="C">
                <label for="escolhaC">C</label>
            </div>
            <div>
                <input type="radio" id="escolhaD" name="escolhas" value="D">
                <label for="escolhaD">D</label>
            </div>
            <div>
                <input type="radio" id="escolhaE" name="escolhas" value="E">
                <label for="escolhaE">E</label>
            </div>

            <input type="submit" name="enviar" value="Enviar">
        </form>
        <!--</main>-->
    </body>
</html>