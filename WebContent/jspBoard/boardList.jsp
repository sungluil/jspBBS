<%@page import="dto.BoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="dao.JspBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	request.setCharacterEncoding("UTF-8");
	String search=request.getParameter("search");
	if(search==null) search="";
	String keyword=request.getParameter("keyword");
	if(keyword==null) keyword="";

	//System.out.println(search+keyword);
	List<BoardDTO> board = JspBoardDAO.getDAO().getBoardList(1, 10, search, keyword); 

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<table>
	<tr>
		<td align="right">total : </td>
	</tr>
	<tr>
		<td>
			<table class="boardTable" border="1" style="border-spacing: 0px; border-collapse: collapse;">
				<tr>
					<td width="50px;">번호</td>
					<td width="400px;">제목</td>
					<td>작성자</td>
					<td>날짜</td>
				</tr>
				<% for(BoardDTO list:board) { %>
				<tr>
					<td><%=list.getNum() %></td>
					<td><%=list.getSubject() %></td>
					<td><%=list.getWriter() %></td>
					<td><%=list.getRegDate() %></td>
				</tr>
				<% } %>
			</table>			
		</td>
	</tr>
	<tr>
		<td align="right">
		<a href="boardWrite.jsp" style="margin-left: 350px;">글쓰기</a>
		</td>
	</tr>
</table>
<form action="boardList.jsp" method="post" id="searchForm">
	<select name="search">
		<option value="writer" selected="selected">&nbsp;작성자&nbsp;</option>
		<option value="subject">&nbsp;제목&nbsp;</option>
		<option value="content">&nbsp;내용&nbsp;</option>
	</select>
	<input type="text" name="keyword" id="keyword">
	<button type="submit">검색</button>
</form>
</body>
</html>