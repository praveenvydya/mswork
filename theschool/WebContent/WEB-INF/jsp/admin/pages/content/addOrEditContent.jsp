<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.vydya.theschool.common.constants.TSConstants"%>
<%@ page import="com.vydya.theschool.web.constants.WebConstants"%>
<%-- <script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/contenteditor.js"></script> --%>

<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery.pedit.min.js"></script>


<link rel="stylesheet" href="<spring:message code="static.application.name"/>/css/contenteditor.css" /> 
<script type="text/javascript">  
jQuery(document).ready(function($){
	
	var initEditor = function() {
		$("#contentTextarea").pedit({
			plugins: 'xhtml',
			style: '<spring:message code="static.application.name"/>/css/pedit.css'
		});
	};

	
	initEditor();
	
	$("#contentForm").validate({
		rules: {   
		 	name: {required: true},
		 content  : {required: true},
		   description: {required: true},
		   category: {required: true}
		       
	},
	messages: {
			name: {required: "Please enter content name"},
		   content: {required: "Please write content"},
		   description: {required: "Please enter description"},
		   category: {required: "Please select category"}
		       
	},
		
		submitHandler: function(form) { 
			
			$("#validity_label").html('<div class="alert alert-success">No errors.</div>');
			$("#saveBttn").attr("disabled", true);	
			$("#contentData").val($("#dataContentEditable").html());
			$("#contentForm").submit();
			},
		invalidHandler: function(form, validator) {
			$("#validity_label").html('<div class="alert alert-error">There be '+validator.numberOfInvalids()+' error'+(validator.numberOfInvalids()>1?'s':'')+' here.</div>');
		}
	});
	  
	$("#editContent").click(function(){
		
		 $('#dataContentEditable').redactor({
			focus: true
		}); 
	});
	
	$("#cancelContent").click(function(){
		$('#dataContentEditable').redactor('destroy');
			
	});
	
	$('#addattchment').fancybox({
		type:'iframe'
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
.dataContentEditable{

}
</style>

	
<form:form enctype="multipart/form-data" name="contentForm" id="contentForm" class=""
				method="POST" commandName="content">
			<form:input type="hidden" path="actionType" />
			<%-- <form:input type="hidden" path="contentData" /> --%>
			
<form:input type="hidden" path="id" />
	<h1>${content.actionType} Content</h1>
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
					<td class="firstcol"><label for="active" class="">Active:</label>
					</td>
					<td><form:select path="active"> 
								<form:option value="1" label="Active" /> 
								<form:option value="0" label="Inactive" /> 
							</form:select></td>
				</tr>
			<tr>
				<td class="firstcol"><label for="category" class="">Category:</label></td>
				<td><form:select path="categoryId" name="category"
								cssClass="" disabled="">
								<c:forEach items="${catRefList}" var="cRef">
									<form:option value="${cRef.idNum}"
										label="${cRef.description}"
										selected="${categoryId eq cRef.idNum ? 'selected': ''}" />
								</c:forEach>
							</form:select>
				</td>
			</tr>
			<tr>
				<td class="firstcol"><label for="title" class="">Title:</label></td>
				<td><form:input  path="title" name="title" class="" cssStyle="" id="" />
				</td>
			</tr>
			
			<tr id="dataContent" >
				<td class="firstcol"><label for="" class="">Content:</label></td>
				<td style="width:760px;padding: 5px;">
								<form:textarea  path="contentData" id="contentTextarea" name="xhtml_field" cssStyle="height:300px;width:100%" /> 
					<%-- <div id="dataContentEditable">${content.contentData}</div> --%>
				</td>
			</tr>
		</tbody>
	</table>
	
</div>

<div class="contentEditTable">
<a id="addattchment" class="a-cms-btn cms-btn"	href="attachments.htm?action=attach?cat=${content.categoryId}">Add Attachments</a>
<input type="button"  class="large clButton gray" id="backBttn" title="Cancel" onClick="history.back();return false;" value="Cancel"/>
<input type="submit"  class="large clButton blue" id="saveBttn" title="Save" value="Save"/>
			
</div>
</form:form>

