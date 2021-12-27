<%@page import="dao.BoardDAO"%>
<%@page import="dto.CommentDTO"%>
<%@page import="dao.CommentDAO"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<% 

	request.setCharacterEncoding("utf-8");
	
	if(request.getMethod().equals("GET")) {
		response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
		return;
	}
	


	String commentContent = request.getParameter("commentContent");
	String commentId = request.getParameter("commentid");
	int commentNum = Integer.parseInt(request.getParameter("commentNum"));
	//System.out.println(commentNum);
	
	CommentDTO comment = new CommentDTO();
	comment.setCommentBoard(commentNum);
	comment.setCommentContent(commentContent);
	comment.setCommentId(commentId);
	
	int rows=CommentDAO.getDAO().getReplyWrite(comment);
	BoardDAO.getDAO().modifyCommentCount(commentNum);

	out.println(rows);
	//System.out.println("reStep"+reStep);


%>