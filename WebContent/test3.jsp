<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<script type="text/javascript">
function a() {
	var question=confirm("���� �����Ͻðڽ��ϱ�?");
	
	if(!question) {
		window.alert("����Ͽ����ϴ�.");
		return false;
	} else {
		window.alert("�����Ͽ����ϴ�.");
	}
}

</script>
</head>
<body>
<button onclick="a();">��ư</button>
</body>
</html>
