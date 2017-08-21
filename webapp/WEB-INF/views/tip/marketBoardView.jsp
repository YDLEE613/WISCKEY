<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<script type="text/javascript">

$(document).ready(function(){
	var defaultParams={
			mypage: "${paramVO.mypage}"
	}
	$("#marketBoardList").click(function(){
		var params = $.param(defaultParams);
		$(location).attr("href", "/Tip/market?"+params);
	});
	
	$("#addReply").click(function(){
		var url = "/Tip/addMarketReply";
		var replyContent = $("#reply").val();
		var params = $.extend({}, defaultParams, {repContent:replyContent, userno:"${session.userno}", brdid:"${paramVO.brdid}"});
		if(params.repContent==""||params.repContent==null){
			alert("����� ������ �� �����ϴ�.");
			return;
		}
		if(params.userno==""||params.userno==null){
			alert("�α����Ͽ� �ֽʽÿ�.");
			return;
		}else{
			$.post(url, params, function(data){
				alert("����� ��ϵǾ����ϴ�.");
				location.reload(true);
			});
		}
	});
	
	$("#marketBoardDelete").click(function(){
		var url = "/Tip/delBoardData";
		var params = $.extend({}, defaultParams, {userno:"${session.userno}", brdid:"${paramVO.brdid}"});
		$.post(url, params, function(data){
			alert("�Խñ��� �����Ǿ����ϴ�.");
			$(location).attr("href","/Tip/market?"+$.param(defaultParams));
		}).error(function(){
			alert("�����͸� �����ϴµ� �����Ͽ����ϴ�. �ٽ� �õ��� �ּ���.");
			$(location).reload(true);
		});
	});
	
	var writerno = "${vo.userno}";
	var userno = "${session.userno}";
	
	if(userno == writerno){
		$("#marketBoardUpdate").show();
		$("#marketBoardDelete").show();
	}
	$("#marketBoardUpdate").click(function(){
		var url = "/Tip/marketBoardWrite?";
		var params = $.param($.extend({}, defaultParams, {brdid:"${paramVO.brdid}"}));
		$(location).attr("href", url+params);
	});
});

//��� ��õ/����
function likes(like, repid){
	var url = "";
	var msg = "";
	if(like == 'Y'){
		url = "/Tip/modRepLikes";
	}else if(like == 'N'){
		url = "/Tip/modRepDislikes";
	}
	var params = $.extend({}, defaultParams, {repid:repid, userno:"${session.userno}"});
	
	$.post(url, params, function(data){
		var msg = "";
		if(like == 'Y'){
			if(data == "Fail"){
				msg = "�̹� ��õ�Ͽ����ϴ�.";
			}else if(data == "Success"){
				msg = "��õ�Ͽ����ϴ�.";
			}else{
				msg = "������ �߻��Ͽ����ϴ�. �ٽ� �õ��� �ֽʽÿ�.";
			}
		}else if(like == "N"){
			if(data == "Fail"){
				msg = "�̹� �����Ͽ����ϴ�.";
			}else if(data == "Success"){
				msg = "�����Ͽ����ϴ�.";
			}else{
				msg = "������ �߻��Ͽ����ϴ�. �ٽ� �õ��� �ֽʽÿ�.";
			}
		}
		alert(msg);
		if(data == "Success"){
			location.reload(true);
		}else{
			return;
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

#marketBoardDelete, #marketBoardUpdate,#marketBoardList{
	margin-left:5px; 
	line-height: 20px; 
	width:45px; 
	vertical-align:middle; 
	padding:0px;
}
</style>

<!-- s:container -->
<div class="container">
	<jsp:include page="../common/top.jsp"></jsp:include>
	<div class="hr_dash" style="width: 100%"></div>
	<div class="row">
		<div class="main_body" style="overflow: hidden;">
			<span id="userno_market" value="${vo.userno}" style="display:none;">${vo.userno}</span>
			<div class="left_menu" style="float:left; width:150px; padding-top: 7px; margin-left: 40px;">
				<div id="l_title" style="font-weight: bold;">
					<span style="font-weight: bold; margin-top: 10px; margin-left: 20px; font-size: 110%;">������</span>
					<ul id="title_list" style="list-style:none; text-decoration: none;">
						<li><a href="/Tip/food">����</a></li>
						<li><a id="current" href="/Tip/market">�������</a></li>
					</ul>
				</div>
			</div>
			<div class="center_menu" style="float: left; margin-left: 35px; width: 700px;">
				
				<div id="marketBoard_main" style="width: 100%; border: 1px solid #cacaca; margin-top: 5px; padding: 10px; background-color: white;">
					<div id="marketBoard_title" style="width: 100%; background-color: lightgrey; font-size: 20px; padding:5px; border-top: 2px solid grey; ">
						<b>[${vo.typename}] ${vo.title }</b> <span style="float: right; font-size:14px;"> ${vo.regdate }</span><br/>
					</div>
					<div id="marketBoard_extra" style="width:100%; background-color: white; padding:5px; font-size:12px;">
						<span style="float: left;">
							�ۼ���: <b>${vo.writer }</b>
						</span>
						<span style="float: right;">
							��ȸ��: ${vo.count} 
						</span>
					</div>
					
					<div style="clear:both;"></div>
					
					<div class="hr_dash" style="opacity: 0.3; background: grey;"></div>
					
					<div id="marketBoard_content" style="width:100%; min-height: 300px; margin-top:10px;">
						${vo.content }
					</div>
					
						
					<div class="hr_dash" style="background: grey;"></div>
					<div style="clear:both;"></div>

					<div style="float: left; width:100%;">
						<button class="btn delete" id="marketBoardDelete" style="float: right; display:none;"><span style="font-size:80%;">����</span></button>
						<button class="btn confirm" id="marketBoardList" style="float: right;"><span style="font-size:80%;">���</span></button>			
						<button class="btn update" id="marketBoardUpdate" style="float:right; display:none;"><span style="font-size:80%;">����</span></button>	
					</div>
					
				
					
					<div style="clear:both;"></div>
					<div id="marketBoard_reply" style="margin-top:20px; border-radius:2em; border: 1px solid #cacaca; padding: 10px; font-size: 12px;">
						��۾���<br/>
						<textarea id="reply" style="width:600px; height: 60px; text-align: left; overflow:auto; border-radius: 1em; margin-top:5px; padding-top:5px;"></textarea>
						<button id="addReply" style="float: right;height:50px; width: 50px;">���</button>
					</div>
					<div style="height: 1px; background-color: lightgrey; width:100%; margin-top:15px;"></div>
					
					<c:forEach items="${reps }" var="rep">
						<div style="border-bottom: 1px solid lightgrey;padding-bottom: 15px; margin-top:15px;" id="${rep.repid}">
							<b>${rep.replier} </b> <span style="font-size:12px;">(${rep.repRegdate})</span>
							<span style="float:right;font-size:12px;">
								<a href="javascript:likes('Y', ${rep.repid})" style="font-size:12px;"><img src="/images/icon/thumbs-up.png" style="width:12px;"> ${rep.repLikes}</a> | 
								<a href="javascript:likes('N', ${rep.repid})" style="font-size:12px;"><img src="/images/icon/thumb-down.png" style="width:12px;"> ${rep.repDislikes}</a>
							</span>
							<br/>
							<span style="font-size:13px;margin-top:10px;">${rep.repContent}</span>
						</div>
						
					</c:forEach>
					
					<div style="clear:both;"></div>
				
				</div>
			</div>
		</div>
	</div>
</div>





<jsp:include page="/WEB-INF/views/common/footer.jsp" flush="false"></jsp:include>
