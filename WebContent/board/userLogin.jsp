<%@page import="util.EncryptFilter"%>
<%@page import="util.EncryptWrapper"%>
<%@page import="dao.userDAO"%>
<%@page import="dto.userDTO"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<% 

	request.setCharacterEncoding("utf-8");

	if(request.getMethod().equals("get")) {
		return;
	}
	
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	
	String password = EncryptWrapper.getSha512(pw);
	
	int rows=userDAO.getDAO().login(id, password);
	userDAO.getDAO().modifyLastLogin(id);
	if(rows==1) {
		session.setAttribute("userID", id);
	}
	
	out.println(rows);


%>