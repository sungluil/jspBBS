<%@page import="dao.CommentDAO"%>
<%@page import="dto.CommentDTO"%>
<%@page import="java.util.List"%>
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
	
	int boardNo=Integer.parseInt(request.getParameter("num"));

	//int commentNum=Integer.parseInt(request.getParameter("num"));
	
    //댓글
    List<CommentDTO> commentList = CommentDAO.getDAO().getCommentList(boardNo);
	
	JSONObject listObj = new JSONObject();
	JSONArray listArray = new JSONArray();
    
    for(int i = 0 ; i < commentList.size() ; i++) {
        JSONObject vo = new JSONObject();  
        vo.put("commentNum", commentList.get(i).getCommentNum());
        vo.put("commentBoard", commentList.get(i).getCommentBoard());
        vo.put("commentId", commentList.get(i).getCommentId());
        vo.put("commentDate", commentList.get(i).getCommentDate());
        vo.put("commentParent", commentList.get(i).getCommentParent());
        vo.put("commentContent", commentList.get(i).getCommentContent());
        listArray.put(i,vo);
    }		
    
    out.print(listArray);

%>