<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../common/header.jsp"></jsp:include>

<script type="text/javascript">
var curPage = "/About/?";
$(document).ready(function(){
	var defaultParams ={
			userno: "${session.userno}",
			username:"${session.username}",
			nickname: "${session.nickname}",
			mypage:"${paramVO.mypage}"
	};
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
		if($(this).val()==1){
			$("#searchTitle").show();
			$("#searchNickname").hide();
		}else if($(this).val()==2){
			$("#searchTitle").hide();
			$("#searchNickname").show();
		}
	});
	
});

function viewNotice(nid){
	var url = "/About/viewNotice?nid=" + nid;
	$(location).attr("href", url);
}
</script>

<style type="text/css">
#title_list_about li>a:active {
	font-size: 105%;
	font-weight: bold;
	text-decoration: none;
}

#title_list_about li>a:hover {
	text-decoration: none;
	font-size: 105%;
	font-weight: bold;
	opacity: 1;
	color: black;
}

#title_list_about li>a:visited {
	font-size: 105%;
	font-weight: bold;
	text-decoration: none;
}

#title_list_about li>a {
	opacity: 0.7;
	text-decoration: none;
	
}

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

#title_list_about>li{
	list-style-type: disc; 
	list-style-position: inside;	
}

#title_list_notice>li{
	list-style-type: decimal;
	
}

</style>
<!-- s:container -->
<div class="container">
	<jsp:include page="../common/top.jsp"></jsp:include>
	<div class="hr_dash" style="width: 100%"></div>
	<div class="row">
		<div class="main_body" style="overflow: hidden;">
			<div id="left_menu" style="float: left; width: 150px;"> <!-- -20px -->
				<div id="l_first_title" style="font-weight: bold; padding: 15px;">
					<span style="font-weight: bold; padding-left:5px; font-size: 110%;">ABOUT <br/></span>
					<ul id="title_list_about" style="list-style: none; padding-left: 10px; text-decoration: none; padding-top: 5px;">
						<li><a href="/About/introWisckey">����Ű �Ұ�</a></li>
						<li><a href="/About/introUniv">�б��Ұ�</a></li>
						<li><a href="/About/notice">��������</a></li>
						<li><a href="/About/otherSites">�ֿ����Ʈ</a></li>
					</ul>
				</div>
				<div style="clear: both;"></div>
				<div id="l_second_title" style="font-size: 115%; margin-top: 20px; padding: 15px;">
					<span style="font-weight: bold;">�������� <br/></span>
					<ol id="title_list_notice" style=" padding-left: 15px; text-decoration: none; padding-top:5px;">
						<c:forEach items="${aboutList}" var="notice" begin="0" end="3" varStatus="status" >
							<c:choose>
								<c:when test="${status.index < 3}">
									<li onClick="javascript:viewNotice(${notice.nid});" style="cursor: pointer; font-weight: bold; font-size:80%;">${notice.title }</li>
								</c:when>
								<c:otherwise>
									<li onClick="javascript:viewNotice(${notice.nid});" style=" cursor: pointer; font-size: 80%; ">${notice.title}</li>
								</c:otherwise>
							</c:choose>							
						</c:forEach>
					</ol>
				</div>
			</div>

			<div class="center_menu"
				style="float: left; width: 870px;  margin-left:30px;">
					<div id="notice_fixed" style="width: 100%; border-top: 1.5px solid #ff0000;  border-bottom: 1.5px solid #ff0000;">
						<table id="top_table" style="background-color:#fffafa;">
							<colgroup>
								<col style="width:50px;">
								<col style="width:450px; padding-left: 70px;">
								<col style="width:130px;">
								<col style="width:130px;">
								<col style="width:60px;">
								<col style="width:56px">
							</colgroup>
							<thead>	
								<tr id="top_row" style=" width: 900px; height:40px; text-align: center; border-bottom: 1px solid #ccc; padding: 10px;">
									<td>��ȣ</td>
									<td>����</td>
									<td>�г���</td>
									<td>�����</td>
									<td>��ȸ</td>
									<td>��õ��</td>
								</tr>
							</thead>
							<tbody>
							<c:forEach items="${aboutList}" var = "list">
								<tr style="height:40px;">
									<td style="text-align: center;">&nbsp;${list.nid}</td>
									<td onClick="javascript:viewNotice(${list.nid});" style="cursor:pointer; padding-left:10px;">&nbsp;${list.title}</td>
									<td style="text-align: center;">&nbsp;${list.writer}</td>
									<td style="text-align: center;">&nbsp;${list.regdate}</td>
									<td style="text-align: center;">&nbsp;${list.count}</td>
									<td style="text-align: center;">&nbsp;${list.likes}</td>
								</tr>
							</c:forEach>
							</tbody>
						</table>
						<div id="writeBtn" style="float: right; padding-top: 20px;">
								<button class="btn" id="addNotice">�۾���</button>
						</div>
					</div>
					<div id="search_box" style="text-align:left; margin-left: 100px;height: 45px; padding-top:40px;">
						<div id="searchValue" >
							<select id="searchType" style="width:150px;;">
						 		<option value="1">����</option>
								<option value="2">�г���</option>
								<option value="3">�Խù� Ÿ��</option>
							</select>
							<input type="text" id="searchTitle" placeHolder = "����" style="width: 200px;">
							<input type="text" id="searchNickname" style="display:none; width:200px;">
							<button class="btn default" id="search" style="margin-left:5px;">�˻�</button>
						</div>
					</div>
					<div class="col-10">
						<div class="fLeft text-center col-8" style="padding-top:20px;">
							   <jsp:include page="../common/paging.jsp" flush="false"></jsp:include>
						</div>
					</div>
					
				</div>
			</div>
			
			
		</div>
	</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" flush="false"></jsp:include>
