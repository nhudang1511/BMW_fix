package vn.connection;

import java.sql.Connection;
import java.sql.DriverManager;

public class ConnectJDBC {
	private final String serverName = "DESKTOP-600QP04";
	private final String dbName = "ChoOnline";
	private final String portNumber = "1433";
	private final String instance = "SQLEXPRESS";// MSSQLSERVER LEAVE THIS ONE EMPTY IF YOUR SQL IS A SINGLE INSTANCE
	private final String userID = "";
	private final String password = "";
	
	public Connection getConnection() throws Exception {
		String url = "jdbc:sqlserver://" + serverName
		+ "\\" + instance + ";integratedSecurity=true;databaseName=" +
		dbName;
		if (instance == null || instance.trim().isEmpty())
		url = "jdbc:sqlserver://" + serverName + ":" + portNumber +
		";integratedSecurity=true;databaseName=" + dbName;
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		return DriverManager.getConnection(url);
		}
	public static void main(String[] args) {
		try {
		System.out.println(new ConnectJDBC().getConnection());
		} catch (Exception e) {
		e.printStackTrace();
		}
		}
}


/*
 * public class ConnectJDBC { private final String serverName =
 * "ChoOnline.mssql.somee.com"; private final String dbName = "ChoOnline";
 * private final String portNumber = "1433"; private final String instance =
 * "SQLEXPRESS";// MSSQLSERVER LEAVE THIS ONE EMPTY IF YOUR SQL IS A SINGLE
 * INSTANCE private final String userID = "geight_nhuntq_SQLLogin_1"; private
 * final String password = "h699atltk4";
 * 
 * public Connection getConnection() throws Exception { String url =
 * "jdbc:sqlserver://" + serverName + ";databaseName=" + dbName; if (instance ==
 * null || instance.trim().isEmpty()) url = "jdbc:sqlserver://" + serverName +
 * ":" + portNumber + ";integratedSecurity=true;databaseName=" + dbName;
 * Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver"); return
 * DriverManager.getConnection(url,userID,password); } public static void
 * main(String[] args) { try { System.out.println(new
 * ConnectJDBC().getConnection()); } catch (Exception e) { e.printStackTrace();
 * } } }
 */