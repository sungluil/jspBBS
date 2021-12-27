<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=dege">
<!-- <link rel="stylesheet" href="/resources/css/default.css"> -->
<title>로그인</title>
<style type="text/css">
ul,ol,li{list-style:none;}
.login { width: 410px; position: absolute; left: 50%; top: 50%;  transform: translate(-50%, -50%); text-align: center;}
.login h2 { padding:0 0 20px; border-bottom: 2px solid #111; text-align: center; line-height:1; font-size: 32px; color: #111;}
.login > ul { padding: 40px 0 33px;}
.login > ul li { padding:0 0 12px; text-align: left;}
.login > ul li input { width: 100%; height: 46px; box-sizing: border-box; text-indent: 16px;}
.login > ul li input::-webkit-input-placeholder { font-size:16px; color:#9fa19f;}
.login > ul li input[type="checkbox"] { 
	position:absolute; 
	left: -197px;
	top: 227px;
	height: 21px;
}
.login > ul li input[type="checkbox"] + label { height: 36px; line-height: 36px;}
.login > ul li input[type="checkbox"] + label:before { content: ""; display:inline-block; margin:0 10px 0 0; width: 18px; height: 18px; border:1px solid #666; background:#fff;
vertical-align: -5px;}
.login > ul li input[type="checkbox"]:checked + label:before {background: url(../images/ico_check_on.png) no-repeat center #333; border-color:#333;}
.login button { width: 100%; height: 56px; background:#ed1c24; font-size: 18px; color:#fff;}
.login div { padding: 0 0 45px;}
.login div ul { display: flex; justify-content: center;}
.login div ul li { position: relative; padding: 0 18px;}
.login div ul li ~ li:after { content: ""; position: absolute; left: 0; top: 4px; height:14px; width: 1px; background: #111; transform: rotate(25deg);}
.login div ul li a { font-size: 14px; color:#111;}
.login > a { font-size: 14px; color:#666; border-bottom: 1px solid #666;}
/* .login > a { position: relative; font-size: 14px; color:#666;}
.login > a:after { content: ""; position: absolute; left: 0; bottom: 0; width: 100%; height: 1px; background: #666;} */s
</style>
</head>
<body>
    <section class="login">
        <h2>로그인</h2>
        <ul>
            <li><input type="text" placeholder="아이디" title="아이디입력"></li>
            <li><input type="password" placeholder="비밀번호" title="비밀번호입력"></li>
            <li><input type="checkbox" id=""><label for="chk_id">아이디저장</label></li>
            <li><button>로그인</button></li>
        </ul>
        <div>
            <a href="">회원가입</a>
            <a href="">아이디 찾기</a>
            <a href="">비밀번호 찾기</a>
        </div>
         <a href="">비회원 주문조회</a>
    </section>
</body>
</html>