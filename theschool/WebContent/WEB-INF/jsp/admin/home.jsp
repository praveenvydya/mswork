<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

 	<script src="<spring:message code="static.application.name"/>/myapp/js/angular.min.js"></script>
  	<script src="<spring:message code="static.application.name"/>/myapp/js/angular-ui-router.js"></script>
  	

<div ng-app="adminApp">

	<div class="adminMain">
        <div class="adminContainer" ng-controller="adminMainCtrl as ad">
            <div ng-include="ad.headerUrl"></div>
             <div ui-view></div>
            <div ng-include="ad.footerUrl"></div>
        </div>
    
    </div>
    
    
    </div>
    
    
   <!--  Individual controllers -->
   	<script src="<spring:message code="static.admin.application.name"/>/js/sections.js"></script> 
   	
   	
   	<!-- Confinguration  -->
   	<script src="<spring:message code="static.admin.application.name"/>/js/adminApp.js"></script>
   	
   <!-- 	Services -->
   	<script src="<spring:message code="static.admin.application.name"/>/js/lookupSvc.js"></script>
   	
	<!-- 	MainController -->
   	<script src="<spring:message code="static.admin.application.name"/>/js/adminMainCtrl.js"></script>
   	