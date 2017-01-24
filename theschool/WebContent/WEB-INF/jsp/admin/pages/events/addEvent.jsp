<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.vydya.theschool.common.constants.TSConstants"%>
<%@ page import="com.vydya.theschool.web.constants.WebConstants"%>
<script type="text/javascript">  
jQuery(document).ready(function($){
	//$('input').filter('.datepicker').datepicker({ changeMonth: true,changeYear: true, dateFormat:"yy-mm-dd"});

	 	$(".galleryName").click(function() {
			var galleryId = $(this).attr("id").split('_');
			$("#galleryImageSearchForm").attr("action","viewGalleryImages.htm");
			$('#galleryImageSearchForm #galleryId').val(galleryId[1]);
			$("#galleryImageSearchForm").submit();
		});
		
		$(".galleryImage").click(function() {
			var galleryId = $(this).attr("id").split('_');
			$("#galleryImageSearchForm").attr("action","viewGalleryImages.htm");
			$('#galleryImageSearchForm #galleryId').val(galleryId[1]);
			$("#galleryImageSearchForm").submit();
		}); 
		
	 $('.saveBttn').click(function(){
		
		$('.saveBttn').attr("disabled", true);	
		$("#galleryForm").attr("action", '<%=TSConstants.ACTION_ADD_GALLERY%>.htm');
		$("#galleryForm").submit();
		//loadGalleries();
	});  
	 
		$('.loadBttn').click(function(){
			
			loadGalleries();
		}); 
	 
		/* $(".saveBttn").click(function(){ 
			alert("d");
			$.post('addGallery.htm',$("#galleryForm").serialize(),function(data){updatedGalleryStatus(data);});
		}); */
		
	 function loadGalleries(){
		 
		 $.getJSON('viewGalleries.htm',  function(data) {
				displayGalleryImages(data);
			});
	 }
	 function displayGalleryImages(data) {
	
			$("#galleriesList").empty();
			$.each(data, function(index, gallery) {

				$("#galleriesList").append("<div class='gallery'><div class='imageDiv'><img width='auto' height='120px' border='0' class='galleryImage' id='galleryImage_"+gallery.id+"' src='data:image/jpg;base64,"+gallery.image+"'/></div><div class='gallery-decorator'><h3 class='galleryName' id='galleryName_"+gallery.id+"'>"+gallery.name+"</h3><p>"+gallery.galleryDesc+"</p></div></div>");//galleryData
				/* $.each(element, function(ind, el) {

					$.each(el, function(i, e) {

						$("#jsondata").append("<li>" + e + "</li>");

					});
				});
				$("#jsondata").append("</ul>"); */

			});
		}
	 
	 function updatedGalleryStatus(data){
		 alert(" ajax resp"+data.isSuccess);
	 }
	 
	 
	 var d = new Date();
		var year = d.getFullYear();
		var stY= year-19;
		var endY = year-2;
		 $(".datepicker").datepicker({  
		            changeMonth: true,
		            changeYear: true,
		            showButtonPanel: true,
					dateFormat:'yy-mm-dd',
					yearRange: stY+":"+endY,
					showButtonPanel: false
					//shortYearCutoff: 10
		        }); 
		 
	   
}); 
</script>
<style>

</style>



	<div id="titleBar">
		<div class="title">Add Galleries</div>
	</div>
	<div><center><form:errors path="error" cssClass="alertMsg" /></center></div>
	<c:if test='${null!=messagekey }'>
		<div class="successMsg">
			<spring:message code="${messagekey}" />
		</div>
	</c:if>
	<c:remove var="messagekey" scope="session" />
	<c:if test='${null!=success_key }'>
		<div class="successMsg"><spring:message code="${success_key}" /></div>
		<c:remove var="success_key" scope="session" />
	</c:if>	
	<div id="Galleries">

		<div class="">
			<form:form enctype="multipart/form-data" name="galleryForm" id="galleryForm"
				method="POST" commandName="galleryForm"	>
		<div><center><form:errors path="error" cssClass="alertMsg" /></center></div>
			<form:input type="hidden" path="id" class="" />
				<table width="500" border="0" cellspacing="0" cellpadding="2">

					<tr>
						<td>Gallery Name<span class="mandatory">*</span></td>
						<td colspan="2"><form:input type="text" path="name" class="searchTextBoxes" />
						<br><form:errors path="name" cssClass="errormsg"/><span class="errormsg" id="nameError"></span></td>
					</tr>
					<tr>
						<td>Gallery Title<span class="mandatory">*</span></td>
						<td colspan="2"><form:input type="text" path="title" class="searchTextBoxes" />
						<br><form:errors path="title" cssClass="errormsg"/><span class="errormsg" id="nameError"></span></td>
					</tr>
					<tr>
						<td>Gallery Type<span class="mandatory">*</span></td>
						<td colspan="2"><form:input type="text" path="galleryType" class="searchTextBoxes" />
						<br><form:errors path="galleryType" cssClass="errormsg"/><span class="errormsg" id="galleryTypeError"></span></td>
					</tr>
					<tr>
						<td>Gallery Category<span class="mandatory">*</span></td>
						<td colspan="2"><form:input type="text" path="galleryCategory" class="searchTextBoxes" />
						<br><form:errors path="galleryCategory" cssClass="errormsg"/><span class="errormsg" id="galleryCategoryError"></span></td>
					</tr>
					  
						  <tr>
								<td>Gallery Date <span class="mandatory">*</span></td>
								<td  colspan="2"><form:input maxlength="200" type="date" path="galleryDate" class="searchTextBoxes datepicker"  readonly="true"  /></td>
						  </tr>	
					<tr>
						<td>Gallery Place<span class="mandatory">*</span></td>
						<td colspan="2"><form:input type="text" path="galleryPlace" class="searchTextBoxes" />
						<br><form:errors path="galleryPlace" cssClass="errormsg"/><span class="errormsg" id="galleryPlaceError"></span></td>
					</tr>
					
					<tr>
						<td>Gallery Description<span class="mandatory">*</span></td>
						<td colspan="2"><form:input type="text" path="galleryDesc" class="searchTextBoxes" />
						<br><form:errors path="galleryDesc" cssClass="errormsg"/><span class="errormsg" id="galleryDescError"></span></td>
					</tr>
					
					<tr>
						<td>Gallery Image<span class="mandatory">*</span></td>
						<td><form:input  type="file" path="files" class="upload" />
						<br><form:errors path="files" cssClass="errormsg"/><span class="errormsg" id="fileError"></span></td>
					</tr>
					
				</table>
				<div id="sectionBttns">
					<input type="button" class="backBttn" title="Back" onClick="history.back();return false;" />
					 <input name="Add Gallery" type="button" class="saveBttn" title="Save" value=""/>
					  
					<input type="reset" value="" class="resetBttnBlack" title="Reset"/>
					<input name="Add Gallery" type="button" class="loadBttn" title="Save" value=""/>
				</div>
			</form:form>
		</div>
	</div>

<%-- <form:form name="galleryImageSearchForm" method="POST" commandName="galleryImageSearchForm"
		id="galleryImageSearchForm" onsubmit="">
		<form:hidden path="galleryId" value="" id="galleryId" />
		<div id="galleriesList"></div>
		</form:form> --%>

