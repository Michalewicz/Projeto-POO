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
import java.util.HashMap;
import java.util.Map;

public class DataBank {

    private static final String URL = "jdbc:derby://localhost:1527/POOPROJECT";
    private static final String USER = "usuario";
    private static final String PASSWORD = "123";

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

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
        String dificuldade = null;
        String query = "SELECT nm_dificuldade FROM dificuldade WHERE id_dificuldade = ?";

        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
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

    public static boolean atualizarProficienciaUsuario(int idUsuario, int idMateria, int contAcer, int contAcerMax, int idTarefa) {
        // Consulta para verificar se a combinação de id_usuario, id_materia e id_tarefa já existe
        String checkExistQuery = """
        SELECT 1 
        FROM proficiencia_usuario 
        WHERE id_usuario = ? AND id_materia = ? AND id_tarefa = ?
    """;

        // Query para inserir dados
        String insertQuery = """
        INSERT INTO proficiencia_usuario (
            id_tarefa,
            id_usuario, 
            id_materia, 
            qt_ponto_usuario, 
            qt_ponto_maximo_usuario, 
            ic_tarefa_concluida_false_true
        )
        VALUES (?, ?, ?, ?, ?, 
            CASE WHEN ? > 3 THEN TRUE ELSE FALSE END)
    """;

        // Query para atualizar dados se a combinação já existir
        String updateQuery = """
        UPDATE proficiencia_usuario
        SET 
            qt_ponto_usuario = ?, 
            qt_ponto_maximo_usuario = ?, 
            ic_tarefa_concluida_false_true = CASE WHEN ? > 3 THEN TRUE ELSE FALSE END,
            dt_teste = CURRENT_DATE
        WHERE id_usuario = ? AND id_materia = ? AND id_tarefa = ?
    """;

        Connection conn = null;
        PreparedStatement stmtCheck = null;
        PreparedStatement stmtInsert = null;
        PreparedStatement stmtUpdate = null;
        ResultSet rs = null;

        try {
            conn = getConnection();
            conn.setAutoCommit(false);  // Inicia transação

            // Verificar se a combinação de id_usuario, id_materia e id_tarefa já existe
            stmtCheck = conn.prepareStatement(checkExistQuery);
            stmtCheck.setInt(1, idUsuario);
            stmtCheck.setInt(2, idMateria);
            stmtCheck.setInt(3, idTarefa);

            rs = stmtCheck.executeQuery();

            if (rs.next()) {
                // Se a combinação já existe, faz o UPDATE
                stmtUpdate = conn.prepareStatement(updateQuery);
                stmtUpdate.setInt(1, contAcer);  // Atualiza os pontos do usuário
                stmtUpdate.setInt(2, contAcerMax);  // Atualiza os pontos máximos
                stmtUpdate.setInt(3, contAcer);  // Atualiza se a tarefa foi concluída
                stmtUpdate.setInt(4, idUsuario);  // Condição: ID do usuário
                stmtUpdate.setInt(5, idMateria);  // Condição: ID da matéria
                stmtUpdate.setInt(6, idTarefa);   // Condição: ID da tarefa

                stmtUpdate.executeUpdate();  // Executa o UPDATE
            } else {
                // Se a combinação não existe, faz o INSERT
                stmtInsert = conn.prepareStatement(insertQuery);
                stmtInsert.setInt(1, idTarefa);
                stmtInsert.setInt(2, idUsuario);
                stmtInsert.setInt(3, idMateria);
                stmtInsert.setInt(4, contAcer);
                stmtInsert.setInt(5, contAcerMax);
                stmtInsert.setInt(6, contAcer);

                stmtInsert.executeUpdate();  // Executa o INSERT
            }

            conn.commit();  // Comita a transação
            return true;  // Operação bem-sucedida
        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback();  // Reverte a transação em caso de erro
                } catch (SQLException eRollback) {
                    System.err.println("Erro ao fazer rollback: " + eRollback.getMessage());
                }
            }
            System.err.println("Erro ao inserir ou atualizar: " + e.getMessage());
            e.printStackTrace();
            return false;  // Falha na operação
        } finally {
            // Fecha os recursos
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmtCheck != null) {
                    stmtCheck.close();
                }
                if (stmtInsert != null) {
                    stmtInsert.close();
                }
                if (stmtUpdate != null) {
                    stmtUpdate.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                System.err.println("Erro ao fechar recursos: " + e.getMessage());
            }
        }
    }

    public static int getIdMateriaPorNome(String nomeMateria) throws Exception {
        String query = "SELECT id_materia FROM materia WHERE nm_materia = ?";
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, nomeMateria); // Define o parâmetro da consulta
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("id_materia"); // Retorna o ID da matéria
                }
            }
        } catch (Exception e) {
            throw new Exception("Erro ao buscar ID da matéria: " + e.getMessage(), e);
        }
        return -1; // Retorna -1 caso a matéria não seja encontrada
    }

    public static int getIdDificuldadePorNome(String nomeDificuldade) throws Exception {
        String sql = "SELECT id_dificuldade FROM dificuldade WHERE nm_dificuldade_tarefa = ?";
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, nomeDificuldade); // Define o parâmetro da consulta
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("id_dificuldade"); // Retorna o ID da dificuldade
                }
            }
        } catch (Exception e) {
            throw new Exception("Erro ao buscar ID da dificuldade: " + e.getMessage(), e);
        }
        return -1; // Retorna -1 caso a dificuldade não seja encontrada
    }

    public static Integer getIdTarefaPorUsuarioMateriaEDificuldade(Integer idUsuario, Integer idMateria, Integer idDificuldade) {
        String sql = "SELECT id_tarefa FROM tarefa WHERE id_usuario = ? AND id_materia = ? AND id_dificuldade = ?";
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, idUsuario);
            stmt.setInt(2, idMateria);
            stmt.setInt(3, idDificuldade);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("id_tarefa");
                }
            }
        } catch (SQLException e) {
            System.err.println("Erro ao buscar id_tarefa para o usuário: " + e.getMessage());
        }
        return null; // Retorna null se não encontrar
    }

    public static List<Boolean> verificarTarefasConcluidas(int idUsuario, int idMateria) {
        List<Boolean> tarefasConcluidas = new ArrayList<>();
        try (Connection conn = getConnection()) {
            String sql = "SELECT ic_tarefa_concluida_false_true FROM proficiencia_usuario "
                    + "WHERE id_usuario = ? AND id_materia = ? ORDER BY id_tarefa ASC";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, idUsuario);
            stmt.setInt(2, idMateria);

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                tarefasConcluidas.add(rs.getBoolean("ic_tarefa_concluida_false_true"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tarefasConcluidas;
    }

    public static void desbloquearTarefa(int idUsuario, int idMateria, int idTarefa) {
        try (Connection conn = getConnection()) {
            String sql = "INSERT INTO proficiencia_usuario (id_usuario, id_materia, id_tarefa, ic_tarefa_concluida_false_true) "
                    + "VALUES (?, ?, ?, FALSE)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, idUsuario);
            stmt.setInt(2, idMateria);
            stmt.setInt(3, idTarefa);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static int getProximaTarefa(int idMateria, int idTarefaAtual) {
        try (Connection conn = getConnection()) {
            String sql = "SELECT id_tarefa FROM tarefa WHERE id_materia = ? AND id_tarefa > ? ORDER BY id_tarefa ASC LIMIT 1";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, idMateria);
            stmt.setInt(2, idTarefaAtual);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("id_tarefa");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1; // Nenhuma próxima tarefa encontrada
    }
    public static int obterTotalTarefasConcluidas(int idUsuario) {
    String sql = "SELECT COUNT(*) FROM proficiencia_usuario WHERE id_usuario = ? AND ic_tarefa_concluida_false_true = TRUE";
    try (Connection conn = getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setInt(1, idUsuario);
        ResultSet rs = stmt.executeQuery();
        return rs.next() ? rs.getInt(1) : 0;
    } catch (SQLException e) {
        e.printStackTrace();
        return 0;
    }
}
    public static double obterPrecisaoMedia(int idUsuario) {
    String sql = "SELECT COALESCE(SUM(qt_ponto_usuario), 0) * 100.0 / NULLIF(SUM(qt_ponto_maximo_usuario), 0) AS precisao_media " +
                 "FROM proficiencia_usuario WHERE id_usuario = ?";
    try (Connection conn = getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setInt(1, idUsuario);
        ResultSet rs = stmt.executeQuery();
        return rs.next() ? rs.getDouble("precisao_media") : 0.0;
    } catch (SQLException e) {
        e.printStackTrace();
        return 0.0;
    }
}
public static int obterTotalMateriasMatriculadas(int idUsuario) {
    String sql = "SELECT COUNT(*) FROM usuario_materia WHERE id_usuario = ?";
    try (Connection conn = getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setInt(1, idUsuario);
        ResultSet rs = stmt.executeQuery();
        return rs.next() ? rs.getInt(1) : 0;
    } catch (SQLException e) {
        e.printStackTrace();
        return 0;
    }
}
public static Map<String, Integer> obterPontosUsuario(int idUsuario) {
    String sql = "SELECT COALESCE(SUM(qt_ponto_usuario), 0) AS total_acertos, " +
                 "COALESCE(SUM(qt_ponto_maximo_usuario), 0) AS total_maximos " +
                 "FROM proficiencia_usuario WHERE id_usuario = ?";
    Map<String, Integer> pontos = new HashMap<>();
    try (Connection conn = getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setInt(1, idUsuario);
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            pontos.put("total_acertos", rs.getInt("total_acertos"));
            pontos.put("total_maximos", rs.getInt("total_maximos"));
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return pontos;
}

}
