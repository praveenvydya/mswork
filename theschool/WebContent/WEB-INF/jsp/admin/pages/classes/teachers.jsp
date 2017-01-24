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



});
</script>
	
			
			<div id="tabularData">
					<form:form name="teacherForm" method="POST" commandName="teacherForm" >
					<ts:button validateAction="true" action="<%=WebConstants.ADD_TEACHER%>" type="submit" value="ADD" cssClass="large clButton green" title="ADD" />
					
					<table width="100%" border="0" cellspacing="0" cellpadding="0" id="sectionsTable">
					 <thead>
					  <tr>
						<th width="4%">&nbsp;</th>
						<th width="12%">Teacher Name</th>
					  </tr>
					 </thead>
					  <c:forEach var="teacher" items="${teachersList}"> 
                      <tr>
						<td>
							<form:radiobutton  path="id" id="${teacher.id}" value="${teacher.id}"/>
						</td>
						<td>${teacher.name}</td>
					  </tr>
                     </c:forEach> 					  
					</table>
					<input type="hidden" name="actionName" value="view">
					<div id="sectionBttns">
						<ts:button validateAction="true" action="<%=WebConstants.EDIT_TEACHER%>" type="submit" value="EDIT" cssClass="large clButton green" title="Edit" />
						<ts:button validateAction="true" action="<%=WebConstants.DELETE_TEACHER%>" type="submit" value="DELETE" cssClass="large clButton green" title="DELETE" />
					</div>
					
					</form:form>
				</div>