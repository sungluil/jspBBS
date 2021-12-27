<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> 
</head>
<body>
<ul>
	<li class="move1">이동1</li>
	<li class="move2">이동2</li>
	<li class="move3">이동3</li>
</ul>
<div id="Context">
    test
</div>
<script type="text/javascript">
$(".move1").click(function() {
	$.ajax({
		type : "GET",
		url : "test2.jsp",
		dataType : "text",
		error : function() {
			alert('통신실패!!');
		},
		success : function(data) {
			$('#Context').html(data);
			var url = 'move1.jsp';
			history.pushState(null,null, url);
		}

	});
});
$(".move2").click(function() {
	$.ajax({
		type : "GET",
		url : "test2.jsp",
		dataType : "text",
		error : function() {
			alert('통신실패!!');
		},
		success : function(data) {
			$('#Context').html(data);
			var url = 'move2.jsp';
			history.pushState(null,null, url);
		}

	});
});
$(".move3").click(function() {
	$.ajax({
		type : "GET",
		url : "test.jsp",
		dataType : "text",
		error : function() {
			alert('통신실패!!');
		},
		success : function(data) {
			$('#Context').html(data);
			var url = 'move3.jsp';
			history.pushState(null,null, url);
		}

	});
});
function ajaxTest() {
	$.ajax({
		type : "GET",
		url : "test.jsp",
		dataType : "text",
		error : function() {
			alert('통신실패!!');
		},
		success : function(data) {
			$('#Context').html(data);
		}

	});
}
ajaxTest();
</script>
</body>
</html>