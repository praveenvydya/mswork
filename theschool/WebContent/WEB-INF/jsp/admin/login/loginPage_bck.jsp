<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

 	<script src="<spring:message code="static.application.name"/>/myapp/js/angular.min.js"></script>
  	<script src="<spring:message code="static.application.name"/>/myapp/js/angular-ui-router.js"></script>
  	

<html ng-app="loginApp">

	<div class="loginMain">
        <div class="loginContainer" ng-controller="loginMainCtrl as lm">
            <div ng-include="lm.headerUrl"></div>
            <div ng-include="lm.contentUrl"></div>
            <div ng-include="lm.footerUrl"></div>
        </div>
    
    </div>
 </html>  
   	<script src="<spring:message code="static.application.name"/>/myapp/js/loginApp.js"></script>
