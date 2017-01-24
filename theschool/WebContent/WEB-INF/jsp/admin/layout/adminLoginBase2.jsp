<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%> 
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>
<tiles:insertAttribute name="title" ignore="true" />
</title>
<link href="<spring:message code="static.application.name"/>/css/loginStyle2.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery-1.3.2.min.js"></script>
 <script type="text/javascript">
jQuery(document).ready(function ($) {
	$(function(){
		$('#loginPageBanners').shyni({
			pagination: false,
			commands	: false,
			thumbs		: false,
			navigation  : false,
			loader		: 'none',
			fx:"simpleFade",
			pauseOnClick : false
		});
	});
});
</script>
</head>
<body>
<div id="loginWrapper2">
		<div class="full-page">
			<div class="page-banner">
				<div class="img-parent">
					<div class="shyni_wrap shyni_magenta_skin" id="loginPageBanners">
						<div data-thumb="" data-src="<spring:message code="static.application.name"/>/images/school/banners/l1.jpg" class="homeimg"></div>
						<div data-thumb="" data-src="<spring:message code="static.application.name"/>/images/school/banners/l2.jpg" class="homeimg"></div>
					</div>
				</div>
			</div>
		</div>
		<div id="loginHeader2"></div>
	<tiles:insertAttribute name="body" />
	<tiles:insertAttribute name="footer" />
</div>
</body>
</html>
