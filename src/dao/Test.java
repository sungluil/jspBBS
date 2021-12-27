package dao;

import java.sql.*;
import java.util.*;
public class Test {
	
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
      
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
         
			String url="jdbc:oracle:thin:@localhost:1521:xe";
			String user="scott";
			String pwd="tiger";
			
			Connection conn= DriverManager.getConnection(url,user,pwd);
			PreparedStatement ps = null;
			ResultSet rs = null;
			
			System.out.println("학생 정보 관리 프로그램");
			System.out.print("검색할 학생의 이름을 입력하세요.");
			
			String name2=sc.nextLine();
			
			String sql="select * from rabbit where name = ?";
			ps=conn.prepareStatement(sql);
			ps.setString(1, name2);
			rs=ps.executeQuery();
			
			boolean isResult=false;
			
			while(rs.next()) {
				String name=rs.getString(1);
				int age = rs.getInt(2);
				String tel=rs.getString(3);
				String addr=rs.getString(4);
				System.out.println(name+"\t"+age+"\t"+tel+"\t"+addr);
				isResult=true;
			}
			String yon=null;
			if(isResult==false) {
				System.out.println("등록된 학생이 아닙니다.");
				System.out.print("등록하시겠습니까?(y/n)");
				yon=sc.nextLine();
            
			}
			if(yon.equals("y")) {
				System.out.println("ㅇㅇ");
            
			}
         
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
