<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<script type="text/javascript">
$(document).ready(function(){
	var defaultParams={
		brdid: "${paramVO.brdid}",
		userno: "${session.userno}",
		mypage: "${paramVO.mypage}"
	};
	$('#content').summernote({
		lang:'ko-KR',
		height: 400,
		callbacks:{
			onImageUpload: function(files){
				for(var i = files.length-1; i>=0; i--){
					sendFile(files[i], this);
				}
			}
		}
	});
	
	var brdid = defaultParams.brdid;
	var bEdit = false;
	
	if(brdid!=0 && brdid!="" && brdid!=null){
		var url="/School/findEducationContent";
		bEdit = true;
		$.post(url, defaultParams, function(data){
			$("#title").val(data.title);
			$("#content").summernote('code', data.content);
		});
	}
	
	$("#addEducation").click(function(){ 
		var url = "/School/addEducationData";
		var content = $("#content").summernote('code');
		
		var params = $.extend({}, $("#educationContent").serialization(), {swid:2, content:content});
		
		if(params.title == null || params.title == ""){
			alert("������ �Է��Ͽ� �ֽʽÿ�.");
			$("#title").focus();
			return;
		}
		if($("#content").summernote('isEmpty')){
			alert("������ �Է��Ͽ� �ֽʽÿ�.");
			$("#content").summernote('focus');
			return;
		}
		if(bEdit){
			url = "/School/modEducationData";
			params.brdid = brdid;
			$.post(url, params, function(data){
				$(location).attr("href", "/School/educationView?brdid="+data);
			});
		}else{
			$.post(url, params, function(data){
				$(location).attr("href", "/School/educationView?brdid="+data);
			});
		}
	});
	
});
function sendFile(file, el){
	var data = new FormData();
	data.append('file', file);
	$.ajax({
		data: data,
		type: "POST",
		url: "/Image/uploadImageFile",
		cache: false,
		contentType: false,
		enctype: 'multipart/form-data',
		processData: false,
		success: function(fid){
			var url = "/Image/loadImage/" + fid;
			$(el).summernote('insertImage', url, function($image){
				$image.attr('id', fid);
			});
			upImgIds.push(fid);
		}
	});
}
</script>
<style type="text/css">
#title_list li>a:hover {
	text-decoration: none;
	font-size: 105%;
	font-weight: bold;
	opacity: 1;
	color: black;
}
#current{
	font-size: 110%;
	font-weight: bold;
	opacity:1;
	color: black;
}
#title_listli>a {
	opacity: 0.7;
	text-decoration: none;
	
}
#title_list>li{
	list-style-type: disc;
	list-style-position: none ;
}
</style>

<!-- s:container -->
<div class="container">
	<jsp:include page="/WEB-INF/views/common/top.jsp"></jsp:include>
	<div class="hr_dash" style="width:100%;"></div>
	<div class="row">
		<div class="main_body" style="overflow:hidden">
			<div id="left_menu" style="float: left; width: 130px;  padding-top: 7px; margin-left: 40px;"> 
				<div id="l_first_title" style="font-weight: bold; border-right: 2px solid #910019;">
					<div id="l_title" style="font-weight: bold; padding-left:5px; font-size: 110%;">�о�<br/></div>
					<div style="clear:both;"></div>
					<ul id="title_list" style="list-style: none; padding-left: 10px; text-decoration: none; padding-top: 5px;">
						<li><a href="/School/pastWork">����</a></li>
						<li><a id="current" href="/School/education">�о��Խ���</a></li>
					</ul>
				</div>
			</div>
			<div id="right_menu" style="float:left; width:700px; margin-left:30px;">
				<table style="width:100%;" id="educationContent">
					<colgroup>
						<col width="15%" >
						<col width="*">
					</colgroup>
					<tbody>
						<tr style="border: 1px solid #ccc;">
							<th  style="text-align: center;"> ����</th>
							<td><input type="text" id="title" style="width:400px;;"></td>
						</tr>
						<tr style="border: 1px solid #ccc;">
							<th  style="text-align: center;">����</th>
							<td style="padding-top: 8px; padding-bottom: 8px;">
								<textarea id="content" style="width:100%; height:400px; display:none;" valid="����"></textarea>
							</td>
						</tr>
					</tbody>
				</table>
				
				
			<div class="buttons">
				<button class="btn neweducationBoard" id="addEducation" style="float: right;">�۾���</button>
			</div>
			
			</div>
		</div>
	</div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" flush="false"></jsp:include>