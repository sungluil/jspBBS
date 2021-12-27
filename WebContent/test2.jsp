<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<title>���̺��� ��� Ŭ���� �ش� �� ����</title>
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
	//[!] ���� ������ jQuery �÷��������� ���׷��̵�����.
	$.fn.alternateRowColors = function() {
		$('tbody tr:odd', this).removeClass('even').addClass('odd');
		$('tbody tr:even', this).removeClass('odd').addClass('even');
		return this;
	};
	$(document).ready(function() {
		$('table.tbl').each(function() {
			var $table = $(this);
			// �÷����� ȣ��
			//$table.alternateRowColors();
			// ���̺� ��� ����
			$('th', $table).each(function(column) {
				alert("tbl")
				// ����� CSS Ŭ������ sort-alpha�� �����Ǿ��ִٸ�, ABC������ ����
				if ($(this).is('.sort-alpha')) {
					// Ŭ���� ���� ����
					var direction = -1;
					$(this).click(function() {
						direction = -direction;
						var rows = $table.find('tbody > tr').get(); 
						// ���� ���õ� ������� �� ��������
						// �ڹٽ�ũ��Ʈ�� sort �Լ��� ����ؼ� �������� ����
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
						//���ĵ� ���� ���̺� �߰�
						$.each(rows,function(index,row) {
							$table.children('tbody').append(row)
						});
						//$table.alternateRowColors(); // ������
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
				<th class="sort-alpha">����</th>
				<th class="sort-alpha">����</th>
				<th class="sort-alpha">�Ⱓ��</th>
				<th class="sort-alpha">����</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><img src="../../ProductImages/thumbs/BOOK-01.jpg" /></td>
				<td>���� ���� ASP.NET 2.0</td>
				<td>�ڿ���</td>
				<td>2008</td>
				<td>20000</td>
			</tr>
			<tr>
				<td><img src="../../ProductImages/thumbs/COM-01.jpg" /></td>
				<td>.NET Bible</td>
				<td>�ڿ���</td>
				<td>2003</td>
				<td>25000</td>
			</tr>
			<tr>
				<td><img src="../../ProductImages/thumbs/HARDWARE-01.jpg" /></td>
				<td>����ó����ɻ�</td>
				<td>�ڿ���</td>
				<td>2000</td>
				<td>18000</td>
			</tr>
		</tbody>
	</table>
</body>
</html>