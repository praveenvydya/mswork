<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%> 
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>
<tiles:insertAttribute name="title" ignore="true" />
</title>

<link type="image/x-icon" href="<spring:message code="static.application.name"/>/images/favicon.ico" rel="shortcut icon"/>
  <link href="<spring:message code="static.application.name"/>/new/css/animate.min.css" rel="stylesheet" />
        <link href="<spring:message code="static.application.name"/>/new/css/sweet-alert.css" rel="stylesheet" />
        <link href="<spring:message code="static.application.name"/>/new/css/material-design-iconic-font.min.css" rel="stylesheet" />
        <link href="<spring:message code="static.application.name"/>/new/css/app.min.1.css" rel="stylesheet" />
        <link href="<spring:message code="static.application.name"/>/new/css/app.min.2.css" rel="stylesheet" />
        <link href="<spring:message code="static.application.name"/>/new/css/cropper.min.css" rel="stylesheet" />
         <link href="<spring:message code="static.application.name"/>/new/css/tooltip.min.css" rel="stylesheet" />
          <link href="<spring:message code="static.application.name"/>/new/css/bootstrap-dialog.min.css" rel="stylesheet" />
          <link href="<spring:message code="static.application.name"/>/new/css/style.css" rel="stylesheet" />
          <link href="<spring:message code="static.application.name"/>/new/css/lightGallery.css" rel="stylesheet" />
           <link href='<spring:message code="static.application.name"/>/new/css/loading-bar.css' rel="stylesheet" />
         
             <link rel="stylesheet" href='<spring:message code="static.application.name"/>/css/gallery/jquery.fancybox.css'  rel="stylesheet" />
	<link rel="stylesheet" href="<spring:message code="static.application.name"/>/css/gallery/jquery.fancybox-thumbs.css"  rel="stylesheet" /> 
      <link rel="stylesheet" href="<spring:message code="static.application.name"/>/new/css/jquery.bootgrid.min.css"  rel="stylesheet" /> 
          <link rel="stylesheet" href="<spring:message code="static.application.name"/>/new/css/jquery-ui.css"  rel="stylesheet" /> 
         
          
         
     
     	<script type="text/javascript" src="<spring:message code="static.application.name"/>/new/js/jquery.min1.9.1.js"></script>
     		<script  type="text/javascript" src="<spring:message code="static.application.name"/>/new/js/jquery.min.js"></script>
     			<script type="text/javascript" src="<spring:message code="static.application.name"/>/new/js/jquery-ui.min.js"></script>
     			
     	<script  type="text/javascript" src="<spring:message code="static.application.name"/>/new/js/demo.js"></script>
          <script type="text/javascript" src="<spring:message code="static.application.name"/>/new/js/cropper2.js"></script>
        <script type="text/javascript" src="<spring:message code="static.application.name"/>/new/js/bootstrap.min.js"></script>
        
     
     <script type="text/javascript" src="<spring:message code="static.application.name"/>/new/js/angular.js"></script>
              <script type="text/javascript" src="<spring:message code="static.application.name"/>/new/js/angular-ap.js"></script>
              <script type="text/javascript" src="<spring:message code="static.application.name"/>/new/js/app.js"></script>
              
        <script type="text/javascript" src="<spring:message code="static.application.name"/>/new/js/jquery.nicescroll.min.js"></script>
        <script type="text/javascript" src="<spring:message code="static.application.name"/>/new/js/waves.min.js"></script>
        <script type="text/javascript" src="<spring:message code="static.application.name"/>/new/js/bootstrap-growl.min.js"></script>
        <script type="text/javascript" src="<spring:message code="static.application.name"/>/new/js/sweet-alert.min.js"></script>
        <%-- <script type="text/javascript" src="<spring:message code="static.application.name"/>/new/js/crop.support.js"></script>
          <script type="text/javascript" src="<spring:message code="static.application.name"/>/new/js/cropper.min.js"></script> --%>
          <script type="text/javascript" src="<spring:message code="static.application.name"/>/new/js/tooltip.min.js"></script>
          <script type="text/javascript" src="<spring:message code="static.application.name"/>/new/js/main.js"></script>
           <script type="text/javascript" src="<spring:message code="static.application.name"/>/new/js/functions.js"></script>
            
          <%--  <script type="text/javascript" src="<spring:message code="static.application.name"/>/new/js/jqBv.js"></script> --%>
            <script type="text/javascript" src="<spring:message code="static.application.name"/>/new/js/fa.js"></script>
            
             <script type="text/javascript" src="<spring:message code="static.application.name"/>/new/js/loading-bar.js"></script>
                <script type="text/javascript" src="<spring:message code="static.application.name"/>/new/js/angular-animate.js"></script>
  <script type="text/javascript" src="<spring:message code="static.application.name"/>/new/js/ui-bootstrap-tpls-0.14.2.js"></script>
    <script type="text/javascript" src="<spring:message code="static.application.name"/>/new/js/ngDialog.js"></script>
    <script type="text/javascript" src="<spring:message code="static.application.name"/>/new/js/imageCropAj.js"></script>
    <script type="text/javascript" src="<spring:message code="static.application.name"/>/new/js/jquery.fancybox.js"></script>
    <script type="text/javascript" src="<spring:message code="static.application.name"/>/new/js/jquery.fancybox-thumbs.js"></script>
   <%--  <script type="text/javascript" src="<spring:message code="static.application.name"/>/new/js/jquery.bootgrid.min.js"></script> --%>
  <%--  <script type="text/javascript" src="<spring:message code="static.application.name"/>/new/js/ng-table.js"></script>
    --%>
       
       
         <script type="text/javascript" src="<spring:message code="static.application.name"/>/new/js/angular-messages.js"></script>
         <script type="text/javascript" src="<spring:message code="static.application.name"/>/new/js/angular/ui-bootstrap.js"></script>
        <script type="text/javascript" src="<spring:message code="static.application.name"/>/new/js/angular/ui-bootstrap-tpls.js"></script>
         <script type="text/javascript" src="<spring:message code="static.application.name"/>/new/js/angular/checklist-model.js"></script>
</head>



<body class="sw-toggled" ng-app="vydyaAdmin"
	data-ng-class="{ 'sw-toggled': mactrl.layoutType === '1', 'modal-open': mactrl.sidebarToggle.left === true }">

	<data ui-view="" class="ng-scope"> <tiles:insertAttribute
		name="header" /> <tiles:insertAttribute name="menu" /> <section
		id="content" class="page-view ng-scope">
	<div class="container ng-scope">
		<div class="block-header">
			<tiles:insertAttribute name="body" />
		</div>
	</div>
	</section> </data>
	
	<tiles:insertAttribute name="footer" />
	
	
	
</body>
</html>


    
    

