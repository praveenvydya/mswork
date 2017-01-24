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

$("a[rel=galleryImage_group]").fancybox({
						'transitionIn' : 'elastic',
						'transitionOut' : 'elastic',
						'titlePosition' : 'over',
						'overlayColor' : '#000',
						'overlayShow' : true,
						'hideOnOverlayClick' : false,
						'overlayOpacity' : 0.5,
						/* 'onStart' : function() {
						}, */
						'titleFormat' : function(
								title,
								currentArray,
								currentIndex,
								currentOpts) {
							return '<span id="fancybox-title-over"><span class="imageDesc">'
									+ (title.length ? ' &nbsp; '
											+ title
											: '')
									+ '</span><span class="imageIndex"> Image:'
									+ (currentIndex + 1)
									+ ' / '
									+ currentArray.length
									+ '</span>';
						}
					});

					$('#scrollboxDiv').finescroll({
					    verticalTrackClass: 'track',
					    verticalHandleClass: 'handle',
					    minScrollbarLength: 15,
					    showOnHover : false
					});
					});
</script>
<style>
.forImage {
	display: none;
	position: absolute;
}

.link:hover {
	text-decoration: none;
}

div.galleryImages a disabledImage {
	z-index: 100;
	opacity: 0.5;
}

.imageCk {
	float: none;
	height: 115px;
	margin: 4px;
	position: inherit;
	width: 188px;
}

.link {
	display: inline;
}

h1 {
	font-family: Arial;
	font-size: 30px;
	font-weight: bold;
	margin: 10px 0 5px;
}

.img-parent img {
	width: 100%;
	  max-height:318px;
}

.img-parent {
	float: right;
	overflow: hidden;
	border: 1px solid #BBBBBB;
	padding: 2px;
	margin: 5px 0px;
	width:720px;
	/* max-height: 150px;
    max-width: 200px; */
  
}

.div-parent {
	padding: 0px;
	margin: 5px 2px;
	float: right;
	/* max-height: 400px; */
	max-width: 100%;
	height: 318px;
}

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

h1 .plcDt {
	font-size: 12px;
	float: right;
}

#scrollboxDiv {
    overflow: auto;
    width: 272px;
    height: 350px;
    padding: 0 5px;
    margin: 5px 0px;
   /*  border: 1px solid #b7b7b7; */
    
}

.track {
    width: 10px;
    background-clip: padding-box;
    background: #fff;
    border-style: solid;
    border-color: transparent;
    border-width: 0;
    border-left-width: 1px;
}

.track.dragging,
.track:hover {
    background: #f2f2f2; /* No RGBA support */
    background: rgba(0, 0, 0, 0.05);
    -webkit-box-shadow: inset 1px 0 0 rgba(0, 0, 0, 0.1);
    box-shadow: inset 1px 0 0 rgba(0, 0, 0, 0.1);
}
.finescroll-track{
	height: 360px;
}
.finescroll-track a.handle{
	height: 200px;
}
.track:active {
    background: #f2f2f2; /* No RGBA support */
    background: rgba(0, 0, 0, 0.05);
    -webkit-box-shadow: inset 1px 0 0 rgba(0, 0, 0, 0.14),
                        inset -1px -1px 0 rgba(0, 0, 0, 0.07);
    box-shadow: inset 1px 0 0 rgba(0, 0, 0, 0.14),
                inset -1px -1px 0 rgba(0, 0, 0, 0.07);
}

.handle {
    width: 10px;
    background-clip: padding-box;
    background: #c2d6ff; /* ccc No RGBA support */
   /*  background: rgba(0, 0, 0, 0.2); */
    -webkit-box-shadow: inset 1px 1px 0 rgba(0, 0, 0, 0.1),
                        inset 0 -1px 0 rgba(0, 0, 0, 0.07);
    box-shadow: inset 1px 1px 0 rgba(0, 0, 0, 0.1),
                inset 0 -1px 0 rgba(0, 0, 0, 0.07);
   border-radius:7px;
}

.handle:hover {
    background: #a0c5fb; /*999 75ACFF No RGBA support */
   /*  background: rgba(0, 0, 0, 0.4); */
    -webkit-box-shadow: inset 1px 1px 1px rgba(0, 0, 0, 0.25);
    box-shadow: inset 1px 1px 1px rgba(0, 0, 0, 0.25);
}

.dragging .handle,
.handle:active {
background:#75ACFF;

/* 
    background: gray; /* No RGBA support */
  /*   background: rgba(0, 0, 0, 0.5); */ 
    
    -webkit-box-shadow: inset 1px 1px 3px rgba(0, 0, 0, 0.35);
    box-shadow: inset 1px 1px 3px rgba(0, 0, 0, 0.35);
}
.scrollbox .item{
	clear:both;
	margin: 0px 0;
    padding: 4px 0;
	display: inline-block;
	border-bottom:1px solid #fff;
	background-color: #eaeff9/* #ecf4fa */;
	
}
.scrollbox .item .imdiv{
	padding: 1px;
	margin: 1px;
	width: 82px;
	height: 54px;
	background-color: #5e90ec;
}
.scrollbox .item .tlebx{
	padding: 1px;
	margin: 1px;
	width: 165px;
	height: 53px;
}
.scrollbox .item .tlebx a{
font-family: 'lucida grande',tahoma,verdana,arial,sans-serif;
font-size: 11px;
color: #3B5998;
font-weight: bold;
text-decoration: none;
}

.scrollbox .item div{
	float: left;
}
.scrollbox .item:hover{
	 /* box-shadow:0 1px 5px 0 #bcbcbc;
	background-color: #e8f3fa;  */
	/* border:1px solid #cde7fa; */
}

</style>

	<h2 class="pagehead">${gallery.title}</h2>
	<h4 class="pagetext">${gallery.eventDesc}</h4>
	<h4 class="pageSubtext"><span>${gallery.eventPlace}</span><span>${gallery.eventDate}</span></h4>
	<div class="img-parent">
			<img src="/theschool/gallery?id=${gallery.id}" />
	</div>
		
		
<%-- <div>
	<div class="div-parent">
		<div class="img-parent">
			<img src="/theschool/gallery?id=${gallery.id}" />
		</div>
		<div class="img-evnt-desc">
			<h1>
				<span class="name">${gallery.name}</span> <span class="plcDt"><span
					class="plc">${gallery.eventPlace}</span><br> <span class="dt">${gallery.eventDate}</span>
				</span>
			</h1>

			<p>${gallery.eventDesc}</p>

		</div>
	</div>
</div> --%>
<div>
	
		<div class="forImages">
			<div class="galleryImages">
				<c:if test='${null!=galleryImageList }'>
					<c:forEach var="galleryImage" items="${galleryImageList}"
						varStatus="imageStatus">
						<div class="galleryImage">
							<a id="evntImg_${galleryImage.id}"
								title="${galleryImage.description}"
								href="${pageContext.request.contextPath}/galleryImage/${galleryImage.imageName}"
								rel="galleryImage_group"> <input type="image"
								src="/theschool/galleryImage/thumb_${galleryImage.imageName}"
								alt="${galleryImage.imageName}" /> </a>
						</div>
					</c:forEach>
				</c:if>
			</div>
		</div>
		<div style="clear: both;"></div>
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


