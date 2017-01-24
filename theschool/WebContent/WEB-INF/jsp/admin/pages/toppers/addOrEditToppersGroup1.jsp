<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.vydya.theschool.common.constants.TSConstants"%>
<%@ page import="com.vydya.theschool.web.constants.WebConstants"%>
<script type="text/javascript">  
jQuery(document).ready(function($){
	//$('input').filter('.datepicker').datepicker({ changeMonth: true,changeYear: true, dateFormat:"yy-mm-dd"});

	 
		
	 $('#saveBttn').click(function(){
		
		$('#saveBttn').attr("disabled", true);	
		$("#toppersGroupForm").submit();
		//loadGalleries();
	});  
	 
	 $("#imageForm").validate({
			rules: {   
				 	imageFile : {
						required : {
							depends : function(
									element) {
								return ($('#cropedImage').src == '');
							}
						},
						extension: "jpeg|jpg",
					},
				       
			},
			messages: {
				imageFile : {
					required : "Please Select a Book category Image.",
					extension:"Please select a valid format(.jpeg)"
				}
			}
	 });
	 
	 $("#toppersGroupForm").validate({
			rules: {   
				 	name: {required: true},
				   file: {required: {depends: function(element) { return ($('#cropedImage').src == '');}}},
				   yearOfClass: {required: true,
					   number:true},
				   className: {required: true},
				   description: {required: true},
				   totalMarks: {required: true,
					   number:true},
				   title: {required: true},
				   imageFile : {
						required : {
							depends : function(
									element) {
								return ($('#cropedImage').src == '');
							}
						},
						extension: "jpeg|jpg",
					},
				       
			},
			messages: {
				name:{	required: "Please write about Group Name."},
				file:{required: "Please Select a group image."},
				yearOfClass:{	required: "Year of Class is required."},
				className:{	required: "Please select event date."},
				description:{	required: "Write Description about Toppers."},
				title:{	required: "Toppers Group title is required."},
				totalMarks:{	required: "Total Marks is required."},
				imageFile : {
					required : "Please Select a Book category Image.",
					extension:"Please select a valid format(.jpeg)"
				},
			},
			
			submitHandler: function(form) { 
				
				$("#validity_label").html('<div class="alert alert-success">No errors.</div>');
				$(this).attr("disabled", true);	
				$("#toppersGroupForm").submit();
				},
			invalidHandler: function(form, validator) {
				$("#validity_label").html('<div class="alert alert-error">There be '+validator.numberOfInvalids()+' error'+(validator.numberOfInvalids()>1?'s':'')+' here.</div>');
			}
		});
	 
	 formName = 'imageForm';
	 cropRatio = '<spring:message code="image.cropratio.width"/>' / '<spring:message code="image.cropratio.height"/>';//762/330; 680 / 460:W/H
		photoId = 'cropedImage';
		imageUrl = '';
		$('#fileUpload').change(function() {
			var validator = $("#imageForm").validate();
			if(validator.element('#fileUpload')){
				$("#" + formName).ajaxSubmit(options);
			}
		});
		 $("#cropedImage").click(function(){
			   $("#fileUpload").click();
			});
	
}); 
</script>
<style>

</style>



	<div id="tabularData">
			<div class="blFormDiv">
					<div class="form-header clearfix">
						<h2 class="bg-header">Add Toppers Group</h2>
						<a id="" href=""></a>
					</div>
					<div class="clearfix form-container" id="" style="position: relative;">
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
							</c:if>	
			<div class="span5" id="validity_label"></div>
			<div style="" class="formDataDiv addFormv">
			
			<table border="0" cellspacing="0" cellpadding="2">
					<tr>
						<td>
					<form:form enctype="multipart/form-data" name="toppersGroupForm" id="toppersGroupForm"
				method="POST" commandName="toppersGroupForm"	>	
				<form:input type="hidden" path="id" class="" />
				<form:input type="hidden" path="actionType" class="" id="tgactionType" />
				<form:hidden path="unid"/>
				<form:hidden path="uuid"/>
		<div><center><form:errors path="error" cssClass="alertMsg" /></center></div>
				<table border="0" cellspacing="0" cellpadding="2">
					<tr>
						<td>Toppers Group Name<span class="mandatory">*</span></td>
						<td><form:input type="text" path="name" class="searchTextBoxes"  required="" placeholder="Group Name" data-placement="right"/>
						<br><form:errors path="name" cssClass="errormsg"/><span class="errormsg" id="nameError" ></span></td>
					</tr>
					<tr>
						<td><label for="title" class="">Toppers Group Title</label></td>
						<td ><form:input type="text" path="title" class="searchTextBoxes" />
						<br><form:errors path="title" cssClass="errormsg"/><span class="errormsg" id="nameError"></span></td>
					</tr>
					<tr>
						<td><label for="yearOfClass" class="">Toppers of Year<span class="mandatory">*</span></label></td>
						<td ><form:input type="text" path="yearOfClass" class="searchTextBoxes" />
						<br><form:errors path="yearOfClass" cssClass="errormsg"/><span class="errormsg" id="eventTypeError"></span></td>
					</tr>
					<tr>
						<td><label for="className" class="">Toppers of Class<span class="mandatory">*</span></label></td>
						<td ><form:input type="text" path="className" class="searchTextBoxes" />
						<br><form:errors path="className" cssClass="errormsg"/><span class="errormsg" id="eventCategoryError"></span></td>
					</tr>
					<tr>
						<td><label for="description" class="">Description</label></td>
						<td ><form:input type="text" path="description" class="searchTextBoxes" />
						<br><form:errors path="description" cssClass="errormsg"/><span class="errormsg" id="eventPlaceError"></span></td>
					</tr>
					<tr>
						<td><label for="totalMarks" class="">Total Marks</label></td>
						<td ><form:input type="text" path="totalMarks" class="searchTextBoxes" />
						<br><form:errors path="totalMarks" cssClass="errormsg"/><span class="errormsg" id="eventPlaceError"></span></td>
					</tr>
					<tr>
					<td class="firstcol"><label for="active" class="">Active:</label>
					</td>
					<td><form:select path="active"> 
								<form:option value="1" label="Active" /> 
								<form:option value="0" label="Inactive" /> 
							</form:select></td>
				</tr>
					<tr>
					<td></td>
					<td>
						
						<input type="button"  class="large clButton gray" id="backBttn" title="Back" onClick="history.back();return false;" value="Back"/>
						<input type="submit"  class="large clButton blue" id="" title="Save" value="Save"/>
					</td>
					</tr>
				</table></form:form>
				</td>
						<td><form:form enctype="multipart/form-data" name="imageForm"
								id="imageForm" method="POST" commandName="imageForm">

								<form:input type="hidden" path="actionType" id="actionType" />
								<form:input type="hidden" path="x" />
								<form:input type="hidden" path="y" />
								<form:input type="hidden" path="height" />
								<form:input type="hidden" path="width" />
								<form:hidden path="uuid" />
								<form:input type="hidden" path="priority" value="1" />
								<table>
									<tr>
										<td><c:choose>
												<c:when test="${null!=imageForm.url}">
													<img
														src="${pageContext.request.contextPath}/static/simg-fix/352x140/${imageForm.url}"
														id="cropedImage"
														style="height: 140px; width: 352px; display: inline-block;" />
												</c:when>
												<c:otherwise>
													<img src="" id="cropedImage"
														style="height: 140px; width: 352px; display: inline-block;" />
												</c:otherwise>
											</c:choose> <span class="errormsg" id="cropedImageError"></span></td>
									</tr>
									<tr>
										<td style="float: left"><spna>Image</spna></span><span
											class="mandatory">*</span> <form:input type="file"
												path="imageFile" class="upload" id="fileUpload"
												name="imageFile" required="" placeholder="Required"
												data-placement="right" /> <form:errors path="imageFile"
												cssClass="errormsg" /><span class="errormsg" id="fileError"></span></td>
									</tr>
									<tr>
										<td style="float: left"><span>Don't Crop</span> &nbsp;<form:checkbox
												path="dontCrop" style="margin:5px;" /><span class="errormsg"
											id="cropedImageError"></span></td>
									</tr>
								</table>
							</form:form></td>
					</tr></table>
				</div>
				
				</div>


	</div>




				

</div>


