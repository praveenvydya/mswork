<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%> 
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" /> -->
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Roboto+Condensed">
<link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Roboto:light,regular,medium,thin,italic,mediumitalic,bold" title="roboto">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="HandheldFriendly" content="true">
<title>
<tiles:insertAttribute name="title" ignore="true" />
</title>
<link type="image/x-icon" href="<spring:message code="static.application.name"/>/images/favicon.ico" rel="shortcut icon"/>
<link rel="stylesheet" href="<spring:message code="static.application.name"/>/css/layout/schoolLayout1.css" />

	<link rel="stylesheet" href="<spring:message code="static.application.name"/>/css/jquery.displaycode.css" />
	<%-- <link rel="stylesheet" href="<spring:message code="static.application.name"/>/css/jquery-ui_b.css" /> --%>

 <link rel="stylesheet"  href="<spring:message code="static.application.name"/>/css/icons.css"/>
 
	<%--  <link rel="stylesheet"  href="<spring:message code="static.application.name"/>/css/megamenu.css"/> --%>
    <link rel="stylesheet"  href="<spring:message code="static.application.name"/>/css/canvas/reset.css"/>
    <link rel="stylesheet"  href="<spring:message code="static.application.name"/>/css/canvas/style.min.css"/>
    <link rel="stylesheet"  href="<spring:message code="static.application.name"/>/css/canvas/canvas-slider.min.css"/>
    <link rel="stylesheet"  href="<spring:message code="static.application.name"/>/css/canvas/default.min.css"/>
    <link rel="stylesheet" href="<spring:message code="static.application.name"/>/css/gallery/jquery.fancybox.css" />
	<link rel="stylesheet" href="<spring:message code="static.application.name"/>/css/gallery/fancy-style-support.css" /> 
	<link rel="stylesheet" href="<spring:message code="static.application.name"/>/css/gallery/jquery.fancybox-thumbs.css" />
	<%-- <link rel="stylesheet"  href="<spring:message code="static.application.name"/>/css/data_table_jui.css"/>  --%>
	<link rel="stylesheet"  href="<spring:message code="static.application.name"/>/css/pageLayout.css"/> 
   <link href="<spring:message code="static.application.name"/>/css/style2.css" rel="stylesheet"  />
    <link rel="stylesheet"  href="<spring:message code="static.application.name"/>/css/shyne.css"/>
 <link rel="stylesheet"  href="<spring:message code="static.application.name"/>/css/bootstrap.css"/>
		<%--<link rel="stylesheet" href="<spring:message code="static.application.name"/>/css/pedit.css" />  --%>
	<link rel="stylesheet" href="<spring:message code="static.application.name"/>/css/navigation.css" /> 
<link href="<spring:message code="static.application.name"/>/css/style.css" rel="stylesheet" type="text/css" />


<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery-1.9.1.js"></script>
<%-- <script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery.1.8.js"></script> --%>
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery.min.js"></script>
<%-- <script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery.tablesorter.js"></script> --%>

<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jssor.slider.mini.js"></script>

<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/bootstrap.js"></script>

<%-- <script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery-ui-timepicker.js"></script> --%>
<%-- <script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery.defaultvalue.js"></script> --%>
<%-- <script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery.validate.min.js"></script> --%>
<%-- <script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery-powertable.js"></script> --%>
<%-- <script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery.metadata.js"></script> --%>

<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery.js"></script>
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/canvas/jqueryc.js"></script>

<%-- <script type='text/javascript' src="<spring:message code="static.application.name"/>/javascript/jquery.hoverIntent.js"></script>  --%>

<%-- <script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/events/jquery.fancybox-1.3.4.pack.js"></script> --%>
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/gallery/jquery.fancybox.js"></script>
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/gallery/jquery.fancybox-thumbs.js"></script>
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery-ui.js"></script>
<%-- <script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery-fine.min.js"></script>
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery.fineJslider.js"></script> --%>
<%-- <script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/datatable/jquery.dataTables.js"></script> --%>
<%-- <script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/datatable/jquery_002.js"></script> --%>

<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/srldiv.js"></script>
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery-finetabs.js"></script>

<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery.displaycode.js"></script>

 <script type='text/javascript' src='<spring:message code="static.application.name"/>/javascript/jquery.mobile.customized.min.js'></script> 
 <script type='text/javascript' src='<spring:message code="static.application.name"/>/javascript/jquery.easing.1.3.js'></script>	
	
<script>

$(document).ready(function() {
function $import(src){
	  var scriptElem = document.createElement('script');
	  scriptElem.setAttribute('src',src);
	  scriptElem.setAttribute('type','text/javascript');
	  document.getElementsByTagName('head')[0].appendChild(scriptElem);
	}
});
</script>	
</head>


<body>
<div id="wrapper">

		<div class="header">
			<div id="header-box">
				<tiles:insertAttribute name="header" />
				<tiles:insertAttribute name="menu" />
			</div>
		</div>
		<div id="content">
  		<div class="clearTop"></div>
  		<div id="leftColumn"><tiles:insertAttribute name="leftmenu" /></div>
		<div id="innerContent">
		<div>
			<tiles:insertAttribute name="breadcrum" />
			<section style="font-size: 100%;" id="scMainbody"> 
				<div class="page">
					<tiles:insertAttribute name="body" />
				</div>
			</section>
			<%-- <tiles:insertAttribute name="pagination" /> --%>
			</div>
		</div>
	<!-- <div class="clearBottom"></div> -->
  </div>
<div class="sfooter"><tiles:insertAttribute name="footer" /></div>
		<div class="sfooter2">
			<div class="" id="sfooter-box">
				<div style="text-align: center;width: auto" class="sfooter-content">
					Copyright &copy; 2014 Vydya Holdings | All rights reserved | Designed by Praveen Vydya (praveenv.1234@gmail.com |+91 9030435028)</div>
			</div>
		</div>
	</div>
	

</body>
</html>
