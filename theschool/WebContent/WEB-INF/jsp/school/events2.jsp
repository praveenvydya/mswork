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

	});
</script>
<style>

body {
    font-family: 'Myriad Pro','Helvetica',tahoma,sans-serif;
    font-size: 13px;
    letter-spacing: 0.02em;
    line-height: 1.3em;
}
.galleries .image {
	float: left;
	height: auto;
	width: 200px;
}
.galleries .main-image{
width: 200px;
}

.galleryblock {
	display: block;
	/* float: left; */
	padding-bottom: 35px;
	padding-left: 20px;
	width: 610px;
}

.text {
	display: inline-block;
	padding-left: 20px;
	width: 290px;
}

.gallery-heading {
	color: #525252;
	font-size: 24px;
	padding-bottom: 12px;
	text-transform: capitalize;
}

.gallery-desc {
	color: #525252;
	font-size: 14px;
}
</style>


<div class="wrap">

	<div class="gallerys">
		<c:if test='${null!=galleryList }'>
			
				<c:forEach var="gallery" items="${galleryList}">
					<div class="galleryblock">
						<div class="image" style="">
							<a href="#" target="_blank"><img class="main-image"
								src="data:image/jpg;base64,<c:out value='${gallery.image}'/>" />
							</a>
						</div>

						<div class="text">
							<p class="gallery-heading">${gallery.name}</p>

							<p class="gallery-desc">${gallery.galleryDesc}</p>
						</div></div>
				</c:forEach>
			
		</c:if>

	</div>
</div>