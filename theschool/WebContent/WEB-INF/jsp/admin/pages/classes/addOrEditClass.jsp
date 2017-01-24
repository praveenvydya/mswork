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
		$("#classForm").attr("action", '<%=TSConstants.ACTION_ADD%>.htm');
		$("#classForm").submit();
		 var d = new Date();
		var year = parseInt(d.getFullYear());
		
		 $('.dpFrom').datepicker( {
			    changeMonth: true,
			    changeYear: true,
			    showButtonPanel: true,
			    yearRange: year+":"+(year+1),
			    dateFormat: 'MM yy',
			    onClose: function(dateText, inst) { 
			        var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
			        var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
			        $(this).datepicker('setDate', new Date(year, month, 1));
			    }
			}); 
		 $('.dpTo').datepicker( {
			    changeMonth: true,
			    changeYear: true,
			    showButtonPanel: true,
			    yearRange: year+":"+(year+1),
			    dateFormat: 'MM yy',
			    onClose: function(dateText, inst) { 
			        var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
			        var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
			        $(this).datepicker('setDate', new Date(year, month, 1));
			    }
			}); 
		
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


	<form:form  name="classForm"
		id="classForm" method="POST" commandName="classForm">
		<div>
			<center>
				<form:errors path="error" cssClass="alertMsg" />
			</center>
		</div>
		<form:input type="hidden" path="id" class="" />

		<div style="" class="formDataDiv addForm">
			<table width="660" border="0" class="order">
				<tbody>

					<tr>
						<td>Class Name<span class="mandatory">*</span></td>
						<td><form:input  type="text" path="className"
								class="searchTextBoxes" /> <br> <form:errors path="className"
								cssClass="errormsg" /><span class="errormsg" id="fileError"></span>
						</td>
					</tr>
					
					<tr>
						<td>Class Starts<span class="mandatory">*</span></td>
						<td colspan=""><form:input type="text" path="classStartDate"
								class="searchTextBoxes" /> <br> <form:errors
								path="classStartDate dpFrom" cssClass="errormsg" /><span class="errormsg"
							id="descriptionError"></span></td>
						<td>Class Ends<span class="mandatory">*</span></td>
						<td colspan=""><form:input type="text" path="classEndDate"
								class="searchTextBoxes dpTo" /> <br> <form:errors
								path="classEndDate" cssClass="errormsg" /><span class="errormsg"
							id="descriptionError"></span></td>
					</tr>
					
					<tr>
						<td>Class Unique Id<span class="mandatory">*</span></td>
						<td colspan="2"><form:input type="text" path="classDesc"
								class="searchTextBoxes" /> <br> <form:errors
								path="classDesc" cssClass="errormsg" /><span class="errormsg"
							id="descriptionError"></span></td>
					</tr>
					
					<tr>
						<td>Description<span class="mandatory">*</span></td>
						<td colspan="2"><form:input type="text" path="classid"
								class="searchTextBoxes" /> <br> <form:errors
								path="classid" cssClass="errormsg" /><span class="errormsg"
							id="classidError"></span></td>
					</tr>
			</table>
			<div id="sectionBttns">
				<input type="button" class="backBttn" title="Back"
onClick="history.back();return false;" /> <input name="Add Class	"
					type="button" class="saveBttn" title="Save" value="" /> <input
					type="reset" value="" class="resetBttnBlack" title="Reset" />
			</div>
			
			</div>
	</form:form>
</div>
