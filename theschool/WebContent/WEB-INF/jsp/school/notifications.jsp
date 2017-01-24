<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%-- <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.vydya.theschool.common.constants.TSConstants"%>
<%@ page import="com.vydya.theschool.web.constants.WebConstants"%>



<div class="full-page">
	<div class="full-content">
		<div id="" class="layout-region content">
			<div class="layout-region-inner content">
				<div id="" class="content-fragment blog-post no-wrapper">
					<div class="content-fragment-content">
						

<div class="advt1 d">
	<h2  >Notifications</h2>
	<div
		style="overflow: hidden; margin: 5px 0 5px 5px; height: auto; width: 100%">
		<div id="" class="notfboard">

			<table>
				<c:forEach var="notf" items="${notificationList}" varStatus="cin">
					<tr><td><div class="dt">${notf.inserted}</div></td><td> »&nbsp; <span class="fileType ${notf.fileType}f"></span><a	href="${pageContext.request.contextPath}/notification/${notf.url}" target="_blank">${notf.name}.</a> 
										</td>
					</tr>
				</c:forEach>
			</table>
		</div>
	</div>
</div>


					</div>
				</div>
			</div>
		</div>
	</div>
</div>


