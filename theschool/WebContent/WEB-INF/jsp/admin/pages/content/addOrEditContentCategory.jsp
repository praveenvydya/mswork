<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.vydya.theschool.common.constants.TSConstants"%>
<%@ page import="com.vydya.theschool.web.constants.WebConstants"%>
<%-- <script type="text/javascript" src="${pageContext.servletContext.contextPath}/javascript/contenteditor.js"></script> --%>

<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery.pedit.min.js"></script>


<link rel="stylesheet" href="<spring:message code="static.application.name"/>/css/contenteditor.css" /> 
<script type="text/javascript">  
jQuery(document).ready(function($){
	
	
	
	$("#contentCategoryForm").validate({
		rules: {   
		 	name: {required: true},
		   title: {required: true}
		       
	},
	messages: {
			name: {required: "Please enter categoy name"},
		   title: {required: "Please enter title"}
		       
	},
		
		submitHandler: function(form) { 
			
			$("#validity_label").html('<div class="alert alert-success">No errors.</div>');
			$("#saveBttn").attr("disabled", true);	
			$("#contentCategoryForm").submit();
			},
		invalidHandler: function(form, validator) {
			$("#validity_label").html('<div class="alert alert-error">There be '+validator.numberOfInvalids()+' error'+(validator.numberOfInvalids()>1?'s':'')+' here.</div>');
		}
	});
	  
	

	
	 
}); 
</script>

<style>
.contentEditTable{
	width: 80%;
	margin: 5px auto;
}
.contentEditTable tr:nth-child(even){
	background-color: #f1f1f1;
}
.contentEditTable tr td:first-child{
	text-align: right;
}

</style>

	
<form:form enctype="multipart/form-data" name="contentCategoryForm" id="contentCategoryForm" class=""
				method="POST" commandName="contentCategory">
			<form:input type="hidden" path="actionType" />
			<%-- <form:input type="hidden" path="contentData" /> --%>
			
<form:input type="hidden" path="id" />
	<h1>${content.actionType} Content Category</h1>
	<div class="" id="validity_label"></div>

<div style="" class="">
	<table border="0" class="contentEditTable">
		<tbody>
			<tr>
				<td class="firstcol"><label for="name" class="">Name:</label></td>
				<td><form:input type="text" path="name" name ="name" value=""  required="true"
					maxlength="200" size="24" /> 
				</td>
			</tr>
			
			<tr>
				<td class="firstcol"><label for="title" class="">Title:</label></td>
				<td><form:input type="text" path="title" name ="title" value=""  required="true"
					maxlength="200" size="24" /> 
				</td>
			</tr>
		</tbody>
	</table>
	
</div>

<div class="contentEditTable">
<input type="button"  class="large clButton gray" id="backBttn" title="Cancel" onClick="history.back();return false;" value="Cancel"/>
<input type="submit"  class="large clButton blue" id="saveBttn" title="Save" value="Save"/>
			
</div>
</form:form>

