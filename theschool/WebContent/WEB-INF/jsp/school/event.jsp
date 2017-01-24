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


.firstcol{
	width: 20%;
}


.secndcol{
	width:80%;
}

.contentTale td{
	max-width: 734px;
}
.contentTale td label {
    font-family: "Segoe UI";
    line-height: 18px;
    margin-bottom: 10px;
    padding: 2px 15px;
    font-weight: bold;
    }
    
    
 table.standard-table {
    border: 2px solid #fff;
    width: 100%;
}
table.standard-table td {
    background-color: rgba(212, 221, 228, 0.15);
    border: 2px solid #fff;
    box-shadow: 0 -1px 0 0 rgba(212, 221, 228, 0.5) inset;
}

</style>
<script type="text/javascript">



</script>
</head>


<div class="full-page">
	<div class="page-banner">
		<div class="img-parent">
			<img src="${pageContext.request.contextPath}/static/simg-org/${event.imageName}" width="100%"/>
		</div>
	</div>
	<div class="full-content">
		<div style="">
		<table class="contentTale" style="width: 100%">
			<tr>
			<td width="100%" style="margin:0px 5px">
				<h3 class="tl07">${event.name}</h3>
				<table border="0" class="standard-table">
							<tbody>
								<tr>
									<td class="firstcol"><label>Date:</label></td>
									<td class="secndcol">
										<p>${event.eventDateDis}</p>
									</td>
								</tr>
								<tr>
									<td class="firstcol"><label>Time:</label></td>
									<td class="secndcol">
										<p>${event.eventTime}
									</td>
								</tr>
								<tr>
									<td class="firstcol"><label>Venue:</label></td>
									<td class="secndcol">
										<p>${event.eventPlace}</p>
									</td>
								</tr>
								<tr>
									<td class="firstcol"><label>Description:</label></td>
									<td class="secndcol">
										<p>${event.eventDesc}</p>
									</td>
								</tr>
							</tbody>
						</table>
					</td>
			</tr>
		</table>
	</div>
	</div>

</div>