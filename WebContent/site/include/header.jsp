<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
.titleText {
	font-size: 1.2em;
	letter-spacing: -2px;
	color: white;
}
.mainImage {
	height: 50px;
	padding-right: 5px;
	
}
a {
	cursor: pointer;
}
</style>
<nav class="navbar navbar-expand-sm navbar-dark bg-dark">   
    <a class="navbar-brand">
    <img alt="mainImage" src="/resources/images/jordan1offwhite.png" class="mainImage">
    <span class="titleText">DreamShoes</span>
    </a> <!-- Toggle Button --> 
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar"> 
        <span class="navbar-toggler-icon"></span> 
    </button> 
    <div class="collapse navbar-collapse" id="collapsibleNavbar"> 
        <ul class="navbar-nav"> 
            <li class="nav-item"><a href="#" class="nav-link">공지사항</a></li> 
            <li class="nav-item"><a href="#" class="nav-link">브랜드</a></li>
            <li class="nav-item"><a href="/site/index.jsp?pageName=include/launch" class="nav-link">발매정보</a></li> 
            <li class="nav-item"><a href="/site/index.jsp?pageName=/board/boardList" class="nav-link">게시판</a></li> 
            <li class="loginmenu"><a class="nav-link">로그인</a></li> 
            <li class="nav-item"><a href="" class="nav-link">회원가입</a></li> 
        </ul> 
    </div> 
</nav> 