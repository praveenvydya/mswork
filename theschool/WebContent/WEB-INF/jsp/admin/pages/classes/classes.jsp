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
					<form:form name="userForm" method="POST" commandName="classForm" >
					<ts:button validateAction="true" action="<%=WebConstants.ADD_CLASS%>" type="submit" value="ADD" cssClass="large clButton green" title="ADD" />
						
					<table width="100%" border="0" cellspacing="0" cellpadding="0" id="sectionsTable">
					 <thead>
					  <tr>
						<th width="4%">&nbsp;</th>
						<th width="12%">Class Name</th>
						<th width="13%">Description</th>
						<th width="15%">ClassId</th>
						<th width="15%">Marks</th>
					  </tr>
					 </thead>
					  <c:forEach var="class" items="${classesList}"> 
                      <tr>
						<td>
							<form:radiobutton  path="id" id="${class.id}" value="${class.id}"/>
						</td>
						<td><a href="${pageContext.servletContext.contextPath}/admin/manageClass/viewAllSubjects.htm?class=${class.id}" >${class.className}</a></td>
						<td>${class.classDesc}</td>
						<td>${class.classid}</td>
						<td><a href="${pageContext.servletContext.contextPath}/admin/manageMarks/viewAll.htm?c=${class.id}" >marks</a></td>
					  </tr>
                     </c:forEach> 					  
					</table>
					<input type="hidden" name="actionName" value="view">
					<div id="sectionBttns">
						<ts:button validateAction="true" action="<%=WebConstants.EDIT_CLASS%>" type="submit" value="Edit" cssClass="large clButton green" title="Edit"  />
						<ts:button validateAction="true" action="<%=WebConstants.DELETE_CLASS%>" type="submit" value="Delete" cssClass="large clButton green" title="Delete" />
					</div>
					
					</form:form>
				</div>
