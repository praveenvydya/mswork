<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.vydya.theschool.common.constants.TSConstants"%>
<%@ page import="com.vydya.theschool.web.constants.WebConstants"%>
<script type="text/javascript">  
jQuery(document).ready(function($){
	//$('input').filter('.datepicker').datepicker({ changeMonth: true,changeYear: true, dateFormat:"yy-mm-dd"});

		
	$('.saveBttn').click(function(){
		
		$('.saveBttn').attr("disabled", true);	
		$("#galleryImageForm").attr("action", '<%=TSConstants.ACTION_ADD_GALLERY_IMAGES%>.htm');
											$("#galleryImageForm").submit();
										});

					});
</script>
<style>
</style>


<div id="">
	<div id="titleBar">
		<div class="title">Add Gallery Image</div>
	</div>
	<div>
		<center>
			<form:errors path="error" cssClass="alertMsg" />
		</center>
	</div>
	<c:if test='${null!=messagekey }'>
		<div class="successMsg">
			<spring:message code="${messagekey}" />
		</div>
	</c:if>
	<c:remove var="messagekey" scope="session" />

	<c:if test='${null!=success_key }'>
		<div class="successMsg">
			<spring:message code="${success_key}" />
		</div>
		<c:remove var="success_key" scope="session" />
	</c:if>


	<form:form enctype="multipart/form-data" name="galleryImageForm"
		id="galleryImageForm" method="POST" commandName="galleryImageForm">
		<div>
			<center>
				<form:errors path="error" cssClass="alertMsg" />
			</center>
		</div>
		<form:input type="hidden" path="id" class="" />
		<form:input type="hidden" path="galleryId" class="" />
		<form:input type="hidden" path="galleryName" class="" />

		<div style="" class="formDataDiv addForm">
			<table width="660" border="0" class="order">
				<tbody>

					<tr>
						<td>Gallery Image<span class="mandatory">*</span></td>
						<td><form:input multiple="true" type="file" path="files"
								class="upload" /> <br> <form:errors path="files"
								cssClass="errormsg" /><span class="errormsg" id="fileError"></span>
						</td>
					</tr>
					<tr>
						<td>Descriptionv<span class="mandatory">*</span></td>
						<td colspan="2"><form:input type="text" path="description"
								class="searchTextBoxes" /> <br> <form:errors
								path="description" cssClass="errormsg" /><span class="errormsg"
							id="descriptionError"></span></td>
					</tr>
					<tr>
						<td>Author<span class="mandatory">*</span></td>
						<td colspan="2"><form:input type="text" path="author"
								class="searchTextBoxes" /> <br> <form:errors
								path="author" cssClass="errormsg" /><span class="errormsg"
							id="authorError"></span></td>
					</tr>
					<%-- <tr>
						<td>Gallery Name<span class="mandatory">*</span></td>
						<td colspan="2"><form:select path="galleryId"
								cssClass="galleryName" disabled="">
								<c:forEach items="${galleryRefList}" var="galleryRef">
									<form:option value="${galleryRef.idNum}"
										label="${galleryRef.description}"
										selected="${galleryId eq galleryRef.idNum ? 'selected': ''}" />
								</c:forEach>
							</form:select></td>
					</tr> --%>
			</table>
			<div id="sectionBttns">
				<input type="button" class="backBttn" title="Back"
					onClick="history.back();return false;" /> <input name="Add Gallery"
					type="button" class="saveBttn" title="Save" value="" /> <input
					type="reset" value="" class="resetBttnBlack" title="Reset" />
			</div>
			
			</div>
	</form:form>
</div>


