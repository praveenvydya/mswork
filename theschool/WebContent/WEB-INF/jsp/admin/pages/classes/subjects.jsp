<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="ts" uri="/WEB-INF/ts-tags.tld" %>
<%@ page import="com.vydya.theschool.common.constants.TSConstants" %> 
<%@ page import="com.vydya.theschool.web.constants.WebConstants" %> 
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery.tablesorter.js"></script>
<script defer="defer">

$(document).ready(function() 
{ 

	 $('#addBttn').click(function(){
			$('#addBttn').attr("disabled", true);
			$("#subjectForm #actionType").val("<%=WebConstants.VIEW%>");
			$("#subjectForm").attr("action", '<%=TSConstants.ACTION_ADD_SUBJECT%>.htm');
			$("#subjectForm").submit();
		}); 
	

});
</script>
	
			<div id="tabularData">
					<form:form name="subjectForm" method="POST" commandName="subjectForm" >
					<form:input type="hidden" path="classId" class="" id="classid" />
					<form:input type="hidden" path="actionType" /> 
					<ts:button validateAction="true" action="<%=WebConstants.ADD_SUBJECT%>" type="submit" value="ADD" cssClass="cms-btn" id="addBttn" title="ADD" />
					
					<table width="100%" border="0" cellspacing="0" cellpadding="0" id="sectionsTable">
					 <thead>
					  <tr>
						<th width="4%">&nbsp;</th>
						<th width="12%">Subject Name</th>
						<th width="13%">Teacher</th>
						<th width="13%">Attendance</th>
					  </tr>
					 </thead>
					  <c:forEach var="subject" items="${subjectList}"> 
                      <tr>
						<td>
							<form:radiobutton  path="id" id="${subject.id}" value="${subject.id}"/>
						</td>
						<td>${subject.subjectName}</td>
						<td>${subject.teacherName}</td>
						<td><a href="<spring:message code="application.name"/>${pageContext.servletContext.contextPath}/admin/manageClass/viewAllAttendance.htm?s=${subject.id}">view attendance</a></td>
					  </tr>
                     </c:forEach> 					  
					</table>
					<input type="hidden" name="actionName" value="view">
					<div id="sectionBttns">
						<ts:button validateAction="true" action="<%=WebConstants.EDIT_SUBJECT%>" type="submit" value="EDIT" cssClass="large clButton green" title="Edit" />
						<ts:button validateAction="true" action="<%=WebConstants.DELETE_SUBJECT%>" type="submit" value="DELETE" cssClass="large clButton green" title="DELETE" />
					</div>
					
					</form:form>
				</div>
