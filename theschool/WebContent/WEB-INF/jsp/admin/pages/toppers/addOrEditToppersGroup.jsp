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
		$("#toppersGroupForm").attr("action", '<%=TSConstants.ACTION_ADD_GROUP%>.htm');
		$("#toppersGroupForm").submit();
	});  
	 
		
}); 
</script>
<style>

</style>



	<div id="titleBar">
		<div class="title">Add Toppers Group</div>
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
	<center>
		<form:errors path="error" cssClass="alertMsg" /></center></div>
		
	<form:form enctype="multipart/form-data" name="toppersGroupForm" id="toppersGroupForm"
				method="POST" commandName="toppersGroupForm"	>
			<div style="" class="formDataDiv addForm">
		
				<form:input type="hidden" path="id" class="" />
				<table width="660" border="0" class="order">
				<!-- <table width="500" border="0" cellspacing="0" cellpadding="2"> -->

					<tr>
						<td><label for="name" class="">Toppers Group Name<span class="mandatory">*</span></label></td>
						<td colspan="2"><form:input type="text" path="name" class="searchTextBoxes" />
						<br><form:errors path="name" cssClass="errormsg"/><span class="errormsg" id="nameError"></span></td>
					</tr>
					<tr>
						<td><label for="title" class="">Toppers Group Title</label></td>
						<td colspan="2"><form:input type="text" path="title" class="searchTextBoxes" />
						<br><form:errors path="title" cssClass="errormsg"/><span class="errormsg" id="nameError"></span></td>
					</tr>
					<tr>
						<td><label for="yearOfClass" class="">Toppers of Year<span class="mandatory">*</span></label></td>
						<td colspan="2"><form:input type="text" path="yearOfClass" class="searchTextBoxes" />
						<br><form:errors path="yearOfClass" cssClass="errormsg"/><span class="errormsg" id="eventTypeError"></span></td>
					</tr>
					<tr>
						<td><label for="className" class="">Toppers of Class<span class="mandatory">*</span></label></td>
						<td colspan="2"><form:input type="text" path="className" class="searchTextBoxes" />
						<br><form:errors path="className" cssClass="errormsg"/><span class="errormsg" id="eventCategoryError"></span></td>
					</tr>
					<tr>
						<td><label for="description" class="">Description</label></td>
						<td colspan="2"><form:input type="text" path="description" class="searchTextBoxes" />
						<br><form:errors path="description" cssClass="errormsg"/><span class="errormsg" id="eventPlaceError"></span></td>
					</tr>
					
					<tr>
						<td><label for="totalMarks" class="">Total Marks</label></td>
						<td colspan="2"><form:input type="text" path="totalMarks" class="searchTextBoxes" />
						<br><form:errors path="totalMarks" cssClass="errormsg"/><span class="errormsg" id="eventPlaceError"></span></td>
					</tr>
					
					<tr>
						<td><label for="file" class="">Toppers Group Photo<span class="mandatory">*</span></label> </td>
						<td><form:input  type="file" path="file" class="upload" />
						<br><form:errors path="file" cssClass="errormsg"/><span class="errormsg" id="fileError"></span></td>
					</tr>
					<tr>
						<td class="firstcol"></td>
						<td><!-- <button type="submit" class="submit">Confirm</button> -->
							<button type="" class="submit" id="" title="Back" onClick="history.back();return false;">Back</button>
							<button type="" class="submit" id="saveBttn" title="Add">Add</button>
							<button type="reset" class="submit">Reset</button>
						</td>
					</tr>
					
				</table>
				<!-- <div id="sectionBttns">
					<input type="button" class="backBttn" title="Back" onClick="history.back();return false;" />
					<input name="Add Toppers Group" type="button" class="saveBttn" title="Save" value=""/>
					<input type="reset" value="" class="resetBttnBlack" title="Reset"/>
				</div> -->
				</div>
			</form:form>
		

