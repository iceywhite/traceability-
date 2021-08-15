package TraceLinkOntologyDBConnector;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

//Purpose: This class is designed as a connection to TMS database and will offer some convenient methods
public class TMSDBConnection {

	private String host;
	private int port;
	private String DBName;
	private String account;
	private String password;
	
	public TMSDBConnection(String account, String password) {
		this("traceability", account, password);
	}
	
	public TMSDBConnection(String DBName, String account, String password) {
		this(3306, DBName, account, password);
	}
	
	public TMSDBConnection(int port, String DBName, String account, String password) {
		this("localhost", port, DBName, account, password);
	}
	
	public TMSDBConnection(String host, String DBName, String account, String password) {
		this(host, 3306, DBName, account, password);
	}
	
	public TMSDBConnection(String host, int port, String DBName, String account, String password) {
		this.host = host;
		this.port = port;
		this.DBName = DBName;
		this.account = account;
		this.password = password;
	}
	
	private String getURL() {
		return String.format("jdbc:mysql://%s:%d/%s", host, port, DBName);
	}
	
	public Connection getConnection() throws ClassNotFoundException, SQLException {
		// Import MySQL JDBC driver
		Class.forName("com.mysql.jdbc.Driver");
		return DriverManager.getConnection(getURL(), account, password);
		
	}
	
	//This main method is for testing
	public static void main(String[] args) {
		TMSDBConnection DBConn = new TMSDBConnection("remote", "remoteUserPwd");
		try {
			Connection conn = DBConn.getConnection();
			System.out.println("Connection created.");
			conn.close();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			System.out.println("Failed to connect to MySQL server.");
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	
	
}
