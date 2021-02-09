package util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DatabaseUtil {
	public static Connection getConnection() {
		try {
			
			String dbURL = "jdbc:mysql://localhost:3306/BBS?characterEncoding=UTF-8&serverTimezone=UTC";
			String dbID = "root";
			String dbPassword = "990902";
			
			
			/* String dbURL = "jdbc:mysql://localhost:3306/BBS?characterEncoding=UTF-8&serverTimezone=UTC";
			  String dbID = "root";
			  String dbPassword = "990902"; */
			  Class.forName("com.mysql.cj.jdbc.Driver");
			  return DriverManager.getConnection(dbURL,dbID,dbPassword);//접속을 도와주는 매개체 역할
		}catch (Exception e) {
			e.printStackTrace();
			
		}
		return null;
	}
	
	
}
