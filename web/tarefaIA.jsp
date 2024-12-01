<%-- 
    Document   : tarefaIA
    Created on : 16 de nov. de 2024, 15:02:19
    Author     : Rafael
--%>

<%@page import="Learning_POO_DB.DataBank"%>
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

    String nomeMateria = new String(request.getParameter("materia").getBytes("ISO-8859-1"), "UTF-8");
    String nomeDificuldade = new String(request.getParameter("dificuldade").getBytes("ISO-8859-1"), "UTF-8");

    // Inicialização de variáveis da sessão, se necessário
    if (contAcer == null) {
        contAcer = 0;
    }
    if (contAcerMax == null) {
        contAcerMax = 5; // Definido como 5 porque o questionário sempre tem 5 perguntas
    }
    if (promptIA == null) {
        promptIA = "[]";
    }
    if (contRes == null) {
        contRes = 0;
    }

    try {
        // Obtém os parâmetros enviados pelo formulário
        String promptM = request.getParameter("materia");
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

        // Regex para capturar o número de pontos antes de "/5"
        String regex = "Total de pontos:\\s*(\\d)/5";

        // Compilar o padrão
        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(completion);

        // Captura e soma os acertos com base no texto da IA
        while (matcher.find()) {
            try {
                // Captura o valor do grupo 1 (o número de pontos)
                int pontos = Integer.parseInt(matcher.group(1));
                contAcer = pontos; // Atualiza o valor dos acertos
            } catch (NumberFormatException e) {
                System.err.println("Erro ao converter número: " + e.getMessage());
            }
        }

        // Adiciona a resposta da IA ao histórico
        historico.put(new JSONObject().put("role", "assistant").put("content", completion));

        // Atualiza os atributos da sessão
        session.setAttribute("historico", historico.toString());
        session.setAttribute("contagem", contRes + 1);
        session.setAttribute("acerto", contAcer);
        request.setAttribute("completion", completion);

        // Atualiza a tabela 'proficiencia_usuario' no banco de dados
        Integer idUsuario = DataBank.buscarIdUsuarioPorEmail((String) session.getAttribute("email"));
        Integer idMateria = DataBank.getIdMateriaPorNome(nomeMateria);
        Integer idTarefa = DataBank.getIdTarefaPorUsuarioMateriaEDificuldade(idUsuario, idMateria, DataBank.getIdDificuldadePorNome(nomeDificuldade));

        if (contRes == 5) {
            boolean sucesso = DataBank.atualizarProficienciaUsuario(idUsuario, idMateria, contAcer, contAcerMax, idTarefa);
            // Mensagem de sucesso ou erro
        }

        if (contRes == 5 && contAcer > 3) {
            // Atualiza a proficiência e desbloqueia a próxima tarefa
            DataBank.atualizarProficienciaUsuario(idUsuario, idMateria, contAcer, contAcerMax, idTarefa);

            // Desbloqueia a próxima tarefa
            int idProximaTarefa = DataBank.getProximaTarefa(idMateria, idTarefa);
            if (idProximaTarefa != -1) {
                DataBank.desbloquearTarefa(idUsuario, idMateria, idProximaTarefa);
            }
        }
    } catch (Exception ex) {
        // Em caso de erro, reseta a sessão
        request.setAttribute("error", ex.getMessage());
        session.setAttribute("contagem", contRes = 0);
        session.setAttribute("acerto", contAcer = 0);
    }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tarefa de <%= nomeMateria%> | Learning with RMS</title>
        <link rel="stylesheet" type="text/css" href="CSS/estilos.css"/>
        <link rel="icon" href="images/icone.png" type="image/png">
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: Arial, sans-serif;
            }

            body {
                min-height: 100vh;
                background: linear-gradient(180deg, #FCFBFF, #D9F6FF);
            }

            main {
                width: 100%;
                max-width: 500px;
                margin: 50px auto;
                display: flex;
                flex-direction: column;
                align-items: center;
            }

            .top-divider {
                width: 100%;
                height: 3px;
                background-color: rgb(0, 17, 255);
                margin: 20px auto;
                border-radius: 2px;
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

            .finish-quiz,
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

            .finish-quiz:hover,
            input[name="enviar"]:hover {
                background-color: rgb(0, 13, 204);
            }

        </style>
    </head>
    <body>
        <header>
            <%@include file="WEB-INF/JSPF/menu.jspf"%>
        </header>
        <main>
            <h1>Tarefa de <%= nomeMateria%></h1>
            <% if (request.getAttribute("error") != null) {%>
            <div style="color: red;">ERRO: <%= request.getAttribute("error")%></div>
            <div class="top-divider"></div>
            <% } else if (request.getAttribute("completion") != null) {%>
            <h2>Nível - <%= nomeDificuldade%></h2>
            <div class="top-divider"></div>
            <div><pre><%= request.getAttribute("completion")%></pre></div>
            <% }%>
            <br>
            <hr>
            <%if (contRes < 5) {%>
            <form>
                <input type="hidden" name="materia" value="<%= request.getParameter("materia")%>">
                <input type="hidden" name="dificuldade" value="<%= request.getParameter("dificuldade")%>">
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
            <%} else if (contRes == 5) {%>
            <a href="tarefas.jsp"><button class="finish-quiz">Finalizar tarefa</button></a>
            <% promptIA = "[]";
                }%>
        </main>
    </body>
</html>