<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%-- <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.vydya.theschool.common.constants.TSConstants"%>
<%@ page import="com.vydya.theschool.web.constants.WebConstants"%>
<%-- <script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery.finescroll.min.js"></script>
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/common.js"></script>
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery-finetabs.js"></script>
 --%>
 
 <script src="<spring:message code="static.application.name"/>/new/js/jquery-ui-timepicker.js"></script>


<script defer="defer">

</script>
<style>
.forImage{
	display: none;
	position: absolute;
}
.link:hover{
	text-decoration: none;
}
div.galleryImages a disabledImage{
z-index: 100;
opacity:0.5;
}
.imageCk{
float: none;
    height: 115px;
    margin: 4px;
    position: inherit;
    width: 188px;
}
.link{
display: inline;
}

#galleryImagesTable textarea:HOVER {
	border: none;
}

</style>
<script type="text/javascript">
		$(document).ready(function() {

			
					});
</script>


<div class="adminLRlayout">

	<div id="left-img-Column">
	
	</div>
	<div id="content-Column" style="width: 77%; float: right;">

		<form:form name="eventForm" id="eventForm" method="POST"
			commandName="eventForm">
			<form:input type="hidden" path="id" class="" id="galId" />
			<form:input type="hidden" path="name" class="" id="galName" />
			<div class="piw">
			<div class="img-parent">
				<img src="${pageContext.request.contextPath}/static/simg-org/${eventForm.imageName}" width="100%"/>
			</div>
			
			<div class="blockquote"
				style=" display: flex;">
				<div style="width: 60%">
					<div><h1>${eventForm.title}</h1></div>
					<div><small>${eventForm.eventDesc}</small></div>
				</div>
				<div style="width: 40%" class="Gd">
					<cite class="muted">${eventForm.eventPlace},&nbsp;${eventForm.eventDate}</cite>
					<small>Inserted By&nbsp; <strong>${eventForm.insertedby}</strong>
						and Updated by&nbsp;<strong>${eventForm.lastmodifiedby}</strong>
						on <b>${eventForm.lastmodified}</b></small>
				</div>
			</div>
			</div>

			<div class="message"></div>
		</form:form>



		<div style="clear: both;"></div>

	</div>
</div>





