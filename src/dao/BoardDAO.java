package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

import dto.BoardDTO;

public class BoardDAO extends JdbcDAO {
	private static BoardDAO _dao;
	
	private BoardDAO() {
		// TODO Auto-generated constructor stub
	}
	
	static {
		_dao=new BoardDAO();
	}
	
	public static BoardDAO getDAO() {
		return _dao;
	}
	
	public List<BoardDTO> boardList_two(int pageNo) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<BoardDTO> boardList = new ArrayList<BoardDTO>();
		
		try {
			con=getConnection();
			//String sql = "select * from bbs_board01";
			String sql = "select t.* from (select * from bbs_board01 order by num desc) t where rownum between ? and ? and status = 1";
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				BoardDTO board=new BoardDTO();
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
				board.setRecnt(rs.getInt("recnt"));
				boardList.add(board);
			}
		} catch (SQLException e) {
			System.out.println("[占쏙옙占쏙옙]getBoardList() 筌�占쏙옙占쏙옙占쏙옙占� SQL 占썬�삼옙 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return boardList;
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
	
	//占쏙옙占쏙옙 占쏙옙甕곤옙占쎈�占쏙옙 �ワ옙�뤄옙 占쏙옙甕곤옙占쎈�占쏙옙 占쏙옙占싼�占쏙옙占� BOARD 占쏙옙占쎈��占쏙옙占� 占쏙옙占싸삼옙占� 野�占쏙옙占썸묾占� 筌��몌옙占쏙옙 占쏙옙占쎈��占� 占썩�ο옙占썸에占� 野�占쏙옙占쏙옙占쏙옙占� 獄�占쏙옙占쏙옙占쏙옙占� 筌�占쏙옙占쏙옙占�
	// => 占쏙옙占쎈��占쏙옙占� 占쏙옙占싸삼옙占� 占쏙옙占쏙옙 占쏙옙占쏙옙 占쏙옙占쎈��占� 筌ｏ옙�깍옙
	public List<BoardDTO> getBoardList(int startRow, int endRow, String search, String keyword) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<BoardDTO> boardList=new ArrayList<BoardDTO>();
		try {
			con=getConnection();
		
			if(keyword.equals("")) {	
				//String sql="select * from (select rownum rn, temp.* from (select * from bbs_board01 order by ref desc,re_step) temp) where rn between ? and ? and status != 9";
				String sql="select * from (select rownum rn, temp.* from (select * from bbs_board01 where status!=9 order by ref desc,re_step,re_level) temp) where rn between ? and ?";
				//String sql = "select t.* from (select * from bbs_board01 order by num desc) t where rownum between ? and ? and status = 1";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, endRow);
			} else {
				String sql="select * from (select rownum rn, temp.* from (select * from bbs_board01 where "
					+search+" like '%'||?||'%' and status!=9 order by ref desc,re_step) temp) where rn between ? and ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, keyword);
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, endRow);
			}
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				BoardDTO board=new BoardDTO();
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
				board.setRecnt(rs.getInt("recnt"));
				boardList.add(board);
			}
		} catch (SQLException e) {
			System.out.println("[占쏙옙占쏙옙]getBoardList() 筌�占쏙옙占쏙옙占쏙옙占� SQL 占썬�삼옙 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return boardList;
	}
	public int addboard(BoardDTO board) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;
		try {
			con=getConnection();
			String sql = "insert into bbs_board01 values(?,?,?,?,?,?,?,?,?,?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, board.getNum());
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return rows;
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
				board.setRecnt(rs.getInt("recnt"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(con, pstmt, rs);
		}
		return board;
	}
	
	public int getboardWrite(BoardDTO board) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;
		
		try {
			con=getConnection();
			//String sql = "insert into bbs_board01 values (sequence_bbs.nextVal,?,?,?,sysdate,0,?,?,?,?,?,?)";
			String sql = "insert into bbs_board01 values ((select nvl(max(num)+1,1) from bbs_board01),?,?,?,sysdate,0,(select nvl(max(num)+1,1) from bbs_board01),?,?,?,?,1,0)";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, board.getId());
			pstmt.setString(2, board.getWriter());
			pstmt.setString(3, board.getSubject());
			pstmt.setInt(4, board.getReStep());
			pstmt.setInt(5, board.getReLevel());
			pstmt.setString(6, board.getContent());
			pstmt.setString(7, board.getIp());
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(con, pstmt);
		}
		//System.out.println("생성된 글 갯수는 "+rows);
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
				board.setRecnt(rs.getInt("recnt"));
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
	//댓글 숫자 증가
	public int modifyCommentCount(int num) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update bbs_board01 set recnt=recnt+1 where num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("modifyCommentCount() = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	//댓글삭제시에 숫자 마이너스
	public int minusCommentCount(int num) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update bbs_board01 set recnt=recnt-1 where num=?";
			//System.out.println(num);
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("minusCommentCount() = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//삭제
	public int removeBoard(int num) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update bbs_board01 set status=9 where num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[占쏙옙占쏙옙]removeBoard() 筌�占쏙옙占쏙옙占쏙옙占� SQL 占썬�삼옙 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	//여러행 삭제
	public int removeAllBoard(int[] arr) {
		Connection con=null;
		PreparedStatement pstmt=null;

		System.out.println(arr);
		String params="";
	 	int rows=0;

	 	for(int i=0;i<arr.length;i++) {
	 		params+=arr[i];
	 		if(i < arr.length-1) {
	 			params+=",";
	 		}
	 	}
	 	
		try {
			con=getConnection();
			
			String sql="update bbs_board01 set status=9 where num in ("+params+")";
			pstmt=con.prepareStatement(sql);
			
			rows=pstmt.executeUpdate();

			

		} catch (SQLException e) {
			System.out.println("removeAllBoard = "+e.getMessage());
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
	//총게시글 수
	public int getTotalCnt() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int rows = 0;
		
		try {
			con=getConnection();
			String sql = "select count(*) from bbs_board01 where status = 1";
			pstmt=con.prepareStatement(sql);
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
			String sql = "insert into bbs_board01 values ((select nvl(max(num)+1,1) from bbs_board01),?,?,?,sysdate,0,?,?,?,?,?,1,0)";
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








