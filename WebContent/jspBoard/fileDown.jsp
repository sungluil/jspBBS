<%@page import="dao.Board_DAO"%>
<%@page import="java.util.List"%>
<%@page import="java.io.BufferedOutputStream"%>
<%@page import="java.io.BufferedInputStream"%>
<%@page import="java.io.FileNotFoundException"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="dto.FileUploadDTO"%>
<%@page import="org.apache.commons.io.FileUtils"%>
<%@page import="java.io.File"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page language="java" trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	request.setCharacterEncoding("UTF-8");

    String fileName = request.getParameter("str");
	System.out.println(fileName);
	
	//String directory = this.getServletContext().getRealPath("/upload/");
	String directory = "C:/Java/workspace/jspBBS/WebContent/resources/fileFolder";
	File file = new File(directory+"/"+fileName);
	
	String mimeType = getServletContext().getMimeType(file.toString());
	if(mimeType == null) {
		response.setContentType("application/octet-stream");
	}
	
	String downloadName = null;
	if(request.getHeader("user-agent").indexOf("MSIE") == -1) {
		downloadName = new String(fileName.getBytes("UTF-8"),"8859_1");
	} else {
		downloadName = new String(fileName.getBytes("EUC-KR"),"8859_1");
	}
	
	response.setHeader("Content-Disposition", "attachment;filename=\""
			+ downloadName + "\";");
	
	FileInputStream fileInputStream = new FileInputStream(file);
	ServletOutputStream servletOutputStream = response.getOutputStream();
	
	byte b[] = new byte[1024];
	int data = 0;
	
	while((data = (fileInputStream.read(b, 0, b.length))) != -1) {
		servletOutputStream.write(b, 0, data);
	}
	
	servletOutputStream.flush();
	servletOutputStream.close();
	fileInputStream.close();
    
// 	if (file.exists())
// 	{
// 	       if (file.canRead())
// 	       {
// 	          // IE6 & SSL PDF Bug
// 	          // http://forums.sun.com/thread.jspa?threadID=526451&start=15&tstart=0

// 	           mimeType = new javax.activation.MimetypesFileTypeMap().getContentType(file);
// 	           response.setHeader("Cache-Control","private");
// 	           response.setHeader("Pragma","expires");
// 	           response.setHeader("Content-Disposition", "inline; filename=\"" + org.apache.commons.io.FilenameUtils.getName(file.getAbsolutePath()) + "\"");
// 	           response.setContentType(mimeType);
// 	           response.setHeader("Content-Length", String.valueOf(file.length()));

// 	           OutputStream output = response.getOutputStream();
// 	           FileUtils.copyFile(file, output);
// 	           output.close();
// 	       }
// 	       else{System.out.println("Cannot read from file");}
// 	}
// 	else{System.out.println("File dosen't exist");}
%>