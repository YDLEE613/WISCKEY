<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../common/header.jsp"></jsp:include>

<script type="text/javascript">
var curPage = "/About/?";
$(document).ready(function(){
	var defaultParams = {
			mypage:"${paramVO.mypage}"
	}

	var authid = "${session.authid}";
	if( authid ==1 ){
		$("#writeBtn").show();
	}
	var srchType = "${paramVO.srchType}";
	if(srchType !=null && srchType !=''){
		$("#searchType").val("${paramVO.srchType}");
		$("#keyword").val("${paramVO.keyword}");
		if(srchType ==1){
			$("#keyword").attr("placeholder","����");
		}else if(srchType == 2){
			$("#keyword").attr("placeholder", "�г���");
		}
	}	
	//�� ���� ���
	$("#addNotice").click(function(){
		var url = "/About/writeForm";
		if(defaultParams.userno==""||defaultParams.userno == null){
			alert("�α��� �Ŀ� �̿��Ͻ� �� �ֽ��ϴ�.");
			return;
		}else{
			$(location).attr("href",url);
		}
	});
	
	$("#searchType").change(function(){
		$("#keyword").val("");
		if($(this).val() == 1){
			$("#keyword").attr("placeholder", "����");
		}else if($(this).val() == 2){
			$("#keyword").attr("placeholder", "�г���");
		}
	});
	$("#search").click(function(){
		search();
	});
	$("#keyword").keydown(function(key){
		if(key.keyCode == 13){
			search();
		}
	});

	
	//���� �������� �� ���
	$.post("/About/listFourNotice", {}, function(data){
		$.each(data, function(index, item){
		
			var title = item.title;
			
			if(title.length>10){
				title = title.substring(0, 10);
				title += "...";
			}
			var li="";
			if(index<3){
				li ="<li  style='cursor: pointer;font-weight:bold; font-size:80%;' onClick='javascript:viewNotice("+ item.nid +");'>"
						+ ++index +'. '+ title +"</li>";
			}else{
				li ="<li  style='cursor: pointer;font-size:80%;' onClick='javascript:viewNotice("+ item.nid +");'>"
				+ ++index +'. '+ title +"</li>";
			}
			$("#notice_left").append(li);
			
		})
	});
});

function search(){
	var keyword = $("#keyword").val();
	var searchType = $("#searchType").val();
	var params = $.extend({}, defaultParams, {keyword:keyword, srchType:searchType});
	var url ="/About/?" +$.param(params);
	$(location).attr("href",url);
}
//��������
function viewNotice(nid){
	var url = "/About/viewNotice?nid=" + nid+ "&mypage=" + defaultParams.mypage;
	$(location).attr("href", url);
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
/*
#l_first_title{


	border: 2px solid #808080;
	border-radius: 25px;
	padding-left: 10px;
	box-shadow: 2px 2px #778899;

}

#l_second_title{
	border: 2px solid #808080;
	border-radius: 25px;
	padding-left: 10px;
	box-shadow: 2px 2px #778899;
}
*/
#title_list_about>li{
	list-style-type: disc; 
	list-style-position: inside;	
}
#row>td{
	font-size: 11.5px;
}
#top_row>td{
	font-size: 80%;
}
input::placeholder{
	font-size:65%;
}


</style>
<!-- s:container -->
<div class="container" >
	<jsp:include page="../common/top.jsp"></jsp:include>
	<div class="hr_dash" style="width: 84.3%; margin-left: 100px; "></div>
	<div class="row">
		<div class="main_body" style="overflow: hidden;">
			<div id="left_menu" style="float: left; width: 130px;  padding-top: 7px; margin-left: 40px;"> <!-- -20px -->
				<div id="l_first_title" style="font-weight: bold; border-right: 2px solid #910019; ">
					<div style="font-weight: bold; padding-left:5px; font-size: 110%; ">ABOUT <br/></div>
					<div style="clear:both;"></div>
					<ul id="title_list_about" style="list-style: none; padding-top:5px; padding-left: 10px; text-decoration: none;">
						<li><a href="/About/introWisckey">����Ű �Ұ�</a></li>
						<li><a href="/About/introUniv">�б��Ұ�</a></li>
						<li><a id="current" href="/About/">��������</a></li>
						<li><a href="/About/otherSites">�ֿ����Ʈ</a></li>
					</ul>
				</div>
				<!--  
				<div style="clear: both;"></div>
				<div id="l_second_title" style="font-size: 115%; margin-top: 20px; padding: 15px;">
					<span style="font-weight: bold;">�������� <br/></span>
					<ul id="title_list_notice" style=" padding-left: 5px; text-decoration: none; padding-top:5px;">
						<li id="notice_left" ></li>
					</ul>
				</div>
				-->
			</div>
			
			<div class="center_menu"
				style="float: left; width: 700px;  margin-left:30px;">
					<div id="notice" style="width: 700px; ">
						<table id="top_table" style="width:670px; background-color:#f7f7f7;border-top: 2px solid #910019;">
							<colgroup>
								<col style="width:5%;">
								<col style="width:65%;">
								<col style="width:10%;">
								<col style="width:10%;">
								<col style="width:5%;">
								<col style="width:5%;">
							</colgroup>
							<thead>	
								<tr id="top_row" style="background-color:#d3d3d3; height:30px; text-align: center; border-bottom: 1px solid #ccc; padding: 10px;">
									<td>��ȣ</td>
									<td><span>��</span><span style="padding-left: 40px;">��</span></td>
									<td>�г���</td>
									<td>��¥</td>
									<td>��ȸ</td>
									<td>��õ</td>
								</tr>
							</thead>
							<tbody>
							<c:forEach items="${aboutList}" var = "list">
								<tr id="row" style="height:25px; border-bottom: 1px solid #d3d3d3;">
									<td style="text-align: center; font-size: 80%;">&nbsp;${list.nid}</td>
									<td onClick="javascript:viewNotice(${list.nid});" style="cursor:pointer; padding-left:30px;">&nbsp;${list.title}</td>
									<td style="text-align: center; font-size: 80%;">&nbsp;${list.writer}</td>
									<td style="text-align: center; font-size: 80%;">&nbsp;${list.regdate}</td>
									<td style="text-align: center; font-size: 80%;">&nbsp;${list.count}</td>
									<td style="text-align: center; font-size: 80%;">&nbsp;${list.likes}</td>
								</tr>
							</c:forEach>
							</tbody>
						</table>
						<div id="writeBtn" style=" float: right; padding-top: 5px; padding-right: 30px; display:none; ">
								<button class="btn" id="addNotice" style="width: 50px; line-height: 15px; vertical-align: middle; padding: 0px;">
									<span style="font-size: 80%;">�۾���</span>
								</button>
						</div>
					</div>
					<div id="search_box" style="padding-left: 210px; height: 20px; padding-top:20px;">
						<div id="searchValue" >
							<select id="searchType" style="width:100px; height:20px; font-size: 60%;">
						 		<option value="1">����</option>
								<option value="2">�г���</option>
								<option value="3">�Խù� Ÿ��</option>
							</select>
							<input type="text" id="keyword" placeHolder = "����" style="width: 120px; height:20px;">
							<button class="btn default" id="search" style="margin-left:5px; line-height: 17px; width:45px; vertical-align:middle; padding:0px;">
								<span style="font-size:80%">�˻�</span>
							</button>
						</div>
					</div>
					<div class="col-10">
						<div class="fLeft text-center col-8" style="margin-left: 80px; padding-top:30px;">
							   <jsp:include page="../common/paging.jsp" flush="false"></jsp:include>
						</div>
					</div>
					
				</div>
			</div>
			
			
		</div>
	</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" flush="false"></jsp:include>
