package wup.data.access;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 * MariaDB를 사용하는 DAO를 지원하기 위한 추상 클래스입니다.
 *
 * @author Eunbin Jeong
 *
 */
public abstract class MariaDbDao extends JdbcDao {
    @FunctionalInterface
    protected interface ResultSetFunction<U> {
        public DaoResult<U> process(ResultSet rs) throws Exception;
    }

    protected static final String CONN_NAME = "jdbc/mariadb";

    protected <T> DaoResult<T> querySingleItem(String tableName, int id, ResultSetFunction<T> func) {
        String sql = String.format("SELECT * FROM `%s` WHERE `id` = ?", tableName);

        try (Connection conn = getConnection(CONN_NAME); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);

            try (ResultSet rs = stmt.executeQuery()) {
                return func.process(rs);
            }
        } catch (Exception e) {
            return DaoResult.fail(DaoResult.Action.READ, e);
        }
    }
}
