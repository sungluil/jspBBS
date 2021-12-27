<%@page import="dao.CommentDAO"%>
<%@page import="dto.CommentDTO"%>
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
	request.setCharacterEncoding("utf-8");
	
	//전달된 페이지번호를 반환받아 저장
	int pageNo=Integer.parseInt(request.getParameter("pageNo"));

	int totalBoard = BoardDAO.getDAO().getTotalCnt();
	
	//System.out.println("pageNo"+pageNo);
	/** 게시판 페이징 계산**/
	
	//페이지에 응답될 게시글의 갯수 설정
	int pageSize=10;//응답 게시글의 갯수를 저장하기 위한 변수
	       
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
	String keyword = request.getParameter("keyword");
	if(keyword==null) keyword="";
	String search = request.getParameter("search");
	if(search==null) search="";
	//System.out.println(search);
	
	//List<BoardDTO> boardList = dao_test.getDAO().getboardPasingList(startRow, endRow);
	
	//페이지에 응답될 게시글의 출력시작번호를 계산하여 저장
	// => 게시글이 하나 출력될 때마다 1씩 감소
	int number=totalBoard-(pageNo-1)*pageSize;
	
	//페이지 블럭에 출력될 페이지 번호의 갯수를 설정하여 저장
	int blockSize=5;//블럭에 출력될 페이지 번호의 갯수를 저장하기 위한 변수
	
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

	List<BoardDTO> boardList = BoardDAO.getDAO().getBoardList(startRow, endRow, search, keyword);
	//List<BoardDTO> boardList = BoardDAO.getDAO().boardList_two(pageNo);
	
	JSONObject listObj = new JSONObject();
	JSONArray listArray = new JSONArray();

	
	for(int j = 0 ; j < boardList.size() ; j++) {
        JSONObject vo = new JSONObject();  
        vo.put("num", boardList.get(j).getNum());
        vo.put("userid", boardList.get(j).getId());
        vo.put("subject", boardList.get(j).getSubject());
        vo.put("writer", boardList.get(j).getWriter());
        vo.put("ref", boardList.get(j).getRef());
        vo.put("reLevel", boardList.get(j).getReLevel());
        vo.put("reStep", boardList.get(j).getReStep());
        vo.put("readcount", boardList.get(j).getReadCount());
        vo.put("recnt", boardList.get(j).getRecnt());
        vo.put("regdate", boardList.get(j).getRegDate());
        listArray.put(j,vo);
    }		
	
    out.print(listArray);
	

	
	
	
//     out.print(startPage);
//     out.print(blockSize);
//     out.print(startPage);
//     out.print(endPage);
//     out.print(totalPage);
%>


