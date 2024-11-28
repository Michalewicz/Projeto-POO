package Learning_POO_DB;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/**
 *
 * @author Rafael
 */
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DataBank {

    private static final String URL = "jdbc:derby://localhost:1527/POOPROJECT";
    private static final String USER = "usuario";
    private static final String PASSWORD = "123";

    public static String buscarAtributo(String coluna, String tabela, String idColuna, String valorId) throws Exception {
        String query = "SELECT " + coluna + " FROM " + tabela + " WHERE " + idColuna + " = ?";
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD); PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, valorId); // Define o valor do parâmetro
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getString(coluna);
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace(); // Imprime a pilha de erros para depuração
            System.out.println("Erro ao buscar atributo: " + ex.getMessage());
        }
        return null; // Retorna null se nada for encontrado
    }

    public static boolean verificarUsuario(String email) {
        String query = "SELECT 1 FROM usuario WHERE nm_email_usuario =" + email;
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD); PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, email);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next(); // Retorna true se encontrar o usuário
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            System.out.println("Erro ao verificar usuário: " + ex.getMessage());
        }
        return false;
    }

    // Registra um novo usuário
    public static boolean registrarUsuario(String email, String nome, String senha) {
        String query = "INSERT INTO usuario (nm_email_usuario, nm_usuario, nm_senha_usuario) VALUES (?, ?, ?)";
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD); PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, email);
            stmt.setString(2, nome);
            stmt.setString(3, senha);

            int rowsInserted = stmt.executeUpdate();
            return rowsInserted > 0; // Retorna true se o registro foi inserido
        } catch (SQLException ex) {
            ex.printStackTrace();
            System.out.println("Erro ao registrar usuário: " + ex.getMessage());
        }
        return false;
    }

    public static boolean testarConexao() {
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD)) {
            System.out.println("Conexão bem-sucedida com o banco de dados.");
            return true;
        } catch (SQLException ex) {
            ex.printStackTrace();
            System.out.println("Erro ao conectar ao banco: " + ex.getMessage());
        }
        return false;
    }

    // Verifica se as credenciais são válidas
    public static boolean verificarCredenciais(String email, String senha) {
        String query = "SELECT 1 FROM usuario WHERE nm_email_usuario = ? AND nm_senha_usuario = ?";
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD); PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, email);
            stmt.setString(2, senha);

            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next(); // Retorna true se encontrar um registro correspondente
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            System.out.println("Erro ao verificar credenciais: " + ex.getMessage());
        }
        return false;
    }

    public static boolean atualizarUsuario(String email, String novoNome, String novaSenha) {
        String query = "UPDATE usuario SET nm_usuario = ?, nm_senha_usuario = ? WHERE nm_email_usuario = ?";
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD); PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, novoNome);
            stmt.setString(2, novaSenha);
            stmt.setString(3, email);

            int linhasAfetadas = stmt.executeUpdate();
            return linhasAfetadas > 0; // Retorna true se o registro foi atualizado
        } catch (SQLException ex) {
            ex.printStackTrace();
            System.out.println("Erro ao atualizar usuário: " + ex.getMessage());
        }
        return false;
    }
}
