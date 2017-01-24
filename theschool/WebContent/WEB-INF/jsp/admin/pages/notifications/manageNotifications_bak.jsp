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
	
		
		
		 $('#addBttn').click(function(){
				
				$('#addBttn').attr("disabled", true);	
				$("#notificationForm").attr("action", '<%=TSConstants.ACTION_ADD%>.htm');
				$("#notificationForm").submit();
			});  
		 
			
			
			  $('.nav-toggle').click(function(){
				  $(".filterTable").slideToggle(1000);
				  });
			  
			   
	});
	</script>
	
	

<div id="tabularDatax">
	<div id="titleBar">
		<div class="title">Search Page</div>
		<div class="addSectionBttn">
			</div> 
	</div>
	<c:if test='${null!=success_key }'>
		<div class="successMsg">
			<spring:message code="${success_key}" />
		</div>
		<c:remove var="success_key" scope="session" />
	</c:if>
		
	</div>
	

<div id="tabularDataWide">
			<form:form  name="notificationForm" action=""
										id="notificationForm" class="" method="POST"
										commandName="notification">
			
			<form:input type="hidden" path="actionType" value="view"/>
			
			<table>
			<tr>
					<td class="" colspan="4"></td>
					<td><button type="" class="add" id="addBttn" title="Add">Add Notification</button></td>
				</tr>
			</table>
		



<c:if test='${null!=notificationList }'>
					
				
					<c:choose>
						<c:when test="${empty notificationList}">
							<div class="alertMsg">No Records Found</div>
						</c:when>
						<c:otherwise>

		<div id="demo">

			<div id="example_wrapper_dummy" class="dataTables_wrapper" role="grid">

				<table aria-describedby="example_info" class="display dataTable"
					id="example" border="0" cellpadding="0" cellspacing="0">
					<thead>
						<tr >
							<th	style="width: 216px;" colspan="1"	rowspan="1" 
								 class="sorting_asc">Name</th>
							<th style="width: 100px;" colspan="1" rowspan="1"
								class="sorting">Content</th>
							<th	style="width: 109px;" colspan="1" rowspan="1"
								class="sorting">Description</th>
							<th	style="width: 75px;" colspan="1" rowspan="1"
								class="sorting">Category</th>
							<th	style="width: 169px;" colspan="1" rowspan="1"
								class="sorting">Status</th>
							<th style="width: 15px;" colspan="1" rowspan="1"
								class="sorting">Inserted</th>
							<th style="width: 15px;" colspan="1" rowspan="1"
								class="sorting">Modified</th>
						</tr>
					</thead>
	
					<tbody >
						<c:if test='${null!=notificationList }'>
							<c:forEach var="notfn" items="${notificationList}">
							
											<tr class="even_gradeA odd" id="ntfn_${notfn.id}">
												<td class="  sorting_1">${notfn.name}</td>
										
												<c:choose>
													<c:when test="${'File' eq notfn.contentType}">
																<td class="fileContent"><img class="main-image"
								src="data:image/jpg;base64,<c:out value='${notfn.content}'/>" /></td>
													</c:when>
													<c:when test="${'Data' eq notfn.contentType}">
																<td class="dataContent">${notfn.content}</td>
													</c:when>
													<c:otherwise>
																<td class=" "></td>
													</c:otherwise>
												</c:choose>	
												
												
												<td class="center ">${notfn.description}</td>
												<td class="center ">${notfn.category}</td>
												
												<c:choose>
													<c:when test="${1 eq notfn.active}">
														<td class="center status-active">Active</td>
												</c:when>
													<c:otherwise>
															<td class="center status-inactive">Inactive</td>
													</c:otherwise>
												</c:choose>	
												<fmt:formatDate type="date" value="${unassignedPaymentData.paymentDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
												<td class="center ">${notfn.inserted}<br>${notfn.insertedby}</td>
												
												<td class="center ">${notfn.lastmodified}<br>${notfn.lastmodifiedby}</td>
											</tr>
								
							</c:forEach>
						</c:if>
					</tbody>
					
				</table>


			</div>  

		</div>
		<div class="spacer"></div>
		
		</c:otherwise>
	</c:choose>
	
	</c:if></form:form>
</div></div>