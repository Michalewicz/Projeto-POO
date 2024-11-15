/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Learning_POO;

/**
 *
 * @author Rafael
 */

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

public class ApiIA {
    public String respostaIA() throws IOException, InterruptedException{
        String[] materia = {"história","matemática","geografia","português"};
        var apiKey = "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";
        var body = """
                {
                    "model": "llama-3.1-8b-instant",
                    "messages": [
                        {
                            "role": "system",
                            "content": "Seja um professor de materia que dá perguntas para o usuário com alternativas de A, B, C, D, E e quando o usuário responde essa pergunta diz se está correto ou não. Faça isso até 10 vezes e dê a nota do usuário (acertos e erros), depois diga o que ele deve melhorar mais (se baseando no que ele errou)."
                        },
                    ]
                }""";

        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create("https://api.groq.com/openai/v1/chat/completions"))
                .header("Content-Type", "application/json")
                .header("Authorization", "Bearer " + apiKey)
                .POST(HttpRequest.BodyPublishers.ofString(body))
                .build();

        var client = HttpClient.newHttpClient();
        var response = client.send(request, HttpResponse.BodyHandlers.ofString());
        return response.body();
    }
    
    public static void main(String[] args) throws IOException, InterruptedException {
        
        ApiIA objeto = new ApiIA();
        
        System.out.println(objeto.respostaIA());
        
        
    }
    
}
