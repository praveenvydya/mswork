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
<link type="image/x-icon" href="<spring:message code="static.application.name"/>images/favicon.ico" rel="shortcut icon"/>
<link href="<spring:message code="static.application.name"/>/css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery-1.9.1.js"></script>
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery.1.8.js"></script>



<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery.min.js"></script>
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery.tablesorter.js"></script>
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery-ui.js"></script>
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/canvas/jqueryc.js"></script>
 <script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery-1.js"></script>
<!-- bootstrap just to have good looking page -->
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/bootstrap.js"></script>

<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery-validate.js"></script>
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery.js"></script>
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery.validation.methods.js"></script>



<%-- <script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery-ui-timepicker.js"></script> --%>
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery.defaultvalue.js"></script>
<%-- <script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery.validate.min.js"></script> --%>
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery-powertable.js"></script>
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery.metadata.js"></script>

<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/gallery/jquery.fancybox.js"></script>
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/gallery/jquery.fancybox-thumbs.js"></script>
<%-- <script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/events/jquery.fancybox-1.3.4.pack.js"></script> --%>
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery-ui.js"></script>
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/datatable/jquery.dataTables.js"></script>
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/datatable/jquery_002.js"></script>
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery.ui.widget.js"></script>
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery.iframe-transport.js"></script>
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery.fileupload.js"></script>
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery.autocomplete.js"></script>
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery.form.js"></script>
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/canvas/jquery.jcrop.js"></script>
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/canvas/crop.image.js"></script>
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jpscore.js"></script>
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jpspanels.js"></script>

 
	
	<link rel="stylesheet" href="<spring:message code="static.application.name"/>/css/jquery-ui_b.css" />
	<link rel="stylesheet" href="<spring:message code="static.application.name"/>/css/image-slider.css"/>
	<%--  <link rel="stylesheet"  href="<spring:message code="static.application.name"/>/css/checkboxtree.css"/> --%>
	 <link rel="stylesheet"  href="<spring:message code="static.application.name"/>/css/megamenu.css"/>
    <link rel="stylesheet"  href="<spring:message code="static.application.name"/>/css/canvas/reset.css"/>
    <link rel="stylesheet"  href="<spring:message code="static.application.name"/>/css/canvas/style.min.css"/>
    <link rel="stylesheet"  href="<spring:message code="static.application.name"/>/css/canvas/canvas-slider.min.css"/>
    <link rel="stylesheet"  href="<spring:message code="static.application.name"/>/css/canvas/default.min.css"/>
    <link rel="stylesheet" href="<spring:message code="static.application.name"/>/css/gallery/jquery.fancybox.css" />
	<link rel="stylesheet" href="<spring:message code="static.application.name"/>/css/gallery/fancy-style-support.css" /> 
	<link rel="stylesheet" href="<spring:message code="static.application.name"/>/css/gallery/jquery.fancybox-thumbs.css" />
	<link rel="stylesheet"  href="<spring:message code="static.application.name"/>/css/data_table_jui.css"/> 
	<link rel="stylesheet"  href="<spring:message code="static.application.name"/>/css/pageLayout.css"/> 
	<link rel="stylesheet"  href="<spring:message code="static.application.name"/>/css/bootstrap.css"/> 
	<link rel="stylesheet"  href="<spring:message code="static.application.name"/>/css/foxycomplete.css"/> 
	<link rel="stylesheet"  href="<spring:message code="static.application.name"/>/css/css-buttons.css"/>  
	<link rel="stylesheet"  href="<spring:message code="static.application.name"/>/css/crop/jquery.Jcrop.css"/> 
	<link rel="stylesheet"  href="<spring:message code="static.application.name"/>/css/crop/jquery.Jcrop.min.css"/>  
	<link rel="stylesheet"  href="<spring:message code="static.application.name"/>/css/jps.panel.css"/>    
	<link rel="stylesheet"  href="<spring:message code="static.application.name"/>/css/colors.css"/> 
	<link rel="stylesheet"  href="<spring:message code="static.application.name"/>/css/adminstyles.css"/>    
   <link href="<spring:message code="static.application.name"/>/css/style2.css" rel="stylesheet"  />
   <link rel="stylesheet" href="<spring:message code="static.application.name"/>/css/pedit.css" /> 
	
</head>
<style type="text/css">



</style>
<body>
<div id="wrapperA">
<div style="display: none;" id="ctl00_Progress" role="status" aria-hidden="true">
	
                <div style="width: 100%; background-color: Black; z-index: 80000; height: 2470px;" class="progressbarCss" id="divProgress">
                    <div style="position: absolute; float: left; top: 283.5px; left: 674.5px;" id="loading">
                        <img alt="" src="<spring:message code="static.application.name"/>images/LodingRound.gif">
                        <br>
                        <span style="font-family: Arial; font-size: 12px; color: White; font-weight: bold;">
                            Loading...</span>
                    </div>
                </div>
            
</div>
  <div id="headerA">
  	<tiles:insertAttribute name="header" />
  	<tiles:insertAttribute name="menu" />
  </div>
  <div id="contentA">
  	<div class="clearTop"></div>
		<div id="innerContentAdmin">
			<div class="fd">
			<tiles:insertAttribute name="breadcrum" />
			<section style="font-size: 100%;" id="scMainbody"> 
				<div class="page">
					<tiles:insertAttribute name="body" />
				</div>
			</section>
			<%-- <tiles:insertAttribute name="pagination" /> --%>
			</div>
		</div>
	<div class="clearBottom"></div>
  </div>
<tiles:insertAttribute name="footer" />
</div>
</body>
</html>
