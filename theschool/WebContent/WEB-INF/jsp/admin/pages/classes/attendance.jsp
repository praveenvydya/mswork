<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="ts" uri="/WEB-INF/ts-tags.tld" %>
<%@ page import="com.vydya.theschool.common.constants.TSConstants" %> 
<%@ page import="com.vydya.theschool.web.constants.WebConstants" %> 
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery.tablesorter.js"></script>
<link href="<spring:message code="static.application.name"/>/css/tables.css" rel="stylesheet" type="text/css" />
<script type='text/javascript' src='<spring:message code="static.application.name"/>/javascript/attendacnePlugin.js'></script>	
<style>


#sectionsTable div {
width: auto;
min-height: 20px;
float: none;
margin: 0px;
padding: 0px 2px;
background-color: #EEE;
text-align: center;
}

#sectionsTable td {
border-left: 1px solid #e4e3e1;
border-right: 1px solid #e4e3e1;
text-align: center;
}


.infodiv{
	height: 100px;
	float: left                   
}

.monthTitle div{
	float: left;
}

</style>
<script defer="defer">
$(document).ready(function() {
	
		$(".attendence").attendance({
			path:'<spring:message code="application.name"/>${pageContext.servletContext.contextPath}',
			classId:$('#classId').val(),
			subjectId:$('#subid').val()
		});
	 
	
});
</script>



<div id="tabularData">
	<form:form name="subjectForm" id="subjectForm" class=""
		method="POST" commandName="subjectForm">
		<form:input type="hidden" path="id" id="subid"/>
		<form:input type="hidden" path="classId"/>
		<div class="span5" id="message_label"></div>
		<div>${subjectForm.subjectName}</div>
		<div class="attendence"></div>
	</form:form>
</div>
