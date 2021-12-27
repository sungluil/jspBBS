package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dto.MemberDTO;
import dto.userDTO;

public class userDAO extends JdbcDAO {
	private static userDAO _dao;
	
	private userDAO() {
		// TODO Auto-generated constructor stub
	}
	
	static {
		_dao=new userDAO();
	}
	
	public static userDAO getDAO() {
		return _dao;
	}
	
	//ȸ������
	public int addMember(userDTO user) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="insert into bbs_user01 values(?,?,?,sysdate,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, user.getId());
			pstmt.setString(2, user.getPw());
			pstmt.setString(3, user.getEmail());
			pstmt.setString(4, user.getName());
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("addMember() = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	//���̵�ã��
	public int idCheck(String id) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int rows=0;
		
		try {
			con=getConnection();
			String sql = "select count(1) from bbs_user01 where id = ?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
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
	//�α���
	public int login(String id, String pw) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int rows=0;
		
		try {
			con=getConnection();
			String sql = "select count(1) from bbs_user01 where id = ? and pw = ?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
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
	public userDTO getMember(String id) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		userDTO user=null;
		try {
			con=getConnection();
			
			String sql="select * from bbs_user01 where id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				user=new userDTO();
				user.setId(rs.getString("id"));
				user.setPw(rs.getString("pw"));
				user.setName(rs.getString("name"));
				user.setEmail(rs.getString("email"));
				user.setLastLogin(rs.getString("last_login"));

			}
		} catch (SQLException e) {
			System.out.println("getMember() = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return user;
	}
	
	//�α����Ҷ� �������α��ν��� ����
	public int modifyLastLogin(String id) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update bbs_user01 set last_login=sysdate where id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("modifyLastLogin() = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//???��??�? ???��??? MEMBER ???��??? ???��?? ??????보�?? ??????�? ???????? �???�? �??????? �?????
	public int removeMember(String id) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="delete from member where id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[????]removeMember() �??????? SQL ?��? = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;		
	}
	
	//??????보�?? ???��??? MEMBER ???��??? ???��?? ??????보�?? �?경�??�? �?경�???? �???�? �??????? �?????
	public int modifyMember(MemberDTO member) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update member set passwd=?,name=?,email=?,mobile=?,zipcode=?,address1=?,address2=? where id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, member.getPasswd());
			pstmt.setString(2, member.getName());
			pstmt.setString(3, member.getEmail());
			pstmt.setString(4, member.getMobile());
			pstmt.setString(5, member.getZipcode());
			pstmt.setString(6, member.getAddress1());
			pstmt.setString(7, member.getAddress2());
			pstmt.setString(8, member.getId());
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[????]modifyMember() �??????? SQL ?��? = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//���� ����Ʈ �ҷ�����
	public List<userDTO> getUserList() {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<userDTO> memberList=new ArrayList<userDTO>();
		try {
			con=getConnection();
			
			String sql="select * from bbs_user01 order by id";
			pstmt=con.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				userDTO user=new userDTO();
				user.setId(rs.getString("id"));
				user.setPw(rs.getString("pw"));
				user.setName(rs.getString("name"));
				user.setEmail(rs.getString("email"));
				user.setLastLogin(rs.getString("last_login"));

				memberList.add(user);
			}
		} catch (SQLException e) {
			System.out.println("getMemberList() = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return memberList;
	}
	
	//???��???? ????�? ???��??? MEMBER ???��??? ???��?? ??????�? �? ????�? �?경�??�? �?경�???? �???�? �??????? �?????
	public int modifyMemberStatus(String id,int status) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update member set status=? where id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, status);
			pstmt.setString(2, id);
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[????]modifyMemberStatus() �??????? SQL ?��? = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
}







