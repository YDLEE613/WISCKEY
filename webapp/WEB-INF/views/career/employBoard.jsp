<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
    
    <jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
    
<!-- ����Խ��� -->
<script type="text/javascript">
var curPage="/Career/employBoard?";
$(document).ready(function(){
	var defaultParams = {
			mypage:"${paramVO.mypage}",
			ptypeid:"${paramVO.ptypeid}"
	}

	var srchType = "${paramVO.srchType}";
	if(srchType !=null && srchType !=''){
		$("#searchType").val("${paramVO.srchType}");
		$("#keyword").val("${paramVO.keyword}");
		if(srchType ==1){
			$("#empid").hide();
			$("#keyword").show();
			$("#keyword").attr("placeholder", "����");
		}else if(srchType == 2){
			$("#empid").hide();
			$("#keyword").show();
			$("#keyword").attr("placeholder", "�г���");
		}else if(srchType == 3){
			$("#empid").val("${paramVO.empid}").prop("selected", true);
			$("#empid").show();
			$("#keyword").hide();
		}
	}	
	$("#addEmploymentBoard").click(function(){
		var params = $.param(defaultParams);
		var userno = "${session.userno}";
		var url = "/Career/employBoardWrite?";
		if(userno==""||userno==null){
			alert("�α��� �Ŀ� �̿��Ͻ� �� �ֽ��ϴ�");
			return;
		}else{
			$(location).attr("href", url+params);
		}
	});
	
	$("#searchType").change(function(){
		$("#keyword").val("");
		if($(this).val() == 1){
			$("#keyword").show();
			$("#empid").hide();
			$("#keyword").attr("placeholder", "����");
		}else if($(this).val() == 2){
			$("#keyword").show();
			$("#empid").hide();
			$("#keyword").attr("placeholder", "�г���");
		}else if($(this).val() == 3){
			$("#keyword").hide();
			$("#empid").show();
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
	
	
});

function search(){
	var keyword = $("#keyword").val();
	var empid = $("#empid").val(); 
	var searchType = $("#searchType").val();
	var params = $.extend({}, defaultParams, {keyword:keyword, srchType:searchType, empid:empid});
	var url ="/Career/employBoard?" +$.param(params);
	$(location).attr("href",url);
}

function viewBoard(brdid){
	var mypage = "${paramVO.mypage}";
	var url="/Career/employBoardView?brdid="+brdid + "&mypage=" + mypage;
	$(location).attr("href", url);
}
</script>

<style type="text/css">
#title_list li>a:hover {
	text-decoration: none;
	font-size: 110%;
	font-weight: bold;
	opacity: 1;
	color: black;
}
#current{
	font-size: 105%;
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

#top_row>td{
	font-size:80%;
}

#top_row>td{
	font-size: 80%;
}
input::placeholder{
	font-size: 12px;
}


</style>


<!-- s:container -->
<div class="container">
	<jsp:include page="/WEB-INF/views/common/top.jsp"></jsp:include>
	<div class="hr_dash" style="width: 84.3%; margin-left: 100px; "></div>
	<div class="row">
		<div class="main_body" style="overflow:hidden">
			<div class="left_menu" style="float:left; width:150px; padding-top: 7px; margin-left: 40px;">
				<div id="l_title" style="font-weight: bold;">
					<span style="font-weight: bold; margin-top: 10px; margin-left: 20px; font-size: 110%;">���</span>
					<ul id="title_list" style="list-style:none; text-decoration: none;">
						<li><a href="/Career/">�������</a></li>
						<li><a id="current"href="/Career/employBoard?ptypeid=3">����Խ���</a></li>
					</ul>
				</div>
			</div>
			<div class="center_menu" style="width: 700px; float:left; margin-left:30px;">
				<table id="primary_table" style="background-color: #f7f7f7; width:700px; border-top: 2px solid #910019; ">
					<colgroup>
						<col style="width:5%;">
						<col style="width:50%;">
						<col style="width:10%;">
						<col style="width:10%;">
						<col style="width:5%;">
					</colgroup>
					<thead>
						<tr id="top_row" style="width: 700px; height:30px; text-align:center; background-color:#d3d3d3;  padding: 10px;">
							<td>��ȣ</td>
							<td><span>��</span><span style="padding-left: 40px;">��</span></td>
							<td>�г���</td>
							<td>�ۼ���</td>
							<td>��ȸ��</td>
						</tr>
					</thead>
					<tbody style="text-align: center; padding: 10px;">
						<c:forEach items="${boardList }" var="list">
							<tr id="list" style="height: 25px; border-bottom: 1px solid #d3d3d3; font-size:80%;">
								<td style="text-align:center;">&nbsp;${list.brdid}</td>
								<td style="text-align: left; padding-left: 10px;cursor: pointer; font-size:100%; padding-top: 5px;" 
									onClick="javascript:viewBoard(${list.brdid});">
								 	<span id="list_title" style="font-weight: 100%;">[${list.typename}]&nbsp;${list.title} </span><span style="color: #910019; margin-left: 2px;">(${list.repcount})</span>
								</td>
								<td style="text-align:center;">&nbsp;${list.writer }</td>
								<td style="text-align:center;">&nbsp;${list.regdate }</td>
								<td style="text-align:center;">&nbsp;${list.count }</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<div id="writeBtn" style=" float: right; padding-top: 5px;">
					<button class="btn" id="addEmploymentBoard" style="width: 50px; line-height: 15px; vertical-align: middle; padding: 0px;">
						<span style="font-size: 80%;">�۾���</span>
					</button>
				</div>
				<div id="search_box" style="padding-left: 210px; height: 20px; padding-top:20px;">
					<div id="searchValue" >
						<select id="searchType" style="width:100px; height:20px; font-size: 60%;">
					 		<option value="1">����</option>
							<option value="2">�г���</option>
							<option value="3">�Խù� Ÿ��</option>
						</select>
						<input type="text" id="keyword" placeHolder = "����" style="width: 120px; height:20px;">
						<select id="empid" style="display:none;">
							<option value="0">��ü</option>
							<c:forEach items="${emptypes}" var="emptype">
								<option value="${emptype.empid}">${emptype.typename}</option>
							</c:forEach>
						</select>
						<button class="btn default" id="search" style="margin-left:5px; line-height: 17px; width:45px; vertical-align:middle; padding:0px;">
							<span style="font-size:80%">�˻�</span>
						</button>
					</div>
				</div>
				
				<div class="col-10 mt15">
					<div class="fLeft text-center col-8" style="padding-top:20px; margin-left:80px;">
				    	<jsp:include page="../common/paging.jsp" flush="false"></jsp:include>
					</div>
				</div>
			</div>
		</div>
	</div> 
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" flush="false"></jsp:include>