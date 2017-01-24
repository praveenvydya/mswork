<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%-- <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.vydya.theschool.common.constants.TSConstants"%>
<%@ page import="com.vydya.theschool.web.constants.WebConstants"%>

<script defer="defer">
	
</script>
<script type="text/javascript">
	$(document).ready(function() {


					$('#scrollboxDiv').finescroll({
					    verticalTrackClass: 'track',
					    verticalHandleClass: 'handle',
					    minScrollbarLength: 15,
					    showOnHover : false
					});
					});
</script>
<style>

.img-evnt-desc {
	padding: 0px;
	margin: 0px;
	float: right;
	width: 100%;
}

.img-evnt-desc .name {
	padding: 0px;
	margin: 0px;
}

.img-evnt-desc .plc {
	padding: 0px;
	margin: 0px;
	float: right;
	font-weight: normal;
	 font-size: 12px;
}

.img-evnt-desc .dt {
	padding: 0px;
	margin: 0px;
	 font-size: 12px;
	 font-weight: normal;
}

</style>

	<div class="full-page">
	<div class="page-banner">
		<div class="img-parent">
				<img src="${pageContext.request.contextPath}/static/simg-org/${group.imageName}"
									class="tgroupImage"
							 	alt="${group.name}" 
									style="display: inline-block;" />
		</div>
	</div>
	<%-- <h2 class="pagehead" >${gallery.title}</h2>
	<h4 class="pagetext">${gallery.eventDesc}</h4>
	<h4 class="pageSubtext"><span style="float: left;">Place: ${gallery.eventPlace}</span><span style="float: right;">Date:${gallery.eventDate}</span></h4>	
	 --%>
	<div class="full-content">
     <div class="blockquote" > 
		<div>
			
                    <h2>${group.title}</h2>
                    <small>${group.description}</small>
               
		</div>
		
	</div> 
	
	<div>
		<%-- <div class="forImages">
			<div class="galleryImages">
				<c:if test='${null!=toppersList }'>
					<c:forEach var="stud" items="${toppersList}"
						varStatus="imageStatus">
							<a id="evntImg_${stud.id}"
								title="${stud.description}"
								href="${pageContext.request.contextPath}/stimages/gallery/af/${stud.imageName}"
								rel="galleryImage_group"> 
							<img src="<spring:message code="static.application.name"/>/gallery/at/${stud.imageName}" class="glthumb"
								alt="${stud.imageName}" /> </a>
					</c:forEach>
				</c:if>
			</div>
		</div>
		--%>
		
		
<div class="forImages">
		<div class="topStudentImages">
			<c:if test='${null!=topStudentsList }'>
				<div class="toppers">
					<c:forEach var="topStudent" items="${topStudentsList}" varStatus="topStudentStatus">
						<div class="topper">
							<div class="image-div">
										<c:choose>
											<c:when test="${null ne topStudent.imageName}">
												<img class="image" src="${pageContext.request.contextPath}/static/simg-fit/96x120/${topStudent.imageName}" />
											</c:when>
											<c:otherwise>
												<img class="image" src="<spring:message code="static.application.name"/>/images/student_m.png" />
											</c:otherwise>
										</c:choose>

										
							</div>
							<div class="sub-div">
								<b>Rank: ${topStudent.rank}</b>
							</div>
							<div class="name-div">
								${topStudent.studentName}
							</div>
							<div class="sub-div">
								HT.No: ${topStudent.hallTiketNo}
							</div>
						</div>
					</c:forEach>
				</div>
			</c:if>
		</div>
		</div>
	</div>
	<div style="clear: both;"></div> 
	</div>
</div>



<!-- <div class="allGalleriesSlider">
		<div id="scrollboxDiv" class="scrollbox">
			<div class="item">
				<div class="imdiv"></div>
				<div class="tlebx"><a href="">abc</a></div>
			</div>
			<div class="item">
				<div class="imdiv"></div>
				<div class="tlebx"><a href="">abc</a></div>
			</div>
			<div class="item">
				<div class="imdiv"></div>
				<div class="tlebx"><a href="">abc</a></div>
			</div>
			<div class="item">
				<div class="imdiv"></div>
				<div class="tlebx"><a href="">abc</a></div>
			</div>
			<div class="item">
				<div class="imdiv"></div>
				<div class="tlebx"><a href="">abc</a></div>
			</div>
			<div class="item">
				<div class="imdiv"></div>
				<div class="tlebx"><a href="">abc</a></div>
			</div>
			<div class="item">
				<div class="imdiv"></div>
				<div class="tlebx"><a href="">abc</a></div>
			</div>
			<div class="item">
				<div class="imdiv"></div>
				<div class="tlebx"><a href="">abc</a></div>
			</div>
			<div class="item">
				<div class="imdiv"></div>
				<div class="tlebx"><a href="">abc</a></div>
			</div>
	
		</div>
	</div> -->


