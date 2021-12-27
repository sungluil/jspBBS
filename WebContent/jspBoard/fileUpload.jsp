<%@page import="java.util.List"%>
<%@page import="dao.Board_DAO"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	/**
	* 1. 파일저장경로설정
	* 2. 파일사이즈 업로드파일이름 파일실제이름
	* 3. MultipartRequest 파일 객체 생성
	* 4. Enumeration 사용하여 파일의 이름들을 nextElement()로 하나의열거형요소로 생성
	* 5. 
	*/
	
	//System.out.println(this.getServletContext().getRealPath("/"));
	//System.out.println(request.getContextPath());
	//String path = request.getSession().getServletContext().getRealPath("/WebContent/resources/fileFolderr");
	//String savePath ="fileFolderr";
	String savePath = "C:/Java/workspace/jspBBS/WebContent/resources/fileFolder";
	
	//System.out.println(savePath);
	int size = 1024*1024*10;
	String file="";
	String originFile="";
	
	try {
		MultipartRequest multi = 
				new MultipartRequest(request, savePath, size, "UTF-8", new DefaultFileRenamePolicy());
		Enumeration files = multi.getFileNames();
		File f = new File(savePath); 
        f.exists();//존재여부 파악
        File filelist[] = f.listFiles();//있는만큼 배열에 담고
		
        String fileName = "";
        String str = "";
        for(int i=0;i<filelist.length;i++) {//길이 만큼 돌리고
        	
        	if(filelist[i].isFile()) {
        		fileName="[File]";
        	} else {
        		fileName="[Dir]";
        	}
        
        	str=filelist[i].getName();// 파일 이름 뽑기
			//System.out.println(filelist[i].getName());
        	
        	//System.out.println(str+fileName);

        }

        
		//String str = (String)files.nextElement();   //파일이름받아옴
		//file = multi.getFilesystemName(str);        //업로드 된 파일 이름
		//originFile = multi.getOriginalFileName(str);//실제파일이름
		
		//WebFolderService wfs=new WebFolderService(fileName,str);
		
	} catch (Exception e){
		e.printStackTrace();
	}
	response.sendRedirect(request.getContextPath()+"/jspBoard/download.jsp");

%>