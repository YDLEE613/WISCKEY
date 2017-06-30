<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<script type="text/javascript">
	
$(document).ready(function(){
	var url ="/Career/listEmployer";
	
	$.post(url,{},function(data){
		for(var i=0; i<data.length; i++){
			var d = new Date(data[i].date);
			
			$('#top_table > tbody:last').append
	 		('<tr style="border-bottom: 1px solid #ccc;">'+
	 		'<td style="text-align:left; padding-left:10px; width:550px;"><a href="/Career/viewEmployer" style="text-decoration:none">'
	 		+ data[i].title +'</a></td><td style="width:200px;">'+data[i].writer+'</td><td style="width:100px;">'
	 		+ data[i].regdate.toDateString().substring(4, d.toDateString().length)+'</td><td>'+data[i].count+'</td></tr>');
		}
	})
});
</script>

<style type="text/css">
#primary_table tr>td:nth-child(1){
	width: 500px;
}
#primary_table tr>td:nth-child(2){
	width: 150px;
}
#primary_table tr>td:nth-child(3){
	width: 70px;
}
#primary_table tr>td:nth-child(4){
	width: 70px;
}
#primary_table tr>td:nth-child(5){
	width: 70px;
}
</style>
<!-- s:container -->
<div class="container">
	<jsp:include page="/WEB-INF/views/common/top.jsp"></jsp:include>
	<div class="hr_dash" style="width:100%;"></div>
	<div class="row">
		<div class="main_body" style="overflow:hidden">
			<div class="left_menu" style="float:left; width:130px; border-right: 1px solid #cccccc;">
				<div id="l_title" style="font-weight: bold; font-size:130%">ABOUT </div>
				<ul id="title_list" style="list-style:none; padding-left:0px; text-decoration: none;">
					<li><a href="/About/introWisckey">-����Ű �Ұ�</a></li>
					<li><a href="/About/introUniv">-�б��Ұ�</a></li>
					<li><a href="/About/notice">-��������</a></li>
					<li><a href="/About/otherSites">-�ֿ����Ʈ �Ұ�</a></li>
				</ul>
			</div>
			
			<div class="center_menu" style="width: 900px; height: 100%; float:left; border:1px solid #ff0000">
				<div id="">
					<table id="primary_table" style="background-color: : #fffafa; margin-left:20px;">
						<tr id="top_row" style="width: 900px; height:100%; text-align:center; border-bottom: 1px solid #ccc; border-top: 1px solid #ccc; padding: 10px;">
							<td>ȸ��</td>
							<td>�����о�</td>
							<td>�󼼳���</td>
							<td>�ۼ���</td>
							<td>��ȸ��</td>
						</tr>
						<tbody style="text-align: center; padding: 10px;"></tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp" flush="false"></jsp:include>