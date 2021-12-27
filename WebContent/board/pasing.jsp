<%@page import="dto.PageVO"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.util.Date"%>
<%@page import="util.Utility"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="dto.MemberDTO"%>
<%@page import="dto.BoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="dao.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//request.setCharacterEncoding("utf-8");

	
// 	int pageNo = Integer.parseInt(request.getParameter("pageNo")); 
// 	int pageSize = Integer.parseInt(request.getParameter("pageSize")); 
// 	int blockSize = Integer.parseInt(request.getParameter("blockSize")); 
// 	int totalCnt = Integer.parseInt(request.getParameter("totalCnt")); 
	
// 	PageVO pageVO = new PageVO(pageNo, pageSize, totalCnt, blockSize);
	
	
// 	JSONArray listArray = new JSONArray();
//     JSONObject vo = new JSONObject();  
//     vo.put("startPage", pageVO.getStartPage());
//     vo.put("endPage", pageVO.getEndPage());
//     vo.put("blockSize", pageVO.getBlockSize());
//     vo.put("pageNo", pageVO.getPageNo());
//     vo.put("totalPage", pageVO.getTotalPage());
//     listArray.put(vo);
	
    //out.print(listArray);
	//out.println("pageSize = "+pageSize+", blockSize = "+blockSize+", totalCnt = "+totalCnt);
%>
<%
	request.setCharacterEncoding("utf-8");
	//전달된 페이지번호를 반환받아 저장
	int pageNo=1;//페이지번호를 저장하기 위한 변수
	if(request.getParameter("pageNo")!=null) {//전달값이 존재할 경우
		pageNo=Integer.parseInt(request.getParameter("pageNo"));
	}
	
	if(pageNo<=0) {
		//비정상적인 페이지 번호가 전달된 경우 무조건 1 페이지로 설정 
		pageNo=1;
	}
	
	//List<BoardDTO> boardList = dao_test.getDAO().getboardList(pageNo);
	
	int totalBoard = Integer.parseInt(request.getParameter("totalCnt"));
	
	
	/** 게시판 페이징 계산**/
	
	//페이지에 응답될 게시글의 갯수 설정
	int pageSize = Integer.parseInt(request.getParameter("pageSize")); 
	       
	//총 페이지 갯수를 계산하여 저장
	//int totalPage=totalBoard/pageSize+(totalBoard%pageSize==0?0:1);//총 페이지 갯수를 저장하기 위한 변수
	int totalPage=(int)Math.ceil((double)totalBoard/pageSize);
	
	//페이지 번호에 대한 게시글 시작 행번호를 계산하여 저장
	// => 1 Page : 1, 2 Page : 11, 3 Page : 21, 4 Page : 31,... 
	int startRow=(pageNo-1)*pageSize+1;
	
	//페이지 번호에 대한 게시글 종료 행번호를 계산하여 저장
	// => 1 Page : 10, 2 Page : 20, 3 Page : 30, 4 Page : 41,... 
	int endRow=pageNo*pageSize;
	
	//마지막 페이지의 게시글 종료 행번호를 게시글 전체 갯수로 변경
	if(endRow>totalBoard) {
		endRow=totalBoard;
	}
	
	//페이지에 응답될 게시글의 출력시작번호를 계산하여 저장
	// => 게시글이 하나 출력될 때마다 1씩 감소
	int number=totalBoard-(pageNo-1)*pageSize;
	
	//페이지 블럭에 출력될 페이지 번호의 갯수를 설정하여 저장
	int blockSize = Integer.parseInt(request.getParameter("blockSize"));
	
	//페이지 블럭에 출력될 시작 페이지 번호를 계산하여 출력
	// => 1 Block(1~5) : 1, 2 Block(6~10) : 6, 3 Block(11~15) : 11, 4(16~20) Block : 16,... 
	int startPage=(pageNo-1)/blockSize*blockSize+1;//블럭에 출력될 페이지 시작 페이지번호를 저장하기 위한 변수
	
	//페이지 블럭에 출력될 마지막 페이지 번호를 계산하여 출력
	// => 1 Block(1~5) : 5, 2 Block(6~10) : 10, 3 Block(11~15) : 15, 4(16~20) Block : 20,...
	int endPage=startPage+blockSize-1;
	
	//마지막 페이지 블럭의 페이지 번호 변경
	if(endPage>totalPage) {
		endPage=totalPage;
	}
	
%>
<%-- 페이지 번호 출력 및 하이퍼 링크 --%>
<div>
<% if(startPage>blockSize) { %>
<a href="<%=request.getContextPath()%>/board/boardList.jsp?pageNo=1">[처음]</a>
<a href="<%=request.getContextPath()%>/board/boardList.jsp?pageNo=<%=startPage-blockSize%>">[이전]</a>
<% } else { %>
[처음][이전]
<% } %>

<% for(int i=startPage;i<=endPage;i++) { %>
	<% if(pageNo!=i) { %>
	<a href="<%=request.getContextPath()%>/board/boardList.jsp?pageNo=<%=i%>">[<%=i %>]</a>
	<% } else { %>
	<span style="font-weight: bold; color: red;">[<%=i %>]</span>
	<% } %>
<% } %>

<% if(endPage!=totalPage) { %>
<a href="<%=request.getContextPath()%>/board/boardList.jsp?pageNo=<%=startPage+blockSize%>">[다음]</a>
<a href="<%=request.getContextPath()%>/board/boardList.jsp?pageNo=<%=totalPage%>">[마지막]</a>
<% } else { %>
[다음][마지막]
<% } %>
</div>