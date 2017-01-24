<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<%-- <script type="text/javascript" src="${pageContext.servletContext.contextPath}/javascript/jquery-1.11.js"></script> --%>

<html lang="en-US" prefix="og: http://ogp.me/ns#">
<!--<![endif]-->
        <script type="text/javascript">
        $(document).ready(function() {
        	
        });    
        
    </script>

<style type="text/css">

</style>
<head>	

<link type="text/css" media="all" 	href="<spring:message code="static.application.name"/>/css/autoptimize.css" rel="stylesheet">
<style type="text/css">
.primary-navigation h1{
padding: 5px 10px 5px 0px;
}

.gsc-control-cse {
font-family: Roboto, sans-serif;
border-color: #FFFFFF;
background-color: #FFFFFF;
}
.gsc-control-cse .gsc-table-result {
font-family: Roboto, sans-serif;
margin: 0px;
}
input.gsc-input {
border-color: #BBBBBB;
}
/* input.gsc-search-button {
border-color: #000000;
background-color: #333333;
} */
.gsc-tabHeader.gsc-tabhInactive {
border-color: #777777;
background-color: #777777;
}
.gsc-tabHeader.gsc-tabhActive {
border-color: #333333;
background-color: #333333;
}
.gsc-tabsArea {
border-color: #333333;
}
.gsc-webResult.gsc-result,
.gsc-results .gsc-imageResult {
border-color: #FFFFFF;
background-color: #FFFFFF;
}
.gsc-webResult.gsc-result:hover,
.gsc-imageResult:hover {
/* border-color: #cdcdcd; */
background-color: #FFFFFF;
}
.gsc-webResult.gsc-result.gsc-promotion:hover {
border-color: #000000;
background-color: #FFFFFF;
}
/* .gs-webResult.gs-result a.gs-title:link,
.gs-webResult.gs-result a.gs-title:link b,
.gs-imageResult a.gs-title:link,
.gs-imageResult a.gs-title:link b {
color: #000000;
} */
.gs-webResult.gs-result a.gs-title:visited,
.gs-webResult.gs-result a.gs-title:visited b,
.gs-imageResult a.gs-title:visited,
.gs-imageResult a.gs-title:visited b {
color: #000000;
}
.gs-webResult.gs-result a.gs-title:hover,
.gs-webResult.gs-result a.gs-title:hover b,
.gs-imageResult a.gs-title:hover,
.gs-imageResult a.gs-title:hover b {
color: #15c;
}
.gs-webResult.gs-result a.gs-title:active,
.gs-webResult.gs-result a.gs-title:active b,
.gs-imageResult a.gs-title:active,
.gs-imageResult a.gs-title:active b {
color: #15c;
}
.gsc-cursor-page {
color: #000000;
}
a.gsc-trailing-more-results:link {
color: #000000;
}
.gs-webResult .gs-snippet,
.gs-imageResult .gs-snippet,
.gs-fileFormatType {
color: #444444;
}
.gs-webResult div.gs-visibleUrl,
.gs-imageResult div.gs-visibleUrl {
color: #093;
}
.gs-webResult div.gs-visibleUrl-short {
color: #3D85C6;
}
.gs-webResult div.gs-visibleUrl-short {
display: none;
}
.gs-webResult div.gs-visibleUrl-long {
display: block;
}
.gs-promotion div.gs-visibleUrl-short {
display: none;
}
.gs-promotion div.gs-visibleUrl-long {
display: block;
}
.gsc-cursor-box {
border-color: #FFFFFF;
}
.gsc-results .gsc-cursor-box .gsc-cursor-page {
border-color: #777777;
background-color: #FFFFFF;
color: #000000;
}
.gsc-results .gsc-cursor-box .gsc-cursor-current-page {
/* border-color: #333333;
background-color: #333333; */
color: #0015FF;
}
.gsc-webResult.gsc-result.gsc-promotion {
border-color: #CCCCCC;
background-color: #E6E6E6;
}
.gsc-completion-title {
color: #000000;
}
.gsc-completion-snippet {
color: #444444;
}
/* .gs-promotion a.gs-title:link,
.gs-promotion a.gs-title:link *,
.gs-promotion .gs-snippet a:link {
color: #0000CC;
}
.gs-promotion a.gs-title:visited,
.gs-promotion a.gs-title:visited *,
.gs-promotion .gs-snippet a:visited {
color: #0000CC;
} */
.gs-promotion a.gs-title:hover,
.gs-promotion a.gs-title:hover *,
.gs-promotion .gs-snippet a:hover {
color: #444444;
}
.gs-promotion a.gs-title:active,
.gs-promotion a.gs-title:active *,
.gs-promotion .gs-snippet a:active {
color: #00CC00;
}
.gs-promotion .gs-snippet,
.gs-promotion .gs-title .gs-promotion-title-right,
.gs-promotion .gs-title .gs-promotion-title-right * {
color: #333333;
}
.gs-promotion .gs-visibleUrl,
.gs-promotion .gs-visibleUrl-short {
color: #00CC00;
}
.gsc-results-wrapper-visible{
	line-height: 20px;
}
table{
margin: 0px;
}
.gsc-selected-option-container{
	width: 70% !important;
}
.gsc-resultsHeader, .gcsc-branding{
	display: none;
}
input[type="text"]:focus
 {
  border-color:#fff;
  outline: 0;
  /* IE6-9 */

  -webkit-box-shadow: none;
     -moz-box-shadow: none;
         box-shadow: none;
}
.gsc-search-box-tools .gsc-search-box .gsc-input{
	height: 25px !important;
	margin: 0px !important;
	padding: 0px 0px 0px 5px !important;
}

.gsib_a{
	padding: 0px !important;
}

</style>
</head>

<div class="bodyHeader megamenu_wrapper">
	<div class="headerContent">
		

		<header id="masthead" class="site-header" role="banner">
			<div class="header-main">
					<span class="logo"><a href="<spring:message code="application.name"/>"><img src="<spring:message code="static.application.name"/>/images/kakathiya_logo.png"
							style="width: 220px;height: 55px;" /></a></span>

				<div class="search-toggle">
					<a
						href="<spring:message code="application.name"/>/#search-container"
						class="screen-reader-text">Search</a>
				</div>

				<nav id="primary-navigation"
					class="site-navigation primary-navigation">
					<h1 class="menu-toggle"></h1>
					<div class="menu-category-menu-container">
						<ul id="menu-category-menu" class="nav-menu">
							<li id=""
								class="menu-item page_item "> <!--  current-menu-item  current_page_item-->
								<a
								title="Home" rel="ipt-icon-bubbles2"
								 href="${pageContext.servletContext.contextPath}/home">Home</a></li>
								 
							${menuString}	 
							
							<li id="" class="menu-item "><a
								title="Gallery" rel="ipt-icon-stack"
								 href="${pageContext.servletContext.contextPath}/gallery">Gallery</a>
								</li>
							<li id="" class="menu-item "><a
								title="Toppers" rel="ipt-icon-stack"
								 href="${pageContext.servletContext.contextPath}/toppers">Toppers</a>
								</li>
							<li id="" class="menu-item "><a
								title="News" rel="ipt-icon-stack"
								 href="${pageContext.servletContext.contextPath}/news">News</a>
								</li>
							<li id="" class="menu-item "><a
								title="Library" rel="ipt-icon-stack"
								 href="${pageContext.servletContext.contextPath}/library">Library</a>
								</li>
							<li id="" class="menu-item "><a
								title="Notifications" rel="ipt-icon-stack"
								 href="${pageContext.servletContext.contextPath}/notifications">Notifications</a>
								</li>
							<li id="" class="menu-item "><a
								title="Events" rel="ipt-icon-stack"
								 href="${pageContext.servletContext.contextPath}/events">Events</a>
								</li>
							<li id="" class="menu-item "><a
								title="Contact" rel="ipt-icon-stack"
								 href="${pageContext.servletContext.contextPath}/contactus">Contact Us</a>
								</li>

						</ul>
					</div>
				</nav>
			</div>
			
		<div id="search-container" class="search-box-wrapper hide">
			<div class="search-box">
				
<div>
  <script>
  (function() {
    var cx = '009513244708120462446:cpkpguf9una';
    var gcse = document.createElement('script');
    gcse.type = 'text/javascript';
    gcse.async = true;
    gcse.src = (document.location.protocol == 'https:' ? 'https:' : 'http:') +
        '//www.google.com/cse/cse.js?cx=' + cx;
    var s = document.getElementsByTagName('script')[0];
    s.parentNode.insertBefore(gcse, s);
  })();
</script>
			<gcse:search></gcse:search>			
					</div>

			</div>
		</div>
	</div>
	<!-- #page -->

	<!-- <script type="text/javascript">
			  (function() {
			    var po = document.createElement('script'); po.type = 'text/javascript'; po.async = true;
			    po.src = 'https://apis.google.com/js/plusone.js';
			    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(po, s);
			  })();
			</script>
	<script type="text/javascript">
		jQuery(document).on( 'ready post-load', function(){
			jQuery( 'a.share-facebook' ).on( 'click', function() {
				window.open( jQuery(this).attr( 'href' ), 'wpcomfacebook', 'menubar=1,resizable=1,width=600,height=400' );
				return false;
			});
		});
		</script>
	<script type="text/javascript">
		jQuery(document).on( 'ready post-load', function(){
			jQuery( 'a.share-twitter' ).on( 'click', function() {
				window.open( jQuery(this).attr( 'href' ), 'wpcomtwitter', 'menubar=1,resizable=1,width=600,height=350' );
				return false;
			});
		});
		</script> -->
	
	<script type="text/javascript"
		src="<spring:message code="static.application.name"/>/javascript/functions.js"></script>
	<script type="text/javascript">
/* <![CDATA[ */
var recaptcha_options = {"lang":"en"};
/* ]]> */
</script>

	<script type="text/javascript">
if (window.top !== window.self) {
	window.top.location = window.self.location;
}
</script>
	</div>
</div>
<div class="pagecontentclear"></div>
      