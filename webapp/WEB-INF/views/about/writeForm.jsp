<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<jsp:include page="../common/header.jsp"></jsp:include>
<script type="text/javascript">

	$(document).ready(function() {
		$('#content').summernote({
			lang:'ko-KR',
			height: 400,
			callbacks:{
				onImageUpload: function(files){
					for(var i = files.length-1; i>=0; i--){
						sendFile(files[i], this);
					}
				},
				onChange: function(contents, $editable){

				}
				
			}
		});
		$("#addData").click(function() {
			var url = "/About/addNewNotice";
			var content = $("#content").summernote('code');
			var params = $.extend({}, $("#notice_info").serialization(), {content:content});
				
			if(params.title == null||params.title==""){
				alert("������ �Է��Ͽ� �ֽʽÿ�.");
				$("#title").focus();
				return;
			}else if(params.content == null || params.content == ""){
				alert("������ �Է��Ͽ� �ֽʽÿ�.");
				$("#content").focus();
				return;
			}else{
				$.post(url, params, function(data) {
					console.log(data);
					$(location).attr("href", "/About/viewNotice?nid="+data);
				});
			}
		});
	});

</script>

<style type="text/css">
#title_list li>a:active {
	font-size: 110%;
	font-weight: bold;
	text-decoration: none;
}

#title_list li>a:hover {
	text-decoration: none;
	font-size: 110%;
	font-weight: bold;
	opacity: 1;
	color: black;
}

#title_list li>a:visited {
	font-size: 110%;
	font-weight: bold;
	text-decoration: none;
}

#title_list li>a {
	opacity: 0.4;
	text-decoration: none;
}
</style>


<!-- s:container -->
<div class="container">
	<jsp:include page="../common/top.jsp"></jsp:include>
	<div class="hr_dash" style="width: 100%"></div>
	<div class="row">
		<div class="main_body" style="overflow: hidden;">
			<div id="left_menu"
				style="float: left; width: 130px; border-right: 1px solid #ccc;">
				<div id="l_title" style="font-weight: bold; font-size: 130%">ABOUT
				</div>
				<ul id="title_list"
					style="list-style: none; padding-left: 0px; text-decoration: none;">
					<li><a href="/About/introWisckey">-����Ű �Ұ�</a></li>
					<li><a href="/About/introUniv">-�б��Ұ�</a></li>
					<li><a href="/About/notice">-��������</a></li>
					<li><a href="/About/otherSites">-�ֿ����Ʈ</a></li>
				</ul>
			</div>

			<div class="center_menu" style="float: left; margin-left: 30px; width: 870px;">	
				
				<table id="notice_info" style="width: 900px;">
					<colgroup>
						<col width="15%">
						<col width="*">
					</colgroup>
					<tr style="border: 1px solid #ccc">
						<td style="text-align: center; width: 150px;">����</td>
						<td><input type="text" id="title" style="width: 400px"></input>
					</tr>
					<tr style="border: 1px solid #ccc">
						<td style="text-align: center; width: 150px;">����</td>
						<td><textarea id="content" style="width: 100%px; height: 400px; text-align: left;"></textarea></td>
					</tr>
				</table>	
				<div style="float: right;">
					<button type="button" class="btn confirm" id="addData">���</button>
				</div>
			
			</div>
		</div>
	</div>
</div>



<jsp:include page="/WEB-INF/views/common/footer.jsp" flush="false"></jsp:include>
