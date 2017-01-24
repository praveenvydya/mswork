<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%> 
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
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

<link href="<spring:message code="static.application.name"/>/css/style.css" rel="stylesheet" type="text/css" />
 <script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery-1.9.1.js"></script>

<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/srldiv.js"></script>

	<link rel="stylesheet" href="<spring:message code="static.application.name"/>/css/layout/schoolLayout1.css" />
	<link rel="stylesheet" href="<spring:message code="static.application.name"/>/css/jquery.displaycode.css" />
    <link rel="stylesheet"  href="<spring:message code="static.application.name"/>/css/canvas/reset.css"/>
    <link rel="stylesheet"  href="<spring:message code="static.application.name"/>/css/canvas/style.min.css"/>
    <link rel="stylesheet"  href="<spring:message code="static.application.name"/>/css/canvas/canvas-slider.min.css"/>
    <link rel="stylesheet"  href="<spring:message code="static.application.name"/>/css/canvas/default.min.css"/>
    <link rel="stylesheet" href="<spring:message code="static.application.name"/>/css/gallery/jquery.fancybox.css" />
	<link rel="stylesheet" href="<spring:message code="static.application.name"/>/css/gallery/fancy-style-support.css" /> 
	<link rel="stylesheet" href="<spring:message code="static.application.name"/>/css/gallery/jquery.fancybox-thumbs.css" />
	<link rel="stylesheet"  href="<spring:message code="static.application.name"/>/css/pageLayout.css"/> 
   <link href="<spring:message code="static.application.name"/>/css/style2.css" rel="stylesheet"  />
    <link rel="stylesheet"  href="<spring:message code="static.application.name"/>/css/shyne.css"/>
 <link rel="stylesheet"  href="<spring:message code="static.application.name"/>/css/bootstrap.css"/>
	<link rel="stylesheet" href="<spring:message code="static.application.name"/>/css/navigation.css" /> 
	
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
		
		<div id="left-innerContent">
			<tiles:insertAttribute name="breadcrum" />
			<section style="font-size: 100%;" id="scMainbody"> 
				<div class="page">
					<tiles:insertAttribute name="body" />
				</div>
			</section>
			<%-- <tiles:insertAttribute name="pagination" /> --%>
			</div>
			<div id="right-Column"><tiles:insertAttribute name="rightNewsmenu" /></div>
		</div>
	<div class="clearBottom"></div>
  </div>
<div class="sfooter"><tiles:insertAttribute name="footer" /></div>
</div>
</body>
</html>
