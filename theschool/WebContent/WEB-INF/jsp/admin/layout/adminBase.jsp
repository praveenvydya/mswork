<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%> 
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>
<tiles:insertAttribute name="title" ignore="true" />
</title>
<link href="<spring:message code="static.application.name"/>/css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery.1.8.js"></script>
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery.tablesorter.js"></script>
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery-ui.js"></script>
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery-ui-timepicker.js"></script>
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery.defaultvalue.js"></script>
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery.validate.min.js"></script>
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery.tools.min.js"></script>
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery.metadata.js"></script>
<link rel="stylesheet" href="<spring:message code="static.application.name"/>/css/jquery-ui.css" />
<script defer="defer">
$(document).ready(function() 
{
	/*jQuery.validator.addMethod("alphanumeric", function(value, element) {
    	return this.optional(element) || /^[\*\?a-zA-Z0-9 ]*$/.test(value);
	});
	
	jQuery.validator.addMethod("ebNumber", function(value, element) {
    	return this.optional(element) || /^[\*\?ebEBwpWPuU0-9 ]*$/.test(value);
	}); */	
});


</script>
	
</head>
<body>
<div id="wrapper">
  <div id="header">
  	<tiles:insertAttribute name="header" />
  	<tiles:insertAttribute name="menu" />
  </div>
  <div id="content">
  	<div class="clearTop"></div>
		<div id="innerContent">
			<tiles:insertAttribute name="breadcrum" />
			<tiles:insertAttribute name="body" />
		<%-- 	<tiles:insertAttribute name="pagination" /> --%>
		</div>
	<div class="clearBottom"></div>
  </div>
<tiles:insertAttribute name="footer" />
</div>
</body>
</html>
