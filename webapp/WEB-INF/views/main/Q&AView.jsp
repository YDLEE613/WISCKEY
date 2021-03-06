<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
    
<script type="text/javascript">
$(document).ready(function(){
	
	var defaultParams={
		brdid: "${paramVO.brdid}",
		userno: "${session.userno}",
		nickname: "${session.nickname}",
		mypage: "${paramVO.mypage}",
	};
	
	
	$("#QnAList").click(function(){
		var params = $.param(defaultParams);
		$(location).attr("href", "/Q&A?"+params);
	})
	
	$("#addReply").click(function(){
		var url = "/addQnABoardReply";
		var replyContent = $("#reply").val();
		var params = $.extend({}, defaultParams, {repContent:replyContent});
		if(params.repContent==""||params.repContent==null){
			alert("댓글은 공백일 수 없습니다.");
			return;
		}
		if(params.userno==""||params.userno==null){
			alert("로그인하여 주십시오.");
			return;
		}else{
			$.post(url, params, function(data){
				alert("댓글이 등록되었습니다.");
				location.reload(true);
			});
		}
	});

	$("#QnADelete").click(function(){
		var url = "/deleteQnABoard";
		var params = $.extend({}, defaultParams, {});
		$.post(url, params, function(data){
			alert("게시글이 삭제되었습니다.");
			$(location).attr("href","/Q&A");
		});
	});
	
	
	//update
	var writerno = "${vo.userno}";
	
	if(defaultParams.userno == writerno){
		$("#QnAUpdate").show();
		$("#QnADelete").show();
	}
	
	$("#QnAUpdate").click(function(){
		var url = "/Q&AWrite?";
		var params = $.param(defaultParams);
		$(location).attr("href", url+params);
	});
	
	
	
	var title = new String($("#title").text());
	var length = ~-encodeURI(title).split(/%..|./).length;
	//76바이트가 넘으면 alt
	if(length>76){
		$('span#title').attr('title',title);
		var title = cutInUTF8(title, 76);
		title += "...";
		$("#title").text(title);
	}
	console.log("title length: "+ length);
})

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

#title_list>li{
	list-style-type: disc; 
	list-style-position: inside;	
}

#QnADelete, #QnAUpdate,#QnAList{
	margin-left:5px; 
	line-height: 20px; 
	width:45px; 
	vertical-align:middle; 
	padding:0px;
}
#QnAcontent{ 
	min-height:300px;
}

</style>

<!-- s:container -->
<div class="container">
	<jsp:include page="../common/top.jsp"></jsp:include>
	<div class="hr_dash" style="width: 100%"></div>
	<div class="row">
		<div class="main_body" style="overflow: hidden;">
			<div id="left_menu" style="float: left; width: 130px;  padding-top: 7px; margin-left: 40px;"> <!-- -20px -->
				<div id="l_first_title" style="font-weight: bold; border-right: 2px solid #910019; ">
					<div style="font-weight: bold; padding-left:5px; font-size: 110%; ">FAQ<br/></div>
					<div style="clear:both;"></div>
					<ul id="title_list" style="list-style: none; padding-left: 10px; text-decoration: none; padding-top: 5px;">
						<li><a href="/FAQ">FAQ</a></li>
						<li><a id="current" href="/Q&A">Q&A</a></li>
					</ul>
				</div>
			</div>
			<div class="center_menu" style="float: left; margin-left: 35px; width: 700px;">
				<div id="QnAmain" style="width: 100%; border: 1px solid #cacaca; margin-top: 5px; padding: 10px; background-color: white;">
					<div id="QnAtitle" style="width: 100%; background-color: lightgrey; font-size: 19px; padding:5px; border-top: 2px solid grey; ">
						<span id="title" style="font-weight:bold;" title="" val="${vo.title}">${vo.title }</span>  <span style="float: right; font-size:14px;"> ${vo.regdate }</span><br/>
					</div>
					<div id="notice_extra" style="width:100%; background-color: white; padding:5px; font-size:12px;">
						<span style="float: left;">
							작성자: <b>${vo.writer }</b> 
						</span>
						<span style="float: right;">
							조회수: ${vo.count}
						</span>
					</div>
					<div style="clear:both;"></div>
					<div class="hr_dash" style="opacity: 0.3; background: grey;"></div>
					
					<div id="QnAcontent" style="width:100%;margin-top:10px;">
						${vo.content }
					</div>
					
					<div class="hr_dash" style="background: grey;"></div>
					<div style="clear:both;"></div>
					
					<div style="float: left; width:100%;">
						<button class="btn delete" id="QnADelete" style="float: right; margin-top:5px; display:none;">삭제</button>
						<button class="btn confirm" id="QnAList" style="float: right; margin-top: 5px;">목록	</button>
						<button class="btn update" id="QnAUpdate" style="float:right; margin-top:5px; display:none;">수정</button>	
					</div>
					
					<div style="clear:both;"></div>
					<div id="QnA_reply" style="margin-top:20px; border: 1px solid #cacaca; border-left:0; border-right:0;padding: 10px; font-size: 12px;">
						댓글쓰기<br/>
						<textarea id="reply" style="width:600px; height: 60px; text-align: left; overflow:auto;  margin-top:5px; padding-top:5px;"></textarea>
						<button id="addReply" style="float: right; height:50px; width: 50px; margin-top:8px;">등록</button>
					</div>
					
					<div style="height: 1px; background-color: lightgrey; width:100%; margin-top:15px;"></div>
					
					<c:forEach items="${reps }" var="rep">
						<div style="border-bottom: 1px solid lightgrey;padding-bottom: 15px; margin-top:15px; padding-left:12px;" id="${rep.repid}">
							<b>${rep.replier} </b> <span style="font-size:12px;">(${rep.repRegdate})</span>
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
    