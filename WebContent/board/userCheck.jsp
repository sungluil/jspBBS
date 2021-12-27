<%@page import="dao.userDAO"%>
<%@page import="dto.userDTO"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<% 

	request.setCharacterEncoding("utf-8");
	
	String id = request.getParameter("id");
	
	int rows=userDAO.getDAO().idCheck(id);
	
	out.println(rows);


%>