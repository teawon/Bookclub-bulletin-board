package file;
import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import util.DatabaseUtil;









public class FileDAO {
	
private Connection conn;
private ResultSet rs;

	
	public FileDAO() {
		
			conn=DatabaseUtil.getConnection();
		
	}
	
	public int upload(String fileName, String fileRealName, int bbsID ) {
		try {
			String SQL ="INSERT INTO FILE VALUES(?, ?, ?, 0)";
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, fileName);
			pstmt.setString(2, fileRealName);
			pstmt.setInt(3, bbsID);
			
			return pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	
	public ArrayList<FileDTO>getFiles(int bbsID) {
		String SQL="SELECT * FROM FILE WHERE bbsID = ?";
		ArrayList<FileDTO> list = new ArrayList<FileDTO>();
		try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, bbsID);
				rs=pstmt.executeQuery();  
				while(rs.next())
				{
					FileDTO file = new FileDTO();
					file.setFileName(rs.getString(1));
					file.setFileRealName(rs.getString(2));
					file.setDownloadCount(rs.getInt(4));
					list.add(file);
				}
				return list;
			
			} catch (Exception e) {
				e.printStackTrace();
			}
		return null; 
		
	}
	
	public int downClick(String fileRealName){
		String SQL="UPDATE FILE SET downloadCount = downloadCount + 1 WHERE fileRealName = ? ";
		try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, fileRealName); 
				return pstmt.executeUpdate();
			
			} catch (Exception e) {
				e.printStackTrace();
			}
		return -1; 
		
	}
	
	public int delete(int bbsID) {
		String SQL="DELETE FROM FILE WHERE bbsID = ?";
		try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, bbsID);
				return pstmt.executeUpdate();
			} catch (Exception e) {
				 e.printStackTrace();
			}
		return -1;
		
		
		
	}
	
}
