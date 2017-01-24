<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%-- <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.vydya.theschool.common.constants.TSConstants"%>
<%@ page import="com.vydya.theschool.web.constants.WebConstants"%>

<script defer="defer">
	
</script>
<script type="text/javascript">
	jQuery(document).ready(function($) {

	});
</script>

<div id="tabularData">
	<div id="titleBar">
		<div class="title">Search Page</div>

		<div class="addSectionBttn"></div>

	</div>
	<c:if test='${null!=success_key }'>
		<div class="successMsg">
			<spring:message code="${success_key}" />
		</div>
		<c:remove var="success_key" scope="session" />
	</c:if>


	<div class="successMsg" id="status_success"></div>
	<div class="errormsg" id="status_fail" style="padding-left: 15px;">

	</div>

	<div id="tabularDataWide">
		<form:form name="homePageImageForm" method="POST"
			commandName="homePageImageForm" id="homePageImageForm">
			<c:if test='${null!=homePageImagesList }'>
				<div class="tableLimiter">

					<div id="titleBar">
						<div class="title">Home Page Images</div>
					</div>

					<c:choose>
						<c:when test="${empty homePageImagesList}">
							<div class="alertMsg">No Pages Found</div>
						</c:when>
						<c:otherwise>
							<table width="100%" border="0" cellspacing="0" cellpadding="0"
								id="sectionsTable">

								<c:forEach var="page" items="${homePageImagesList}">
									<tr>
										<td><a href="javascript:showPreview('${page.id}');"><img
												src="${pageContext.servletContext.contextPath}/homePageImage?id=${page.id}" />
										</a>
										</td>
										<td>${page.imageName}</td>
										<td>${page.description}</td>

									</tr>
								</c:forEach>
							</table>

						</c:otherwise>
					</c:choose>
				</div>

			</c:if>

		</form:form>
	</div>
</div>