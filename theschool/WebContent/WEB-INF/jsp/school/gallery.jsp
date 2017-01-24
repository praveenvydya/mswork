<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%-- <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.vydya.theschool.common.constants.TSConstants"%>
<%@ page import="com.vydya.theschool.web.constants.WebConstants"%>
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/ajc.js"></script><script type="text/javascript">


	$(document).ready(function() {
		
		
		loadY('g','<spring:message code="application.name"/>${pageContext.servletContext.contextPath}');
	});
	
</script>
<style>
.ol{
	
}
.ol ul{
margin: 0px !important;
}
.ol ul li{
margin:15px auto;
text-align: center;
}
.ol ul li a{
	font-weight: 200;
	font-family: Roboto;
	font-size: 30px;
}
.widget-title{
text-align: center;
}
.out2{
	padding: 0px;
}
</style>
	<h2>Gallery</h2>
		 
	<div id="free-file" class="allGalleries">
		<div class="outer-boundary">
		<c:if test='${null!=galleryList }'>
			<c:forEach var="gallery" items="${galleryList}">
				<div class="inner-boundary" id="gallery_${gallery.id}">
					<div class="inner-border">
						<div class="gallery-inner">
							<div class="thumbnail itemcontainer">
								<a href="${pageContext.servletContext.contextPath}/gallery/${gallery.url}" id="galleryName_${gallery.id}_${gallery.url}" class="gthumb">	
								<img src="${pageContext.request.contextPath}/static/simg-fit/262x140/${gallery.imageName}" id="galleryImage_${gallery.id}_${gallery.url}" class="galleryImage"
								alt="${gallery.name}" /></a>
							</div>
							<div class="content-div">
							<div class="gallery-decorator">
									<a href="${pageContext.servletContext.contextPath}/gallery/${gallery.url}" id="galleryName_${gallery.id}_${gallery.url}"  class="galleryName"><span class="img-content-title"> ${gallery.title}</span>&nbsp;(${gallery.gallerysize})</a>
								<div class="img-content-div">${gallery.eventDesc}</div>
							</div>
							
							</div>
						</div>
					</div>
				
				</div>
			</c:forEach>
		</c:if>
		</div>
</div>

	<div class="out2">
		<h4 class="widget-title">
			<span>PREVIOUS GALLERIES</span>
		</h4>
		<div id="previous-years" class="ol"></div>
	</div>
