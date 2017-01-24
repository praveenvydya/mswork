<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.vydya.theschool.common.constants.TSConstants"%>
<%@ page import="com.vydya.theschool.web.constants.WebConstants"%>
<script type="text/javascript">  
jQuery(document).ready(function($){
	
	$("#notificationForm").validate({
		rules: {   
		 	name: {required: true},
		   file: {required: true},
		   contentType: {required: true},
		   content: {required: true},
		   description: {required: true},
		   category: {required: true}
		       
	},
	messages: {
			name: {required: "Please enter notification name"},
		   file: {required: "Please select notification file"},
		   contentType: {required: "Please select content type"},
		   content: {required: "Please write notification"},
		   description: {required: "Please enter description"},
		   category: {required: "Please select category"}
		       
	},
		
		submitHandler: function(form) { 
			
			$("#validity_label").html('<div class="alert alert-success">No errors.</div>');
			$(this).attr("disabled", true);	
			$("#notificationForm").submit();
			},
		invalidHandler: function(form, validator) {
			$("#validity_label").html('<div class="alert alert-error">There be '+validator.numberOfInvalids()+' error'+(validator.numberOfInvalids()>1?'s':'')+' here.</div>');
		}
	});
	  
	 $("#contentType").change(function(){
		 
		 if($(this).val()=='File'){
			 
			
			 $("#dataContent").hide();
			 $("#fileContent").show();
		 }
		 else{
			 $("#fileContent").hide();
			 $("#dataContent").show();
		 }
	 });
	 
}); 
</script>
<style>
#fileUpload{
	display: block;
}
</style>

	
<form:form enctype="multipart/form-data" name="notificationForm" id="notificationForm" class=""
				method="POST" commandName="notification">
			<form:input type="hidden" path="actionType" />
<form:input type="hidden" path="id" />
	<h1>${notification.actionType} Notification</h1>
	<div class="span5" id="validity_label"></div>
<c:if test='${null!=success_key }'>
		<div class="successMsg"><spring:message code="${success_key}" /></div>
		<c:remove var="success_key" scope="session" />
	</c:if>	
<div style="" class="formDataDiv addFormv">
	<table width="560" border="0" class="order">
		<tbody>

			<tr>
				<td class="firstcol"><label for="name" class="">Name:</label></td>
				<td><form:input type="text" path="name" name ="name" value=""  required="true"
					maxlength="200" size="24" /> 
				</td>
			</tr>

<c:if test="${notification.actionType eq 'add' }">

<tr>
			<td class="firstcol"><label for="file" class="">Upload:</label></td>
			<td><form:input type="file" path="file" name="file"  id="fileUpload" />
					<span class="errormsg" id="notfFile"></span></td>
			</tr>
</c:if>
			
			

			<tr>
				<td class="firstcol"><label for="description" class="">Description:</label></td>
				<td><form:textarea  path="description" name="description" class="" cssStyle="" id="" rows="3" />
				</td>
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
					<td class="firstcol"></td>
					<td>
						<!-- <button type="submit" class="submit">Confirm</button> -->
						<input type="submit"  class="large clButton green" id="saveBttn" title="Save" value="Save"/>
						<input type="button"  class="large clButton yellow" id="backBttn" title="Back" onClick="history.back();return false;" value="Back"/>
				</tr>
		</tbody>
	</table>
</div>
</form:form>

