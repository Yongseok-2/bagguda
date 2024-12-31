package termpackage;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.sql.SQLException;
import com.mysql.cj.jdbc.AbandonedConnectionCleanupThread;

public class MySQLCleanupListener implements ServletContextListener {
    
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        // 여기에 초기 DB 작업이나 기타 코드 추가 가능
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        try {
            AbandonedConnectionCleanupThread.shutdown();
            System.out.println("MySQL AbandonedConnectionCleanupThread has been shut down.");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}