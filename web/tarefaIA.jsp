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
    // Obtém o histórico da sessão (se houver) ou cria um novo
    String promptIA = (String) session.getAttribute("historico");
    Integer contRes = (Integer) session.getAttribute("contagem");

    // Inicializa PromptIA e contRes se forem nulos
    if (promptIA == null) {
        promptIA = "[]";
    }
    if (contRes == null) {
        contRes = 0;
    } else if (contRes > 11) {
        // Reseta PromptIA e contRes após o questionário
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
                    "FUNÇÃO: PROFESSOR\nMATÉRIA: " + promptM + 
                    "\nDIFICULDADE: " + promptDif + 
                    "\nMÉTODO: QUESTIONÁRIO DE 10 PERGUNTAS COM ALTERNATIVAS: 'A', 'B', 'C', 'D', 'E'" +
                    "\nOBJETIVO FINAL: DIZER AO USUÁRIO ONDE ELE DEVE APRIMORAR SEUS CONHECIMENTOS E MOSTRAR SEMPRE A QUANTIDADE DE ACERTOS DELE.\n" +
                    "OBSERVAÇÃO: SEMPRE EXIBA O TOTAL DE PONTOS E NUNCA SUBTRAÍA OS PONTOS."));
                historico.put(new JSONObject().put("role", "user").put("content", 
                    "Olá! Desejo saber mais sobre " + promptM + "!"));
            } else {
                // Interação subsequente
                historico.put(new JSONObject().put("role", "user").put("content", 
                    "É a alternativa letra " + prompt + "!"));
            }

            // Chama o método da IA com o histórico completo
            String completion = WebIA.getCompletion(promptM, historico.toString(), promptDif, prompt, contRes);

            // Adiciona a resposta da IA ao histórico
            historico.put(new JSONObject().put("role", "assistant").put("content", completion));

            // Atualiza os atributos da sessão
            session.setAttribute("historico", historico.toString());
            session.setAttribute("contagem", contRes + 1);
            request.setAttribute("completion", completion);
        } catch (Exception ex) {
            // Em caso de erro, reseta os dados da sessão
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

        <% if (request.getAttribute("error") != null && contRes <= 10) {%>
        <div>ERRO: <%= request.getAttribute("error")%></div>
        <hr/>
        <% } else if (request.getAttribute("completion") != null && contRes <= 10) {%>
        <h2>MATÉRIA - <%=request.getParameter("materias").toUpperCase()%></h2>
        <div><pre><%= request.getAttribute("completion")%></pre></div>
        <hr/>
        <% }%>
        MATÉRIA DIFICULDADE<br/>
        <form>
            <select name="materias" id="materias">
                <optgroup label="Exatas">
                    <option value="matematica">Matemática</option>
                    <option value="biologia">Biologia</option>
                    <option value="quimica">Quimíca</option>
                    <option value="fisica">Física</option>
                </optgroup>
                <optgroup label="Humanas">
                    <option value="sociologia">Sociologia</option>
                    <option value="historia">História</option>
                    <option value="geografia">Geografia</option>
                    <option value="filosofia">Filosofia</option>
                </optgroup>
            </select>
            <select name="dificuldade" id="dificuldade">
                    <option value="muito facil">Muito fácil</option>
                    <option value="facil">Fácil</option>
                    <option value="medio">Médio</option>
                    <option value="dificil">Difícil</option>
                    <option value="muito dificil">Muito difícil</option>
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
