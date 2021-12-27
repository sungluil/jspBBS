<%@page import="java.net.URLEncoder"%>
<%@page import="dto.FileUploadDTO"%>
<%@page import="dao.Board_DAO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% 

	request.setCharacterEncoding("UTF-8");

	List<FileUploadDTO> list = Board_DAO.getDAO().fileList();
	
	int size =0;
	for(int i=0;i<list.size();i++) {
		size += list.get(i).getTotalSize();	
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
h2 {
	text-align: center;
}

article li {
	list-style-type: none;
}

article label {
	width: 80px;
	float: left;
}

article meter {
	width: 350px;
}

article table {
	width: 550px;
	margin: 0px auto;
	border-top: 3px double darkblue;
	border-bottom: 3px double darkblue;
}

article table th {
	background-color: skyblue;
}
</style>
<title>Insert title here</title>
</head>
<body>
	<%-- <div><%@include file="/header.jsp" %></div> --%>

	<section>
		<article>
			<h2>Y드라이브</h2>
			<fieldset>
				<legend>기본 정보</legend>
				<ul>
					<li><label>총 용량</label> <meter min="0" max="<%=size %>" value="<%=size %>"></meter>(<%=size %>Byte)</li>
					<li><label>사용 용량</label> <meter min="0" max="100" value="50"></meter>(50Byte)</li>
					<li><label>남은 용량</label> <meter min="0" max="100" value="50"></meter>(50Byte)</li>

				</ul>
			</fieldset>
		</article>
		<article>
<!-- 			<form method="post" action="fileUpload.jsp" enctype="multipart/form-data"> -->
			<form method="post" action="fileTest.jsp" enctype="multipart/form-data">
				<div>
					file : <input type="file" name="file" accept="image/*">
				</div>
				<input type="submit">
			</form>
			<table>
				<thead>
					<tr>
						<th>분류</th>
						<th>파일 및 폴더 이름</th>
						<th>삭제</th>
					</tr>
				</thead>
				<tbody id="tbody">
					<% for(FileUploadDTO fileList:list) { %>
					<tr>
						<td>[<%=fileList.getFileName()  %>]</td>
						<% if(fileList.getFileName()=="File") { %>
						<td><a href="<%=request.getContextPath() %>/jspBoard/fileDown.jsp?fileName=<%=fileList.getFileName()%>&str=<%=fileList.getStr()%>"><%=fileList.getStr()%></a></td>
						<% } else { %>
						<td><a href="<%=request.getContextPath() %>/jspBoard/folderList.jsp?str=<%=fileList.getStr()%>"><%=fileList.getStr()%></a></td>
						<% } %>
					</tr>
					<% } %>
				</tbody>
			</table>
		</article>
	</section>

	<!-- 자동 들여쓰기 ctrl+shift+F -->
	<!-- 어떤 사용자든간에 공간 제시해주기위해  폴더 생성 upload 사용자 올리는 공간-->
	<%-- <div><%@include file="/footer.jsp" %></div> --%>
</body>
</html>