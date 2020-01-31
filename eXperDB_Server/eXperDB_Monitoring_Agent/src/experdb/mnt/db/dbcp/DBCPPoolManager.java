package experdb.mnt.db.dbcp;

import java.sql.DriverManager;
import java.util.Properties;

import org.apache.commons.dbcp.ConnectionFactory;
import org.apache.commons.dbcp.DriverManagerConnectionFactory;
import org.apache.commons.dbcp.PoolableConnectionFactory;
import org.apache.commons.dbcp.PoolingDriver;
import org.apache.commons.pool.ObjectPool;
import org.apache.commons.pool.impl.GenericObjectPool;
import org.apache.log4j.Logger;

public class DBCPPoolManager {
	private static Logger log = Logger.getLogger(DBCPPoolManager.class);
	
	public static void setupDriver(String driver, String url, String user, String password, String poolName, int maxActive) throws Exception {
		log.info("************************************************************");
		log.info("Create DBCPPool ["+poolName+"]");		
		
		// JDBC 클래스 로딩
		try {
			Class.forName(driver);
			
			//DB 연결대기 시간
			DriverManager.setLoginTimeout(5);
			
	        // DB URI
	        String connectURI = url;
	        String validationQuary = "select 1";
	        
	        // ID and Password
	        Properties props = new Properties();
	        props.put("user", user);
	        props.put("password", password);
	        //props.put("socketTimeout", "1");
	        props.put("tcpKeepAlive", "true");
	        
	        // 커넥션 풀로 사용할 commons-collections의 genericOjbectPool을 생성 
	        GenericObjectPool connectionPool = new GenericObjectPool(null);
	        
	        // Pool에서 Connection을 받아와 DB에 Query문을 날리기 전에
	        // 해당 Connection이 Active한지 Check하고 
	        // Active하지 않으면 해당 Connection을 다시 생성합니다
	        connectionPool.setTestOnBorrow(true);
	        connectionPool.setTestOnReturn(true);
	        connectionPool.setTestWhileIdle(true);
	        connectionPool.setMaxActive(maxActive);	        
	        
	        connectionPool.setMinEvictableIdleTimeMillis(30 * 1000);
	        connectionPool.setTimeBetweenEvictionRunsMillis(30 * 1000);
	        
	        // 풀이 커넥션을 생성하는데 사용하는 DriverManagerConnectionFactory를 생성
	        ConnectionFactory connectionFactory = new DriverManagerConnectionFactory(connectURI, props);
	        
	        // ConnectionFactory의 래퍼 클래스인 PoolableConnectionFactory를 생성
            PoolableConnectionFactory poolableConnectionFactory =
                    new PoolableConnectionFactory(connectionFactory, connectionPool, null, validationQuary, false, true);	        
	        
            //PoolingDriver 자신을 로딩
            Class.forName("org.apache.commons.dbcp.PoolingDriver");
            PoolingDriver pDriver = (PoolingDriver) DriverManager.getDriver("jdbc:apache:commons:dbcp:");
            
            //Pool 등록
            pDriver.registerPool(poolName, connectionPool);
            
		} catch (Exception e) {
			throw e;
		}
		
		log.info("Complete creation DBCPPool ["+poolName+"]");
		log.info("************************************************************");		
	}
	
	public static void shutdownDriver(String poolName) throws Exception {
		PoolingDriver driver = (PoolingDriver) DriverManager.getDriver("jdbc:apache:commons:dbcp:");
		driver.closePool(poolName);
	}
	
    public static void printDriverStats(String poolName) throws Exception {
        PoolingDriver driver = (PoolingDriver) DriverManager.getDriver("jdbc:apache:commons:dbcp:");
        ObjectPool connectionPool = driver.getConnectionPool(poolName);
        
        log.info("["+poolName+"] NumActive: [" + connectionPool.getNumActive() + "] NumIdle: [" + connectionPool.getNumIdle() + "]");
    }
}
