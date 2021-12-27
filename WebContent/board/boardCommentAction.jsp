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
	String id = request.getParameter("id");
	String content = request.getParameter("content");
	String writer = request.getParameter("writer");
	int ref = Integer.parseInt(request.getParameter("ref"));
	int reStep = Integer.parseInt(request.getParameter("reStep"));
	int reLevel = Integer.parseInt(request.getParameter("reLevel"));
	
	
	//System.out.println(boardNo);
// 	System.out.println(subject);
// 	System.out.println("ref"+ref);
// 	System.out.println("reStep"+reStep);
	
	
	BoardDTO board2 = new BoardDTO();
	board2.setRef(ref);
	board2.setReStep(reStep);
	BoardDAO.getDAO().modifyComment(board2);
	
	
	
	BoardDTO board = new BoardDTO();
	board.setId(id);
	board.setWriter(writer);
	board.setSubject(subject);
	board.setContent(content);
	board.setRef(ref);
	BoardDAO.getDAO().commentWrite(board);
	
	
	out.println(board);


%>