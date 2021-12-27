<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<script type="text/javascript">
function a() {
	var question=confirm("정말 삭제하시겠습니까?");
	
	if(!question) {
		window.alert("취소하였습니다.");
		return false;
	} else {
		window.alert("삭제하였습니다.");
	}
}

</script>
</head>
<body>
<button onclick="a();">버튼</button>
</body>
</html>
