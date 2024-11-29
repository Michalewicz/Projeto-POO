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
import java.util.List;
import java.util.ArrayList;

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

    public static int quantidadeMateria() {
        int qtdMateria = 0;
        String query = "SELECT COUNT(id_materia) AS total FROM materia";
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD); PreparedStatement stmt = conn.prepareStatement(query); ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) { // Move para o primeiro registro do ResultSet
                qtdMateria = rs.getInt("total"); // Obtém o valor da contagem
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            System.out.println("Erro ao buscar a quantidade de matérias: " + ex.getMessage());
        }
        return qtdMateria;
    }

    public static String buscarMateriaPorId(int idMateria) {
        String nomeMateria = null;
        String query = "SELECT nm_materia FROM materia WHERE id_materia = ?";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD); PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, idMateria); // Define o parâmetro para a consulta
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    nomeMateria = rs.getString("nm_materia");
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            System.out.println("Erro ao buscar matéria por ID: " + ex.getMessage());
        }
        return nomeMateria;
    }

    public static void matricularMaterias(int idUsuario, List<Integer> idsMaterias) {
        String query = "INSERT INTO usuario_materia (id_usuario, id_materia, dt_matricula) VALUES (?, ?, ?)";
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD); PreparedStatement stmt = conn.prepareStatement(query)) {

            // A data de matrícula será a data atual
            java.sql.Date dataMatricula = new java.sql.Date(System.currentTimeMillis());

            // Inserir cada matéria selecionada
            for (Integer idMateria : idsMaterias) {
                stmt.setInt(1, idUsuario);  // ID do usuário
                stmt.setInt(2, idMateria);   // ID da matéria
                stmt.setDate(3, dataMatricula); // Data da matrícula
                stmt.addBatch(); // Adiciona à batch para execução
            }

            // Executar a batch de inserção
            int[] resultados = stmt.executeBatch();
            System.out.println("Inserção realizada. Linhas afetadas: " + resultados.length);
        } catch (SQLException ex) {
            ex.printStackTrace();
            System.out.println("Erro ao matricular matérias: " + ex.getMessage());
        }
    }

    public static int buscarIdUsuarioPorEmail(String email) {
        String query = "SELECT id_usuario FROM usuario WHERE nm_email_usuario = ?";
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD); PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, email);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("id_usuario");
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            System.out.println("Erro ao buscar ID do usuário: " + ex.getMessage());
        }
        return -1; // Retorna -1 se não encontrar
    }

    public static List<Integer> buscarIdsMateriaPorNomes(List<String> nomesMaterias) {
        String query = "SELECT id_materia FROM materia WHERE nm_materia = ?";
        List<Integer> idsMaterias = new ArrayList<>();

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD); PreparedStatement stmt = conn.prepareStatement(query)) {

            for (String nomeMateria : nomesMaterias) {
                stmt.setString(1, nomeMateria);
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        idsMaterias.add(rs.getInt("id_materia"));
                    }
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            System.out.println("Erro ao buscar IDs das matérias: " + ex.getMessage());
        }

        return idsMaterias; // Retorna a lista de IDs
    }

    public static int contarMatriculaUsuario(int idUsuario) {
        int qtdMatricula = 0;
        String query = "SELECT COUNT(id_materia) AS total FROM usuario_materia WHERE id_usuario = ?";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD); PreparedStatement stmt = conn.prepareStatement(query)) {

            // Definindo o parâmetro do usuário
            stmt.setInt(1, idUsuario);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    qtdMatricula = rs.getInt("total");  // Recupera o número total de matérias matriculadas
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            System.out.println("Erro ao contar as matrículas do usuário: " + ex.getMessage());
        }

        return qtdMatricula;  // Retorna a quantidade de matrículas do usuário
    }

    public static List<Integer> listarMatriculaUsuario(int idUsuario) {
        List<Integer> materiasMatriculadas = new ArrayList<>();
        String query = "SELECT id_materia FROM usuario_materia WHERE id_usuario = ?";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD); PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, idUsuario);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    int idMateria = rs.getInt("id_materia");
                    materiasMatriculadas.add(idMateria);  // Adiciona o id_materia à lista
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            System.out.println("Erro ao listar as matérias matriculadas: " + ex.getMessage());
        }

        return materiasMatriculadas;  // Retorna a lista com os ids das matérias matriculadas
    }
}
