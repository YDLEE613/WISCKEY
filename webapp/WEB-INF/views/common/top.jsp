<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<script type="text/javascript">
var defaultParams = {
		userno: "${session.userno}",
		userid: "${session.userid}",
		nickname: "${session.nickname}",
		email: "${session.email}",
		authid: "${session.authid}",
		authname: "${session.authname}"
	}
$(document).ready(function(){
	var navbars;
	var url;
	if(defaultParams.authid == 1 || defaultParams.authid == 2){
		$("#admin_menu").show();
		if(defaultParams.authid == 2){
			$(".superadmin").hide();
		}
	}
	var userno = defaultParams.userno;
	if(userno!=null&&userno!=""){
		$("#logoutDiv").show();
		$("#userName").text(defaultParams.nickname);
	}else{
		$("#logoutDiv").hide();
	}
});
function login(){
	var url = "/LogInOut/Login";
	var params = $("#login").serialization();
	
	$.post(url, params, function(data){
		if(data.rst == "Success"){
			$.cookie("saveid", params.userid, {
				expires:7
			});
			if($("input[type=checkbox]#savepw").is(":checked")){
				var savepw = $.cookie("savepw");
				if (savepw == null || (savepw != null && savepw == "")) {
					$.cookie("savepw", data.passwd, {
						expires:7
					});
				}
			} else {
				$.cookie("savepw", "", { expires: -1 });
			}
			$(location).attr("href","/");
		} else if(data.rst == "NotFound"){
			alert("존재하지 않는 회원입니다.");
			$.cookie("saveid", '', {expires:-1});
			$("#userid").val('');
			$("#userid").focus();
			$("#passwd").val('');
		} else if(data.rst == "Fail"){
			alert("비밀번호가 일치하지 않습니다.");
			$.cookie("saveid", '', {expires:-1});
			$("#passwd").val('');
			$("#passwd").focus();
		}else if(data.rst == "Expired"){
			alert("탈퇴한 회원 입니다.");
			$.cookie("saveid",'',{expires:-1});
			$("#userid").val('');
			$("#passwd").val('');
		}
	}).error(function(){
		alert("로딩에 실패하였습니다. 잠시 후 다시 시도해 주시기 바랍니다.");
	});
	
}

</script>

<style type="text/css">
.dropdown-menu>li>.link:hover{
	background-color: #ccc;
	font-weight: bold;
	color: black;
	
}
</style>


<div class="row top_nav">
		<div class="nav logInOut" id="logoutDiv" style="float:right; vertical-align: middle;padding-top:12px; display:hidden; padding-right: 110px;" >
			<span id="userName" style="font-weight: bold; font-size:105%;"></span>님
			<a href="/Member/memberView" style="margin-left: 20px; margin-right:10px; font-size:85%;">내 정보</a>|<a href="/LogInOut/Logout" style="margin-left:10px;font-size:85%;">LOGOUT</a>
		</div>
		<div style="width:100%; height:140px;">
			<div class="logo" id="top_logo" style="width:35%; height:100%; margin-left:auto; margin-right:auto">
				<a id="logoSrc" href="/"><img style="height:100%; width: 100%;"src="../images/LOGO1.png" alt="logo" /></a>
			</div>
		</div>
		<nav class="navbar navbar-default">
			<div class="container-fluid" style="background-color: #910019">
				<div class="div_nav">
					<ul class="nav navbar-nav">
						<li class="dropdown"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-haspopup="true"
							aria-expanded="false" style="color:white;padding-left:60px;"><span style="font-weight: bold;">ABOUT</span></a>
							<ul class="dropdown-menu">
								<li><a class="link" href="/About/introWisckey">위스키 소개</a></li>
								<li><a class="link" href="/About/introUniv">학교소개</a></li>
								<li><a class="link" href="/About/">공지사항</a></li>
								<li><a class="link" href="/About/otherSites">주요사이트 소개</a></li>
							</ul>
						</li>
					</ul>
					<ul class="nav navbar-nav">
						<li class="dropdown"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-haspopup="true"
							aria-expanded="false" style="color:white; margin-left:20px;">취업 게시판<span class="caret"></span></a>
							<ul class="dropdown-menu">
								<li><a class="link" href="/Career/?ptypeid=8">취업공고</a></li>
								<li><a class="link" href="/Career/employBoard?ptypeid=3">취업 게시판</a></li>
							</ul></li>
					</ul>
					<ul class="nav navbar-nav">
						<li class="dropdown"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-haspopup="true"
							aria-expanded="false" style="color:white; margin-left:20px;">학업 게시판<span class="caret"></span></a>
							<ul class="dropdown-menu">
								<!-- <li><a href="/School/pastWork">족보</a></li> -->
								<li><a class="link" href="/School/education?ptypeid=5">학업게시판</a></li>
							</ul></li>
					</ul>
					<ul class="nav navbar-nav">
						<li class="dropdown"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-haspopup="true"
							aria-expanded="false" style="color:white; margin-left:20px;">깨알팁<span class="caret"></span></a>
							<ul class="dropdown-menu">
								<li><a class="link" href="/Tip/tips?ptypeid=6">맛집</a></li>
								<li><a class="link" href="/Tip/tips?ptypeid=7">벼룩시장</a></li>
								<li><a class="link" href="/Tip/tips?ptypeid=9">생활팁</a></li>
							</ul></li>
					</ul>
					<ul class="nav navbar-nav">
						<li class="dropdown"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-haspopup="true"
							aria-expanded="false" style="color:white; margin-left:20px;">동아리 게시판<span class="caret"></span></a>
							<ul class="dropdown-menu">
								<li><a class="link" href="/Org/">소개</a></li>
								<li><a class="link" href="/Org/orgBoard?orgtypeid=1">학술</a></li>
								<li><a class="link" href="/Org/orgBoard?orgtypeid=2">취미</a></li>
								<li><a class="link" href="/Org/orgBoard?orgtypeid=3">스포츠</a></li>
								<li><a class="link" href="/Org/orgBoard?orgtypeid=4">종교</a></li>
							</ul></li>
					</ul>
					<ul class="nav navbar-nav">
						<li class="dropdown"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-haspopup="true"
							aria-expanded="false" style="color:white; margin-left:20px;">자유 게시판<span class="caret"></span></a>
							<ul class="dropdown-menu">
								<li><a class="link" href="/Board/?ptypeid=1">게시판</a></li>
								<!-- <li><a href="/Board/?ptypeid=2">신입생 게시판</a></li> -->
							</ul></li>
					</ul>
					<ul class="nav navbar-nav" style="display:none;" id="admin_menu">
						<li class="dropdown"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-haspopup="true"
							aria-expanded="false" style="color:white; margin-left:20px;">관리자<span class="caret"></span></a>
							<ul class="dropdown-menu">
								<li class='superadmin'><a class="link" href="/Admin/ManageMenu">게시판 관리</a></li>
								<li class='superadmin'><a class="link" href="/Admin/ManageOrg">동아리 관리</a></li>
								<li class='orgadmin'><a class="link" href="/Admin/MyOrg">내 동아리</a>
							</ul>
						</li>
					</ul>
				</div>
			</div>
		</nav>
</div>
