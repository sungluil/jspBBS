<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="dto.BoardDTO"%>
<%@page import="dao.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<% 

	request.setCharacterEncoding("utf-8");
	
	if(request.getMethod().equals("GET")) {
		response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
		return;
	}
	

	int boardNo=Integer.parseInt(request.getParameter("num"));
	String subject = request.getParameter("subject");
	String content = request.getParameter("content");
	
	//System.out.println(boardNo);
	//System.out.println(subject);
	//System.out.println(content);
	
	BoardDTO board = new BoardDTO();
	board.setSubject(subject);
	board.setContent(content);
	board.setNum(boardNo);
	
	BoardDAO.getDAO().modifyBoard(board);


%>