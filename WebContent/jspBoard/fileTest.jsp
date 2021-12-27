<%@page import="java.util.List"%>
<%@page import="dao.Board_DAO"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String savePath = "C:/Java/workspace/jspBBS/WebContent/resources/fileFolder";
	
	int size = 1024*1024*10;
	String file="";
	String originFile="";
	
	try {
		MultipartRequest multi = 
				new MultipartRequest(request, savePath, size, "UTF-8", new DefaultFileRenamePolicy());
		File f = new File(savePath); 
		
	} catch (Exception e){
		e.printStackTrace();
	}
	response.sendRedirect(request.getContextPath()+"/jspBoard/download.jsp");

%>