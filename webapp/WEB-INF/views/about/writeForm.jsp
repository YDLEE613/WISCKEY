<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<jsp:include page="../common/header.jsp"></jsp:include>
<script type="text/javascript">
var chkTitle = false;
var chkContent = false;
var params;

function chkValid(){
	var params = $("#notice_info").serialization();
	
	
	alert("fix: "+ params.fix);
	
	//Ÿ��Ʋ üũ
	if(params.title == null || params.title==""){
		alert("������ �Է��Ͽ� �ֽʽÿ�.");
		$("#title").val('');
		$("#title").focus();
		return false;
	}//Ÿ��Ʋ ���
	
	//���� üũ
	if(params.content==null||params.content==""){
		alert("������ �Է��Ͽ� �ֽʽÿ�.");
		$("#content").focus();
		return false;
	}//���� ���
	
	return true;
	
}

function addNotice(){
		var params = $("#notice_info").serialization();
		
		params.fix = $("input[name=fix]:checked").val();
		
		var url="/About/addNewNotice";
		if(chkValid()){
			
				$.post(url, params, function(data){
					if(data>0){
						alert("�ۼ��Ǿ����ϴ�.");
					}else{
						alert("�ۼ� �����Ͽ����ϴ�. �ٽ� �õ��� �ֽñ� �ٶ��ϴ�."
								+ "Data: " +data);
					}
					location.href="/About/notice";
				}).fail(function(){
					alert("�ۼ� �����Ͽ����ϴ�. �ٽ� �õ��� �ֽñ� �ٶ��ϴ�.");
				});
		}else{
			return;
		}
}
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
			<div id="left_menu" style="float: left; width: 130px; border-right: 1px solid #ccc;">
				<div id="l_title" style="font-weight: bold; font-size: 130%">ABOUT
				</div>
				<ul id="title_list"
					style="list-style: none; padding-left: 0px; text-decoration: none;">
					<li><a href="/About/introWisckey">-����Ű �Ұ�</a></li>
					<li><a href="/About/introUniv">-�б��Ұ�</a></li>
					<li><a href="/About/notice">-��������</a></li>
					<li><a href="/About/otherSites">-�ֿ����Ʈ �Ұ�</a></li>
				</ul>
			</div>

			<div class="center_menu" style="float: left; margin-left: 10px; width: 900px; height: 100%;">
				<div id="write_form" style="width: 935px; height: 20%; border: 2px solid #00ffff">
					<table id="notice_info" style="width: 900px; ">
							<tr style="border: 1px solid #ccc">
								<td style="text-align: center; width: 150px;">����</td>
								<td>
									<input type="text" id="title" style="width:400px"></input>
									<span><input type="radio" name="fix" value="F">���� ��������
									<input type="radio" name="fix" value="N">�ӽ� ��������</span>
								</td>
							
							</tr>
							<tr>
								<td style="text-align:center; width: 200px;">�ۼ���</td>
								<td><input type="text" id="writer"></td>
							</tr>
							<tr style="border: 1px solid #ccc">
								<td style="text-align: center; width: 150px;">����</td>
								<td><textarea rows="15" cols="130" id="content" style="width: 750px; text-align: left;"></textarea></td>
							</tr>
					</table>
				</div> 
				<div style="float:right;">
					<button type="button" class="btn confirm" onClick="javascript:addNotice()">Ȯ��</button>
				</div>
			</div>
		</div>
	</div>
</div>
    
    
    
<jsp:include page="/WEB-INF/views/common/footer.jsp" flush="false"></jsp:include>
    