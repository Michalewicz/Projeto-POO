/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Learning_POO_IA;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.security.cert.X509Certificate;
import javax.net.ssl.SSLContext;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 *
 * @author Rafael
 */
public class WebIA {
    private static final String API_KEY = "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";
    
    private static final HttpClient httpClient = createHttpClient();
    
    // Certificação do servidor para o uso da IA.
    private static HttpClient createHttpClient() {
        try {
            TrustManager[] trustAllCerts = new TrustManager[]{
                new X509TrustManager() {
                    public X509Certificate[] getAcceptedIssuers() { return null; }
                    public void checkClientTrusted(X509Certificate[] certs, String authType) {}
                    public void checkServerTrusted(X509Certificate[] certs, String authType) {}
                }
            };

            SSLContext sslContext = SSLContext.getInstance("SSL");
            sslContext.init(null, trustAllCerts, new java.security.SecureRandom());

            return HttpClient.newBuilder()
                .sslContext(sslContext)
                .build();
        } catch (Exception e) {
            throw new RuntimeException("Erro ao configurar HttpClient: " + e.getMessage());
        }
    }
    
    public static String getCompletion(String prompt) throws Exception {
        // Definição do modelo da IA e o prompt da IA com a definição de suas tarefas com o usuário.
        String promptPrimario = "Seja um professor de materia que dá perguntas para o usuário com alternativas de A, B, C, D, E e quando o usuário responde essa pergunta diz se está correto ou não. Faça isso até 10 vezes e dê a nota do usuário (acertos e erros), depois diga o que ele deve melhorar mais (se baseando no que ele errou)";
        JSONObject data = new JSONObject();
        data.put("model", "llama-3.1-8b-instant");
        data.put("messages", new JSONArray()
                .put(new JSONObject()
                .put("role", "system")
                .put("content", promptPrimario)
            )
                .put(new JSONObject()
                .put("role", "user")
                .put("content", prompt)
            )
                .put(new JSONObject()
                .put("role", "assistant")
                .put("content", "")
            )
        );
        // Tokens máximos e randomicidade da IA.
        data.put("max_tokens", 4500);
        data.put("temperature", 1.0);
        
        // Request da API de compleção do GROQ
        HttpRequest request = HttpRequest.newBuilder()
                .uri(new URI("https://api.groq.com/openai/v1/chat/completions"))
                .header("Authorization", "Bearer " + API_KEY)
                .header("Content-Type", "application/json")
                .POST(HttpRequest.BodyPublishers.ofString(data.toString()))
                .build();

        HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());

        if (response.statusCode() != 200) {
            throw new RuntimeException("Erro na requisição: " + response.statusCode() + " - " + response.body());
        } else {
            return new JSONObject(response.body())
                    .getJSONArray("choices")
                    .getJSONObject(0)
                    .getJSONObject("message")
                    .get("content").toString()
                    // Conversão de **texto** que a IA usa para colocar em negrito para <b></b>
                    .replaceAll("\\*\\*(.*?)\\*\\*", "<b>$1</b>");
        }
    }
    
    /*public static String getMemory(String promptIA) throws Exception {
        JSONObject data = new JSONObject();
        data.put("model", "llama-3.1-8b-instant");
        data.put("messages", new JSONArray()
                .put(new JSONObject()
                .put("role", "assistant")
                .put("content", promptIA)
            )
        );
        
        HttpRequest request = HttpRequest.newBuilder()
                .uri(new URI("https://api.groq.com/openai/v1/chat/completions"))
                .header("Authorization", "Bearer " + API_KEY)
                .header("Content-Type", "application/json")
                .POST(HttpRequest.BodyPublishers.ofString(data.toString()))
                .build();

        HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
        
        if (response.statusCode() != 200) {
            throw new RuntimeException("Erro na requisição: " + response.statusCode() + " - " + response.body());
        } else {
            return new JSONObject(response.body())
                    .getJSONArray("choices")
                    .getJSONObject(0)
                    .getJSONObject("message")
                    .get("content").toString();
        }
    }*/
    
    public static JSONObject getCompletion(JSONObject data) throws Exception {
        HttpRequest request = HttpRequest.newBuilder()
                .uri(new URI("https://api.groq.com/openai/v1/chat/completions"))
                .header("Authorization", "Bearer " + API_KEY)
                .header("Content-Type", "application/json")
                .POST(HttpRequest.BodyPublishers.ofString(data.toString()))
                .build();

        HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());

        if (response.statusCode() != 200) {
            throw new RuntimeException("Erro na requisição: " + response.statusCode() + " - " + response.body());
        } else {
            return new JSONObject(response.body());
        }
    }

}