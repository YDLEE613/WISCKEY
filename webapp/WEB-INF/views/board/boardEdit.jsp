<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../common/header.jsp"></jsp:include>
<script type="text/javascript">
var upImgIds = [];
$(document).ready(function(){
	var defaultParams = {
			mypage:"${paramVO.mypage}",
			ptypeid:"${paramVO.ptypeid}"
	};
	
	$('#content').summernote({
		lang: 'ko-KR',
		height: 400,
		disableResizeEditor:true,
		callbacks:{
			onImageUpload: function(files){
				for(var i = files.length - 1; i >= 0; i--){
					sendFile(files[i], this);
				}
			}
		}
	});
	
	var brdid = "${paramVO.brdid}";
	var bEdit = false;
	if(brdid != 0 && brdid != '' && brdid != null){
		var url = "/Board/findBoardContent";
		bEdit = true;
		var params = $.extend({}, defaultParams, {brdid:brdid});
		$.post(url, params, function(data){
			if("${session.userno}" != data.userno || "${session.userno}" == null){
				alert("수정할 수 있는 권한이 없습니다.");
				$(location).attr("href", "/Board/?"+$.param(defaultParams));
				return;
			}else{
				$("#title").val(data.title);
				$("#content").summernote('code', data.content);
				$("#frid").val(data.frid).prop("selected", true);
			}
		});
	}
	
	$("#cancel").click(function(){
		var url = "/Board/?";
		var params = $.param(defaultParams);
		$(location).attr("href", url+params);
	});

	$("#addData").click(function(){
		var url = "/Board/addBoardData";
		var content = $("#content").summernote('code');
		var frid = $("#frid").val();
		var params = $.extend({}, $("#brdContent").serialization(), {brdid:brdid, frid:frid,content:content,userno:"${session.userno}"});
		if(params.title == null || params.title == ""){
			alert("제목을 입력하여 주십시오.");
			$("#title").focus();
			return;
		}
		if($("#content").summernote('isEmpty')){
			alert("내용을 입력하여 주십시오.");
			$("#content").summernote('focus');
			return;
		}
		if(bEdit){
			url = "/Board/modBoardData";
			params.brdid = brdid;
			$.post(url, params, function(data){
				$(location).attr("href", "/Board/BoardView?brdid="+data);
			});
		}else{
			$.post(url, params, function(data){
				$(location).attr("href", "/Board/BoardView?brdid="+data);
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
			if(fid == 0){
				alert("이미지가 너무 큽니다. 5MB 이하만 첨부하실 수 있습니다.");
				return;
			}
			$(el).summernote('insertImage', url, function($image){
				$image.attr('id', fid);
				$image.css('width', "80%");
			});
			upImgIds.push(fid);
		},
		error: function(error){
			alert(error);
		}
	});
}

</script>
<style>
.left_ul>li{
border-bottom:1px solid black;
}
.right_menu>div{
border:1px dashed red; 
}
</style>
<!-- s:container -->
<div class="container">
	<jsp:include page="../common/top.jsp"></jsp:include>
	<div class="hr_dash" style="width: 84.3%; margin-left: 100px; "></div>
	<div class="row">
		<div class="main_body">
			<jsp:include page="./leftmenu.jsp"></jsp:include>
			<div id="right_menu" style="float:left; width:700px; margin-left:30px;">
				<div>
					<table style="width:100%;" id="brdContent">
						<colgroup>
							<col width="15%">
							<col width="*">
						</colgroup>
						<tbody>
							<tr style="border: 1px solid #ccc;">
								<th style="text-align: center;">말머리</th>
								<td>
									<select id="frid">
										<c:forEach items="${frtypes}" var="frtype">
											<option value="${frtype.frid}">${frtype.typename}</option>
										</c:forEach>
									</select>
								</td>
							<tr style="border: 1px solid #ccc;">
								<th style="text-align: center;">제목</th>
								<td><input type="text" id="title" style="width:100%;"></td>
							</tr>
							<tr style="border: 1px solid #ccc;">
								<th style="text-align: center;">내용</th>
								<td style="min-height:400px;">
									<div id="content"></div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="buttons">
					<button class="fRight btn btn-default" id="cancel" style="padding:3px 9px; font-size:13px;">취소</button>
					<button class="fRight btn btn-default" id="addData" style="padding:3px 9px; font-size:13px;">등록</button>
				</div>
			</div>
		</div>
	</div>
</div>
<jsp:include page="../common/footer.jsp" flush="false"></jsp:include>

<!-- e:container -->