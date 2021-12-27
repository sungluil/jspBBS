<%@page import="dao.Board_DAO"%>
<%@page import="dto.BoardDTO"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<% 

	String[] delIds = request.getParameterValues("arrVal");
	
	int[] arr = new int[delIds.length];

	for(int i=0;i<delIds.length;i++) {
		arr[i] = Integer.parseInt(delIds[i]);
		System.out.println(arr[i]);
	}
	int rows=Board_DAO.getDAO().removeAllBoard(arr);
	out.println(rows);
	
	//response.sendRedirect("location.href = '"+request.getContextPath()+"/board/boardList.jsp';");
	//response.sendRedirect(request.getContextPath()+"/board/boardList.jsp");

%>