<%@page import="dto.BoardDTO"%>
<%@page import="dao.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<% 

	request.setCharacterEncoding("utf-8");

// 	if(request.getMethod().equals("get")) {
// 		response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
// 		return;
// 	}
	
	String subject = request.getParameter("subject");
	String content = request.getParameter("content");
	String writer = request.getParameter("writer");
	String id = request.getParameter("userid");
		
	//System.out.println(subject);
	
	BoardDTO board = new BoardDTO();
	board.setSubject(subject);
	board.setContent(content);
	board.setWriter(writer);
	board.setId(id);
	
	int rows = BoardDAO.getDAO().getboardWrite(board);
	
	out.println(rows);
	
// 	response.sendRedirect(request.getContextPath()+"/board/boardList.jsp");


%>