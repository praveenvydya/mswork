<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%-- <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.vydya.theschool.common.constants.TSConstants"%>
<%@ page import="com.vydya.theschool.web.constants.WebConstants"%>

<script defer="defer">
	
</script>
<script type="text/javascript">
	$(document).ready(function() {

	/* 	$(".tgroupName").click(function() {
			var tgroupId = $(this).attr("id").split('_');
			$("#toppersGroupForm").attr("action","viewAll.htm");
			$('#toppersGroupForm #topperGrpId').val(tgroupId[1]);
			$("#toppersGroupForm").submit();
		});
		$(".tgroupImage").click(function() {
			var tgroupId = $(this).attr("id").split('_');
			$("#toppersGroupForm").attr("action","viewAll.htm");
			$('#toppersGroupForm #topperGrpId').val(tgroupId[1]);
			$("#toppersGroupForm").submit();
		}); */
		
		$(".editlink").click(function() {
			var tgroupId = $(this).attr("id").split('_');
			$("#toppersGroupForm #actionType").val("<%=WebConstants.VIEW%>");
			$("#toppersGroupForm").attr("action", "editGroup.htm");
			$('#toppersGroupForm #topperGrpId').val(tgroupId[1]);
			$("#toppersGroupForm").submit();
		});
		$(".deletelink").click(function() {
			
			if(confirm("Do you want to delete this Gallery?")){
			
			var tgroupId = $(this).attr("id").split('_');
			$('#toppersGroupForm #topperGrpId').val(tgroupId[1]);
			
			$.post('delete.htm',$("#toppersGroupForm").serialize(),function(data){
				if(data.success==true){
					var div = $("div#topperOfYr_"+tgroupId[1]);
					div.css("background-color","#666666");
					div.fadeOut(400,function(){
						div.remove();
					});
					$(".message").empty().html("<font class='g'>"+data.message+"</font>");
					return false;
				}
				else{
					$(".message").empty().html("<font class='r'>"+data.errormsg+"</font>");
				}
			});
			}
		else{
			
			return false;
		}
			
		});
		
		 $('#addBttn').click(function(){
				$('#addBttn').attr("disabled", true);
				$("#toppersGroupForm #actionType").val("<%=WebConstants.VIEW%>");
				$("#toppersGroupForm").attr("action", "addGroup.htm");
				$("#toppersGroupForm").submit();
			}); 
		
		 $('.message font').fadeIn().delay(5000).fadeOut();
			$('.successMsg').fadeIn().delay(5000).fadeOut();
		/* 
		
		$("#addTopperGrp").fancybox({
			'width'				: '75%',
			'height'			: '75%',
			'autoScale'			: false,
			'overlayShow'	: true,
			'hideOnOverlayClick':false,
			'transitionIn'		: 'none',
			'transitionOut'		: 'none',
			'type'				: 'iframe',
			'onClosed'			:function() {
				loadUpdatedTopperGroup();
				
			}
		});
		
		function loadUpdatedTopperGroup(){
			$.getJSON('loadUpdatedGallery.htm', function(data) {displayUpdatedGroup(data);});
		 }
		
		function displayUpdatedGroup(data) {
			$.each(data, function(index, grp) {
					if(groupContains(grp.id)){
						   $(".outer-boundary").append('<div class="inner-boundary"><div class="inner-border"><div class="gallery-inner"><div class="thumbnail itemcontainer"><img src="/theschool/gallery?id='+gallery.id+'" id="galleryImage_'+gallery.id+'" class="galleryImage" alt="'+gallery.name+'" /> </div><div class="gallery-decorator"><h3><a href="" id="galleryName_'+data.gallery+'"  class="galleryName">'+gallery.name+'</a></h3><p>'+gallery.galleryDesc+'</p></div><div class="gallery-info-container"><span class="displayDate">'+gallery.lastmodified+'</span><p>'+gallery.lastmodifiedby+'</p></div></div></div></div>');
					  }
				});
				}
		 */
		function groupContains(grpId){
			$(".inner-boundary").each(function(ind, value) { 
				var grpV = $(this).attr("id").split('_');
			   if(grpV[1]==grpId){
				   return false;
			   }
			});
			  return true;
		}
		
		
	});
</script>
<style>
body {
	font-family: 'Myriad Pro', 'Helvetica', tahoma, sans-serif;
	font-size: 13px;
	letter-spacing: 0.02em;
	line-height: 1.3em;
}


</style>

<div id="free-file" class="allGalleries">
	
		
		
	<form:form name="toppersGroupForm" method="POST" commandName="toppersGroupForm"
		id="toppersGroupForm" onsubmit="">
		<form:input type="hidden" path="actionType" class="" id="actionType" />
		<form:hidden path="id" value="" id="topperGrpId" />
		
		<h1>School Toppers</h1>
		<p>Some Description</p>
		<div class="message"></div>
		
		
		<div id="" style="display: inline-block;">
			<div class="">	<div><center><form:errors path="error" cssClass="alertMsg" /></center></div>
							<c:if test='${null!=messagekey }'>
								<div class="successMsg">
									<spring:message code="${messagekey}" />
									<c:remove var="success_key" scope="session" />
								</div>
							</c:if>
							<c:remove var="messagekey" scope="session" />
							<c:if test='${null!=success_key }'>
								<div class="successMsg"><spring:message code="${success_key}" /></div>
								<c:remove var="success_key" scope="session" />
							</c:if></div>
				<div class="">
					<input type="button"  class="large clButton yellow" id="addBttn" title="Add" value="Add"/>
					<%-- <ts:button validateAction="true" action="<%=WebConstants.ADD_GALLERY%>"  type="button"  
					 id="addBttn" cssClass="large clButton yellow " name="Add" value="Add" title="Add" /> --%>
				</div>
					
			</div>
			
		<div class="outer-boundary">
		<c:if test='${null!=toppersGroupList }'>
			<c:forEach var="tgroup" items="${toppersGroupList}">
				<div class="admin-inner-boundary-T" id="topperOfYr_${tgroup.id}">
					<div class="a-inner-border">
						<div class="gallery-inner">
							<div class="thumbnail itemcontainer">
									<%-- <img src="/theschool/toppers/thumb_${tgroup.name}.jpeg" id="topperGrpImage_${tgroup.id}_${tgroup.name}" class="tgroupImage"
							 	alt="${tgroup.name}" /> --%>
							 	<img src="${pageContext.request.contextPath}/static/simg-fit/352x140/${tgroup.imageName}"
									id="topperGrpImage_${tgroup.id}_${tgroup.name}" class="tgroupImage"
							 	alt="${tgroup.name}" 
									style="display: inline-block;" />
								<div class="overdiv"> <div style="float: left"><a class="ln editlink" id="ed_${tgroup.id}">Edit</a></div><div style="float: right"><a class="ln deletelink" id="de_${tgroup.id}">Delete</a> </div></div>
				 			</div>
							<div class="content-div">
								<div class="gallery-decorator">
										
										<a href="${pageContext.servletContext.contextPath}/admin/manageToppers/viewAll.htm?t=${tgroup.id}" 
										id="tg_${tgroup.id}_${tgroup.url}"  class="">${tgroup.name}&nbsp;</a>
										
									<div class="img-content-div3">${tgroup.description}</div>
								</div>
							</div>
						</div>
					</div>
				
				</div>
			</c:forEach>
		</c:if>
		</div>
		
	

	</form:form>
</div>


