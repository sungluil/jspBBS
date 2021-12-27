package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

import dto.BoardDTO;

public class JspBoardDAO extends JdbcDAO {
	private static JspBoardDAO _dao;
	
	private JspBoardDAO() {
		// TODO Auto-generated constructor stub
	}
	
	static {
		_dao=new JspBoardDAO();
	}
	
	public static JspBoardDAO getDAO() {
		return _dao;
	}
	
	
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
	
}








