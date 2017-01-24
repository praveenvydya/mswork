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

		var mySlider = $("#mySlider").canvasSlider({
			width : 960,
			height : 400,
			fluid : true,

			startIndex : 0,

			mouse : true,
			keyboard : true,
			swipe : true,

			speed : 500,
			loop : true,

			autoplay : true,
			interval : 5000,
			pauseOnHover : false,
			pauseOnClick : true,

			playButton : true,
			playButtonHide : false,
			playText : 'play',
			pauseText : 'stop',

			directionNav : true,
			directionNavHide : false,
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
			captionSpeed : 400,
			captionDelay : 200,
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

	});
</script>


<div class="wrap">

		<div id="mySlider" class="canvasSlider default"
			style="width: 100%; height: 427px;">

			<ul class="slides">

				<li 
					style="display: none;"><a
					href="http://codecanyon.net/user/evoslider" target="_blank"><img
						src="<spring:message code="static.application.name"/>/images/computer.jpg" class="main-image">
				</a>

					<div class="canvas-caption big dark" data-effect="left"
						data-move="50" style="left: 768px; top: 256px; opacity: 0;">Simple,</div>
					<div class="canvas-caption medium dark" data-effect="right"
						data-move="50" style="left: 778px; top: 299px; opacity: 0;">yet
						brilliant</div>

					<div class="canvas-caption image-link"
						style="right: 20px; bottom: 10px; opacity: 0;" data-effect="fade">
						<a href="http://photodune.net/item/computer/351817"
							target="_blank">Computer</a>
					</div></li>

				<li
					style="display: none;"><a
					href="http://codecanyon.net/user/evoslider" target="_blank"><img
						class="main-image" src="<spring:message code="static.application.name"/>/images/computer.jpg">
				</a>

					<div class="canvas-caption big dark"
						style="left: 102px; top: 299px; opacity: 0;" data-effect="left"
						data-move="50">Saves Development Time</div>
					<div class="canvas-caption big dark"
						style="left: 102px; top: 342px; opacity: 0;" data-effect="right"
						data-move="50">Free Support &amp; Upgrades</div>

					<div class="canvas-caption image-link"
						style="right: 20px; bottom: 10px; opacity: 0;" data-effect="fade">
						<a href="http://photodune.net/item/wind-power-generation-/1429537"
							target="_blank">Wind power generation</a>
					</div></li>

				<li 
					style="display: list-item; "><a
					href="http://codecanyon.net/user/evoslider" target="_blank"><img
						class="main-image" src="<spring:message code="static.application.name"/>/images/keyboard.jpg">
				</a>

					<div class="canvas-caption big dark"
						style="left: 50%; top: 10%; opacity: 0;" data-effect="left">Simple
						interfaces</div>
					<div class="canvas-caption medium dark"
						style="left: 60%; top: 20%; opacity: 0;" data-effect="right">with
						spicy code</div>

					<div class="canvas-caption image-link"
						style="right: 20px; bottom: 10px; opacity: 0;" data-effect="fade">
						<a
							href="http://photodune.net/item/workplace-room-with-computers/915001"
							target="_blank"> workplace room with computers </a>
					</div></li>

				<li 
					style="display: none;"><a
					href="http://codecanyon.net/user/evoslider" target="_blank"><img
						src="<spring:message code="static.application.name"/>/images/keyboard.jpg" class="main-image">
				</a>

					<div class="canvas-caption big dark"
						style="left: 70%; top: 70%; opacity: 0;" data-effect="down"
						data-move="30">bring UNIQUE</div>
					<div class="canvas-caption medium dark"
						style="left: 70%; top: 80%; opacity: 0;" data-effect="up"
						data-move="30">to your design!</div>

					<div class="canvas-caption image-link"
						style="right: 20px; bottom: 10px; opacity: 0;" data-effect="fade">
						<a href="http://photodune.net/item/social-network-concept/781882"
							target="_blank">Social Network Concept</a>
					</div></li>

				<li 
					style="display: none;"><a
					href="http://codecanyon.net/user/evoslider" target="_blank"><img
						src="<spring:message code="static.application.name"/>/images/apple-laptop.jpg" class="main-image">
				</a>

					<div class="canvas-caption big dark"
						style="left: 10%; top: 10%; opacity: 0;" data-effect="up"
						data-move="50">Be Successful</div>
					<div class="canvas-caption medium dark"
						style="left: 10%; top: 20%; opacity: 0;" data-effect="down"
						data-move="50">WITH US!</div>

					<div class="canvas-caption image-link"
						style="right: 20px; bottom: 10px; opacity: 0;" data-effect="fade">
						<a href="http://photodune.net/item/the-laptop-and-apple/1262956"
							target="_blank">Apple and Laptop</a>
					</div></li>

			</ul>
			
			<ul class="controlNav">
				<li><a href="http://1.s3.envato.com/files/36680856/index.html#"
					class="">1</a></li>
				<li><a href="http://1.s3.envato.com/files/36680856/index.html#"
					class="">2</a></li>
				<li><a href="http://1.s3.envato.com/files/36680856/index.html#"
					class="active">3</a></li>
				<li><a href="http://1.s3.envato.com/files/36680856/index.html#">4</a>
				</li>
				<li><a href="http://1.s3.envato.com/files/36680856/index.html#">5</a>
				</li>
			</ul>
			<a class="directionNav prev"
				href="http://1.s3.envato.com/files/36680856/index.html#">Prev</a><a
				class="directionNav next"
				href="http://1.s3.envato.com/files/36680856/index.html#">Next</a>
			<ul class="playButton">
				<li class="play" style="display: none;">play</li>
				<li class="pause" style="display: list-item;">stop</li>
			</ul>
		</div>

	</div>