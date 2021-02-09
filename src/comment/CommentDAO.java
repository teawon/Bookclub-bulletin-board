package comment;
import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;


import util.DatabaseUtil;



public class CommentDAO {

private Connection conn;
private ResultSet rs;

		
		public CommentDAO() {
			
				conn=DatabaseUtil.getConnection();
			
		}	
		
		public int upload(int bbsID, String userID, String content) {
			try {
				String SQL ="INSERT INTO COMMENT VALUES(?, ?, ?, ? , null)";
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, bbsID);
				pstmt.setString(2, userID.replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
				pstmt.setString(3, content.replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
				pstmt.setString(4, getDate());
				
				return pstmt.executeUpdate();
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			return -1;
		}
		
		
		public ArrayList<CommentDTO>getComments(int bbsID) {
			String SQL="SELECT * FROM COMMENT WHERE bbsID = ?";
			ArrayList<CommentDTO> list = new ArrayList<CommentDTO>();
			try {
					PreparedStatement pstmt = conn.prepareStatement(SQL);
					pstmt.setInt(1, bbsID);
					rs=pstmt.executeQuery();  
					while(rs.next())
					{
						CommentDTO comet = new CommentDTO();
						comet.setUserID(rs.getString(2));
						comet.setContent(rs.getString(3));
						comet.setCommentDate(rs.getString(4));
						comet.setComID(rs.getInt(5));
						list.add(comet);
					}
					return list;
				
				} catch (Exception e) {
					e.printStackTrace();
				}
			return null; 
			
		}
		
		
		
		public int delete(int comID) {
			String SQL="DELETE FROM COMMENT WHERE comID = ?";
			try {
					PreparedStatement pstmt = conn.prepareStatement(SQL);
					pstmt.setInt(1, comID);
					return pstmt.executeUpdate();
				} catch (Exception e) {
					 e.printStackTrace();
				}
			return -1;
			
			
			
		}
		
		public String getDate() {
			String SQL="SELECT NOW()"; //현재 시간을 가져오는 mysql 명령문
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				rs=pstmt.executeQuery();
				if(rs.next()) {
					return rs.getString(1);
				}
			}catch (Exception e) {
				e.printStackTrace();
			}
			return ""; //데이터 베이스 오류 string형식이라 -1 안됨
		}
}











