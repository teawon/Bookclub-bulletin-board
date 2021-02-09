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
			//String dbURL ="jdbc:mysqul://localhost:3306/BBS"; ������ ������ ��
			//String dbURL = "jdbc:mysql: //localhost:3306/BBS?serverTimezone=UTC";
			//String dbID = "root";
			//String dbPassword = "990902";
			//Class.forName("com.mysql.jdbc.Drvier"); 
			
			  String dbURL = "jdbc:mysql://localhost:3306/BBS?characterEncoding=UTF-8&serverTimezone=UTC";
			  String dbID ="root";
			  String dbPassword = "990902";
			   Class.forName("com.mysql.cj.jdbc.Driver"); //������ �����ִ� �Ű�ü ����
			conn=DriverManager.getConnection(dbURL,dbID,dbPassword);
			//conn��ü �ȿ�  ���ӵ� ������ ���� ��.
		} catch (Exception e) {
			e.printStackTrace();
		}   -> ó���� ��� dao���Ͽ� �ش� ������ �־��ٰ� util�� �ٲ�
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
						return 1; //�α��� ���� , ��� ����
					
					else 
						return 0; //��� Ʋ��
					
				}
				return -1; //���̵� ����
			
			
			} catch (Exception e) {
					e.printStackTrace();
			}
			return -2; //������ ���̽� ����
		
	}
	
	public int join(User user) {
		String SQL ="INSERT INTO USER VALUES(?, ?, ?)";
		try {

			pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			return pstmt.executeUpdate(); //INSERT������ ������ ���� �ݵ�� 0�̻��� ���ڰ� ��ȯ�ȴ�.
			
			
			
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //-1�� �ƴѰ�� ���������� ȸ�������� �Ǿ����� �ǹ��Ѵ�.
	}
}
