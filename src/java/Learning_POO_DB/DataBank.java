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
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {

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
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {

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
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {

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
        try (Connection conn = getConnection()) {
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
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {

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
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {

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
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(query); ResultSet rs = stmt.executeQuery()) {

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

        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {

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
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {

            // A data de matrícula será a data atual
            java.sql.Date dataMatricula = new java.sql.Date(System.currentTimeMillis());

            for (Integer idMateria : idsMaterias) {
                stmt.setInt(1, idUsuario);
                stmt.setInt(2, idMateria);
                stmt.setDate(3, dataMatricula);
                stmt.addBatch(); // Adiciona à batch
            }

            // Executar a batch de inserção
            stmt.executeBatch();

            // Gerar as tarefas para cada matéria matriculada
            for (Integer idMateria : idsMaterias) {
                criarTarefasParaUsuario(idUsuario);
            }

            System.out.println("Matrícula e geração de tarefas realizadas com sucesso.");
        } catch (SQLException ex) {
            ex.printStackTrace();
            System.out.println("Erro ao matricular matérias: " + ex.getMessage());
        }
    }

    public static int buscarIdUsuarioPorEmail(String email) {
        String query = "SELECT id_usuario FROM usuario WHERE nm_email_usuario = ?";
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {

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

        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {

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

    public static List<Integer> listarMatriculaUsuario(int idUsuario) {
        List<Integer> materiasMatriculadas = new ArrayList<>();
        String query = "SELECT id_materia FROM usuario_materia WHERE id_usuario = ?";

        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {

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

    public static String buscarNomeMateriaPorId(int idMateria) {
        String nomeMateria = null;
        String query = "SELECT nm_materia FROM materia WHERE id_materia = ?";

        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, idMateria);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                nomeMateria = rs.getString("nm_materia");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return nomeMateria;
    }

    public static List<String> listarTarefasPorMateria(int idMateria, int idUsuario) {
        String query = "SELECT t.id_tarefa, t.id_materia, t.id_dificuldade, d.nm_dificuldade_tarefa "
                + "FROM tarefa t "
                + "INNER JOIN dificuldade d ON t.id_dificuldade = d.id_dificuldade "
                + "WHERE t.id_materia = ? "
                + "AND t.id_usuario = ?";
        List<String> tarefas = new ArrayList<>();

        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, idMateria);
            stmt.setInt(2, idUsuario);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    tarefas.add(rs.getString("nm_dificuldade_tarefa"));
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            System.out.println("Erro ao listar tarefas: " + ex.getMessage());
        }

        return tarefas;
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

    public static void criarTarefasParaUsuario(int idUsuario) {
        // Recupera as matérias do usuário
        List<Integer> idsMaterias = DataBank.listarMatriculaUsuario(idUsuario);

        // Usando transação para garantir a consistência
        Connection conn = null;
        try {
            conn = DataBank.getConnection(); // Método para obter a conexão com o banco
            conn.setAutoCommit(false); // Desabilita auto-commit para garantir que todas as inserções sejam tratadas como uma transação

            for (int idMateria : idsMaterias) {
                // Verificar se o usuário já tem tarefas associadas a essa matéria
                for (int idDificuldade = 0; idDificuldade < 7; idDificuldade++) {  // Existem 7 dificuldades
                    // Verifica se já existe uma tarefa para o usuário e a matéria
                    String checkQuery = "SELECT COUNT(*) FROM tarefa WHERE id_usuario = ? AND id_materia = ? AND id_dificuldade = ?";
                    PreparedStatement checkStmt = conn.prepareStatement(checkQuery);
                    checkStmt.setInt(1, idUsuario);
                    checkStmt.setInt(2, idMateria);
                    checkStmt.setInt(3, idDificuldade);

                    ResultSet rs = checkStmt.executeQuery();
                    rs.next();
                    int count = rs.getInt(1);

                    // Se não houver tarefas, insere as novas
                    if (count == 0) {
                        String insertQuery = "INSERT INTO tarefa (id_usuario, id_materia, id_dificuldade) VALUES (?, ?, ?)";
                        PreparedStatement insertStmt = conn.prepareStatement(insertQuery);
                        insertStmt.setInt(1, idUsuario);
                        insertStmt.setInt(2, idMateria);
                        insertStmt.setInt(3, idDificuldade);
                        insertStmt.executeUpdate();
                    }
                }
            }

            conn.commit(); // Se todas as inserções foram bem-sucedidas, confirma a transação

        } catch (SQLException e) {
            e.printStackTrace();
            if (conn != null) {
                try {
                    conn.rollback(); // Se houver erro, faz o rollback para reverter todas as inserções
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true); // Restaura o auto-commit
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    public static List<Integer> buscarMateriasMatriculadas(int idUsuario) {
        List<Integer> materiasMatriculadas = new ArrayList<>();
        String query = "SELECT id_materia FROM usuario_materia WHERE id_usuario = ?";

        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, idUsuario);

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                materiasMatriculadas.add(rs.getInt("id_materia"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return materiasMatriculadas;
    }
    public static String buscarDificuldadePorId(int idDificuldade) {
    // Supondo que você tenha uma tabela de dificuldades no banco de dados
    String dificuldade = null;
    String sql = "SELECT nm_dificuldade FROM dificuldade WHERE id_dificuldade = ?";
    
    try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setInt(1, idDificuldade);
        ResultSet rs = stmt.executeQuery();
        
        if (rs.next()) {
            dificuldade = rs.getString("nm_dificuldade");
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    
    return dificuldade;
}
    
}
