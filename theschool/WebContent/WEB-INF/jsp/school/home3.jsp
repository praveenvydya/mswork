<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%-- <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.vydya.theschool.common.constants.TSConstants"%>
<%@ page import="com.vydya.theschool.web.constants.WebConstants"%>


<head>

<script type='text/javascript' src="<spring:message code="static.application.name"/>/javascript/gallery/shyni.min.js"></script>
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



jQuery(document).ready(function ($) {

	
	
				$("#eventTab").fineTabs({
					tabhead : 'h2',
					fx : "fadeIn",
					syncheights : true,
					saveState : true,
					clearfixClass : 'ym-clearfix',
					currentInfoText : ""

				});
				$(function(){
					$('#homepageBanners').shyni({
						loader: 'bar',
						pagination: false,
						commands	: false,
						thumbs		: false,
						navigation  : false,
						loader		: 'none'
					});
					
				});
				

				 var optionsx = {
			                $FillMode: 2,                                       //[Optional] The way to fill image in slide, 0 stretch, 1 contain (keep aspect ratio and put all inside slide), 2 cover (keep aspect ratio and cover whole slide), 4 actual size, 5 contain for large image, actual size for small image, default value is 0
			                $AutoPlay: true,                                    //[Optional] Whether to auto play, to enable slideshow, this option must be set to true, default value is false
			                $AutoPlayInterval: 4000,                            //[Optional] Interval (in milliseconds) to go for next slide since the previous stopped if the slider is auto playing, default value is 3000
			                $PauseOnHover: 1,                                   //[Optional] Whether to pause when mouse over if a slider is auto playing, 0 no pause, 1 pause for desktop, 2 pause for touch device, 3 pause for desktop and touch device, 4 freeze for desktop, 8 freeze for touch device, 12 freeze for desktop and touch device, default value is 1

			                $ArrowKeyNavigation: false,   			            //[Optional] Allows keyboard (arrow key) navigation or not, default value is false
			                $SlideEasing: $JssorEasing$.$EaseOutQuint,          //[Optional] Specifies easing for right to left animation, default value is $JssorEasing$.$EaseOutQuad
			                $SlideDuration: 1000,                               //[Optional] Specifies default duration (swipe) for slide in milliseconds, default value is 500
			                $MinDragOffsetToSlide: 20,                          //[Optional] Minimum drag offset to trigger slide , default value is 20
			                //$SlideWidth: 600,                                 //[Optional] Width of every slide in pixels, default value is width of 'slides' container
			               // $SlideHeight: 300,                                //[Optional] Height of every slide in pixels, default value is height of 'slides' container
			                $SlideSpacing: 0, 					                //[Optional] Space between each slide in pixels, default value is 0
			                $DisplayPieces: 1,                                  //[Optional] Number of pieces to display (the slideshow would be disabled if the value is set to greater than 1), the default value is 1
			                $ParkingPosition: 0,                                //[Optional] The offset position to park slide (this options applys only when slideshow disabled), default value is 0.
			                $UISearchMode: 1,                                   //[Optional] The way (0 parellel, 1 recursive, default value is 1) to search UI components (slides container, loading screen, navigator container, arrow navigator container, thumbnail navigator container etc).
			                $PlayOrientation: 1,                                //[Optional] Orientation to play slide (for auto play, navigation), 1 horizental, 2 vertical, 5 horizental reverse, 6 vertical reverse, default value is 1
			                $DragOrientation: 1,                                //[Optional] Orientation to drag slide, 0 no drag, 1 horizental, 2 vertical, 3 either, default value is 1 (Note that the $DragOrientation should be the same as $PlayOrientation when $DisplayPieces is greater than 1, or parking position is not 0)

			                
			                $BulletNavigatorOptions: {                          //[Optional] Options to specify and enable navigator or not
			                    $Class: $JssorBulletNavigator$,                 //[Required] Class to create navigator instance
			                    $ChanceToShow: 0,                               //[Required] 0 Never, 1 Mouse Over, 2 Always
			                    $AutoCenter: 1,                                 //[Optional] Auto center navigator in parent container, 0 None, 1 Horizontal, 2 Vertical, 3 Both, default value is 0
			                    $Steps: 1,                                      //[Optional] Steps to go for each navigation request, default value is 1
			                    $Lanes: 1,                                      //[Optional] Specify lanes to arrange items, default value is 1
			                    $SpacingX: 8,                                   //[Optional] Horizontal space between each item in pixel, default value is 0
			                    $SpacingY: 8,                                   //[Optional] Vertical space between each item in pixel, default value is 0
			                    $Orientation: 1                                 //[Optional] The orientation of the navigator, 1 horizontal, 2 vertical, default value is 1
			                },

			                $ArrowNavigatorOptions: {                           //[Optional] Options to specify and enable arrow navigator or not
			                    $Class: $JssorArrowNavigator$,                  //[Requried] Class to create arrow navigator instance
			                    $ChanceToShow: 1,                               //[Required] 0 Never, 1 Mouse Over, 2 Always
			                    $AutoCenter: 2,                                 //[Optional] Auto center arrows in parent container, 0 No, 1 Horizontal, 2 Vertical, 3 Both, default value is 0
			                    $Steps: 1                                       //[Optional] Steps to go for each navigation request, default value is 1
			                }
			            };

			            
			            var _CaptionTransitions = [];
			            _CaptionTransitions["L"] = { $Duration: 800, x: 0.6, $Easing: { $Left: $JssorEasing$.$EaseInOutSine }, $Opacity: 2 };
			            _CaptionTransitions["R"] = { $Duration: 800, x: -0.6, $Easing: { $Left: $JssorEasing$.$EaseInOutSine }, $Opacity: 2 };
			            _CaptionTransitions["T"] = { $Duration: 800, y: 0.6, $Easing: { $Top: $JssorEasing$.$EaseInOutSine }, $Opacity: 2 };
			            _CaptionTransitions["B"] = { $Duration: 800, y: -0.6, $Easing: { $Top: $JssorEasing$.$EaseInOutSine }, $Opacity: 2 };
			            _CaptionTransitions["TL"] = { $Duration: 800, x: 0.6, y: 0.6, $Easing: { $Left: $JssorEasing$.$EaseInOutSine, $Top: $JssorEasing$.$EaseInOutSine }, $Opacity: 2 };
			            _CaptionTransitions["TR"] = { $Duration: 800, x: -0.6, y: 0.6, $Easing: { $Left: $JssorEasing$.$EaseInOutSine, $Top: $JssorEasing$.$EaseInOutSine }, $Opacity: 2 };
			            _CaptionTransitions["BL"] = { $Duration: 800, x: 0.6, y: -0.6, $Easing: { $Left: $JssorEasing$.$EaseInOutSine, $Top: $JssorEasing$.$EaseInOutSine }, $Opacity: 2 };
			            _CaptionTransitions["BR"] = { $Duration: 800, x: -0.6, y: -0.6, $Easing: { $Left: $JssorEasing$.$EaseInOutSine, $Top: $JssorEasing$.$EaseInOutSine }, $Opacity: 2 };

			            _CaptionTransitions["WAVE|L"] = { $Duration: 1500, x: 0.6, y: 0.3, $Easing: { $Left: $JssorEasing$.$EaseLinear, $Top: $JssorEasing$.$EaseInWave }, $Opacity: 2, $Round: { $Top: 2.5} };
			            _CaptionTransitions["MCLIP|B"] = { $Duration: 600, $Clip: 8, $Move: true, $Easing: $JssorEasing$.$EaseOutExpo };

			            var optionsy = {
			                    $AutoPlay: true,                                    //[Optional] Whether to auto play, to enable slideshow, this option must be set to true, default value is false
			                    $DragOrientation: 3,                                //[Optional] Orientation to drag slide, 0 no drag, 1 horizental, 2 vertical, 3 either, default value is 1 (Note that the $DragOrientation should be the same as $PlayOrientation when $DisplayPieces is greater than 1, or parking position is not 0)
			                    $CaptionSliderOptions: {                            //[Optional] Options which specifies how to animate caption
			                        $Class: $JssorCaptionSlider$,                   //[Required] Class to create instance to animate caption
			                        $CaptionTransitions: _CaptionTransitions,       //[Required] An array of caption transitions to play caption, see caption transition section at jssor slideshow transition builder
			                        $PlayInMode: 1,                                 //[Optional] 0 None (no play), 1 Chain (goes after main slide), 3 Chain Flatten (goes after main slide and flatten all caption animations), default value is 1
			                        $PlayOutMode: 3                                 //[Optional] 0 None (no play), 1 Chain (goes before main slide), 3 Chain Flatten (goes before main slide and flatten all caption animations), default value is 1
			                    }
			                };
			            var jssor_slider1 = new $JssorSlider$("slider1_container", optionsx);
			            var jssor_slider2 = new $JssorSlider$("slider2_container", optionsy);
			            var jssor_slider3 = new $JssorSlider$("slider3_container", optionsy);
			            //responsive code begin
			            //you can remove responsive code if you don't want the slider scales while window resizes
			           /*  function ScaleSlider() {
			                var bodyWidth = document.body.clientWidth;
			                if (bodyWidth)
			                    jssor_slider1.$ScaleWidth(Math.min(bodyWidth, 1920));
			                else
			                    window.setTimeout(ScaleSlider, 30);
			            }
			 */
			           /*  ScaleSlider();

			             if (!navigator.userAgent.match(/(iPhone|iPod|iPad|BlackBerry|IEMobile)/)) {
			                $(window).bind('resize', ScaleSlider);
			            } */
			 
				
			});
</script>

<style>
.slides p {
	padding: 10px 20px;
	margin:0px;
	display: inline-table;
}

.updates-box {
	float: left;
	margin: 2px;
}

.jsslr {
	position: relative;
	/* margin: 0 auto; */
	top: 0px;
	left: 0px;
	width: 278px;
	height: 200px;
	overflow: hidden;
}

.jsslr .loading {
	position: absolute;
	top: 0px;
	left: 0px;
}

.jsslr .loading .ln {
	filter: alpha(opacity = 70);
	opacity: 0.7;
	position: absolute;
	display: block;
	top: 0px;
	left: 0px;
	width: 50%;
	height: 50%;
}


.jsslr .slides {
	/* position: absolute;
	left: 0px;
	top: 0px; */
	width: 278px;
	height: 160px;
	overflow: hidden;
	background-color: #F8FFC5;
}

.jsslr .head {
	/* position: absolute;
	left: 0px;
	top: 0px;
	width: 278px; */
	height: 40px;
	background-color: #A4F785;
}
.jsslr .head div{
	text-align: center;
	line-height: 40px;
	font-weight: bold;
}

.jsslr .sign {
	width: 278px;
	height: 40px;
	text-align: right;
	position: absolute;
	top: 120px;
	left: 0px color:  black;
	font-size: 16px;
	font-weight: bold;
	line-height: 40px;
}

.jsslr .sign div {
	margin-right: 10px;
	font-weight: bold;
}

.jsslr .slides .caption,.jsslr .slides .layer {
	position: absolute;
	top: 120px;
	left: 0px;
	width: 278px;
	height: 40px;
}
.jsslr .comment {
	font-size: 14px;
}
.jsslr .slides .caption .background,.jsslr .slides .layer .background {
	position: absolute;
	top: 0px;
	left: 0px;
	width: 278px;
	height: 40px;
}
.jsslr .slides .caption .background {
	background-color: Black;
	opacity: 0.5;
	filter: alpha(opacity = 50);
}

.jsslr .slides .layer .background{
	background-color: #FFF84F;
}

.jsslr .slides .layer .ttle {
	color:#707070 !important;
}

.jsslr .slides .caption .ttle,.jsslr .slides .layer .ttle {
	position: absolute;
	top: 0px;
	left: 0px;
	width: 278px;
	height: 40px;
	color: White;
	font-size: 14px;
	font-weight: normal;
	line-height: 40px;
	text-align: center;
}

.jsslr .slides  .jsslrimg{
	width: 278px;
	height: 120px !important;
}



.jsslr .evdatedisp{
	width: 50px;height:40px; float:left; background-color: #FFF84F; color:#123;
}
.jsslr .evdatedisp .mt{
	font-size: 13px;
font-weight: bold;
height: 10px;
margin-top: 2px;
line-height: 15px;
}

.jsslr .evdatedisp .dt{
	font-size: 20px;
font-weight: bold;
/* height: 24px; */
line-height: 30px;
}



</style>

<!--[if gte IE 9]>
  <style type="text/css">
    .gradient {
       filter: none;
    }
  </style>
<![endif]-->

</head>


<script type="text/javascript">
jQuery(document).ready(function ($) {
	
	var popupid = $("#homePopUp").attr("id");
	
	//if(null!=popupid){
		// $("#homePopUp").fancybox().trigger('click');
	//}
	  
	
	// $.fancybox.open('#id');
	 
	$("#homePopUp").fancybox({
		fitToView	: true,
		helpers : {
			overlay : {
				closeClick : false
			},
			 media: {},
	         buttons: {}
			
		},
		arrows:false,
		autoHeight : true,
		autoWidth  : true,
		autoSize	: true,
		openEffect	: 'none',
		nextClick  : false,
		closeEffect	: 'none',
		type: 'image', //image,swf,html,inline,iframe
  	  	swf: {
  	    	'wmode': 'transparent', 'allowfullscreen': 'true'
  	  		}
	}).trigger("click");;
});
</script>


<div class="full-page">
	<div class="page-banner">
		<div class="img-parent">
				<c:if test='${null!=homePageImagesList }'>
				<div class="shyni_wrap shyni_magenta_skin" id="homepageBanners">
					<c:forEach var="page" items="${homePageImagesList}">
							<div data-thumb="" data-src="${pageContext.request.contextPath}/static/simg-org/${page.imageName}" class="homeimg" >
		                        <div class="shyni_caption moveFromLeft">
		                        <span style="">${page.imageTitle}</span><br> ${page.description} (<a href="#" >link</a>)
		                        </div>
	                        </div>
                 	 </c:forEach>
                 	 </div>
                 </c:if>
		</div>
	</div>
	
            
	<div class="full-content">
		
		<div id="cnt1">
		<div class="home-content-desc1">
			<div class="box">
				<h4 class="ui-borderBottom pbs mbs">Welcome To My School</h4>
				<div class="">
					
					<p>Heralding a unique revolution in New Age Technology, school has now transformed the very basis of how education is imparted in a class. Carrying forward its belief that everyone has a right to affordable quality education, the Kakathiya Group now opens up a new dimension in learning with Digital Classrooms that change the way teachers teach and students learn.</P>

<p>The platform of Multimedia now adds life and a brand new meaning to the way a lesson is taught and understood. The visual impact not only aids perception and better memory retention, it also gains the complete attention of every single student in class. This concept is poised to inspire and make education an unforgettable journey.</P>

<p>Innovative in approach and inspiring in more ways than one, the Vydya  School now turns learning into an unforgettable experience. This new concept adds a new dimension to the traditional text book and blackboard method of teaching.<P>
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
	
	
	<div id="slider1_container" style="" class="updates-box jsslr">
        <div u="loading" class="loading">
            <div class="ln">
            </div>
            <div class="limg">
            </div>
        </div>
         <div class="head"> <div>Testimonials</div></div>
        <div class="slides" u="slides" >
            <div>
               <div class="comment"><p><i>I must take time out to express my sincere gratitude to each one of you for enhancing my life and the life of my daughter...</i></p>
                     </div>
                     <div class="sign">
                       <span><div >Sharmila Devi</div></span> 
                    </div> 
            </div>
            <div>
                  <div class="comment"><p><i>It is a pleasure to work with the school personnel, it is problem-free, and the students get exactly what they need.</i></p> 
                     </div>
                     <div class="sign">
                       <span><div >Aravind Rao</div></span> 
                    </div> 
            </div>
            <div>
                 <div class="comment"><p><i>Safe, caring and family like all in a highly educational setting and attractive setting.</i></p>
                     </div>
                     <div class="sign">
                       <span><div ">Chakravarthi P.S</div></span> 
                    </div> 
            </div>
            <div>
                 <div class="comment"><p><i> Your child be welcomed with open arms. The opportunities are numerous and always positive.</i></p>
                     </div>
                     <div class="sign">
                       <span><div ">Narendar Singh</div></span> 
                    </div> 
            </div>
            
           
        </div>
        <div u="navigator" class="jssorb21" style="position: absolute; bottom: 26px; left: 6px;">
            <div u="prototype" style="POSITION: absolute; WIDTH: 19px; HEIGHT: 19px; text-align:center; line-height:19px; color:White; font-size:12px;"></div>
        </div>
     </div>  
     
     
      
 <div id="slider2_container" class="updates-box jsslr">
         <div u="loading" class="loading">
            <div class="ln">
            </div>
            <div class="limg">
            </div>
        </div>
         <div class="head"> <div>Gallery</div></div>
        <div class="slides" u="slides" >
        
        		<c:if test='${null!=glist }'>
					<c:forEach var="g" items="${glist}">
					<div>
		                <img u="image" src="${pageContext.request.contextPath}/static/simg-fit/262x140/${g.url}" />
		                <div u="caption" t="B" class="caption">
		                    <div class="background">
		                    </div>
		                    <div class="ttle">
		                        ${g.name}
		                    </div>
		                </div>
		            </div>
                 	 </c:forEach>
                 </c:if>
        </div>
     </div> 
            
     <div id="slider3_container" class="updates-box jsslr">
         <div u="loading" class="loading">
            <div class="ln">
            </div>
            <div class="limg">
            </div>
        </div>
         <div class="head"> <div>Upcoming Events</div></div>
        <div class="slides" u="slides" >
        	<c:if test='${null!=elist }'>
					<c:forEach var="e" items="${elist}">
						<div>
			                <img u="image" src="${pageContext.request.contextPath}/static/simg-fit/352x140/${e.url}" class="jsslrimg"/>
			                <div  class="caption">
			                    <div class="background">
			                    </div>
			                    <div class="ttle">
			                       <div class="evdatedisp">
			                       	<div class="mt">${e.content2}</div><div class="dt">${e.content1}</div>
			                       </div> ${e.name} 
			                    </div>
			                </div>
			            </div>
                 	 </c:forEach>
                 </c:if>

        </div>
     </div> 
     
     
</div>


<c:if test='${null!=sessionScope.popuphome }'>
	<c:choose>
			<c:when test="${empty sessionScope.popuphome}">
				
			</c:when>
			<c:otherwise>
				<div> <a id="homePopUp" class="" 
			title=""
			
			href="${sessionScope.popuphome}"
			rel=""></a></div>
			</c:otherwise>
	</c:choose>
</c:if>
<c:remove var="popuphome" scope="session" />
 <!-- <div> <a id="homePopUp" class="" 
			title=""
			
			href="http://www.youtube.com/embed/KPlu_9SapKQ?rel=0"
			rel=""></a></div>  -->
     <!-- href="http://www.youtube.com/v/KPlu_9SapKQ?fs=1&autoplay=0" -->   
</div>