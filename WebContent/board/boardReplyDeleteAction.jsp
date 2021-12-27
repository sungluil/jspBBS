<%@page import="dao.BoardDAO"%>
<%@page import="dao.CommentDAO"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<% 

	int num = Integer.parseInt(request.getParameter("num"));
	int boardNum=Integer.parseInt(request.getParameter("boardNum"));
	int rows = CommentDAO.getDAO().removeReply(num);
	BoardDAO.getDAO().minusCommentCount(boardNum);
	out.println(rows);
	
	//response.sendRedirect("location.href = '"+request.getContextPath()+"/board/boardList.jsp';");
	//response.sendRedirect(request.getContextPath()+"/board/boardList.jsp");

%>