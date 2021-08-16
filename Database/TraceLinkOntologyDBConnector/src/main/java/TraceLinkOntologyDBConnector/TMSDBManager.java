package TraceLinkOntologyDBConnector;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

// Purpose: This class is designed as a connection to TMS database and will offer some convenient methods
public class TMSDBManager {

	private String host;
	private int port;
	private String DBName;
	private String account;
	private String password;

	// Default local connection
	public TMSDBManager(String account, String password) throws SQLException {
		this("traceability", account, password);
	}

	// Default local connection with specified DB name
	public TMSDBManager(String DBName, String account, String password) throws SQLException {
		this(3306, DBName, account, password);
	}

	// Local connection with specified port
	public TMSDBManager(int port, String DBName, String account, String password) throws SQLException {
		this("localhost", port, DBName, account, password);
	}

	// Connection with default port
	public TMSDBManager(String host, String DBName, String account, String password) throws SQLException {
		this(host, 3306, DBName, account, password);
	}

	// Object Constructor
	public TMSDBManager(String host, int port, String DBName, String account, String password) throws SQLException {
		this.host = host;
		this.port = port;
		this.DBName = DBName;
		this.account = account;
		this.password = password;
		if (!this.testConnection())
			throw new SQLException("Connection availability testing failed.");
	}

	public String getHost() {
		return host;
	}

	public int getPort() {
		return port;
	}

	public String getDBName() {
		return DBName;
	}

	public String getAccount() {
		return account;
	}

	// Generate the URL to connect to the DB
	private String getURL() {
		return String.format("jdbc:mysql://%s:%d/%s", host, port, DBName);
	}

	// Get JDBC Connection
	public Connection getConnection() throws SQLException {
		return DriverManager.getConnection(getURL(), account, password);

	}

	// Purpose: Test whether this DBConnection is available
	private boolean testConnection() {
		// Print basic connection information
		System.out.println("Testing database connection to " + getHost() + ":" + getPort());
		try {
			// Test the availability of the connection
			// Create a new connection
			Connection conn = getConnection();
			System.out.println("Successfully connected");
			// Print Host Information
			System.out.println("Host: " + conn.getMetaData().getDatabaseProductName() + " "
					+ conn.getMetaData().getDatabaseProductVersion());
			conn.close();
		} catch (SQLException e) {
			System.out.println("Connection failed. Please check your settings.");
			return false;
		}
		return true;
	}

	// This main method is for testing
	public static void main(String[] args) {
		try {
			String account = "remote";
			String pwd = "remoteUserPwd";
			TMSDBManager DBMan = new TMSDBManager(account, pwd);
			Connection conn = DBMan.getConnection();
			System.out.println("Connection created.");
			conn.close();
		} catch (SQLException e) {
			System.out.println("Failed to connect to MySQL server.");
			// Print Stack Trace (Dev)
			e.printStackTrace();
		}

	}

}
