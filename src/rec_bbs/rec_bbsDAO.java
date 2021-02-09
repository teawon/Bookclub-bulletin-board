package rec_bbs;

import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;

import java.util.ArrayList;

import util.DatabaseUtil;


public class rec_bbsDAO {
	
	private Connection conn;
	
	private ResultSet rs;
	
	public rec_bbsDAO() {
		conn=DatabaseUtil.getConnection();
	}
	
	public int write_rec(String userID, String rec_bookName, String rec_author, String rec_content, String rec_score, String rec_type) {
		String SQL="INSERT INTO REC_BBS VALUES(NULL, ?, ?, ?, ?, ? , ?, ?)";
		try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				
				pstmt.setString(1,userID.replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
				pstmt.setString(2,rec_bookName.replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
				pstmt.setString(3,rec_author.replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
				pstmt.setString(4,rec_content.replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
				pstmt.setString(5,rec_score.replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
				pstmt.setString(6,rec_type.replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
				pstmt.setInt(7,0);
				
				return pstmt.executeUpdate();
			
		   }catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터 베이스 오류
		
		
	
      }
	
	public ArrayList<rec_bbsDTO>getList(int pageNumber) {
	
		String SQL="SELECT * FROM REC_BBS ORDER BY REC_BBSID DESC LIMIT " + (pageNumber-1)*5 + "," +(pageNumber-1)*5+6;
		ArrayList<rec_bbsDTO> list = new ArrayList<rec_bbsDTO>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs=pstmt.executeQuery();  //rs에 10번까지의 Bbs객체의 데이터(게시판)가 들어가게 되고 1번 데이터에서 나온 여러 가지 값들을 bbs객체에 임시로 넣고 함수 호풀시 만든 list에다가 넣어서 총 10개의 데이터가 list안에 전부 들어가도록 한다.
			while(rs.next())
			{
				rec_bbsDTO rec=new rec_bbsDTO();
				rec.setRec_bbsID(rs.getInt(1));
				rec.setUserID(rs.getString(2));
				rec.setRec_bookName(rs.getString(3));
				rec.setRec_author(rs.getString(4));
				rec.setRec_content(rs.getString(5));
				rec.setRec_score(rs.getString(6));
				rec.setRec_type(rs.getString(7));
				rec.setRec_likeCount(rs.getInt(8));
				list.add(rec);
			}
			return list; 
			
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return list; 
		
		
	
		}
	
	public int like(int rec_bbsID) {
		String SQL="UPDATE REC_BBS SET rec_likeCount = rec_likeCount + 1 WHERE rec_bbsID = ?";
		try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, rec_bbsID);
				return pstmt.executeUpdate();
			} catch (Exception e) {
				 e.printStackTrace();
			}
		return -1;
		
		
		
	}
	
	public int delete(int rec_bbsID) {
		String SQL="DELETE FROM REC_BBS WHERE rec_bbsID = ?";
		try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, rec_bbsID);
				return pstmt.executeUpdate();
			} catch (Exception e) {
				 e.printStackTrace();
			}
		return -1;
		
		
		
	}
	
	public String getUserID(int rec_bbsID) {
		String SQL="SELECT userID FROM REC_BBS WHERE rec_bbsID = ?"; // 내림차순으로 정렬 후 가장 큰 값 가져옴
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,rec_bbsID);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return null; //데이터 베이스 오류 string형식이라 -1 안됨
	}
		
	
}
