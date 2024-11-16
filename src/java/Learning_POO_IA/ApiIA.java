/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Learning_POO_IA;

/**
 *
 * @author Rafael
 */

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import org.json.JSONArray;
import org.json.JSONObject;

public class ApiIA {
    private static final String API_KEY = "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";

    public static String getCompletion(String prompt) throws Exception {
        JSONObject data = new JSONObject();
        data.put("model", "llama-3.1-8b-instant");
        data.put("messages", new JSONArray()
            .put(new JSONObject()
                .put("role", "system")
                .put("content", "Seja um professor de materia que dá perguntas para o usuário com alternativas de A, B, C, D, E e quando o usuário responde essa pergunta diz se está correto ou não. Faça isso até 10 vezes e dê a nota do usuário (acertos e erros), depois diga o que ele deve melhorar mais (se baseando no que ele errou)")
            )
            .put(new JSONObject()
                .put("role", "user")
                .put("content", prompt)
            )
        );
        data.put("max_tokens", 4000);
        data.put("temperature", 1.0);
        HttpClient client = HttpClient.newHttpClient();
        HttpRequest request = HttpRequest.newBuilder()
            .uri(new URI("https://api.groq.com/openai/v1/chat/completions"))
            .header("Authorization", "Bearer " + API_KEY)
            .header("Content-Type", "application/json")
            .POST(HttpRequest.BodyPublishers.ofString(data.toString()))
            .build();
        HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());
        if (response.statusCode() != 200) {
            throw new RuntimeException("Erro na requisição: " + response.statusCode() + " - " + response.body());
        }else{
            return new JSONObject(response.body())
                    .getJSONArray("choices")
                    .getJSONObject(0)
                    .getJSONObject("message")
                    .get("content").toString();
        }
    }
    
    public static void main(String[] args) {
        try{
            System.out.println(ApiIA.getCompletion("Ensine história."));
        }catch(Exception ex){
            System.out.println("ERRO: "+ex.getLocalizedMessage());
        }
    }
    
}
