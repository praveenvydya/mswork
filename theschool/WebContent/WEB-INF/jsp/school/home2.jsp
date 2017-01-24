<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%-- <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.vydya.theschool.common.constants.TSConstants"%>
<%@ page import="com.vydya.theschool.web.constants.WebConstants"%>
<head>
<style>
div.desc {
	background-color: #fff;
	/*   color: #FFFFFF; */
	height: auto;
	left: 582px;
	opacity: 0.60;
	padding: 10px;
	top: 219px;
	width: auto;
	
}
.controlNav{
	opacity:0.7;
}
#tbx {
	padding: 0px;
	float: right;
}

/* #innerContent {
	width: 996px;
} */

#cnt1,#cnt2,#cnt3 {
	padding: 0px;
	margin: 0px;
	float: left;
	width: 100%;
}
</style>
<script type="text/javascript">
	$(document).ready(
			function() {

				var mySlider = $("#mySlider").canvasSlider({
					/* width : 960,
					height : 400, */
					width : 726,
					height : 323,
					fluid : true,

					startIndex : 0,

					mouse : true,
					keyboard : true,
					swipe : true,

					speed : 2000,
					loop : true,

					autoplay : true,
					interval : 5000,
					pauseOnHover : false,
					pauseOnClick : false,

					playButton : true,
					playButtonHide : true,
					playText : 'play',
					pauseText : 'stop',

					directionNav : true,
					directionNavHide : true,
					nextText : 'Next',
					prevText : 'Prev',

					controlNav : true,
					controlNavThumbs : false,
					controlNavHide : false,
					customIndex : [],

					addLinkToImage : true,
					linkTarget : '_blank',

					captionAnimation : true,
					captionEffect : 'fade',
					captionMove : 20,
					captionSpeed : 500,
					captionDelay : 400,
					captionEasing : 'swing',

					animation : true,
					effect : 'random',
					barColumns : 12,
					barRows : 5,
					gridColumns : 12,
					gridRows : 5,

					before : function() {
					},
					after : function() {
					},
					start : function() {
					},
					complete : function() {
					}
				});

				$('ul.etabs').each(
						function() {
							// For each set of tabs, we want to keep track of
							// which tab is active and it's associated content
							var $active, $content, $links = $(this).find('a');

							// If the location.hash matches one of the links, use that as the active tab.
							// If no match is found, use the first link as the initial active tab.
							$active = $($links.filter('[href="' + location.hash
									+ '"]')[0]
									|| $links[0]);
							$active.addClass('active');
							$content = $($active.attr('href'));

							// Hide the remaining content
							$links.not($active).each(function() {
								$($(this).attr('href')).hide();
							});

							// Bind the click event handler
							$(this).on('click', 'a', function(e) {
								// Make the old tab inactive.
								$active.removeClass('active');
								$content.hide();

								// Update the variables with the new link and content
								$active = $(this);
								$content = $($(this).attr('href'));

								// Make the tab active.
								$active.addClass('active');
								$content.fadeIn(1000);

								// Prevent the anchor's default click action
								e.preventDefault();
							});
						});

				$("#eventTab").fineTabs({
					tabhead : 'h2',
					fx : "fadeIn",
					syncheights : true,
					saveState : true,
					clearfixClass : 'ym-clearfix',
					currentInfoText : ""

				});

			

			});
</script>
</head>

<div class="wrap">
	<form:form name="homePageImageForm" method="POST"
		commandName="homePageImageForm" id="homePageImageForm">
		<div id="mySlider" class="canvasSlider default">

			<ul class="slides">
				<c:if test='${null!=homePageImagesList }'>
					<c:forEach var="page" items="${homePageImagesList}">
						<li style="display: none;"><a><img class="main-image"
								src="data:image/jpg;base64,<c:out value='${page.image}'/>" /> </a>

							<div class="canvas-caption big dark desc" data-effect="left"
								data-move="50" style="left: 570px; top: 234px;">
								<p>${page.imageTitle}</p>
							</div>
							<div class="canvas-caption medium dark desc" data-effect="right"
								data-move="50" style="left: 616px; top: 279px; float: right;">
								<p>${page.description}</p>
							</div> <!-- <div class="canvas-caption image-link"
							style="right: 20px; bottom: 10px; opacity: 0;" data-effect="fade">
							<a href="#" target="_blank">Computer</a>
						</div> -->
						</li>
					</c:forEach>
				</c:if>
			</ul>
		</div>
	</form:form>
	<div id="cnt1">
		<div class="home-content-desc1">
			<div class="box">
				<h4 class="ui-borderBottom pbs mbs">Newsletter Signup</h4>
				<div class="box box-bdr pam mts">
					<div class="box-hd pan">
						Track the latest collections and offers at Jabong.
						<div class="sp_shipping_grey">
							<i><strong> Sign up for our newsletter and get a Rs.
									2000 Voucher!</strong> </i>
						</div>
					</div>
					<div class="box-bd pan mtm" id="FooterNewsletter">Principal
						info</div>
					<div class="box-ft fss lhs pan mtm">
						Your data will not be shared with others and you can unsubscribe
						at any time.
						<div class="mrt-10">*Voucher is valid only on new
							registrations.</div>
					</div>
				</div>
			</div>
		</div>
		<div id="tbx">
			<h4 class="ui-borderBottom pbs mbs">
				<b>Event Gallery Images</b>
			</h4>
			<div class="tabs" id="eventTab">
				<ul class="clearfix tabs-list tabamount3">
					<li class="current first" id="accessibletabsnavigation0-0"><a
						href="#accessibletabscontent0-0"><span class="current-info"></span>School</a>
					</li>
					<li id="accessibletabsnavigation0-1"><a
						href="#accessibletabscontent0-1">College</a></li>
					<li id="accessibletabsnavigation0-2"><a
						href="#accessibletabscontent0-2">Degree</a></li>
				</ul>
				<div class="tabBox">

					<div style="display: block;" class="tabbody">
						<div class="ev-link">
							<a href="#">View All</a>
						</div>
						<div>
							<div class="ev-div">
								<div class="img-div"></div>
								<div class="content-div2">
									<a href="#">First Day School function at jammikunta</a>
								</div>
							</div>
							<div class="ev-div">
								<div class="img-div"></div>
								<div class="content-div2"><a href="#">First Day School function at jammikunta</a></div>
							</div>
							<div class="ev-div">
								<div class="img-div"></div>
								<div class="content-div2"><a href="#">First Day School function at jammikunta</a></div>
							</div>
						</div>
					</div>
					<div style="display: block;" class="tabbody">
						<div class="ev-link">
							<a href="#">View All</a>
						</div>
						<div>
							<div class="ev-div">
								<div class="img-div"></div>
								<div class="content-div2">
									<a href="#">First Day School function at jammikunta</a>
								</div>
							</div>
							<div class="ev-div">
								<div class="img-div"></div>
								<div class="content-div2"></div>
							</div>
							<div class="ev-div">
								<div class="img-div"></div>
								<div class="content-div2"></div>
							</div>
						</div>
					</div>
					<div style="display: block;" class="tabbody">
						<div class="ev-link">
							<a href="#">View All</a>
						</div>
						<div>
							<div class="ev-div">
								<div class="img-div"></div>
								<div class="content-div2">
									<a href="#">First Day School function at jammikunta</a>
								</div>
							</div>
							<div class="ev-div">
								<div class="img-div"></div>
								<div class="content-div2"></div>
							</div>
							<div class="ev-div">
								<div class="img-div"></div>
								<div class="content-div2"></div>
							</div>
						</div>
					</div>


				</div>
			</div>
		</div>
	</div>
	<div id="cnt2">
		<div class="line">
			<div class="unit size4of6">
				<div>
					<div class="line">
						<div class="unit size1of4">
							<div class="box fss mrm">
								<h4 class="ui-borderBottom pbs mbs">School</h4>
								<ul>
									<li class="mbs"><a rel="nofollow" title="About"
										href="http://www.jabong.com/about/"
										onclick="_gaq.push(['_trackEvent', 'footer','about-jabong','about-us']);">About</a>
									</li>
									<li class="mbs"><a rel="nofollow" title="Contact"
										href="http://www.jabong.com/contact/"
										onclick="_gaq.push(['_trackEvent', 'footer','about-jabong','contact']);">Contact</a>
									</li>

								</ul>
							</div>
						</div>
						<div class="unit size1of4">
							<div class="box fss mrm">
								<h4 class="ui-borderBottom pbs mbs">College</h4>
								<ul>
									<li class="mbs"><a rel="nofollow"
										title="Cancellations and Returns"
										href="http://www.jabong.com/help/#returns"
										onclick="_gaq.push(['_trackEvent', 'footer','our-policies','cancellations_returns']);">Cancellations
											and Returns</a>
									</li>
									<li class="mbs"><a rel="nofollow" title="Shipping"
										href="http://www.jabong.com/help/#shipping"
										onclick="_gaq.push(['_trackEvent', 'footer','our-policies','shipping']);">Shipping</a>
									</li>

								</ul>
							</div>
						</div>
						<div class="unit size1of4">
							<div class="box fss mrm">
								<h4 class="ui-borderBottom pbs mbs">Degree</h4>
								<ul>
									<li class="mbs"><a rel="nofollow" title="Facebook"
										target="_blank" href="http://www.facebook.com/myjabong"
										class="icon i-socFacebook"
										onclick="_gaq.push(['_trackEvent', 'footer','social','facebook']);">Facebook</a>
									</li>
									<li class="mbs"><a rel="nofollow" title="Twitter"
										target="_blank" href="http://twitter.com/jabongindia"
										class="icon i-socTwitter"
										onclick="_gaq.push(['_trackEvent', 'footer','social','twitter']);">Twitter</a>
									</li>
								</ul>
							</div>
						</div>
						<div class="unit size1of4 lastUnit">
							<div class="box fss mrm">
								<h4 class="ui-borderBottom pbs mbs">Payment Methods</h4>
								<div class="ui-listHorizontal">
									<div title="Visa"
										class="ui-listItem icon i-payVisa lfloat mr-bs">Visa</div>
									<div title="Master Card"
										class="ui-listItem icon i-payMasterCard lfloat mr-bs">Master
										Card</div>

								</div>
							</div>
							<div class="box fss mrm mtm">
								<h4 class="ui-borderBottom pbs mbs">Shipping Partner</h4>
								<ul class="ui-listHorizontal">
									<li title="Javas" class="ui-listItem icon i-shipJavas lfloat">Javas</li>
									<li title="DTDC" class="ui-listItem icon i-dtdc lfloat">DTDC</li>

								</ul>
							</div>
						</div>
					</div>
				</div>

			</div>
			<div class="unit size2of6 lastUnit">
				<div class="box">
					<h4 class="ui-borderBottom pbs mbs">Newsletter Signup</h4>
					<div class="box box-bdr pam mts">
						<div class="box-hd pan">
							Track the latest collections and offers at Jabong.
							<div class="sp_shipping_grey">
								<i><strong> Sign up for our newsletter and get a
										Rs. 2000 Voucher!</strong> </i>
							</div>
						</div>
						<div class="box-bd pan mtm" id="FooterNewsletter">Principal
							info</div>
						<div class="box-ft fss lhs pan mtm">
							Your data will not be shared with others and you can unsubscribe
							at any time.
							<div class="mrt-10">*Voucher is valid only on new
								registrations.</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- <iframe src="//www.facebook.com/plugins/likebox.php?href=https%3A%2F%2Fwww.facebook.com%2FFacebookDevelopers&amp;width=292&amp;height=590&amp;show_faces=true&amp;colorscheme=light&amp;stream=false&amp;show_border=true&amp;header=true" scrolling="no" frameborder="0" style="border:none; overflow:hidden; width:292px; height:400px;" allowTransparency="true"></iframe>
 --></div>