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

    public static String buscarAtributo(String coluna, String id, String atributo) throws Exception {
        String query = "SELECT " + coluna + " FROM usuario  WHERE " + id + " = " + atributo;
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD); PreparedStatement stmt = conn.prepareStatement(query)) {

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getString(atributo);
                }
            } catch (Exception quer) {
                System.out.println("Falha na querry");
            }
        } catch (SQLException ex) {
            System.out.println("Falha na conexão");
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
        String query = "INSERT INTO usuario (nm_email_usuario, nm_usuario, senha_usuario, qt_acerto, qt_maximo_acerto) VALUES (?, ?, ?, 0, 0)";
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(query)) {

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
        String query = "SELECT 1 FROM usuario WHERE nm_email_usuario = ? AND senha_usuario = ?";
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(query)) {

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
}