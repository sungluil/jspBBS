package dto;

/*
이름              널?       유형             
--------------- -------- -------------- 
COMMENT_NUM     NOT NULL NUMBER(4)      
COMMENT_BOARD   NOT NULL NUMBER(4)      
COMMENT_ID               VARCHAR2(15)   
COMMENT_DATE             DATE           
COMMENT_PARENT           NUMBER(4)      
COMMENT_CONTENT NOT NULL VARCHAR2(1000) 
*/
public class CommentDTO {
	private int commentNum;
	private int commentBoard;
	private String commentId;
	private String commentDate;
	private int commentParent;
	private String commentContent;
	
	public CommentDTO() {
		// TODO Auto-generated constructor stub
	}

	public int getCommentNum() {
		return commentNum;
	}

	public void setCommentNum(int commentNum) {
		this.commentNum = commentNum;
	}

	public int getCommentBoard() {
		return commentBoard;
	}

	public void setCommentBoard(int commentBoard) {
		this.commentBoard = commentBoard;
	}

	public String getCommentId() {
		return commentId;
	}

	public void setCommentId(String commentId) {
		this.commentId = commentId;
	}

	public String getCommentDate() {
		return commentDate;
	}

	public void setCommentDate(String commentDate) {
		this.commentDate = commentDate;
	}

	public int getCommentParent() {
		return commentParent;
	}

	public void setCommentParent(int commentParent) {
		this.commentParent = commentParent;
	}

	public String getCommentContent() {
		return commentContent;
	}

	public void setCommentContent(String commentContent) {
		this.commentContent = commentContent;
	}
	
	
}
