package user;

import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import util.DatabaseUtil;

public class UserDAO {

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public UserDAO() {
		
			conn=DatabaseUtil.getConnection();
		
	}
	
	/*public UserDAO() {
		try {
			//String dbURL ="jdbc:mysqul://localhost:3306/BBS"; 이유는 모르지만 안
			//String dbURL = "jdbc:mysql: //localhost:3306/BBS?serverTimezone=UTC";
			//String dbID = "root";
			//String dbPassword = "990902";
			//Class.forName("com.mysql.jdbc.Drvier"); 
			
			  String dbURL = "jdbc:mysql://localhost:3306/BBS?characterEncoding=UTF-8&serverTimezone=UTC";
			  String dbID ="root";
			  String dbPassword = "990902";
			   Class.forName("com.mysql.cj.jdbc.Driver"); //접속을 도와주는 매개체 역할
			conn=DriverManager.getConnection(dbURL,dbID,dbPassword);
			//conn객체 안에  접속된 정보가 담기게 됨.
		} catch (Exception e) {
			e.printStackTrace();
		}   -> 처음에 모든 dao파일에 해당 문구를 넣었다가 util로 바꿈
		import java.sql.DriverManager;
		
	*/
	public int login(String userID, String userPassword) {
			String SQL ="SELECT userPassword FROM USER WHERE userID = ?";
			try {
				pstmt=conn.prepareStatement(SQL);
				pstmt.setString(1,userID);
				rs=pstmt.executeQuery();
				if (rs.next()) {
					if(rs.getString(1).equals(userPassword)) 
						return 1; //로그인 성공 , 비번 맞음
					
					else 
						return 0; //비번 틀림
					
				}
				return -1; //아이디 없음
			
			
			} catch (Exception e) {
					e.printStackTrace();
			}
			return -2; //데이터 베이스 오류
		
	}
	
	public int join(User user) {
		String SQL ="INSERT INTO USER VALUES(?, ?, ?)";
		try {

			pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			return pstmt.executeUpdate(); //INSERT문장을 실행한 경우는 반드시 0이상의 숫자가 반환된다.
			
			
			
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //-1이 아닌경우 성공적으로 회원가입이 되었음음 의미한다.
	}
}
