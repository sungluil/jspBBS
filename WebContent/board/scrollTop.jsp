<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-2.2.1.js"></script>
<style type="text/css">
.top-bar {
    position: absolute;
    width: 100%;
    top: 0;
    left: 0;
    margin: 0;
    background-color: blanchedalmond;
}
.top-bar.follow {
	position: fixed;
}
</style>
<title>Insert title here</title>
</head>
<body>
    <div id="app">
        <div class="top-bar">
            <ul style="list-style: none;">
                <li>Logo</li>
            </ul>
        </div>
        <div>
        	<img src="<%=request.getContextPath() %>/resources/images/b.jpg">
        </div>
    </div>
    <script type="text/javascript">

    	$(window).scroll(function() {
    		
    		var scrollTop = $(window).scrollTop();
    		
    		//alert(scrollTop)
    		if(scrollTop > 100) {
    			$(".top-bar").addClass('follow');
    		} else {
    			$(".top-bar").removeClass('follow');
    		}
    	});
    	
    
	</script>
</body>
</html>