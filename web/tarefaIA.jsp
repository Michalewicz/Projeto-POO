<%-- 
    Document   : tarefaIA
    Created on : 16 de nov. de 2024, 15:02:19
    Author     : Rafael
--%>
<%@page import="Learning_POO_IA.WebIA"%>
<%@page import="Learning_POO_Logica.Logica_tarefaIA"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%
    
    if(request.getParameter("enviar")!=null){
        try{
            String prompt = request.getParameter("materias");
            String completion = WebIA.getCompletion(prompt);
            request.setAttribute("completion", completion);
            if(completion != null){
                
            }
        }catch(Exception ex){
            request.setAttribute("error", ex.getMessage());
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
        
        <% if(request.getAttribute("error") != null) { %>
        <div>ERRO: <%= request.getAttribute("error") %></div>
        <hr/>
        <% } else if(request.getAttribute("completion") != null) { %>
        <h2>MAT�RIA - <%= request.getParameter("materias").toUpperCase() %></h2>
        <h2>Completion</h2>
        <div><pre><%= request.getAttribute("completion") %></pre></div>
        <hr/>
        <% } %>
        
        MAT�RIA<br/>
        <form>
            <select name="materias" id="materias">
                <optgroup label="Exatas">
                  <option value="matem�tica">Matem�tica</option>
                  <option value="biologia">Biologia</option>
                  <option value="quim�ca">Quim�ca</option>
                  <option value="f�sica">F�sica</option>
                </optgroup>
                <optgroup label="Humanas">
                  <option value="sociologia">Sociologia</option>
                  <option value="hist�ria">Hist�ria</option>
                  <option value="geografia">Geografia</option>
                  <option value="filosofia">Filosofia</option>
                </optgroup>
            </select>
            <input type="submit" name="enviar" value="Enviar"/>
        </form>

    </body>
</html>
