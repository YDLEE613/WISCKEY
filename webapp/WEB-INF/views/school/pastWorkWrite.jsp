<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<script type="text/javascript">
var upImgIds = [];
$(document).ready(function(){
	var defaultParams={
		brdid: "${paramVO.brdid}",
		userno: "${session.userno}",
		mypage: "${paramVO.mypage}"
	};
	$('#content').summernote({
		lang:'ko-KR',
		height: 400,
		disableResizeEditor:true,
		callbacks:{
			onImageUpload: function(files){
				for(var i = files.length-1; i>=0; i--){
					sendFile(files[i], this);
				}
			}
		}
	});
	
	$("#cancel").click(function(){
		var url = "/School/PastWork?";
		var params = $.param(defaultParams);
		$(location).attr("href", url+params);
	});
	
	var brdid = "${paramVO.brdid}";
	var bEdit = false;
	
	if(brdid!=0 && brdid!="" && brdid!=null){
		var url="/School/findPastWorkContent";
		bEdit = true;
		$.post(url, defaultParams, function(data){
			$("#title").val(data.title);
			$("#content").summernote('code', data.content);
		});
	}
	
	$("#addPastWork").click(function(){ 
		var url = "/School/addPastWorkData";
		var content = $("#content").summernote('code');
		
		var params = $.extend({}, $("#pastWorkContent").serialization(), {swid:1, content:content});
		
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
			url = "/School/modPastWorkData";
			params.brdid = brdid;
			$.post(url, params, function(data){
				$(location).attr("href", "/School/pastWorkView?brdid="+data);
			});
		}else{
			$.post(url, params, function(data){
				$(location).attr("href", "/School/pastWorkView?brdid="+data);
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


//제목 글자제한
function byteCheck(str){
	var byteLen = 0;
	for(var i = 0; i<str.length; i++){
		var eachChar = escape(str.charAt(i));
		if(eachChar.length == 1){
			byteLen++;
		}else if(eachChar.indexOf("%u") != -1){
			byteLen+=3;
		}else if(eachChar.indexOf("%") != -1){
			byteLen ++;
		}
	}
	
	return byteLen;
}
function titleByte(){
	var title = $("#title").val();
	var length = byteCheck(title);
	console.log(length+" bytes");
	if(length>82){
		var tmp = cutInUTF8(title,76);
		alert("제목 길이가 제한을 초과하였습니다.");
		$("#title").text(tmp);
		$("#title").focus();
		
	}
}
function cutInUTF8(str, n) {
  var len = Math.min(n, str.length);
  var i, cs, c = 0, bytes = 0;
  for (i = 0; i < len; i++) {
      c = str.charCodeAt(i);
      cs = 1;
      if (c >= 128) cs++;
      if (c >= 2048) cs++;
      if (n < (bytes += cs)) break;
  }
  return str.substr(0, i);
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
					<div id="l_title" style="font-weight: bold; padding-left:5px; font-size: 110%;">학업<br/></div>
					<div style="clear:both;"></div>
					<ul id="title_list" style="list-style: none; padding-left: 10px; text-decoration: none; padding-top: 5px;">
						<li><a id="current" href="/School/pastWork">족보</a></li>
						<li><a href="/School/education">학업게시판</a></li>
					</ul>
				</div>
			</div>
			<div id="right_menu" style="float:left; width:700px; margin-left:30px;">
				<table style="width:100%;" id="pastWorkContent">
					<colgroup>
						<col width="15%" >
						<col width="*">
					</colgroup>
					<tbody>
						<tr style="border: 1px solid #ccc;">
							<th  style="text-align: center;"> 제목</th>
							<td><input type="text" id="title" style="width:400px;" onKeyDown="javascript:titleByte()"></td>
						</tr>
						<tr style="border: 1px solid #ccc;">
							<th  style="text-align: center;">내용</th>
							<td style="padding-top: 8px; padding-bottom: 8px;">
								<textarea id="content" style="width:100%; height:400px; display:none;" valid="내용"></textarea>
							</td>
						</tr>
					</tbody>
				</table>
				
				
			<div class="buttons">
				<button class="fRight btn btn-default" id="cancel" style="padding:3px 9px; font-size:13px;">취소</button>
				<button class="fRight btn btn-default" id="addPastWork" style="padding:3px 9px; font-size:13px;">등록</button>
			</div>
			
			</div>
		</div>
	</div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" flush="false"></jsp:include>