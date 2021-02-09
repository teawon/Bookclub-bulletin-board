package bbs;

public class Bbs {
	private int bbsID;
	private String bbsTitle;
	private String userID;
	private String bbsDate;
	private String bbsContent;
	private int bbsAvailable;
	private int bbs_freeID;
	private int bbs_bookID;
	private int seeCount;
	private int commentCount;
	
	public int getSeeCount() {
		return seeCount;
	}
	public int getCommentCount() {
		return commentCount;
	}
	public void setCommentCount(int commentCount) {
		this.commentCount = commentCount;
	}
	public void setSeeCount(int seeCount) {
		this.seeCount = seeCount;
	}
	public int getBbs_freeID() {
		return bbs_freeID;
	}
	public void setBbs_freeID(int bbs_freeID) {
		this.bbs_freeID = bbs_freeID;
	}
	public int getBbs_bookID() {
		return bbs_bookID;
	}
	public void setBbs_bookID(int bbs_bookID) {
		this.bbs_bookID = bbs_bookID;
	}
	public int getBbsID() {
		return bbsID;
	}
	public void setBbsID(int bbsID) {
		this.bbsID = bbsID;
	}
	public String getBbsTitle() {
		return bbsTitle;
	}
	public void setBbsTitle(String bbsTitle) {
		this.bbsTitle = bbsTitle;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getBbsDate() {
		return bbsDate;
	}
	public void setBbsDate(String bbsDate) {
		this.bbsDate = bbsDate;
	}
	public String getBbsContent() {
		return bbsContent;
	}
	public void setBbsContent(String bbsContent) {
		this.bbsContent = bbsContent;
	}
	public int getBbsAvailable() {
		return bbsAvailable;
	}
	public void setBbsAvailable(int bbsAvailable) {
		this.bbsAvailable = bbsAvailable;
	}
	
}
