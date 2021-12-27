<%@page import="dao.CommentDAO"%>
<%@page import="dao.userDAO"%>
<%@page import="dto.userDTO"%>
<%@page import="java.util.List"%>
<%@page import="dto.BoardDTO"%>
<%@page import="dao.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%  

	request.setCharacterEncoding("UTF-8");
	int totalCnt = BoardDAO.getDAO().getTotalCnt();
	int pageNo=1;//페이지번호를 저장하기 위한 변수
	if(request.getParameter("pageNo")!=null) {//전달값이 존재할 경우
		pageNo=Integer.parseInt(request.getParameter("pageNo"));
	}
	
	if(pageNo<=0) {
		//비정상적인 페이지 번호가 전달된 경우 무조건 1 페이지로 설정 
		pageNo=1;
	}
	String userid=null;
	//System.out.println("페이지번호 = "+pageNo);
	if(session.getAttribute("userID")!= null) {
		//System.out.println("있음");
		userid = (String)session.getAttribute("userID");
	} else {
		//"WebContent/board/boardModifyView.jsp";
		userid=null;
	}
	//System.out.println(userid);
	userDTO user = userDAO.getDAO().getMember(userid);
	//System.out.println(user.getName());
	//int commentCount = CommentDAO.getDAO().commentCount(commentNum);
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Cache-Control" content="no-cache">
<meta http-equiv="expires" content="-1">
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<title>Insert title here</title>
<style type="text/css">
a { cursor: pointer; color: blue; }
a:hover,a.hover { text-decoration: underline; }

.boardTable {
	width: 780px;
	
}
.boardTable tr {
/* 	text-align: center; */
}
.writeBox-off {
	display: none;
}
button {
	cursor: pointer;
}
html {
	font-family: '돋움',Dotum,Helvetica,'Apple SD Gothic Neo',Sans-serif;
    font-size: 12px;
}
#board_list > tr > td {
	height: 30px;
}
/* .xx-selected { */
/* 	background-color: #ebf0f9; */
/* } */
.xx {

}
.notify_area .notice {
    line-height: 32px;
    color: #00ba2e;
    font-size: 11px;
    display: inline-block;
    height: auto;
    letter-spacing: -1px;
    white-space: nowrap;
}
.notify_area {
	padding-right: 14px;
    z-index: 40;
}
</style>
</head>
<body>
<input type="hidden" class="pageNo" name="pageNo" value="<%=pageNo %>">
<input type="hidden" class="totalCnt" name="totalCnt" value="<%=totalCnt %>">
<!-- 
<ul>

	<li class="xxx"><input type="checkbox" name="swimming1" class="x" /></li>
	<li class="xxx"><input type="checkbox" name="swimming2" class="x" /></li>
	<li class="xxx"><input type="checkbox" name="swimming3" class="x" /></li>
</ul>
<br/>
<ul>
	<li class="xxx"><input type="checkbox" name="diving1" class="x" /></li>
	<li class="xxx"><input type="checkbox" name="diving2" class="x" /></li>
	<li class="xxx"><input type="checkbox" name="diving3" class="x" /></li>
</ul>
 -->
<table>
	<caption>JSP Ajax 게시판</caption>
	<tr>
		<% if(userid != null) { %>
		<td align="right" id="logoutBox" class="writeBox-on">
			<button class="logoutBtn">로그아웃</button>
			<button class="mypageBtn">회원정보</button>
			<span style="margin-right: 452px">[<%=user.getName() %>]님 환영합니다.</span>
			<span class="cnt"></span>
		</td>
		<% } else { %>
		<td align="right" id="loginBox" class="writeBox-on">
			<button class="loginBtn">로그인</button>
			<button style="margin-right: 577px" class="joinBtn">회원가입</button>
			<span class="cnt"></span>
		</td>
		<% } %>
	</tr>
	<tr>
		<td>
			<table class="boardTable" border="1" style="border-spacing: 0px; border-collapse: collapse;">
				<tr>
					<td align="center" width="30px;" height="30px"><input type="checkbox" class="testChk00" name="allchk" id="allchk" value="0"></td>
					<td align="center" width="50px;">번호</td>
					<td align="center" width="400px;">제목</td>
					<td align="center">작성자</td>
					<td align="center">날짜</td>
					<td align="center">조회수</td>
					<td align="center">수정</td>
					<td align="center">삭제</td>
				</tr>
				<tbody id="board_list">
				</tbody>
			</table>			
		</td>
	</tr>
	<tr>
		<td>
			<button type="button" class="prev-btn" >Prev</button>
			<button type="button" class="next-btn" >Next</button>
		</td>
	</tr>
	<tr>
		<%if(userid != null) { %>
		<td align="right">
		<button type="button" class="testChk" >체크박스 삭제</button>
		<button type="button" onclick="clickEvent();" class="writerBtn01">글쓰기</button></td>
		<% } else { %>
		<td align="right">
		<button type="button" class="testChk" >체크박스 삭제</button>
		</td>
		<% }%>
	</tr>
	<tr>
		<td>
			<div class="notify_area">
				
			</div>
		</td>
	</tr>
	<tr>
		<td align="center"><div id="pasingDiv"></div></td>
	</tr>
</table>
<br>

<div id="divEvent01" class="writeBox-off">
<% if(userid != null) { %>
<table>
	<tr>
		<td>
			<table id="boardWrite" border="1" style="border-spacing: 0px; border-collapse: collapse;">
				<tr>
					<td width="70px;">제목</td>
					<td width="240px;"><input id="writeSubject" type="text" required="required" class="boardWritesubject" name="subject" maxlength="20" style="width: 98%; height: 100%;"></td>
				</tr>
				<tr>
					<td width="70px;">내용</td>
					<td><textarea rows="10" cols="43" required="required" name="content" class="boardWritecontent"></textarea></td>
				</tr>
				<tr>
					<td width="70px;">작성자</td>
					<td>
					<input type="hidden" class="boardWritewriter" name="writer" maxlength="20" style="width: 98%; height: 100%;" value="<%=user.getName() %>"><%=user.getName() %>
					<input type="hidden" class="boardid" name="boardid" maxlength="20" style="width: 98%; height: 100%;" value="<%=user.getId() %>">
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td colspan="2" align="right">
<!-- 			<input type="button" value="이전" onclick="javaScript:history.back();"> -->
			<input type="button" value="작성" class="Writebtn">
		</td>
	</tr>
</table>
<% } %>
</div>
<div id="message">&nbsp;</div>
<div id="divEvent02" class="writeBox-off"></div>
<div id="divEvent03" class="writeBox-off"></div>
<div id="commentDiv" class="writeBox-off">
</div>
<div id="divEvent04" class="writeBox-off">
<% if(userid != null) { %>
<table>
	<tr>
		<td>
			<table id="commentWrite" style="border-spacing: 0px; border-collapse: collapse;">
				<tr>
					<td>
					<textarea rows="5" cols="42" required="required" name="commentContent" class="commentContent"></textarea>
					<input type='hidden' class='commentid' name='id' value='<%=user.getId() %>'>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td colspan="2" align="right">
<!-- 			<input type="button" value="이전" onclick="javaScript:history.back();"> -->
			<input type="button" value="입력" class="CommentWritebtn">
		</td>
	</tr>
</table>
<% } else {%>
<table>
	<tr>
		<td>
			<table id="commentWrite" style="border-spacing: 0px; border-collapse: collapse;">
				<tr>
					<td>
					댓글은 로그인 후 이용 가능합니다.
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<% }%>
<div id="message2" style="color: red;">&nbsp;</div>
</div>
<div id="divEvent05" class="writeBox-off">
<table style="border-spacing: 0px; border-collapse: collapse;">
<caption style="margin-bottom: 10px">회원가입</caption>
	<tr>
		<td width="70px;">아이디</td>
		<td width="140px;"><input type="text" class="joinid" name="id" maxlength="20" style="width: 98%; height: 100%;"></td>
		<td>&nbsp;<button type="button" class="checkedId">아이디확인</button></td>
	</tr>
	<tr>
		<td width="70px;">비밀번호</td>
		<td><input type="password" required="required" class="joinpw" name="pw" maxlength="20" style="width: 98%; height: 100%;"></td>
	</tr>
	<tr>
		<td width="70px;">이름</td>
		<td><input type="text" required="required"  class="joinname" name="name" maxlength="20" style="width: 98%; height: 100%;"></td>
	</tr>
	<tr>
		<td width="70px;">이메일</td>
		<td><input type="text" required="required"  class="joinemail" name="email" maxlength="20" style="width: 98%; height: 100%;"></td>
	</tr>
	<tr>
		<td align="center" colspan="2" style="padding-top: 10px">
			<button class="joinUserBtn">가입</button>
		</td>
	</tr>
</table>
</div>
<div id="divEvent06" class="writeBox-off">
<table style="border-spacing: 0px; border-collapse: collapse;">
	<tr>
		<td width="70px;" >아이디</td>
		<td width="140px;"><input type="text" class="loginid" name="id" maxlength="20" style="width: 98%; height: 100%;"></td>
	</tr>
	<tr>
		<td width="70px;">비밀번호</td>
		<td><input type="password" required="required" class="loginpw" name="pw" maxlength="20" style="width: 98%; height: 100%;"></td>
	</tr>
	<tr>
		<td align="center" colspan="2" style="padding-top: 10px">
			<button class="loginUserBtn">로그인</button>
		</td>
	</tr>
</table>
</div>
<script type="text/javascript">
//loadList();
//pasingList();

var pageNo = 1;
var pageSize = 10;
var totalCnt = $(".totalCnt").val();
loadList();
totalCount();
//삭제
	
function totalCount() {
	$.ajax({
		type:"get",
		url:"totalCnt.jsp",
		success:function(data) {
			//alert(data)
			$(".cnt").html("총 게시물 : "+data);
		},
		error:function(xhr,statusText) {
			alert(statusText)
		}
	})
}

$(".prev-btn").on('click', function() {
	//alert("prev")
	if(pageNo > 1) {
		pageNo--;
		$("#board_list").html("");
		loadList();
	}
	//console.log("pageNo = "+pageNo)
});
$(".next-btn").on('click', function() {
	//alert("next")
	if(pageNo * pageSize < totalCnt) {
		pageNo++;
		$("#board_list").html("");
		loadList();
	}
	//console.log("pageNo = "+pageNo)
});
//아이디 중복확인
var isChecked=false;
$(".checkedId").click(function() {
	var id = document.querySelector(".joinid").value;
	
	$.ajax({
		url:"userCheck.jsp",
		type:"post",
		data : 
		{
			id:id,
		},
		success : function(data) {
			if(data==0) {
				alert("사용가능");
				isChecked=true;
				//console.log(isChecked)
			} else {
				alert("존재하는 아이디입니다.")
				isChecked=false;
			}
		},
		error: function(request,status,error) {
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});	
});
//로그아웃 버튼 이벤트
$(".logoutBtn").click(function() {
	$.ajax({
		url:"userLogout.jsp",
		type:"post",
		success : function(data) {
			alert("로그아웃 되었습니다.")
			location.reload();
			//document.querySelector("#logoutBox").className = "writeBox-off";
			//document.querySelector("#loginBox").className = "writeBox-on";
		},
		error: function(request,status,error) {
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});		
});
//회원가입 테이블 불러오기
$(".joinBtn").click(function() {
	//alert("d")
	if(divEvent05.className=="writeBox-off") {
		document.querySelector("#divEvent05").className = "writeBox-on"
	} else {
		document.querySelector("#divEvent05").className = "writeBox-off"
	}
});
//로그인 테이블 불러오기
$(".loginBtn").click(function() {
	if(divEvent06.className=="writeBox-off") {
		document.querySelector("#divEvent06").className = "writeBox-on"
	} else {
		document.querySelector("#divEvent06").className = "writeBox-off"
	}
})
//로그인 버튼 이벤트
document.querySelector(".loginUserBtn").addEventListener('click', function() {
	var id = document.querySelector(".loginid").value;
	var pw = document.querySelector(".loginpw").value;
	

	$.ajax({
		url:"userLogin.jsp",
		type:"post",
		data : 
		{
			id:id,
			pw:pw,
		},
		success : function(data) {
			if(data==1) {
				alert("환영합니다.")
				document.querySelector("#divEvent06").className="writeBox-off";
				//location.href=request.getContextPath()+"/board/boardList.jsp"
				location.reload();
				//document.querySelector("#logoutBox").className = "writeBox-on"
				//document.querySelector("#loginBox").className = "writeBox-off"
			} else {
				alert("비밀번호 또는 아이디가 잘못되었습니다.")
			}
		},
		error: function(request,status,error) {
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});		
});



//가입하기 버튼 이벤트
document.querySelector(".joinUserBtn").addEventListener('click', function() {
	var id = document.querySelector(".joinid").value;
	var pw = document.querySelector(".joinpw").value;
	var email = document.querySelector(".joinemail").value;
	var name = document.querySelector(".joinname").value;
	//console.log(name)
	//console.log(isChecked);
	if(isChecked==true) {
		$.ajax({
			url:"userJoinAction.jsp",
			type:"get",
			data : 
			{
				id:id,
				pw:pw,
				email:email,
				name:name,
			},
			success : function(data) {
				if(data==1) {
					alert("가입되었습니다.")
					document.querySelector(".joinid").innerHTML="";
					document.querySelector(".joinpw").innerHTML="";
					document.querySelector(".joinemail").innerHTML="";
					document.querySelector(".joinname").innerHTML="";
					document.querySelector("#divEvent05").className="writeBox-off"; 
				}
			},
			error: function(request,status,error) {
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});		
	} else {
		alert("아이디 중복확인을 눌러주세요.")
	}
});

//댓글 삭제
function deleteReply(commentNum) {
	//console.log(num)
	var num = $("#commentNum").html();//CommentBoard 글번호
	var su = $(".minusNum").val();
	console.log(su)
	$.ajax({
		url:"boardReplyDeleteAction.jsp",
		type:"get",
		data : 
		{
			num:commentNum,
			boardNum:su,
		},
		success : function(data) {
			if(data==1) {
				//alert(num)
				commentView(num);
			}
		},
		error: function(request,status,error) {
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	})
}
//선택한 요소 색상변경 or 다중삭제
$(".testChk").click(function() {
	var arrVal = [];
	$("input[type='checkbox']:checked").each(function(){
		arrVal.push($(this).val());
	});
	//document.querySelector(".colortest").className="colortest-selected";
	//$(".colortest-selected").css('background-color', '#ebf0f9');
	//var arr = arrVal.join(",");

	//console.log(arr)
	if(arrVal == "") {
		alert("체크박스를 선택해주세요")
	} else {
		$.ajax({
			url:"boardDeleteAll.jsp",
			type:"post",
			traditional:true,
			data : 
			{
				arrVal:arrVal,
			},
			success : function(data) {
				$("#board_list").html("");
				loadList(); 			
			},
			error: function(request,status,error) {
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		})
		
	}
	
})
//글삭제
function deleterows(num) {
	
	$.ajax({
		url:"boardDeleteAction.jsp",
		type:"get",
		data : 
		{
			num:num,
		},
		success : function(data) {
			if(data==1) {
				//alert("성공")
				$("#board_list").html("");
				loadList();
				//pasingList();
				totalCount();
			}
		},
		error: function(request,status,error) {
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	})
}
//선택된 체크박스 갯수 구하고 나타내기
$(document).ready(function(){
	$(".testChk00").change(function(){
		//var $this = $(this);
	    var chk_leng = $("input[name=delchk]:checked").length;
	    //alert($this)
	    if(chk_leng > 0) {
			var html ="<span id='notice' class='notice'><span class='selection'>"+chk_leng+"개의 메일을 선택했습니다.</span></span>"
			$(".notify_area").html(html);	    	
	    } else {
	    	$(".notify_area").html("");
	    }
	});

});


//게시글 리스트
function loadList() {
	
	
	$.ajax({
		type: "GET",
		url: "listAction.jsp",
		data: {"pageNo":pageNo},
		success: function(data,statusText) { 
			if('success' == statusText) {
				//console.log(data)
				var list = JSON.parse(data);//넘어온데이터 파싱
				var listLen = list.length;
				//console.log(listLen)
				var wd = 0;
				var html;
				//console.log(id)
				if(listLen == 0) {
					$("#board_list").append("<tr><td height='50px' colspan='8' align='center'>게시글이 존재하지 않습니다.</td></tr>")
				}
                for(var i=0; i<listLen; i++){
                	wd = list[i].reLevel * 20;
                	id = list[i].id;
                	//console.log("wd"+wd)
					var id = "<%=userid%>";
                	//console.log(id)
               		//console.log(list[i].userid)
                	if(list[i].reLevel > 0 ) {
	                	
						if(id == list[i].userid) {
            				$("#board_list").append("<tr class='xx'><td align='center' width='30px;'><input type='checkbox' class='aa' id='testChk01' name='delchk' value='"+list[i].num+"' onclick='test("+1000+","+list[i].num+")'></td><td class='originNum' align='center'>"+list[i].num+"</td>"
							+"<td><img style='padding-left:"+wd+"px;' src='/resources/images/14.png' width='20' height='20px;'><a onclick='viewRows("+list[i].num+"),commentView("+list[i].num+");'>"+list[i].subject+"&nbsp;("+list[i].recnt+")</a></td>"
							+"<td align='center'>"+list[i].writer+"</td>"
							+"<td align='center'>"+list[i].regdate+"</td>"
							+"<td align='center'>"+list[i].readcount+"</td>"
							+"<td align='center'><button type='button' onclick='modifyrows("+list[i].num+");'>수정</button></td>"
							+"<td align='center'><button type='button' onclick='deleterows("+list[i].num+");'>삭제</button></td></tr>")	
						} else {
                			$("#board_list").append("<tr class='xx'><td align='center' width='30px;'><input type='checkbox' class='aa' id='testChk01' name='delchk' value='"+list[i].num+"' onclick='test("+1000+","+list[i].num+")'></td><td class='originNum' align='center'>"+list[i].num+"</td>"
        					+"<td><img style='padding-left:"+wd+"px;' src='/resources/images/14.png' width='20' height='20px;'><a onclick='viewRows("+list[i].num+"),commentView("+list[i].num+");'>"+list[i].subject+"&nbsp;("+list[i].recnt+")</a></td>"
        					+"<td align='center'>"+list[i].writer+"</td>"
        					+"<td align='center'>"+list[i].regdate+"</td>"
        					+"<td align='center'>"+list[i].readcount+"</td>"
        					+"<td></td><td></td></tr>")	
						}
//    								+"<td align='center'><button type='button' onclick='viewRows("+list[i].num+"),commentView("+list[i].num+");'>보기</button></td>"
                	} else {
                		if(id == list[i].userid) {
		                	$("#board_list")
		<%-- 							+"<td><a href='<%=request.getContextPath() %>/board/boardView.jsp?boardNo="+list[i].num+"'>"+list[i].subject+"</a></td>" --%>
		                	.append("<tr class='xx'><td align='center' width='30px;'><input type='checkbox' class='aa' id='testChk01' name='delchk' value='"+list[i].num+"' onclick='test("+1000+","+list[i].num+")'></td><td align='center'><div>"+list[i].num+"<div></td>"
							+"<td style='padding-left:10px;'><a onclick='viewRows("+list[i].num+"),commentView("+list[i].num+");'>"+list[i].subject+"&nbsp;("+list[i].recnt+")</a></td>"
							+"<td align='center'>"+list[i].writer+"</td>"
							+"<td align='center'>"+list[i].regdate+"</td>"
							+"<td align='center'>"+list[i].readcount+"</td>"
							+"<td align='center'><button type='button' onclick='modifyrows("+list[i].num+");'>수정</button></td>"
							+"<td align='center'><button type='button' onclick='deleterows("+list[i].num+");'>삭제</button></td></tr>")            											
                		} else {
		                	$("#board_list")
		            		<%-- 							+"<td><a href='<%=request.getContextPath() %>/board/boardView.jsp?boardNo="+list[i].num+"'>"+list[i].subject+"</a></td>" --%>
   		                	.append("<tr class='xx'><td align='center' width='30px;'><input type='checkbox' class='aa' id='testChk01' name='delchk' value='"+list[i].num+"' onclick='test("+1000+","+list[i].num+")'></td><td align='center'><div>"+list[i].num+"<div></td>"
   							+"<td style='padding-left:10px;'><a onclick='viewRows("+list[i].num+"),commentView("+list[i].num+");'>"+list[i].subject+"&nbsp;("+list[i].recnt+")</a></td>"
   							+"<td align='center'>"+list[i].writer+"</td>"
   							+"<td align='center'>"+list[i].regdate+"</td>"
   							+"<td align='center'>"+list[i].readcount+"</td>"
   							+"<td></td><td></td></tr>")  
                		}
// 						if(id == list[i].userid) {
//             				$("#board_list").append("<tr class='xx'><td align='center' width='30px;'><input type='checkbox' class='testChk00' id='testChk01' name='delchk' value='"+list[i].num+"' onclick='test("+1000+","+list[i].num+");'></td><td class='originNum' align='center'>"+list[i].num+"</td>"
// 							+"<td><img style='padding-left:"+wd+"px;' src='/resources/images/14.png' width='20' height='20px;'><a onclick='viewRows("+list[i].num+"),commentView("+list[i].num+");'>"+list[i].subject+"&nbsp;("+list[i].recnt+")</a></td>"
// 							+"<td align='center'>"+list[i].writer+"</td>"
// 							+"<td align='center'>"+list[i].regdate+"</td>"
// 							+"<td align='center'>"+list[i].readcount+"</td>"
// 							+"<td align='center'><button type='button' onclick='modifyrows("+list[i].num+");'>수정</button></td>"
// 							+"<td align='center'><button type='button' onclick='deleterows("+list[i].num+");'>삭제</button></td></tr>")	
// 						} else {
//                 			$("#board_list").append("<tr class='xx'><td align='center' width='30px;'><input type='checkbox' class='testChk00' id='testChk01' name='delchk' value='"+list[i].num+"' onclick='test("+1000+","+list[i].num+");'></td><td class='originNum' align='center'>"+list[i].num+"</td>"
//         					+"<td><img style='padding-left:"+wd+"px;' src='/resources/images/14.png' width='20' height='20px;'><a onclick='viewRows("+list[i].num+"),commentView("+list[i].num+");'>"+list[i].subject+"&nbsp;("+list[i].recnt+")</a></td>"
//         					+"<td align='center'>"+list[i].writer+"</td>"
//         					+"<td align='center'>"+list[i].regdate+"</td>"
//         					+"<td align='center'>"+list[i].readcount+"</td>"
//         					+"<td></td><td></td></tr>")	
// 						}
// //    								+"<td align='center'><button type='button' onclick='viewRows("+list[i].num+"),commentView("+list[i].num+");'>보기</button></td>"
//                 	} else {
//                 		if(id == list[i].userid) {
// 		                	$("#board_list")
 		<%-- 							+"<td><a href='<%=request.getContextPath() %>/board/boardView.jsp?boardNo="+list[i].num+"'>"+list[i].subject+"</a></td>" --%>
// 		                	.append("<tr class='xx'><td align='center' width='30px;'><input type='checkbox' class='testChk00' id='testChk01' name='delchk' value='"+list[i].num+"' onclick='test("+1000+","+list[i].num+");'></td><td align='center'><div>"+list[i].num+"<div></td>"
// 							+"<td style='padding-left:10px;'><a onclick='viewRows("+list[i].num+"),commentView("+list[i].num+");'>"+list[i].subject+"&nbsp;("+list[i].recnt+")</a></td>"
// 							+"<td align='center'>"+list[i].writer+"</td>"
// 							+"<td align='center'>"+list[i].regdate+"</td>"
// 							+"<td align='center'>"+list[i].readcount+"</td>"
// 							+"<td align='center'><button type='button' onclick='modifyrows("+list[i].num+");'>수정</button></td>"
// 							+"<td align='center'><button type='button' onclick='deleterows("+list[i].num+");'>삭제</button></td></tr>")            											
//                 		} else {
// 		                	$("#board_list")
<%-- 		            									+"<td><a href='<%=request.getContextPath() %>/board/boardView.jsp?boardNo="+list[i].num+"'>"+list[i].subject+"</a></td>" --%>
//    		                	.append("<tr class='xx'><td align='center' width='30px;'><input type='checkbox' class='testChk00' id='testChk01' name='delchk' value='"+list[i].num+"' onclick='test("+1000+","+list[i].num+");'></td><td align='center'><div>"+list[i].num+"<div></td>"
//    							+"<td style='padding-left:10px;'><a onclick='viewRows("+list[i].num+"),commentView("+list[i].num+");'>"+list[i].subject+"&nbsp;("+list[i].recnt+")</a></td>"
//    							+"<td align='center'>"+list[i].writer+"</td>"
//    							+"<td align='center'>"+list[i].regdate+"</td>"
//    							+"<td align='center'>"+list[i].readcount+"</td>"
//    							+"<td></td><td></td></tr>")  
//                 		}
                	} 	
                }
				//pasingList();
				//totalCnt();

			}

		},
		error: function(xhr) {
			alert("에러코드 = "+xhr.status);
		}
	});
}
//댓글 쓰기
$(".CommentWritebtn").click(function() {
	var commentContent = $(".commentContent").val();//댓글내용
	var commentid = $(".commentid").val();//댓글내용
	var num = $("#commentNum").html();//CommentBoard 글번호
	
	
	//alert(commentNum)
	if(commentContent=="") {
		$("#message2").html("댓글내용를 입력해 주세요.");
		$(".commentContent").focus();
		return;
	}
	
	$.ajax({
		url:"boardReplyAction.jsp",
		type:"post",
		data : 
		{
			commentContent:commentContent,
			commentNum:num,
			commentid:commentid,
			
		},
		success : function(data) {
			if(data==1) {
				//alert("성공")
// 				$(".subject").val('');
// 				$(".content").val('');
// 				$(".writer").val('');
				$(".commentContent").val("");
				//console.log(num)
				commentView(num);

// 				//pasingList();
// 				totalCount();
// 				document.getElementById("divEvent01").className = "writeBox-off";
				
			} else {
				alert("에러")
			}
		},
		error: function(request,status,error) {
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	})
	
});
//게시글 작성
$(".Writebtn").click(function() {
	var subject = $(".boardWritesubject").val();
	var content = $(".boardWritecontent").val();
	var writer = $(".boardWritewriter").val();
	var userid = $(".boardid").val();

	console.log(writer)
	
	if(subject=="") {
		$("#message").html("제목를 입력해 주세요.");
		$(".subject").focus();
		return;
	}
	if(content=="") {
		$("#message").html("내용를 입력해 주세요.");
		$(".content").focus();
		return;
	}
	
	
	$.ajax({
		url:"boardWriteAction.jsp",
		type:"get",
		data : 
		{
			subject:subject,
			content:content,
			writer:writer,
			userid:userid,
		},
		success : function(data) {
			if(data==1) {
				$(".boardWritesubject").val('');
				$(".boardWritecontent").val('');
				$("#board_list").html("");
				loadList();
				//pasingList();
				totalCount();
				document.getElementById("divEvent01").className = "writeBox-off";				
				
			} else {
				alert("에러")
			}
		},
		error: function(request,status,error) {
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	})
});
//댓글 보이기
function commentView(num) {
	//var num = $(".originNum").html();//CommentBoard 글번호
	
	//console.log("num"+num)
	$.ajax({
		type: "post",
		url: "boardCommentView.jsp",
		data: {"num":num},
		success: function(data,statusText) { 
			var list = JSON.parse(data);
			//console.log(list)
			var listlen = list.length;
			//console.log(listlen)
			$("#commentDiv").html("");
			var id = "<%=userid%>";
			var html;
			for(var i=0;i<listlen;i++) {
			//console.log(id)
// 				$("#commentDiv").append("<tr><td align='center'>"+list[i].num+"</td>"
// 							+"<td><img style='padding-left:"+wd+"px;' src='/resources/images/14.png' width='20' height='20px;'>"+list[i].subject+"</td>"
// 							+"<td align='center'>"+list[i].writer+"</td>"
// 							+"<td>"+list[i].regdate+"</td>"
// 							+"<td><button type='button' onclick='viewRows("+list[i].num+");'>보기</button></td>"
// 							+"<td><button type='button' onclick='modifyrows("+list[i].num+");'>수정</button></td>"
// 							+"<td><button type='button' onclick='deleterows("+list[i].num+");'>삭제</button></td></tr>"); 
				$("#commentDiv").append("<table><tr>"
				+"<td width='300px;'>"+list[i].commentContent+"</td>"
				+"</tr>"
				+"<tr>"
				+"<td>["+list[i].commentId+"]</td>"
				+"</tr>"
				+"<tr>"
				+"<td>"+list[i].commentDate+"</td>"
				+"</tr>"
				+"</table>");
				if(id == list[i].commentId) {
					$("#commentDiv").append("<button onclick='deleteReply("+list[i].commentNum+")'>삭제</button>"); 
					$("#commentDiv").append("<input type='hidden' class='minusNum' value='"+list[i].commentBoard+"'>");
				} else {
					$("#commentDiv").append("");
				}
// 				$("#commentDiv").html(html);
			}
			$("#board_list").html("");
			loadList();
		},
		error: function(xhr,statusText) {
			alert("에러코드 = "+xhr.status+","+statusText);
		}
	});
} 


//글 보기 불러오기
function viewRows(num) {
	if(divEvent03.className == "writeBox-off") {
		document.getElementById("divEvent03").className = "writeBox-on"; 			
		document.getElementById("divEvent04").className = "writeBox-on"; 			
		document.getElementById("commentDiv").className = "writeBox-on"; 			
	} else {
		document.getElementById("divEvent03").className = "writeBox-off";
		document.getElementById("divEvent04").className = "writeBox-off";
		document.getElementById("commentDiv").className = "writeBox-off";
	}	

	$.ajax({
		url:"boardModifyView.jsp",
		data:{"num":num},
		type:"post",
		success:function(result, statusText) {
			var list = JSON.parse(result);
			var listLen = list.length;
			//console.log(list)
			var content;
			$("#divEvent02").html("");
			$("#divEvent03").html("");
			//$("#commentDiv").html("");
<%-- 			var idnull = <%=userid%> --%>
			var id = "<%=userid%>"
			//console.log(id)
			for(var i=0; i<listLen; i++){
				//console.log(id)
				if(id=="null") {
					content = "<table>";
					content += "<tr>";
						content += "<td>";	
						content += "<table border='1' style='border-spacing: 0px; border-collapse: collapse;'>";
							content += "<tr>";
								content += "<td width='70px;'>글번호</td>";
								content += "<td id='commentNum' class='commentNum' width='240px;'>";
								content += list[i].num;
								content += "</td>";
							content += "</tr>";
							content += "<tr>";
								content += "<td width='70px;'>제목</td>";
								content += "<td width='240px;'>";
								content += list[i].subject;
								content += "</td>";
								content += "<tr>";
								content += "<td width='70px;'>내용</td>";
								content += "<td>";
								content += list[i].content;
								content += "</td>";
								content += "<tr>";
								content += "<td width='70px;'>작성자</td>";
								content += "<td>";
								content += list[i].writer;
								content += "</td>";
							content += "</tr>";
						content += "</table>";
						content += "</td>";
					content += "</tr>";
					content += "</table>";
				} else {
					content = "<table>";
					content += "<tr>";
						content += "<td>";	
						content += "<table border='1' style='border-spacing: 0px; border-collapse: collapse;'>";
							content += "<tr>";
								content += "<td width='70px;'>글번호</td>";
								content += "<td id='commentNum' class='commentNum' width='240px;'>";
								content += list[i].num;
								content += "</td>";
							content += "</tr>";
							content += "<tr>";
								content += "<td width='70px;'>제목</td>";
								content += "<td width='240px;'>";
								content += list[i].subject;
								content += "</td>";
								content += "<tr>";
								content += "<td width='70px;'>내용</td>";
								content += "<td>";
								content += list[i].content;
								content += "</td>";
								content += "<tr>";
								content += "<td width='70px;'>작성자</td>";
								content += "<td>";
								content += list[i].writer;
								content += "</td>";
							content += "</tr>";
						content += "</table>";
						content += "</td>";
					content += "</tr>";
					content += "<tr>";
						content += "<td colspan='2' align='right'>";
						//console.log(list[i].id)
						if(id == list[i].id) {//작성자와 로그인사용자가 같을때
							content += "<button type='button' id='replyBtn' onclick='reply("+list[i].num+");'>답글</button>";
	// 						content += "<button type='button' id='commentBtn' onclick='comment("+list[i].num+");'>댓글</button>";
							content += "<button type='button' id='modifyBtn' onclick='modifyrows("+list[i].num+");'>수정</button>";
							content += "</td>";							
						} else {
							content += "<button type='button' id='replyBtn' onclick='reply("+list[i].num+");'>답글</button>";
						}


					content += "</tr>";
				content += "</table>";
				}
			}
			$("#divEvent03").append(content);	
					
// 				} else {
// 					

// 			$("#divEvent03").append(content);
			
		},
		error:function(req) {
			alert(req.status)
		}
		
	});

}

//답글 불러오기
function reply(num) {
	if(divEvent02.className == "writeBox-off") {
		document.getElementById("divEvent02").className = "writeBox-on"; 			
	} else {
		document.getElementById("divEvent02").className = "writeBox-off";
	}
	document.getElementById("divEvent04").className = "writeBox-off";
	$.ajax({
		url:"boardModifyView.jsp",
		data:{"num":num},
		type:"post",
		success:function(result, statusText) {
			var list = JSON.parse(result);
			var listLen = list.length;
			//console.log(listLen)
			var content;
			$("#divEvent02").html("");
			$("#divEvent03").html("");
			for(var i=0; i<listLen; i++){
				content = "<table>";
				content += "<input type='hidden' class='commentnum' name='num' value='"+list[i].num+"'>";				
				content += "<input type='hidden' class='commentref' name='ref' value='"+list[i].ref+"'>";				
				content += "<input type='hidden' class='commentrestep' name='restep' value='"+list[i].restep+"'>";				
				content += "<input type='hidden' class='commentrelevel' name='reLevel' value='"+list[i].reLevel+"'>";						
					content += "<tr>";
						content += "<td>";
						content += "<table border='1' style='border-spacing: 0px; border-collapse: collapse;'>";
							content += "<tr>";
								content += "<td width='70px;'>제목</td>";
								content += "<td width='240px;'>";
								content += "<input type='text' required='required' class='commentsubject' name='subject' maxlength='20' style='width: 98%; height: 100%;'>";
								content += "</td>";
								content += "<tr>";
								content += "<td width='70px;'>내용</td>";
								content += "<td>";
								content += "<textarea rows='10' cols='33' required='required' name='content' class='commentcontent'></textarea>";
								content += "</td>";
								content += "<tr>";
								content += "<td width='70px;'>작성자</td>";
								content += "<%if(userid != null) {%>";
								content += "<td><input type='hidden' required='required'  class='commentwriter' name='writer' maxlength='20' style='width: 98%; height: 100%;' value='<%=user.getName()%>'><%=user.getName()%></td>";
								content += "<input type='hidden' class='commentid' name='id' value='<%=user.getId() %>'>";	
								content += "<%} else { %>";
								content += "<td><input type='text' required='required'  class='commentwriter' name='writer' maxlength='20' style='width: 98%; height: 100%;'></td>";
								content += "<%} %>";
							content += "</tr>";
						content += "</table>";
						content += "</td>";
					content += "</tr>";
					content += "<tr>";
						content += "<td colspan='2' align='right'>";
						content += "<button type='button' id='commentBtn' onclick='commentRows("+list[i].num+");'>답글</button>";
						content += "</td>";
					content += "</tr>";
			content += "</table>";
			}
			$("#divEvent02").append(content);
			
		},
		error:function(req) {
			alert(req.status)
		}
		
	});
	
// 	if(divEvent02.className == "writeBox-off") {
// 		document.getElementById("divEvent02").className = "writeBox-on"; 			
// 	} else {
// 		document.getElementById("divEvent02").className = "writeBox-off";
// 	}	
// 	console.log("수정버튼 num = "+num)
// 	return num;
}
//글 수정박스 불러오기
function modifyrows(num) {
	if(divEvent02.className == "writeBox-off") {
		document.getElementById("divEvent02").className = "writeBox-on"; 			
	} else {
		document.getElementById("divEvent02").className = "writeBox-off";
	}	
	$.ajax({
		url:"boardModifyView.jsp",
		data:{"num":num},
		type:"post",
		success:function(result, statusText) {
			var list = JSON.parse(result);
			var listLen = list.length;
			//console.log(listLen)
			var content;
			$("#divEvent02").html("");
			$("#divEvent03").html("");
			for(var i=0; i<listLen; i++){
				content = "<table>";
					content += "<tr>";
						content += "<td>";
						content += "<table border='1' style='border-spacing: 0px; border-collapse: collapse;'>";
							content += "<tr>";
								content += "<td width='70px;'>제목</td>";
								content += "<td width='240px;'>";
								content += "<input type='text' required='required' class='modifysubject' name='subject' maxlength='20' style='width: 98%; height: 100%;' value='"+list[i].subject+"'>";
								content += "</td>";
								content += "<tr>";
								content += "<td width='70px;'>내용</td>";
								content += "<td>";
								content += "<textarea rows='10' cols='33' required='required' name='content' class='modifycontent'>"+list[i].content+"</textarea>";
								content += "</td>";
								content += "<tr>";
								content += "<td width='70px;'>작성자</td>";
								content += "<td>"+list[i].writer+"</td>";
							content += "</tr>";
						content += "</table>";
						content += "</td>";
					content += "</tr>";
					content += "<tr>";
						content += "<td colspan='2' align='right'>";
						content += "<button type='button' id='updateBtn' onclick='updateRows("+list[i].num+");'>수정</button>";
						content += "</td>";
					content += "</tr>";
			content += "</table>";
			}
			$("#divEvent02").append(content);
			
		},
		error:function(req) {
			alert(req.status)
		}
		
	});
	
// 	if(divEvent02.className == "writeBox-off") {
// 		document.getElementById("divEvent02").className = "writeBox-on"; 			
// 	} else {
// 		document.getElementById("divEvent02").className = "writeBox-off";
// 	}	
// 	console.log("수정버튼 num = "+num)
// 	return num;
}
//답글버튼 클릭시 이벤트발생
function commentRows(num) {
	
	var subject = $(".commentsubject").val();
	var content = $(".commentcontent").val();
	var writer = $(".commentwriter").val();
	var ref = $(".commentref").val();
	var reStep = $(".commentrestep").val();
	var reLevel = $(".commentrelevel").val();
	var id = $(".commentid").val();

	//console.log(ref)
	//console.log(content)

// 	if(subject=="") {
// 		$("#message").html("제목를 입력해 주세요.");
// 		$(".subject").focus();
// 		return;
// 	}
// 	if(content=="") {
// 		$("#message").html("내용를 입력해 주세요.");
// 		$(".content").focus();
// 		return;
// 	}
// 	if(writer=="") {
// 		$("#message").html("작성자를 입력해 주세요.");
// 		$(".writer").focus();
// 		return;
// 	}
	
	
	$.ajax({
		url:"boardCommentAction.jsp",
		type:"post",
		data : 
		{
			num:num,
			subject:subject,
			content:content,
			writer:writer,
			ref:ref,
			reStep:reStep,
			reLevel:reLevel,
			id:id,
		},
		success : function(data) {
			$("#board_list").html("");
			loadList();
			//pasingList();
			document.getElementById("divEvent02").className = "writeBox-off";
			document.getElementById("divEvent03").className = "writeBox-off"; 			
			document.getElementById("divEvent04").className = "writeBox-off"; 			
			document.getElementById("commentDiv").className = "writeBox-off"; 			
		},
		error: function(request,status,error) {
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	})
}
//수정버튼 클릭시 이벤트
function updateRows(num) {
	var subject = $(".modifysubject").val();
	var content = $(".modifycontent").val();

	//console.log(subject)
	//console.log(content)
	
// 	if(subject=="") {
// 		$("#message").html("제목를 입력해 주세요.");
// 		$(".subject").focus();
// 		return;
// 	}
// 	if(content=="") {
// 		$("#message").html("내용를 입력해 주세요.");
// 		$(".content").focus();
// 		return;
// 	}
// 	if(writer=="") {
// 		$("#message").html("작성자를 입력해 주세요.");
// 		$(".writer").focus();
// 		return;
// 	}
	
	
	$.ajax({
		url:"boardModifyAction.jsp",
		type:"post",
		data : 
		{
			num:num,
			subject:subject,
			content:content,
		},
		success : function(data) {
			$("#board_list").html("");
			loadList();
			//pasingList();
			document.getElementById("divEvent02").className = "writeBox-off"; 			
		},
		error: function(request,status,error) {
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	})
}
/*
function loadList() {
	$.ajax({
		type: "GET",
		url: "listAction.jsp",
		dataType: "xml",
		success: function(xmlDoc) {
			var code=$(xmlDoc).find("code").text();
			
			console.log("code = "+code)
			console.log("$(xmlDoc) = "+$(xmlDoc))
			
			if(code=="success") {//댓글이 있는 경우
				//alert($(xmlDoc).find("data").text());
				
				console.log(xmlDoc)
				//$("#comment_list").html(xmlDoc);
				var commentArray=JSON.parse($(xmlDoc).find("data").text());
				//alert("commentArray.length = "+commentArray.length);
				
				console.log("json"+commentArray)
				//댓글목록 출력영역 초기화
				$("#board_list").children().remove();
				
				$(commentArray).each(function() {
					//댓글정보를 엘리먼트로 생성하여 댓글목록 출력영역에 추가
					$("#board_list").append("<tr><td>"+this.num+"</td>"
							+"<td>"+this.subject+"</td>"
							+"<td>"+this.writer+"</td>"
							+"<td>"+this.regdate+"</td></tr>");
					
					
				});
			} else {//댓글이 없는 경우
				var message=$(xmlDoc).find("message").text();
				$("#board_list").html("<div class='no_comment'>"+message+"</div>");
			}
		},
		error: function(xhr) {
			alert("에러코드 = "+xhr.status);
		}
	});
}
*/
function clickEvent() {
	if(divEvent01.className == "writeBox-off") {
		document.getElementById("divEvent01").className = "writeBox-on"; 			
	} else {
		document.getElementById("divEvent01").className = "writeBox-off";
	}	
}
//모든 체크박스의 값
$('input[type="checkbox"]').each(function(){
	var checkboxValue = $(this).val();
	//console.log("checkboxValue = " +checkboxValue);
});

//선택한요소의 클래스명 변경
function test(chk,num) {
	$(".aa").change(function() {
		//alert("dd");
		var n = $(this).attr('name');
		console.log(n)
		if ($(this).prop('checked')) {
			$(this).parents(".xx").prop("className", 'xx-selected')
			$(".xx-selected").css( 'background-color', '#ebf0f9' );
			//$(this).parent().prop("className", 'xx-selected')
		} else {
			$(this).parents(".xx-selected").prop("className", 'xx')
			$(".xx").css( 'background-color', '' );
			//$(this).parent().prop("className", 'xx')
		}
		var selchk = $("input:checkbox[name=delchk]:checked").length
		var fulchk = $("input:checkbox[name=delchk]").length

		if(selchk==fulchk) {
			$("input:checkbox[name=allchk]").prop("checked", true);	
		} else if (selchk<fulchk) {
			$("input:checkbox[name=allchk]").prop("checked", false);	
		}
		
	});				
	//체크박스 갯수	
	var chk_leng = $("input:checkbox[name=delchk]:checked").length;
	//var chk_leng = $("#testChk01:checked").length;
	if($("#testChk01:checked").length > 0) {
		var html ="<span id='notice' class='notice'><span class='selection'>"+chk_leng+"개의 메일을 선택했습니다.</span></span>"
		$(".notify_area").html(html);	    	
    } else {
    	$(".notify_area").html("");
    }

}

// function test(chk,num) {
// 	$(".testChk00").change(function() {
// 		var n = $(this).attr('name');
// 		console.log(n)
// 		if ($(this).prop('checked')) {
// 			$(this).parents(".xx").prop("className", 'xx-selected')
// 			$(".xx-selected").css( 'background-color', '#ebf0f9' );
// 			//$(this).parent().prop("className", 'xx-selected')
// 		} else {
// 			$(this).parents(".xx-selected").prop("className", 'xx')
// 			$(".xx").css( 'background-color', '' );
// 			//$(this).parent().prop("className", 'xx')
// 		}
// 		//체크박스 갯수
// 		$("input:checkbox[name=delchk]").click(function() {
// 			//var chk_leng = $("input:checkbox[name=delchk]:checked").length;
// 			var chk_leng = $("#testChk01:checked").length;
// 			if($("#testChk01:checked").length > 0) {
// 				var html ="<span id='notice' class='notice'><span class='selection'>"+chk_leng+"개의 메일을 선택했습니다.</span></span>"
// 				$(".notify_area").html(html);	    	
// 		    } else {
// 		    	$(".notify_area").html("");
// 		    }
// 		});
		
// 	});			
// }
$(".x").change(function(){
	var n = $(this).attr('name');
	var $this = $(this);
	var m = $this.parent().attr('class');
	//$("[name=" + n + ']').prop("checked", false);
	//var chk = $("input:checkbox[name=" + n + ']');
	console.log(m)
	if ($(this).prop('checked')) {
	//if($(this).prop("checked", true)) {
		//$(this).prop("className", 'x-selected')	
		$(this).parent().prop("className", 'xx-selected')
	} else {
		//$(this).prop("className", 'x')
		$(this).parent().prop("className", 'xx')
	}

// 	if ($(this).prop('checked')) {
// 		$(".xx-selected").css('background-color', '#ebf0f9');
// 	}
});

//전부선택 or 전부해제
$("input:checkbox[name=allchk]").click(function() {
	if ($(this).prop('checked')) {
		$("input:checkbox[name=delchk]").prop("checked", true);	
		$(".xx").prop("className", 'xx-selected')
		$(".xx-selected").css( 'background-color', '#ebf0f9' );
	} else if ($(this).prop('checked')==false) {
		$("input:checkbox[name=delchk]").prop("checked", false);
		$(".xx-selected").prop("className", 'xx')
		$(".xx").css( 'background-color', '' );
	}
});




</script>
</body>
</html>