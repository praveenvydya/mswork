<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.vydya.theschool.common.constants.TSConstants"%>
<%@ page import="com.vydya.theschool.web.constants.WebConstants"%>
<script type="text/javascript">  
jQuery(document).ready(function($){
	//$('input').filter('.datepicker').datepicker({ changeMonth: true,changeYear: true, dateFormat:"yy-mm-dd"});

	 $('#subjectTypeid').change(function(){
		  $('#teacherid').attr('disabled',true);
		 //$('#selected_contentId').attr('disabled','disabled');
		 var subjectTypeId = parseInt($(this).val());
		  $.post('<spring:message code="application.name"/>${pageContext.servletContext.contextPath}/school/getData.htm?t=TC&id='+subjectTypeId,function(data){updateData(data);});
			
	  });
	  
	  function updateData(data){
		  ccList=[];
		  ccList = data;
		  $('#contentId').empty();
		  $(ccList).each(function(index, val){
			  $('#teacherid').attr('disabled',false);
			  $('#teacherid').empty();
			  $('#teacherid').append('<option value="'+val.id+'">'+val.name+'</option>');
			  $('#teacherid').attr('disabled',false);
		  });
		 // populateDropdown();
		//$('#selected_contentId').attr('disabled',false);
	  }
	  
	$('#saveBtn').click(function(){
		$('#saveBtn').attr("disabled", true);	
		<%-- $("#subjectForm").attr("action", '<%=TSConstants.ACTION_ADD%>.htm'); --%>
		$("#subjectForm").submit();
	});

	
});
</script>
<style>
</style>


<div id="">
	<div id="titleBar">
		<div class="title">Add Class</div>
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
		<c:remove var="messagekey" scope="session" />
	</c:if>
	

	<c:if test='${null!=success_key }'>
		<div class="successMsg">
			<spring:message code="${success_key}" />
		</div>
		<c:remove var="success_key" scope="session" />
	</c:if>


	<form:form  name="subjectForm"
		id="subjectForm" method="POST" commandName="subjectForm">
		<div>
			<center>
				<form:errors path="error" cssClass="alertMsg" />
			</center>
		</div>
		<form:input type="hidden" path="id" class="" />
		<form:input type="hidden" path="actionType" /> 
		<form:input type="hidden" path="classId" /> 
		<div style="" class="formDataDiv addForm">
			<table width="660" border="0" class="order">
				<tbody>

					<tr>
						<td>Subject Name<span class="mandatory">*</span></td>
						<td><form:input  type="text" path="subjectName"
								class="searchTextBoxes" /> <br> <form:errors path="subjectName"
								cssClass="errormsg" /><span class="errormsg" id="fileError"></span>
						</td>
					</tr>
					<tr>
				<td class="firstcol"><label for="category" class="">Subject Type:</label></td>
				<td><form:select path="subjectTypeid" name="subjectTypeid"
								cssClass="" disabled="">
								<c:forEach items="${subjectTpLilst}" var="sub">
									<form:option value="${sub.idNum}"
										label="${sub.idValue}"
										selected="${subjectTypeid eq sub.idNum ? 'selected': ''}" />
								</c:forEach>
							</form:select>
				</td>
			</tr>
			
			<tr>
				<td class="firstcol"><label for="category" class="">Teacher:</label></td>
				<td><form:select path="teacherid" name="teacherid"
								cssClass="" disabled="">
								<%-- <c:forEach items="${TeacherLilst}" var="sub">
									<form:option value="${sub.idNum}"
										label="${sub.idValue}"
										selected="${teacherid eq sub.idNum ? 'selected': ''}" />
								</c:forEach> --%>
							</form:select>
				</td>
			</tr>
			
					<tr>
						<td>Description<span class="mandatory">*</span></td>
						<td colspan="2"><form:input type="text" path="subjectDesc"
								class="searchTextBoxes" /> <br> <form:errors
								path="subjectDesc" cssClass="errormsg" /><span class="errormsg"
							id="classidError"></span></td>
					</tr>
					<tr>
						<td>Total Marks<span class="mandatory">*</span></td>
						<td colspan="2"><form:input type="text" path="totalMarks"
								class="searchTextBoxes" /> <br> <form:errors
								path="totalMarks" cssClass="errormsg" /><span class="errormsg"
							id="classidError"></span></td>
					</tr>
			</table>
			<div id="sectionBttns">
				<input type="button" class="cms-btn" title="Back" value="Back"
onClick="history.back();return false;" /> <input name="Add" value="Add" id="saveBtn"
					type="button" class="cms-btn" title="Save" /> <input  name="Reset" value="Reset"
					type="reset" value="" class="cms-btn" title="Reset" />
			</div>
			
			</div>
	</form:form>
</div>
