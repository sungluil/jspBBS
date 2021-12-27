<%@page import="dao.CommentDAO"%>
<%@page import="dto.CommentDTO"%>
<%@page import="java.util.List"%>
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
	//int commentNum=Integer.parseInt(request.getParameter("num"));
    //댓글
    List<CommentDTO> commentList = CommentDAO.getDAO().getCommentList(boardNo);
	
	JSONObject listObj = new JSONObject();
	JSONArray listArray = new JSONArray();
 
	BoardDTO boardList = BoardDAO.getDAO().getboardView(boardNo);
	BoardDAO.getDAO().modifyReadCount(boardNo);
    listObj.put("num", boardList.getNum());
    listObj.put("id", boardList.getId());
    listObj.put("subject", boardList.getSubject());
    listObj.put("writer", boardList.getWriter());
    listObj.put("ref", boardList.getRef());
    listObj.put("restep", boardList.getReStep());
    listObj.put("reLevel", boardList.getReLevel());
    listObj.put("content", boardList.getContent());
    listObj.put("regdate", boardList.getRegDate());
    
    listArray.put(listObj);	
    
    
    out.print(listArray);

%>