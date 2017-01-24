<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="ts" uri="/WEB-INF/ts-tags.tld"%>
<%@ page import="com.vydya.theschool.common.constants.TSConstants"%>
<%@ page import="com.vydya.theschool.web.constants.WebConstants"%>
<script type="text/javascript">
	jQuery(document).ready(function($) {

						$("#imageForm").validate(
										{
											rules : {
												imageFile : {
													required : {
														depends : function(element) {
															return ($('#cropedImage').src == '');
														}
													},
													extension : "jpeg|jpg",
													maxSize : true,
													minSize : true
												},
											},
											messages : {
												imageFile : {
													required : "Please Select a Book category Image.",
													extension : "Please select a valid format(.jpeg)"
												}
											}
										});

						$("#homePageImageForm").validate(
										{
											rules : {
												description : {
													required : true
												},
												imageTitle : {
													required : true
												}

											},
											messages : {
												description : {
													required : "Please write about image."

												}
											},

											submitHandler : function(form) {

												$("#validity_label").html('<div class="alert alert-success">No errors. </div>');
												$(this).attr("disabled", true);
												$("#homePageImageForm").ajaxSubmit(imageOptions);
											},
											invalidHandler : function(form,	validator) {
												$("#validity_label").html('<div class="alert alert-error">There be '
																		+ validator.numberOfInvalids()
																		+ ' error'
																		+ (validator.numberOfInvalids() > 1 ? 's'
																				: '')
																		+ ' here.</div>');
											}
										});

						$.validator.addMethod("maxSize",
								function(val, element) {
									var ext = $(element).val().split('.').pop().toLowerCase();
									var size = element.files[0].size;
									if (size > 5242880) {//5MB =5242880
										return false;
									} else {
										return true;
									}

								}, "Image size cannot be more than 5Mb");

						$.validator.addMethod("minSize",
								function(val, element) {
									var ext = $(element).val().split('.').pop().toLowerCase();

									var allow = new Array('jpeg', 'jpg');
									var size = element.files[0].size;

									if (size < 10240) {//1048576
										return false;
									} else {
										return true;
									}

								}, "Image size cannot be less than 10kb");
						formName = 'imageForm';
						cropRatio = '<spring:message code="image.cropratio.width"/>' / '<spring:message code="image.cropratio.height"/>';//762/330; 680 / 460:W/H
						photoId = 'cropedImage';
						imageUrl = '';
						$('#fileUpload').change(function() {
							var validator = $("#imageForm").validate();
							if (validator.element('#fileUpload')) {
								$("#" + formName).ajaxSubmit(options);
							}
						});
						 $("#cropedImage").click(function(){
							   $("#fileUpload").click();
							});
					});
</script>
<style>
.addFormv div{
	float: left;
}
</style>

<div id="tabularData">
	<div class="blFormDiv">
		<div class="form-header clearfix">
			<h2 class="bg-header">Add Home Page Image</h2>
			<a id="" href=""></a>
		</div>
		<div class="clearfix" id="" style="position: relative;">
			<!-- form-container -->
			<c:if test='${null!=success_key }'>
				<div class="successMsg">
					<spring:message code="${success_key}" />
				</div>
				<c:remove var="success_key" scope="session" />
			</c:if>
			<div class="span5" id="validity_label"></div>
			<div style="" class="formDataDiv addFormv">
				<table border="0" cellspacing="0" cellpadding="2">
					<tr>
						<td>
					<form:form enctype="multipart/form-data" name="homePageImageForm"
						id="homePageImageForm" method="POST"
						commandName="homePageImageForm">
							<form:input type="hidden" path="id" class="" />
							<form:input type="hidden" path="actionType" class="" id="hactionType" />
							<form:hidden path="unid" id="hunid"/>
							<form:hidden path="uuid" id="huuid"/>
									
						<div>
							<center>
								<form:errors path="error" cssClass="alertMsg" />
							</center>
						</div>
						<table width="" border="0" class="order">
							<tbody>
								
								<tr>
									<td><label class="text-right padding-top5">Image
											Title:<span class="mandatory">*</span>
									</label>
									</td>
									<td><form:input type="text" path="imageTitle" cssClass=""
											name="imageTitle" /> <form:errors path="imageTitle"
											cssClass="errormsg" />
									</td>
								</tr>
							<tr>
									<td><label class="text-right padding-top5">Description:<span
											class="mandatory">*</span>
									</label>
									</td>
									<td><form:input type="text" path="description" cssClass=""
											name="description" /> <form:errors path="description"
											cssClass="errormsg" />
									</td>
								</tr>
								<tr>
									<td class="firstcol"><label for="titlePosition" class="">Content
											Title Position:</label></td>
									<td><form:select path="titlePosition" cssClass="dropDown"
											disabled="">
											<c:forEach items="${tpRefList}" var="tpRef">
												<form:option value="${tpRef.idValue}"
													label="${tpRef.description}"
													selected="${titlePosition eq tpRef.idValue ? 'selected': ''}" />
											</c:forEach>
										</form:select>
									</td>
								</tr>
								<tr>
									<td colspan="2"><input type="button"
										class="large clButton gray" id="backBttn" title="Cancel"
										onClick="history.back();return false;" value="Cancel" /> <input
										type="submit" class="large clButton blue" id="" title="Save"
										value="Save" /></td>
								</tr>
						</table>
					</form:form>
				</td>
						<td><form:form enctype="multipart/form-data" name="imageForm"
								id="imageForm" method="POST" commandName="imageForm">

								<form:input type="hidden" path="actionType" id="actionType" />
								<form:input type="hidden" path="x" />
								<form:input type="hidden" path="y" />
								<form:input type="hidden" path="height" />
								<form:input type="hidden" path="width" />
								<form:hidden path="uuid" />

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
