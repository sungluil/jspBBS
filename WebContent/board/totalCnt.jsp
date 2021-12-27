<%@page import="dao.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	int cnt=BoardDAO.getDAO().getTotalCnt();
	out.println(cnt);
%>
