<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%-- <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.vydya.theschool.common.constants.TSConstants"%>
<%@ page import="com.vydya.theschool.web.constants.WebConstants"%>

<style>


div.allLibs div.cat-inner-boundary {
/* width: 188px !important; */
float: left;
height: auto;
padding: 3px;
}

#free-file .c-inner-border {
clear: both;
display: table-row;
padding: 5px 5px 0;
}

#free-file .cat-inner:hover {
border: 2px solid #A2F397;
}


#free-file .cat-inner {
background-color: #FFFFFF;
border: 2px solid #E4E3E1;
box-shadow: 0 1px 4px rgba(0, 0, 0, 0.067);
padding: 3px;
}

.cat-inner div.trans {
background-color:rgba(0,0,0,0.7);
filter: alpha(opacity=40); /* For IE8 and earlier */
filter: progid:DXImageTransform.Microsoft.gradient(startColorstr=#4C000000,endColorstr=#4C000000);
bottom: 14px;
color: #fff;
display: block;
left: 0;
padding: 2px 7px 2px 7px;
position: absolute;
word-wrap: break-word;
position: relative;

}
.cat-inner div.trans a{
color:#fff;
text-transform: uppercase;
font-weight: bold;
}
.catImage{

width: 111px;
height: 148px;
padding-left: 0px;
padding-top: 9px;
}

</style>
<script defer="defer">
	
</script>
<script type="text/javascript">
	$(document).ready(function() {

		$(".bookCatName").click(function() {
			var bookCatId = $(this).attr("id").split('_');
			$("#bookCatForm").attr("action","books.htm");
			$('#bookCatForm #bookCatId').val(bookCatId[1]);
			$("#bookCatForm").submit();
		});
		$(".catImage").click(function() {
			var bookCatId = $(this).attr("id").split('_');
			$("#bookCatForm").attr("action","books.htm");
			$('#bookCatForm #bookCatId').val(bookCatId[1]);
			$("#bookCatForm").submit();
		});
		
		$(".editlink").click(function() {
			var bookCatId = $(this).attr("id").split('_');
			$("#bookCatForm #actionType").val("<%=WebConstants.VIEW%>");
			$("#bookCatForm").attr("action", '<%=TSConstants.ACTION_EDIT%>.htm');
			$('#bookCatForm #bookCatId').val(bookCatId[1]);
			$("#bookCatForm").submit();
		});
		$(".deletelink").click(function() {
			
			if(confirm("Do you want to delete this bookCat?")){
			
			var bookCatId = $(this).attr("id").split('_');
			$('#bookCatForm #bookCatId').val(bookCatId[1]);
			
			$.post('delete.htm',$("#bookCatForm").serialize(),function(data){
				if(data.success==true){
					var div = $("div#bookCat_"+bookCatId[1]);
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
				$("#bookCatForm #actionType").val("<%=WebConstants.VIEW%>");
				$("#bookCatForm").attr("action", '<%=TSConstants.ACTION_ADD%>.htm');
				$("#bookCatForm").submit();
			}); 
		
		
			$('.message font').fadeIn().delay(5000).fadeOut();
			$('.successMsg').fadeIn().delay(5000).fadeOut();
		function bookCatContains(bookCatId){
			$(".inner-boundary").each(function(ind, value) { 
				var bookCatV = $(this).attr("id").split('_');
			   //alert('bookCat ' + ind + ':' + $(this).attr('id')); 
			   if(bookCatV[1]==bookCatId){
				   return false;
			   }
			});
			  return true;
		}
	});
</script>
<style>


div.allGalleries div.abc-inner-boundary {
float: left;
padding: 5px;
}

.cat-inner div.gallery-decorator .lib-title{
text-overflow: ellipsis;
white-space: nowrap;
overflow: hidden;
width: 136px;
}



</style>
<div class="allGalleries" id="free-file">

<form:form name="bookCatForm" method="POST" commandName="bookCatForm" id="bookCatForm">
	<form:input type="hidden" path="actionType" class="" id="actionType" />
	<form:hidden path="id" value="" id="bookCatId" />
	
		<h1>Library</h1>
		<p>School bookCat</p>
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
					<%-- <ts:button validateAction="true" action="<%=WebConstants.ADD_bookCat%>"  type="button"  
					 id="addBttn" cssClass="large clButton yellow " name="Add" value="Add" title="Add" /> --%>
				</div>
					
			</div>
	
		<div class="outer-boundary">
		<c:if test='${null!=bookCatList }'>
			<c:forEach var="cat" items="${bookCatList}">
				<div class="cat-inner-boundary-B" id="bookCat_${cat.id}">
					<div class="c-inner-border">
						<div class="cat-inner">
							<div class="thumbnail bookcontainer">
									 <img src="${pageContext.request.contextPath}/static/simg-org/${cat.imageName}" id="bookCat_${cat.id}" class="catImage"
							 	alt="${cat.name}" />
								<div class="overdiv"> 
								<div style="float: left"><a class="ln editlink" id="ed_${cat.id}">Edit</a></div>
								<div style="float: right"><a class="ln deletelink" id="de_${cat.id}">Delete</a> </div></div>
				 			</div>
							<div class="content-div">
							<div class="gallery-decorator">
								
									<a  id="cat_${cat.id}"  class="bookCatName"><span class="lib-title">${cat.title}</span>&nbsp;(${cat.count})</a>
								
								<div class="img-content-div"></div>
							</div>
							<div class="gallery-info-container">
								&nbsp;by&nbsp;${cat.lastmodifiedby}
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


