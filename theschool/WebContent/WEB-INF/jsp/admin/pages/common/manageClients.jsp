<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%-- <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.vydya.theschool.common.constants.TSConstants"%>
<%@ page import="com.vydya.theschool.web.constants.WebConstants"%>

<script defer="defer">



</script>

<style type="text/css">


</style>	
	<script type="text/javascript">  
	jQuery(document).ready(function($){
	
			 
		var oTable = $('#clientsTable').dataTable({
			"sPaginationType" : "full_numbers",
			"bJQueryUI" : true,
			"bRetrieve" : true
		});
		
		var oTable = $('#sessionsTable').dataTable({
			"sPaginationType" : "full_numbers",
			"bJQueryUI" : true,
			"bRetrieve" : true
		});
		
		
			   
	});
	</script>
	
	

<div id="tabularDatax">
	

	<c:if test='${null!=success_key }'>
		<div class="successMsg">
			<spring:message code="${success_key}" />
		</div>
		<c:remove var="success_key" scope="session" />
	</c:if>
		
	</div>
	

<div id="">
<h4 class="widget-title"><span>Request Details</span></h4>
<c:if test='${null!=clientsList }'>
		<c:choose>
			<c:when test="${empty clientsList}">
				<div class="alertMsg">No Records Found</div>
			</c:when>
			<c:otherwise>
			
				<table class="display dataTable" id="clientsTable" border="0"
					cellpadding="0" cellspacing="0">
					<thead>
						<tr>
							<th style="width: 94px;"  colspan="1" rowspan="1" class="sorting_disabled">Computer Name</th>
							<th style="width: 120px;" colspan="1" rowspan="1" class="sorting">Host Name</th>
							<th style="width: 100px;" colspan="1" rowspan="1" class="sorting">Inet Address</th>
							<th style="width: 100px;" colspan="1" rowspan="1" class="sorting">Remote Address</th>
							<th style="width: 100px;" colspan="1" rowspan="1" class="sorting">No Of Clicks</th>
							<th style="width: 100px;" colspan="1" rowspan="1" class="sorting_disabled">Inserted</th>
						</tr>
					</thead>
					<!-- <tfoot style="display: none">
						<tr>
							<th colspan="1" rowspan="1">Image</th>
							<th colspan="1" rowspan="1">Description</th>
							<th colspan="1" rowspan="1">Inserted</th>
							<th colspan="1" rowspan="1">Inserted By</th>
							<th colspan="1" rowspan="1">Updated</th>
							<th colspan="1" rowspan="1">Updated By</th>
							<th colspan="1" rowspan="1">Action</th>
						</tr>
					</tfoot> -->
					<form:form name="clientsForm" action="" id="clientsForm"
						class="" method="POST" commandName="clientsForm">
						<tbody id="">
							<c:if test='${null!=clientsList }'>
								<c:forEach var="client" items="${clientsList}">

									<tr class="even_gradeA odd" id="client_${client.id }">
										<td class="">${client.computerName}		</td>
										<td class="center">${client.hostName}</td>
										<td class="center ">${client.inetAddress}</td>
										<td class="center ">${client.remoteAddress}</td>
										<td class="center ">${client.noclicks}</td>
										<td class="center">${client.inserted}</td>
									</tr>
								</c:forEach>
							</c:if>
						</tbody>
					</form:form>
				</table>

			</c:otherwise>
		</c:choose>

	</c:if>
</div>


<div id="">
<h4 class="widget-title"><span>Current Active Sessions</span></h4>
<c:if test='${null!=sessionslist }'>
		<c:choose>
			<c:when test="${empty sessionslist}">
				<div class="alertMsg">No Records Found</div>
			</c:when>
			<c:otherwise>
			
				<table class="display dataTable" id="sessionsTable" border="0"
					cellpadding="0" cellspacing="0">
					<thead>
						<tr>
							<th style="width: 100px;" colspan="1" rowspan="1" class="sorting">Session Id</th>
							<th style="width: 94px;"  colspan="1" rowspan="1" class="sorting_disabled">Computer Name</th>
							<th style="width: 120px;" colspan="1" rowspan="1" class="sorting">Host Name</th>
							<th style="width: 100px;" colspan="1" rowspan="1" class="sorting">Inet Address</th>
							<th style="width: 100px;" colspan="1" rowspan="1" class="sorting">Remote Address</th>
							<th style="width: 100px;" colspan="1" rowspan="1" class="sorting_disabled">Inserted</th>
						</tr>
					</thead>
					<!-- <tfoot style="display: none">
						<tr>
							<th colspan="1" rowspan="1">Image</th>
							<th colspan="1" rowspan="1">Description</th>
							<th colspan="1" rowspan="1">Inserted</th>
							<th colspan="1" rowspan="1">Inserted By</th>
							<th colspan="1" rowspan="1">Updated</th>
							<th colspan="1" rowspan="1">Updated By</th>
							<th colspan="1" rowspan="1">Action</th>
						</tr>
					</tfoot> -->
					<form:form name="clientsForm" action="" id="clientsForm"
						class="" method="POST" commandName="clientsForm">
						<tbody id="">
							<c:if test='${null!=sessionslist }'>
								<c:forEach var="session" items="${sessionslist}">

									<tr class="even_gradeA odd" id="client_${session.id }">
										<td class="center ">${session.sessionId}</td>
										<td class="">${session.computerName}		</td>
										<td class="center">${session.hostName}</td>
										<td class="center ">${session.inetAddress}</td>
										<td class="center ">${session.remoteAddress}</td>
										<td class="center">${session.inserted}</td>
									</tr>
								</c:forEach>
							</c:if>
						</tbody>
					</form:form>
				</table>

			</c:otherwise>
		</c:choose>

	</c:if>
</div>