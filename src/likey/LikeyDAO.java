package likey;

import java.sql.Connection;
import util.DatabaseUtil;
import java.sql.PreparedStatement;


public class LikeyDAO {

	private Connection conn;
	
	
	public LikeyDAO() {
		conn=DatabaseUtil.getConnection();
	}
	
	public int like(String userID, int rec_bbsID, String userIP) {
		String SQL="INSERT INTO LIKEY VALUES(?,?,?)";
		try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1,userID);
				pstmt.setInt(2,rec_bbsID);
				pstmt.setString(3,userIP);
				return pstmt.executeUpdate();
			
		   }catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 추천 오류 -> 동일 글에 동일 유저의 정보가 들어가면 primary키 오류 발생.
	}
	
	
}




