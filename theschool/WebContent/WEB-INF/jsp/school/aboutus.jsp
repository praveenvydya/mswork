<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%-- <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.vydya.theschool.common.constants.TSConstants"%>
<%@ page import="com.vydya.theschool.web.constants.WebConstants"%>
<head>
<style>
</style>
<script type="text/javascript">
	$(document).ready(function() {

	});
</script>
</head>


<!-- <div
					class="wk-slideshow wk-slideshow-default"
					id="slideshow-1-52728fc414456"
					style="visibility: hidden; position: relative; width: 680px;">
					<div>
						<ul class="slides"
							style="width: 100%; overflow: hidden; position: relative; height: 250px;">

							<li
								style="top: 0px; left: 0px; position: absolute; display: list-item; z-index: 2; height: 250px;">
								<article class="wk-content clearfix">
								<img alt="About 01"
									src=""></article>
							</li>
						</ul>
						<div class="" style="display: none;"></div>
						<ul class="" style="display: none;">
							<li></li>
						</ul>
					</div>
				</div> -->

<div class="full-page">
	<div class="page-banner">
		<div class="img-parent">
			<img src="<spring:message code="static.application.name"/>/images/school/banners/home02.jpg" />
		</div>
	</div>
	<div class="full-content">

		<h2 class="pagehead">ABC School</h2>
		<h5 class="pagetext">Fundamental purpose is to preserve for the
			posteritythe unsurpassed and indisputable beauty of Indian Culture,
			art and heritage.</h5>

		<div class="items-row cols-2 row-0">
			<div class="item column-1">
				<h5>Founder</h5>
				<div class="img-main-left">
					<img alt="about Overview udpated"
						src="<spring:message code="static.application.name"/>/images/school/abt.jpg"
						style="float: left;" class="pageimg">
				</div>
				<p>
					Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam
					nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat
					volutpat. Ut wisi enim ad minim veniam. Duis autem vel eum iriure
					dolor in hendrerit in vulputate velit esse molestie consequat, vel
					illum dolore eu feugiat nulla facilisis at vero eros et accumsan et
					iusto odio dignissim qui blandit praesent luptatum zzril delenit
					augue duis dolore te feugait nulla facilisi. <span class="readmore">
						<a href="${pageContext.servletContext.contextPath}/school/aboutus/founder"> More &#187;</a> </span>
				</p>
			</div>
			<div class="item column-2">
				<h5>Overview</h5>
				<div class="img-main-left">
					<img alt=""
						src="<spring:message code="static.application.name"/>/images/school/abt.jpg"
						title="" style="float: left;" class="pageimg">
				</div>
				<p>
					ABC aims to preserve, encourage and propagate the teaching and
					understanding of Indian art and culture as an integral part of the
					culture of the United Kingdom. It commends universal values in
					performance and studies. Our objective is to provide a centre of
					learning in the UK for Indian culture.<span class="readmore">
						<a href="${pageContext.servletContext.contextPath}/school/aboutus/overview"> More &#187;</a> </span>
				</p>
			</div>
		</div>


		<div class="items-row cols-2 row-0">
			<div class="item column-1">
				<h5>Vision, Mission &amp; Objectives</h5>
				<div class="img-main-left">
					<img alt=""
						src="<spring:message code="static.application.name"/>/images/school/abt.jpg"
						title="" style="float: left;" class="pageimg">
				</div>
				<p>
					It is a credible acceptance that ABCs success over the years has to
					be credited to its patrons and executives. Their trust and belief
					in ABCs mission has proved indispensable to ABCs comprehensive...<span
						class="readmore"> <a href="${pageContext.servletContext.contextPath}/school/aboutus/vission"> More &#187;</a> </span>
				</p>
			</div>
			<div class="item column-2">
				<h5>Management Team</h5>
				<div class="img-main-left">
					<img alt=""
						src="<spring:message code="static.application.name"/>/images/school/abt.jpg"
						title="" style="float: left;" class="pageimg">
				</div>
				<p>
					ABC''s Management Team comprises highly qualified individuals whose
					concerted efforts have made ABC a global organization today. They
					deal with all the aspects that have engendered ABCs unmatched... <span
						class="readmore"> <a href="${pageContext.servletContext.contextPath}/school/aboutus/management"> More &#187;</a> </span>
				</p>
			</div>

		</div>
	</div>