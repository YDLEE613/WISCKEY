<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<script type="text/javascript">
$(document).ready(function(){
	var defaultParams={
		brdid: "${paramVO.brdid}",
		mypage: "${paramVO.mypage}",
		ptypeid: "${paramVO.ptypeid}"
	};
	
	//editor
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
	//modify
	var brdid = "${paramVO.brdid}";
	var bEdit = false;
	
	if(brdid!=0 && brdid!="" && brdid!=null){
		var url="/Tip/findMarketContent";	//TODO mapper
		bEdit = true;
		var params = $.extend({}, defaultParams, {brdid:brdid});
		$.post(url, params, function(data){
			$("#title").val(data.title);
			$("#content").summernote('code', data.content);
		});
	}
	
	$("#cancel").click(function(){
		var url = "/Tip/market?";
		var params = $.param(defaultParams);
		$(location).attr("href", url+params);
	});
	
	// upload to DB
	$("#addMarketBoard").click(function(){ 
		var url = "/Tip/addMarketData";
		var content = $("#content").summernote('code');
		var tipid = $("#tipid").val();

		//table name : #
		var params = $.extend({}, $("#marketBoardContent").serialization(), {tipid:tipid, content:content});	//�����ڵ����̺� ����
		
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
		if(bEdit){	//edit
			url = "/Tip/modMarketData";
			params.brdid = brdid;
			$.post(url, params, function(data){
				$(location).attr("href", "/Tip/marketBoardView?brdid="+data);
			});
		}else{
			console.log("aaaaaaaa")
			$.post(url, params, function(data){
				$(location).attr("href", "/Tip/marketBoardView?brdid="+data);
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
#title_list_about li>a:hover {
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
#title_list_about li>a {
	opacity: 0.7;
	text-decoration: none;
	
}

#l_title{
/*
	border: 2px solid #808080;
	border-radius: 25px;
	padding-left: 10px;
	box-shadow: 2px 2px #778899;
*/
	border-right:2px solid #a80e34;
}
#title_list>li{
	list-style-type: disc;
	list-style-position: inside ;
}

</style>
<!-- s:container -->
<div class="container">
	<jsp:include page="/WEB-INF/views/common/top.jsp"></jsp:include>
	<div class="hr_dash" style="width: 84.3%;  margin-left: 100px;"></div>
	<div class="row">
		<div class="main_body" style="overflow:hidden">
				<div class="left_menu" style="float:left; width:130px; padding-top: 7px; margin-left: 40px;">
				<div id="l_first_title" style="font-weight: bold; border-right: 2px solid #910019; ">
					<div style="font-weight: bold; padding-left:5px; font-size: 110%; ">������ <br/></div>
					<div style="clear:both;"></div>
					<ul id="title_list" style="list-style: none; padding-top:5px; padding-left: 10px; text-decoration: none;">
						<li><a  href="/Tip/food">����</a></li>
						<li><a id="current" href="/Tip/market">�������</a></li>
					</ul>
				</div>
			</div>
			<div id="right_menu" style="float:left; width:700px; margin-left:35px;">
				<table style="width:100%;" id="marketBoardContent">
					<colgroup>
						<col width="15%" >
						<col width="*">
					</colgroup>
					<tbody>
						<!-- ���Ӹ� -->
						<tr style="border: 1px solid #ccc;">
							<th style="text-align: center;">���Ӹ�</th>
							<td>
								<select id="tipid">
									<c:forEach items="${markettypes}" var="markettype">
										<option value="${markettype.tipid}">${markettype.typename}</option>
									</c:forEach>
								</select>
							</td>
						</tr>
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
				<button class="fRight btn btn-default" id="cancel" style="padding:3px 9px; font-size:13px;">���</button>
				<button class="fRight btn btn-default" id="addMarketBoard" style="padding:3px 9px; font-size:13px;">���</button>
			</div>
			
			</div>
		</div>
	</div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" flush="false"></jsp:include>
