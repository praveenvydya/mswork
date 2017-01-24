<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%> 
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>
<tiles:insertAttribute name="title" ignore="true" />
</title>
<link href="<spring:message code="static.application.name"/>/css/style.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery-1.9.1.js"></script>
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery.1.8.js"></script>
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery.tablesorter.js"></script>
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery.min.js"></script>
<%-- <script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery-ui-timepicker.js"></script> --%>
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery.defaultvalue.js"></script>
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery.validate.min.js"></script>
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery-powertable.js"></script>
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery.metadata.js"></script>
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery.js"></script>
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/canvas/jqueryc.js"></script>
<%-- <script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/events/jquery.fancybox-1.3.4.pack.js"></script> --%>
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/gallery/jquery.fancybox.js"></script>
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/gallery/jquery.fancybox-thumbs.js"></script>
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery-ui.js"></script>	
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery.jcrop.js"></script>
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery.form.js"></script>




 
<link rel="stylesheet" href="<spring:message code="static.application.name"/>/css/jquery-ui_b.css" />
<link rel="stylesheet" href="<spring:message code="static.application.name"/>/css/image-slider.css" />

	 <link rel="stylesheet"  href="<spring:message code="static.application.name"/>/css/megamenu.css"/>
    <link rel="stylesheet"  href="<spring:message code="static.application.name"/>/css/canvas/reset.css"/>
    <link rel="stylesheet"  href="<spring:message code="static.application.name"/>/css/canvas/style.min.css"/>
    <link rel="stylesheet"  href="<spring:message code="static.application.name"/>/css/canvas/canvas-slider.min.css"/>
    <link rel="stylesheet"  href="<spring:message code="static.application.name"/>/css/canvas/default.min.css"/>
    <link rel="stylesheet" href="<spring:message code="static.application.name"/>/css/gallery/jquery.fancybox.css" />
	<link rel="stylesheet" href="<spring:message code="static.application.name"/>/css/gallery/fancy-style-support.css" />  
	<link rel="stylesheet" href="<spring:message code="static.application.name"/>/css/gallery/jquery.fancybox-thumbs.css" />  
	<link rel="stylesheet"  href="<spring:message code="static.application.name"/>/css/pageLayout.css"/> 
   	<link rel="stylesheet" href="<spring:message code="static.application.name"/>/css/css-buttons.css" />    
      <link href="<spring:message code="static.application.name"/>/css/style2.css" rel="stylesheet"  />
	
	
	
<style>
#iframeContent{
 margin: auto;
    padding: 15px 2px;
    width: 586px;
}
#innerIframeContent table tr{

padding: 5px 2px;
}

#innerIframeContent div{

margin: 0px;
}

</style>   
	
</head>
<body>
 
  <div id="iframeContent">
  	<div class="clearTop"></div>
		<div id="innerIframeContent">
			<tiles:insertAttribute name="body" />
			<%-- <tiles:insertAttribute name="pagination" /> --%>
		</div>
	<div class="clearBottom"></div>
  </div>
</body>
</html>
