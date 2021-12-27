package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dto.BoardDTO;
import dto.CommentDTO;

public class CommentDAO extends JdbcDAO {
	private static CommentDAO _dao;
	
	private CommentDAO() {
		// TODO Auto-generated constructor stub
	}
	
	static {
		_dao=new CommentDAO();
	}
	
	public static CommentDAO getDAO() {
		return _dao;
	}
	
	
	//野�占쏙옙占쏙옙占쏙옙占썸�⑨옙 野�占쏙옙占쏙옙�쇽옙占쏙옙占썹��占� 占쏙옙占싼�占쏙옙占� BOARD 占쏙옙占쎈��占쏙옙占� 占쏙옙占싸삼옙占� 野�占쏙옙占쏙옙�쇽옙占쏙옙占� 野�占쏙옙占썸묾占쏙옙占� 揶�占쏙옙占썹��占� 野�占쏙옙占쏙옙占쏙옙占� 獄�占쏙옙占쏙옙占쏙옙占� 筌�占쏙옙占쏙옙占�
	// => 野�占쏙옙占쏙옙占쏙옙占쏙옙占� 占쏙옙占쏙옙 野���占쏙옙 BOARD 占쏙옙占쎈��占쏙옙占� 占쏙옙占싸삼옙占� 占쏙옙筌ｏ옙 野�占쏙옙占썸묾占쏙옙占� 揶�占쏙옙占썹��占� 野�占쏙옙占쏙옙占쏙옙占� 獄�占쏙옙占쏙옙占쏙옙占� 筌�占쏙옙占쏙옙占�
	public int getBoardTotal(String search, String keyword) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int rows=0;
		try {
			con=getConnection();
			
			//筌�占쏙옙占쏙옙占쏙옙占� 占쏙옙占쎌�곤옙占쎄�占쏙옙 占쏙옙占싼�占쏙옙 揶�占쏙옙占� 占쎄�占쏙옙 占썬�삘�� SQL   
			//筌�占쏙옙諭�占쏙옙 占쏙옙占싸쏙옙占쏙옙占� 占쏙옙占싼�占쏙옙占쏙옙嚥∽옙 占썬�쇽옙占� - 占쏙옙占쏙옙 SQL
			if(keyword.equals("")) {//野�占쏙옙占� 疫꿸�占쏙옙 沃�紐�占싼�占쏙옙
				String sql="select count(*) from bbs_board01";
				pstmt=con.prepareStatement(sql);
			} else {//野�占쏙옙占� 疫꿸�占쏙옙 占싼�占쏙옙
				//���占쎌�곤옙占쏙옙 占쏙옙占싸쏙옙占� Java 癰�占쏙옙占쏙옙占� InParameter嚥∽옙 占싼�占쏙옙 �븝옙揶�占쏙옙占�
				String sql="select count(*) from bbs_board01 where "+search+" like '%'||?||'%'";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, keyword);
			}
			
			rs=pstmt.executeQuery();
			if(rs.next()) {
				rows=rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[占쏙옙占쏙옙]getBoardTotal() 筌�占쏙옙占쏙옙占쏙옙占� SQL 占썬�삼옙 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return rows;
	}
	
	// 댓글 리스트
	public List<CommentDTO> getCommentList(int commentNum) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<CommentDTO> commentList=new ArrayList<CommentDTO>();
		try {
			con=getConnection();

			String sql="select * from(select * from comment_table order by comment_num) where comment_board = ?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, commentNum);
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				CommentDTO comment=new CommentDTO();
				comment.setCommentNum(rs.getInt("comment_num"));
				comment.setCommentBoard(rs.getInt("comment_board"));
				comment.setCommentId(rs.getString("comment_id"));
				comment.setCommentDate(rs.getString("comment_date"));
				comment.setCommentParent(rs.getInt("comment_parent"));
				comment.setCommentContent(rs.getString("comment_content"));
				commentList.add(comment);
			}
		} catch (SQLException e) {
			System.out.println("[getCommentList] = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return commentList;
	}
	
	//BOARD_SEQ 占쏙옙占쎈�占썬�쇽옙占� 占쏙옙占쏙옙 筌�占썲�占썲�占쏙옙占� 野�占쏙옙占쏙옙占쏙옙占� 獄�占쏙옙占쏙옙占쏙옙占� 筌�占쏙옙占쏙옙占�
	public int getBoardNum() {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int num=0;
		try {
			con=getConnection();
			
			String sql="select sequence_bbs.nextval from dual";					
			pstmt=con.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				num=rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[占쏙옙占쏙옙]getBoardNum() 筌�占쏙옙占쏙옙占쏙옙占� SQL 占썬�삼옙 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return num;
	}
	public BoardDTO getboardView(int boardNo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		BoardDTO board = null;
		try {
			con=getConnection();
			String sql = "select * from bbs_board01 where num = ?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, boardNo);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				board = new BoardDTO();
				board.setNum(rs.getInt("num"));
				board.setId(rs.getString("id"));
				board.setWriter(rs.getString("writer"));
				board.setSubject(rs.getString("subject"));
				board.setRegDate(rs.getString("reg_date"));
				board.setReadCount(rs.getInt("readcount"));
				board.setRef(rs.getInt("ref"));
				board.setReStep(rs.getInt("re_step"));
				board.setReLevel(rs.getInt("re_level"));
				board.setContent(rs.getString("content"));
				board.setIp(rs.getString("ip"));
				board.setStatus(rs.getInt("status"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(con, pstmt, rs);
		}
		return board;
	}
	
	//댓글쓰기
	public int getReplyWrite(CommentDTO comment) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;
		
		try {
			con=getConnection();
			String sql = "insert into comment_table values ((select nvl(max(comment_num)+1,1) from comment_table),?,?,sysdate,?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, comment.getCommentBoard());//글번호?
			pstmt.setString(2, comment.getCommentId());//댓글작성자 아이디
			pstmt.setInt(3, comment.getCommentParent());//상위댓글-부모
			pstmt.setString(4, comment.getCommentContent());//댓글내용
			rows=pstmt.executeUpdate();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(con, pstmt);
		}
		//System.out.println("생성된 댓글 갯수 : "+rows);
		return rows;
	}
	
	//댓글
	public int modifyReSetp(int ref,int reStep) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update bbs_board01 set re_step=re_step+1 where ref=? and re_step>?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, ref);
			pstmt.setInt(2, reStep);
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[占쏙옙占쏙옙]modifyReSetp() 筌�占쏙옙占쏙옙占쏙옙占� SQL 占썬�삼옙 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//게시글번호가져오기
	public BoardDTO getBoard(int num) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		BoardDTO board=null;
		try {
			con=getConnection();
			
			String sql="select * from bbs_board01 where num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				board=new BoardDTO();
				board.setNum(rs.getInt("num"));
				board.setId(rs.getString("id"));
				board.setWriter(rs.getString("writer"));
				board.setSubject(rs.getString("subject"));
				board.setRegDate(rs.getString("reg_date"));
				board.setReadCount(rs.getInt("readcount"));
				board.setRef(rs.getInt("ref"));
				board.setReStep(rs.getInt("re_step"));
				board.setReLevel(rs.getInt("re_Level"));
				board.setContent(rs.getString("content"));
				board.setIp(rs.getString("ip"));
				board.setStatus(rs.getInt("status"));
			}
		} catch (SQLException e) {
			System.out.println("[占쏙옙占쏙옙]getBoard() 筌�占쏙옙占쏙옙占쏙옙占� SQL 占썬�삼옙 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return board;
	}
	
	//조회수 증가
	public int modifyReadCount(int num) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update bbs_board01 set readcount=readcount+1 where num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[占쏙옙占쏙옙]modifyReadCount() 筌�占쏙옙占쏙옙占쏙옙占� SQL 占썬�삼옙 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//댓글삭제
	public int removeReply(int num) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="delete from comment_table where comment_num = ?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[removeReply()] = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//수정
	public int modifyBoard(BoardDTO board) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update bbs_board01 set subject=?,content=? where num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, board.getSubject());
			pstmt.setString(2, board.getContent());
			pstmt.setInt(3, board.getNum());
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("modifyBoard() = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	//해당글의 대한 댓글의 갯수
	public int commentCount(int commentNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int rows = 0;
		
		try {
			con=getConnection();
			String sql = "select count(*) from comment_table where comment_board = ?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, commentNum);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				rows=rs.getInt(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(con, pstmt, rs);
		}
		return rows;
	}
	public int commentWrite(BoardDTO board) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;
		
		try {
			con=getConnection();
			//String sql = "insert into bbs_board01 values (sequence_bbs.nextVal,?,?,?,sysdate,0,?,?,?,?,?,?)";
			String sql = "insert into bbs_board01 values ((select nvl(max(num)+1,1) from bbs_board01),?,?,?,sysdate,0,?,?,?,?,?,1)";
			//System.out.println("level"+board.getReLevel());
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, board.getId());
			pstmt.setString(2, board.getWriter());
			pstmt.setString(3, board.getSubject());
			pstmt.setInt(4, board.getRef());
			pstmt.setInt(5, board.getReStep()+1);
			pstmt.setInt(6, board.getReLevel()+1);
			pstmt.setString(7, board.getContent());
			pstmt.setString(8, board.getIp());
			rows=pstmt.executeUpdate();
			//con.commit();
			//con.setAutoCommit(true);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(con, pstmt);
		}
		//System.out.println("생성된 글 갯수는 "+rows);
		return rows;
	}
	//수정
	public int modifyComment(BoardDTO board2) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			//con.setAutoCommit(false);
			String sql="update bbs_board01 set re_step=re_step+1 where ref=? and re_step > ?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, board2.getRef());
			pstmt.setInt(2, board2.getReStep());
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("modifyBoard() = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
}








