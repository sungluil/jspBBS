<%@page import="util.EncryptWrapper"%>
<%@page import="util.EncryptFilter"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="dao.userDAO"%>
<%@page import="dto.userDTO"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<% 

	request.setCharacterEncoding("utf-8");
	
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String email = request.getParameter("email");
	String name = request.getParameter("name");
	
	userDTO user = new userDTO();
	user.setId(id);
	user.setPw(EncryptWrapper.getSha512(pw));//비밀번호 암호화
	user.setEmail(email);
	user.setName(name);
	

	
	System.out.println(name);
	System.out.println(email);
	
	int rows=userDAO.getDAO().addMember(user);
	if(rows==1) {
		session.setAttribute("userid", id);
		//response.sendRedirect(request.getContextPath()+"/board/boardList.jsp");
	}
	
	
	out.println(rows);


%>