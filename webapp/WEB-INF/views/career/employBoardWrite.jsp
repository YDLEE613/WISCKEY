<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
var upImgIds = [];
$(document).ready(function(){
	var defaultParams={
		mypage:"${paramVO.mypage}",
		ptypeid:"${paramVO.ptypeid}"
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
	
	var brdid = "${paramVO.brdid}";
	var bEdit = false;
	
	if(brdid!=0 && brdid!="" && brdid!=null){
		var url="/Career/findEmployBoardContent";
		bEdit = true;
		var params = $.extend({}, defaultParams, {brdid:brdid});
		if("${session.userno}" != data.userno || "${session.userno}" == null){
			alert("������ �� �ִ� ������ �����ϴ�.");
			$(location).attr("href", "/Career/employBoard?"+$.param(defaultParams));
			return;
		}else{
			$.post(url, params, function(data){
				$("#title").val(data.title);
				$("#content").summernote('code', data.content);
			});
			
		}
	}
	
	$("#addEmployBoard").click(function(){ 
		var url = "/Career/addEmployBoardData";
		var content = $("#content").summernote('code');
		var empid = $("empid").val();
		console.log("empid: "+ empid)
		var params = $.extend({}, $("#emplyBoardContent").serialization(), {brdid:brdid, empid:empid, content:content,userno:"${session.userno}"});
		
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
			url = "/Career/modEmployBoardData";
			params.brdid = brdid;
			$.post(url, params, function(data){
				$(location).attr("href", "/Career/employBoardView?brdid="+data);
			});
		}else{
			if(byteCheck(params.title)<=82){
				$.post(url, params, function(data){
					$(location).attr("href", "/Career/employBoardView?brdid="+data);
				});
			}else{
				alert("���� ���̰� ������ �ʰ��Ͽ����ϴ�.");
				$("#title").focus();
			}
		}
	});
	
	$("#cancel").click(function(){
		var url = "/Career/employBoard?";
		var params = $.param(defaultParams);
		$(location).attr("href", url+params);
	});
	
	//���� ���ڼ� ����
	var maxChars = $("#title");
	var maxLength = maxChars.attr('maxlength');
	$("#maxLength").text(maxLength);
	if(maxLength>0){
		maxChars.bind('keyup', function(e){
			length = new Number(maxChars.val().length);
			var counter = maxLength = length;
			$("#counter").text(counter);
		});
	}
	
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
//���� ��������
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
		alert("���� ���̰� ������ �ʰ��Ͽ����ϴ�.");
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
#title_list li>a {
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
	list-style-position: none ;
}
div input{
	float:left;
}
.checkBox{
	display:table-cell;
}

</style>
<!-- s:container -->
<div class="container">
	<jsp:include page="/WEB-INF/views/common/top.jsp"></jsp:include>
	<div class="hr_dash" style="width:100%;"></div>
	<div class="row">
		<div class="main_body" style="overflow:hidden">
				<div class="left_menu" style="float:left; width:150px; padding-top: 7px; margin-left: 40px;">
				<div id="l_title" style="font-weight: bold;">
					<span style="font-weight: bold; margin-top: 10px; margin-left: 20px; font-size: 110%;">���</span>
					<ul id="title_list" style="list-style:none; text-decoration: none;">
						<li><a href="/Career/">�������</a></li>
						<li><a id="current" href="/Career/employBoard">����Խ���</a></li>
					</ul>
				</div>
			</div>
			<div id="right_menu" style="float:left; width:700px; margin-left:35px;">
				<table style="width:100%;" id="emplyBoardContent">
					<colgroup>
						<col width="15%" >
						<col width="*">
					</colgroup>
					<tbody>
						<tr style="border: 1px solid #ccc;">
							<th style="text-align: center;">���Ӹ�</th>
							<td>
								<select id="empid">
									<c:forEach items="${emptypes}" var="emptype">
										<option value="${emptype.empid}">${emptype.typename}</option>
									</c:forEach>
								</select>
							</td>
							<tr>
						<tr style="border: 1px solid #ccc;">
							<th style="text-align: center;"> ����</th>
							<td>
								<input type="text" id="title" style="width:400px;" onKeyDown="javascript:titleByte()">
							</td>
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
				<button class="btn btn-default" id="cancel" style="float:right;">���</button>
				<button class="btn newEmployBoard" id="addEmployBoard" style="float: right;">�۾���</button>
			</div>
			
			</div>
		</div>
	</div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" flush="false"></jsp:include>