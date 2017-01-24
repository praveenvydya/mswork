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
	
	var initEditor = function() {
		$("#contentTextarea").pedit({
			plugins: 'xhtml',
			style: '<spring:message code="static.application.name"/>/css/pedit.css'
		});
	};
	
	initEditor();
	
	$("#menuForm").validate({
		rules: {   
		 		name: {required: true},
				 url  : {required: true},
				 menuType:{required: true},
		  	 parentId: {
					depends : function(
							element) {
						return ($("#menuForm input[name='menuType']:checked").val()=='child');
					}
				}
		       
	},
	messages: {
			name: {required: "Please enter Menu Name"},
		   url: {required: "Please enter url"},
		   menuType:{required: "Is new Menu or child Menu?"},
		   parentId: {required: "Please select Parent"}
		       
	},
		
		submitHandler: function(form) { 
			
			$("#validity_label").html('<div class="alert alert-success">No errors.</div>');
			$("#saveBttn").attr("disabled", true);	
			$("#contentTextarea").val($("#dataContentEditable").html());
			$("#menuForm").submit();
			},
		invalidHandler: function(form, validator) {
			$("#validity_label").html('<div class="alert alert-error">There be '+validator.numberOfInvalids()+' error'+(validator.numberOfInvalids()>1?'s':'')+' here.</div>');
		}
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
	
	loadM();
	function loadM(){
		
		var rd =  $("input[type=radio][name='menuType']:checked").val();
		if (rd == "child") {
	        $("#selectParent").show();
	    } else {
	        $("#selectParent").hide();
	    }
		 
	}
	
	 
	$("#attachmentsBttn").click(function(){
		$("#attachmentsDiv").show();
		/* $.get('<spring:message code="application.name"/>${pageContext.servletContext.contextPath}/ajaxGetValue.htm?key=unid', function( data ) {
			var unid = data;
			$("#unid").val(unid);
			$("#attunid").val(unid);
			});  */
			
	});
	
	$("#menuForm input[name='menuType']:radio").change(function () {
	    if ($(this).val() == "child") {
	        $("#selectParent").show();
	    } else {
	        $("#selectParent").hide();
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
.contentEditTable{
	width: 100%;
	margin: 5px auto;
}
.contentEditTable tr:nth-child(even){
	background-color: #f1f1f1;
}
.contentEditTable tr td:first-child{
	text-align: right;
	width: 20%;
}
.dataContentEditable{

}
body{
font-family:'Segoe UI';
}
.attachments{
display: inline-table;
}

*{
font: -webkit-mini-control;
}
</style>

	

	<h1>${menuForm.actionType} Menu</h1>
	<div class="" id="validity_label"></div>
<c:if test='${null!=success_key }'>
		<div class="successMsg"><spring:message code="${success_key}" /></div>
		<c:remove var="success_key" scope="session" />
	</c:if>	
<div style="" class="">
	<table border="0" class="contentEditTable">
		<tbody>
			<tr>
				<td class="firstcol"><label for="name" class="">Image:</label></td>
				<td><form:form enctype="multipart/form-data" name="imageForm"
								id="imageForm" method="POST" commandName="imageForm">

								<form:input type="hidden" path="actionType" id="actionType" />
								<form:input type="hidden" path="x" />
								<form:input type="hidden" path="y" />
								<form:input type="hidden" path="height" />
								<form:input type="hidden" path="width" />
								<form:hidden path="uuid" />

								<div><c:choose>
												<c:when test="${null!=imageForm.url}">
													<img
														src="${pageContext.request.contextPath}/static/simg-fix/352x140/${imageForm.url}"
														id="cropedImage"
														style="" />
												</c:when>
												<c:otherwise>
													<img src="" id="cropedImage"
														style="height: 140px; width: 352px; display: inline-block;" />
												</c:otherwise>
											</c:choose>
									</div>
									<div>
										Don't Crop &nbsp;<form:checkbox	path="dontCrop" style="margin:5px;" /><form:input type="file"
												path="imageFile" class="upload" id="fileUpload"
												name="imageFile" required="" placeholder="Required"
												data-placement="right" />
									</div>
									
							</form:form></td>
			</tr></tbody></table>
	<form:form enctype="multipart/form-data" name="menuForm" id="menuForm" class=""
				method="POST" commandName="menuForm">
			<form:input type="hidden" path="actionType" />
			<form:input type="hidden" path="menuId" />
			<form:hidden path="unid" />
			<form:hidden path="uuid" />
	<table border="0" class="contentEditTable">
		<tbody>
			<tr>
				<td class="firstcol"><label for="name" class="">Name:</label></td>
				<td><form:input type="text" path="name" name ="name" value=""  required="true"
					maxlength="200" size="24" /> 
				</td>
			</tr>
			<tr>
				<td class="firstcol"><label for="url" class="">Url:</label></td>
				<td><form:input type="text" path="path" name ="path" value=""  required="true"
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
					<td class="firstcol"></td>
					<td>	<form:radiobutton  path="menuType" id="newMenu" value="new" class="contentId"  name="menuType" selected="selected"/>  New Menu &nbsp;&nbsp;
							<form:radiobutton  path="menuType" id="childMenu" value="child" class="contentId"  name="menuType"/>&nbsp; Child Menu
					</td>
				</tr>
				
			
			<tr id ="selectParent" style="display: none">
				<td class="firstcol"><label for="category" class="">Parent:</label></td>
				<td><form:select path="parentId" name="parentId"
								cssClass="" disabled="">
								<c:forEach items="${menulist}" var="mn">
									<form:option value="${mn.menuId}"
										label="${mn.name}"
										selected="${parentId eq mn.menuId ? 'selected': ''}" />
								</c:forEach>
							</form:select>
				</td>
			</tr>
			
			<tr id="dataContent" >
				<td class="firstcol"><label for="" class="">Html:</label></td>
				<td style="width:78%;padding: 5px;">
					<form:textarea  path="html" id="contentTextarea" name="xhtml_field" cssStyle="height:400px;width:100%" /> 
				</td>
			</tr>
		</tbody>
	</table>
<div class="contentEditTable">
<input type="button"  class="large clButton gray" id="backBttn" title="Cancel" onClick="history.back();return false;" value="Cancel"/>
<input type="submit"  class="large clButton blue" id="saveBttn" title="Save" value="Save"/>
			
</div>
</form:form>

	<div class="attachments">
		<c:if test='${menuForm.actionType!="add" }'>
			<div id="attachmentsDiv">
				<jsp:directive.include file="menuAttachments.jsp" />
			</div>
		</c:if>
	</div>
</div>




