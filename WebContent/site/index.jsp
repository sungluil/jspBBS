<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	//String pname = request.getParameter("pageName");
	//System.out.println(pname);
	//String pageName="";		
	//if(pname==null) {
		//pageName="include/default";
	//} else {
		//pageName=pname;		
	//}

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!-- CSS --> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> 
<!-- JS --> 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> 
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script> 
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<style type="text/css">
iframe {width:1px; min-width:100%;}

</style>
<title>Insert title here</title>
</head>
<body>
    <!-- header --> 
    <jsp:include page="include/header.jsp"></jsp:include>

    <!-- content --> 
    <div class="contentbox">

    </div>
<%--     <iframe src="<%=pageName  %>.jsp" height="3000px;" --%>
<!--        frameborder="0" framespacing="0" marginheight="0" marginwidth="0"  -->
<!--        scrolling="no" space="0"></iframe> -->
    <!-- footer -->
</body>
<script type="text/javascript">
$(".loginmenu").click(function() {
	$.ajax({
		type : "GET",
		url : "login.jsp",
		dataType : "text",
		error : function() {
			alert('통신실패!!');
		},
		success : function(data) {
			$('.contentbox').html(data);
			var url = '/site/index.jsp?login';
			history.pushState(null,null, url);
		}

	});
});
$(".navbar-brand").click(function() {
	$.ajax({
		type : "GET",
		url : "index.jsp",
		dataType : "text",
		error : function() {
			alert('통신실패!!');
		},
		success : function(data) {
			$('.contentbox').html("");
			var url = '/site/index.jsp';
			history.pushState(null,null, url);
		}

	});
});
</script>
</html>