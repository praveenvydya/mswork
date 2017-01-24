<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%-- <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.vydya.theschool.common.constants.TSConstants"%>
<%@ page import="com.vydya.theschool.web.constants.WebConstants"%>
	<link rel="stylesheet" href="<spring:message code="static.application.name"/>/css/ecalendar.css" />
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery.ecalendar.js"></script>

<head>
<style>

</style>
<script type="text/javascript">

$(document).ready(function() {
	$("#ecalendarInline").ecalendar({
		//jsonData: newEvents,
		eventsjson: '<spring:message code="application.name"/><spring:message code="app.name"/>/getevents.htm',
		cacheJson: false
	});
	
});

</script>
</head>

<div class="full-page">
	<div class="page-banner">
		<div class="img-parent">
			<img src="<spring:message code="static.application.name"/>/images/school/banners/events.jpg" />
		</div>
	</div>
	<div class="full-content">
		<div style="">
		<div id="ecalendarInline"></div>
	</div>
	</div>

</div>