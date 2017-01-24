<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%> 
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- Hide this line for IE (needed for Firefox and others) -->
<link type="image/x-icon" href="<spring:message code="static.application.name"/>/images/favicon.ico" rel="shortcut icon"/>
<!-- <link rel="icon" href="images/praveen.png" type="image/x-icon" /> -->
<!-- This is needed for IE -->
<!-- <link rel="shortcut icon" href="images/praveen.ico" type="image/ico" /> -->
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
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery-powertable.js"></script>
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery.metadata.js"></script>
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/reports.js"></script>
<link rel="stylesheet" href="<spring:message code="static.application.name"/>/css/jquery-ui.css" />

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
			<tiles:insertAttribute name="pagination" />
		</div>
	<div class="clearBottom"></div>
  </div>
<tiles:insertAttribute name="footer" />
</div>
</body>
</html>
