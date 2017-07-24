<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<jsp:include page="../common/header.jsp"></jsp:include>

<script type="text/javascript">
$(document).ready(function(){
	$.post("/About/listFourNotice", {}, function(data){
		$.each(data, function(index, item){
		
			console.log(index);
			
			var title = item.title;
			console.log(title);
			
			if(title.length>10){
				title = title.substring(0, 10);
				title += "...";
				console.log(title);
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

function viewNotice(nid){
	var url = "/About/viewNotice?nid=" + nid;
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
	text-decoration:none;
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
	padding-left: 5px;
	box-shadow: 2px 2px #778899;
}

#title_list_notice>li{
	list-style-type:none;
}
*/
#title_list_about>li{
	list-style-type: disc; 
	list-style-position: inside;	
}


#center{
	border: 2px solid #808080;
	border-radius: 25px;
	padding-left: 10px;
	box-shadow: 2px 2px #778899;
	margin-left: 30px;
}
</style>

<!-- s:container -->
<div class="container">
	<jsp:include page="/WEB-INF/views/common/top.jsp"></jsp:include>
	<div class="hr_dash" style="width: 84.3%; margin-left: 100px; "></div>
	<div class="row">
		<div class="main_body" style="overflow:hidden">
			<div id="left_menu" style="float: left; width: 130px;  padding-top: 7px; margin-left: 40px;"> <!-- -20px -->
				<div id="l_first_title" style="font-weight: bold; border-right: 2px solid #910019; ">
					<div style="font-weight: bold; padding-left:5px; font-size: 110%; ">ABOUT <br/></div>
					<div style="clear:both;"></div>
					<ul id="title_list_about" style="list-style: none; padding-left: 10px; text-decoration: none; padding-top: 5px;">
						<li><a href="/About/introWisckey">����Ű �Ұ�</a></li>
						<li><a id="current" href="/About/introUniv">�б��Ұ�</a></li>
						<li><a href="/About/">��������</a></li>
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
				<div class="center_menu" id="center" style=" width: 700px; float:left;">
					<div id="center_s_menu" style="text-align:center; margin-top: 30px;">
						<img src="../images/uwMadison.jpg" style="width:70%;">
				</div>
				
				<div style="clear: both;"></div>
				
				<div id="center_s_menu2" style="padding-left: 30px; margin-top: 50px; margin-bottom: 50px;">
					<p>����� �б��Ұ�</p>
					
					<p>��.</p>
				</div>
				
				</div>
	
			<div class="right_menu">
				<div id="r_title">
					
				</div>
			</div>
		</div>
	</div>

	

</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp" flush="false"></jsp:include>