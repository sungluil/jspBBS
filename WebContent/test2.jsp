<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<title>테이블의 헤더 클릭시 해당 열 정렬</title>
<style type="text/css">
.odd {
	background-color: Silver;
}
.even {
	background-color: Aqua;
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> 
<script type="text/javascript">
	//[!] 배경색 변경을 jQuery 플러그인으로 업그레이드하자.
	$.fn.alternateRowColors = function() {
		$('tbody tr:odd', this).removeClass('even').addClass('odd');
		$('tbody tr:even', this).removeClass('odd').addClass('even');
		return this;
	};
	$(document).ready(function() {
		$('table.tbl').each(function() {
			var $table = $(this);
			// 플러그인 호출
			//$table.alternateRowColors();
			// 테이블 헤더 정렬
			$('th', $table).each(function(column) {
				alert("tbl")
				// 헤더의 CSS 클래스가 sort-alpha로 설정되어있다면, ABC순으로 정렬
				if ($(this).is('.sort-alpha')) {
					// 클릭시 정렬 실행
					var direction = -1;
					$(this).click(function() {
						direction = -direction;
						var rows = $table.find('tbody > tr').get(); 
						// 현재 선택된 헤더관련 행 가져오기
						// 자바스크립트의 sort 함수를 사용해서 오름차순 정렬
						rows.sort(function(a,b) {
							var keyA = $(a).children('td').eq(column).text().toUpperCase();
							var keyB = $(b).children('td').eq(column).text().toUpperCase();
							if (keyA < keyB) {
								return -direction;
							}
							if (keyA > keyB) {
								return direction;
							}
							return 0;
						});
						//정렬된 행을 테이블에 추가
						$.each(rows,function(index,row) {
							$table.children('tbody').append(row)
						});
						//$table.alternateRowColors(); // 재정렬
					});
				}
			}); // end table sort
		}); // end each()
	}); // end ready()
</script>
</head>
<body>
	<table class="tbl" border="1">
		<thead>
			<tr>
				<th>&nbsp;</th>
				<th class="sort-alpha">제목</th>
				<th class="sort-alpha">저자</th>
				<th class="sort-alpha">출간일</th>
				<th class="sort-alpha">가격</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><img src="../../ProductImages/thumbs/BOOK-01.jpg" /></td>
				<td>쉽게 배우는 ASP.NET 2.0</td>
				<td>박용준</td>
				<td>2008</td>
				<td>20000</td>
			</tr>
			<tr>
				<td><img src="../../ProductImages/thumbs/COM-01.jpg" /></td>
				<td>.NET Bible</td>
				<td>박용준</td>
				<td>2003</td>
				<td>25000</td>
			</tr>
			<tr>
				<td><img src="../../ProductImages/thumbs/HARDWARE-01.jpg" /></td>
				<td>정보처리기능사</td>
				<td>박용준</td>
				<td>2000</td>
				<td>18000</td>
			</tr>
		</tbody>
	</table>
</body>
</html>