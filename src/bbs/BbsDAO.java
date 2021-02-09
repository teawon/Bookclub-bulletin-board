package bbs;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Types;
import java.util.ArrayList;

import util.DatabaseUtil;

public class BbsDAO {
private Connection conn;
	
	private ResultSet rs;
	
	public BbsDAO() {
		conn=DatabaseUtil.getConnection();
	}
	
	
	public String getDate() {
		String SQL="SELECT NOW()"; //���� �ð��� �������� mysql ��ɹ�
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return ""; //������ ���̽� ���� string�����̶� -1 �ȵ�
	}
		//�������� ���� 1�� ũ�� ��ȯ�ߴµ� �ȵ�, �Ƹ� ���α׷��� ����ɶ����� ���������� 1�� �ʱ�ȭ �Ǵ°� ����.
	public int getNext() {
		String SQL="SELECT bbsID FROM BBS ORDER BY bbsID DESC"; // ������������ ���� �� ���� ū �� ������
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1)+1;
			}
			return 1; //ù ��° �Խù��̶�� 1 ����. (���� ���� ���, ���� mysql���� ���� �����ͼ� �ϳ� �� �ø�!)
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //������ ���̽� ���� string�����̶� -1 �ȵ�
	}
	
	public int getNext_FreeID() {
		String SQL="SELECT bbs_freeID FROM BBS ORDER BY bbs_freeID DESC"; // ������������ ���� �� ���� ū �� ������
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1)+1;
			}
			return 1; //ù ��° �Խù��̶�� 1 ����. (���� ���� ���, ���� mysql���� ���� �����ͼ� �ϳ� �� �ø�!)
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //������ ���̽� ���� string�����̶� -1 �ȵ�
	}
	
	public int getNext_BookID() {
		String SQL="SELECT bbs_bookID FROM BBS ORDER BY bbs_bookID DESC"; // ������������ ���� �� ���� ū �� ������
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1)+1;
			}
			return 1; //ù ��° �Խù��̶�� 1 ����. (���� ���� ���, ���� mysql���� ���� �����ͼ� �ϳ� �� �ø�!)
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //������ ���̽� ���� string�����̶� -1 �ȵ�
	}
	
	
	public int write_free(String bbsTitle, String userID, String bbsContent) {
		String SQL="INSERT INTO BBS VALUES(?, ?, ?, ?, ?, ? , ?, ?, ? ,?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,getNext());
			pstmt.setString(2,bbsTitle.replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(3,userID);
			pstmt.setString(4,getDate());
			pstmt.setString(5,bbsContent.replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setInt(6,1);
			pstmt.setInt(7,getNext_FreeID());
			pstmt.setNull(8,Types.INTEGER);
			pstmt.setInt(9, 0);
			pstmt.setInt(10,0);
			
			
			
			//rs=pstmt.executeQuery(); <- �Է¹����� �̰� ����
			return pstmt.executeUpdate();
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //������ ���̽� ����
		
		
	}
	
	public int write_book(String bbsTitle, String userID, String bbsContent) {
		String SQL="INSERT INTO BBS VALUES(?, ?, ?, ?, ?, ? , ?, ?,? , ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,getNext());
			pstmt.setString(2,bbsTitle.replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(3,userID);
			pstmt.setString(4,getDate());
			pstmt.setString(5,bbsContent.replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setInt(6,1);
			pstmt.setNull(7,Types.INTEGER);
			pstmt.setInt(8,getNext_BookID()); 
			pstmt.setInt(9, 0);
			pstmt.setInt(10,0);
			
			
			//rs=pstmt.executeQuery(); <- �Է¹����� �̰� ����
			return pstmt.executeUpdate();
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //������ ���̽� ����
		
		
	}
	

	public ArrayList<Bbs>getList_free(int pageNumber) {
		String SQL="SELECT * FROM BBS WHERE bbsAvailable = 1 AND bbs_freeID > 0 ORDER BY bbs_freeID DESC LIMIT "+ (pageNumber-1)*10 + "," +(pageNumber-1)*10+11;
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			
			rs=pstmt.executeQuery();  //rs�� 10�������� Bbs��ü�� ������(�Խ���)�� ���� �ǰ� 1�� �����Ϳ��� ���� ���� ���� ������ bbs��ü�� �ӽ÷� �ְ� �Լ� ȣǮ�� ���� list���ٰ� �־ �� 10���� �����Ͱ� list�ȿ� ���� ������ �Ѵ�.
			while(rs.next())
			{
				Bbs bbs=new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				bbs.setBbs_freeID(rs.getInt(7));
				bbs.setSeeCount(rs.getInt(9));
				bbs.setCommentCount(rs.getInt(10));
				list.add(bbs);
			}
			return list; 
			
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return list; 
		
		
	}
	
	public ArrayList<Bbs>getList_book(int pageNumber) {
		String SQL="SELECT * FROM BBS WHERE bbsAvailable = 1 AND bbs_bookID > 0 ORDER BY bbs_bookID DESC LIMIT "+ (pageNumber-1)*9 + "," +(pageNumber-1)*9+10;
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs=pstmt.executeQuery();  //rs�� 10�������� Bbs��ü�� ������(�Խ���)�� ���� �ǰ� 1�� �����Ϳ��� ���� ���� ���� ������ bbs��ü�� �ӽ÷� �ְ� �Լ� ȣǮ�� ���� list���ٰ� �־ �� 10���� �����Ͱ� list�ȿ� ���� ������ �Ѵ�.
			while(rs.next())
			{
				Bbs bbs=new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				bbs.setBbs_bookID(rs.getInt(8));
				bbs.setSeeCount(rs.getInt(9));
				bbs.setCommentCount(rs.getInt(10));
				list.add(bbs);
			}
			return list; 
			
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return list; 
		
		
	}

	public Bbs getBbs(int bbsID) {
		String SQL="SELECT * FROM BBS WHERE bbsID = ?";
		try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, bbsID);
				rs=pstmt.executeQuery();  
				if(rs.next())
				{
					Bbs bbs=new Bbs();
					bbs.setBbsID(rs.getInt(1));
					bbs.setBbsTitle(rs.getString(2));
					bbs.setUserID(rs.getString(3));
					bbs.setBbsDate(rs.getString(4));
					bbs.setBbsContent(rs.getString(5));
					bbs.setBbsAvailable(rs.getInt(6));
					bbs.setBbs_freeID(rs.getInt(7));
					bbs.setBbs_bookID(rs.getInt(8));
					bbs.setSeeCount(rs.getInt(9));
					bbs.setCommentCount(rs.getInt(10));
					return bbs;
				}
			
			} catch (Exception e) {
				e.printStackTrace();
			}
		return null; 
		
	}
	
		
	
		public int delete(int bbsID) {
		 String SQL="UPDATE BBS SET bbsAvailable = 0 WHERE bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			return pstmt.executeUpdate();
		 } catch (Exception e) {
			 e.printStackTrace();
		 }
		return -1;
		
		
		
	}
		
		public int update(int bbsID, String bbsTitle, String bbsContent) {
			 String SQL="UPDATE BBS SET bbsTitle = ?,bbsContent = ? WHERE bbsID = ?";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, bbsTitle.replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
				pstmt.setString(2, bbsContent.replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
				pstmt.setInt(3, bbsID);
				return pstmt.executeUpdate();
			 } catch (Exception e) {
				 e.printStackTrace();
			 }
			return -1;
			
			
			
		}
		
		public int seeCountAdd(int bbsID) {
			String SQL="UPDATE BBS SET seeCount = seeCount + 1 WHERE bbsID = ?";
			try {
					PreparedStatement pstmt = conn.prepareStatement(SQL);
					pstmt.setInt(1, bbsID);
					return pstmt.executeUpdate();
				} catch (Exception e) {
					 e.printStackTrace();
				}
			return -1;
		}
		
		public int commentCountAdd(int bbsID) {
			String SQL="UPDATE BBS SET commentCount = commentCount + 1 WHERE bbsID = ?";
			try {
					PreparedStatement pstmt = conn.prepareStatement(SQL);
					pstmt.setInt(1, bbsID);
					return pstmt.executeUpdate();
				} catch (Exception e) {
					 e.printStackTrace();
				}
			return -1;
		}
		
		public int commentCountDeAdd(int bbsID) {
			String SQL="UPDATE BBS SET commentCount = commentCount -1 WHERE bbsID = ?";
			try {
					PreparedStatement pstmt = conn.prepareStatement(SQL);
					pstmt.setInt(1, bbsID);
					return pstmt.executeUpdate();
				} catch (Exception e) {
					 e.printStackTrace();
				}
			return -1;
		}
		
		public int getbbsID() {
			String SQL="SELECT bbsID FROM BBS ORDER BY bbsID DESC"; // ������������ ���� �� ���� ū �� ������
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				rs=pstmt.executeQuery();
				if(rs.next()) {
					return rs.getInt(1);
				}
			}catch (Exception e) {
				e.printStackTrace();
			}
			return -1; //������ ���̽� ���� string�����̶� -1 �ȵ�
		}
		
		
		public int getbbs_bookID() {
			String SQL="SELECT bbs_bookID FROM BBS ORDER BY bbs_bookID DESC"; // ������������ ���� �� ���� ū �� ������
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				rs=pstmt.executeQuery();
				if(rs.next()) {
					return rs.getInt(1);
				}
			}catch (Exception e) {
				e.printStackTrace();
			}
			return -1; //������ ���̽� ���� string�����̶� -1 �ȵ�
		}
		
		// ���� ��� ī��Ʈ �����°� �����ؾ���
		
}