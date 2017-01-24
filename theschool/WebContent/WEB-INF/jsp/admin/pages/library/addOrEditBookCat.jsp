<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.vydya.theschool.common.constants.TSConstants"%>
<%@ page import="com.vydya.theschool.web.constants.WebConstants"%>
<script type="text/javascript">

$.validator.setDefaults({
	submitHandler: function() {


	}
});

	jQuery(document).ready(
					function($) {

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
						 
						 
						$("#bookCatForm").validate(
										{
											rules : {
												name : {
													required : true
												},
												
												title : {
													required : true
												}

											},
											messages : {
												title : {
													required : "Title is required."
												},
												name : {
													required : "Name is required."
												}
											} ,

											submitHandler : function(form) {

												$("#validity_label").html('<div class="alert alert-success">No errors.</div>');
												$(this).attr("disabled", true);
												$("#bookCatForm").submit();
											},
											invalidHandler : function(form,	validator) {
												$("#validity_label").html('<div class="alert alert-error">There be '
																		+ validator.numberOfInvalids()
																		+ ' error'
																		+ (validator.numberOfInvalids() > 1 ? 's'																			: '')
																		+ ' here.</div>');
											}
										});

						
						formName = 'imageForm';
						cropRatio = 146 / 194;//762/330; 680 / 460:W/H
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
				<h2 class="bg-header">Add Book Category</h2>
			</div>

			<div class="clearfix form-container" id=""
				style="position: relative;">
				<div>
					<center>
						<form:errors path="error" cssClass="alertMsg" />
					</center>
				</div>
				<c:if test='${null!=messagekey }'>
					<div class="successMsg">
						<spring:message code="${messagekey}" />
						<c:remove var="success_key" scope="session" />
					</div>
				</c:if>
				<c:remove var="messagekey" scope="session" />
				<c:if test='${null!=success_key }'>
					<div class="successMsg">
						<spring:message code="${success_key}" />
					</div>
					<c:remove var="success_key" scope="session" />
				</c:if>
				<div class="span5" id="validity_label"></div>
				<div style="" class="formDataDiv addFormv">
					<table border="0" cellspacing="0" cellpadding="2">

				<tr><td>
				
				<form:form enctype="multipart/form-data" name="bookCatForm"
						id="bookCatForm" method="POST" commandName="bookCatForm">
						<form:input type="hidden" path="id" class="" />
						<form:input type="hidden" path="actionType" class="" id="gactionType" />
						<form:hidden path="unid"/>
						<form:hidden path="uuid"/>
						
				<table border="0" cellspacing="0" cellpadding="2">
						<tr>
							<td>Category Name<span class="mandatory">*</span></td>
							<td><form:input type="text" path="name" class="" required=""
									placeholder=" Name" data-placement="right" /> <form:errors
									path="name" cssClass="errormsg" /><span class="errormsg"
								id="nameError"></span></td>
						</tr>
						<tr>
							<td>Category Title<span class="mandatory">*</span></td>
							<td><form:input type="text" path="title" class=""
									name="title" required="" placeholder="Gallery Title"
									data-placement="right" /> <form:errors path="title"
									cssClass="errormsg" /><span class="errormsg" id="nameError"></span></td>
						</tr>
						<%-- <tr>
							<td>Gallery Description<span class="mandatory">*</span></td>
							<td><form:input type="text" path="descripton" class=""
									name="descripton" required="" placeholder="Description"
									data-placement="right" /> <form:errors path="descripton"
									cssClass="errormsg" /><span class="errormsg"
								id="bookCatDescError"></span></td>
						</tr> --%>

						<tr>
							<td colspan="2"><input type="button"
								class="large clButton gray" id="backBttn" title="Back"
								onClick="history.back();return false;" value="Back" /> <input
								type="submit" class="large clButton blue" id="" title="Save"
								value="Save" /></td>
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
														src="${pageContext.request.contextPath}/static/simg-fix/117x155/${imageForm.url}"
														id="cropedImage"
														style="height: 155px; width: 117px; display: inline-block;" />
												</c:when>
												<c:otherwise>
													<img src="" id="cropedImage"
														style="height: 155px; width: 117px; display: inline-block;" />
												</c:otherwise>
											</c:choose> <span class="errormsg" id="cropedImageError"></span></td>
									</tr>
									<tr>
										<td style="float: left"><spna>Image</spna></span><span
											class="mandatory">*</span> <form:input type="file"
												path="imageFile" class="upload" id="fileUpload"
												name="imageFile" required="" placeholder="Required"
												data-placement="right" /> <form:errors path="imageFile" cssClass="errormsg" /><span class="errormsg" id="fileError"></span></td>
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


