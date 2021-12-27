<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<title>Insert title here</title>
</head>
<body>
<input type="checkbox" name="chkbox" id="chkbox">1
<input type="checkbox" name="chkbox" id="chkbox">2
<input type="checkbox" name="chkbox" id="chkbox">3
<div class="notify_area"></div>
<div class="notify_area2"></div>
<div class="board_list"></div>




<script type="text/javascript">

html="<input type='checkbox' class='aa' id='testChk01' name='delchk' onclick='test();'>";
html+="<input type='checkbox' class='aa' id='testChk02' name='delchk' onclick='test();'>"
$(".board_list").append(html);


$("input:checkbox[name=chkbox]").click(function() {
	//var chk_leng = $("input:checkbox[name=delchk]:checked").length;
	var chk_leng = $("#chkbox:checked").length;
	//alert(chk_leng)
	if(chk_leng > 0) {
		var html ="<span id='notice' class='notice'><span class='selection'>"+chk_leng+"개의 메일을 선택했습니다.</span></span>"
		$(".notify_area").html(html);	    	
    } else {
    	$(".notify_area").html("");
    }
});

function test() {

	var chk_leng = $("input:checkbox[name=delchk]:checked").length;
	if(chk_leng > 0) {
		var html ="<span id='notice' class='notice'><span class='selection'>"+chk_leng+"개의 메일을 선택했습니다.</span></span>"
		$(".notify_area2").html(html);	    	
    } else {
    	$(".notify_area2").html("");
    }
}



</script>
</body>
</html>