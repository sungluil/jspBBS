<%@page import="dao.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<% 

	int num = Integer.parseInt(request.getParameter("num"));
	int rows = BoardDAO.getDAO().removeBoard(num);
	out.println(rows);
	
	//response.sendRedirect("location.href = '"+request.getContextPath()+"/board/boardList.jsp';");
	//response.sendRedirect(request.getContextPath()+"/board/boardList.jsp");

%>