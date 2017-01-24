<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%> 
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title><%-- <spring:message code="static.application.name"/>/ --%>
<tiles:insertAttribute name="title" ignore="true" />
</title>

  
  <link href="<spring:message code="static.application.name"/>/new/css/animate.min.css" rel="stylesheet">
  <link href="<spring:message code="static.application.name"/>/new/css/sweet-alert.css" rel="stylesheet">
  <link href="<spring:message code="static.application.name"/>/new/css/material-design-iconic-font.min.css" rel="stylesheet">
  
  
        <link href="<spring:message code="static.application.name"/>/new/css/app.min.1.css" rel="stylesheet">
        <link href="<spring:message code="static.application.name"/>/new/css/app.min.2.css" rel="stylesheet">
         
        <%--  <script src="<spring:message code="static.application.name"/>/new/js/loginBase.js"></script> --%>
         
     	<script src="<spring:message code="static.application.name"/>/new/js/jquery.min.js"></script>
        <script src="<spring:message code="static.application.name"/>/new/js/bootstrap.min.js"></script>
        
        <script src="<spring:message code="static.application.name"/>/new/js/jquery.nicescroll.min.js"></script>
        <script src="<spring:message code="static.application.name"/>/new/js/waves.min.js"></script>
        <script src="<spring:message code="static.application.name"/>/new/js/bootstrap-growl.min.js"></script>
        <script src="<spring:message code="static.application.name"/>/new/js/sweet-alert.min.js"></script>
             
</head>
<body>
<div id="loginWrapper">
	<div id="<!-- loginHeader -->" class="logo"></div>
	<tiles:insertAttribute name="body" />
	<tiles:insertAttribute name="footer" />
</div>
</body>
</html>
