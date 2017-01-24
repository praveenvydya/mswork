<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%-- <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.vydya.theschool.common.constants.TSConstants"%>
<%@ page import="com.vydya.theschool.web.constants.WebConstants"%>

<link href="<spring:message code="static.application.name"/>/css/gallery/touch-gallery.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/gallery/jquery-touch-gallery.js"></script>

<script type="text/javascript">

//(function(a){(jQuery.browser=jQuery.browser||{}).mobile=/(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows ce|xda|xiino/i.test(a)||/1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i.test(a.substr(0,4))})(navigator.userAgent||navigator.vendor||window.opera);

	$(document).ready(function() {
		var smartPhone = /ipad|iphone|ipod|android|bada|iemobile|mobile.+firefox|windows phone/i.test(navigator.userAgent.toLowerCase());
		if (smartPhone)
		{
			$("#mobilegallery").show();
			 //$import('${pageContext.servletContext.contextPath}/javascript/gallery/jquery-touch-gallery.js');
			$.extend(blueimp.Gallery.prototype.options, {
            	container:"#blueimp-galleryx",
                useBootstrapModal: false,
                hidePageScrollbars: false
                
            });
			$("#browsergallery").hide();
			
		}
		else{
			$("#mobilegallery").hide();
			$("a[rel=galleryImage_group]").fancybox({
				
				prevEffect : 'fade',
				nextEffect : 'fade',
				openEffect:'elastic',
				closeEffect:'elastic',
				helpers : {
					/* thumbs : {
						width  : 50,
						height : 50
					}, */
					overlay : {
						closeClick : false
					}
				}
			});
		}
		
		
		$("a[rel=galleryVideo_group]").fancybox({
			
			fitToView	: true,
			helpers : {
				overlay : {
					closeClick : false
				}
			},
			arrows:false,
      	  title: this.title,
			autoSize	: true,
			openEffect	: 'elastic',
			nextClick  : false,
			closeEffect	: 'elastic',
			type: 'swf',
      	  swf: {
      	    'wmode': 'transparent',
      	    'allowfullscreen': 'true'
      	  }
		});

						/* 'onStart' : function() {
						}, */
						/* 'titleFormat' : function(
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
						} */

					/* $('#scrollboxDiv').finescroll({
					    verticalTrackClass: 'track',
					    verticalHandleClass: 'handle',
					    minScrollbarLength: 15,
					    showOnHover : false
					}); */
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
/* .widget-title{
padding: 8px 8px 8px 0px !important;
margin-bottom: 5px;
font-size: 16px !important;
font-weight: normal !important;
margin: 5px!important;
}
 */
</style>

	<div class="full-page">
	<div class="page-banner">
		<div class="img-parent">
				<img src="${pageContext.request.contextPath}/static/simg-org/${gallery.imageName}" />
		</div>
	</div>
	<%-- <h2 class="pagehead" >${gallery.title}</h2>
	<h4 class="pagetext">${gallery.eventDesc}</h4>
	<h4 class="pageSubtext"><span style="float: left;">Place: ${gallery.eventPlace}</span><span style="float: right;">Date:${gallery.eventDate}</span></h4>	
	 --%>
	<div class="full-content">
     <div class="blockquote" > 
		<div>
			
                    <h2>${gallery.title}</h2>
                    <small>${gallery.eventDesc}</small>
               
		</div>
		
	</div> 
	
	<div id="browsergallery">
		<div class="forImages">
			<div class="galleryImages">
				<c:if test='${null!=galleryImageList }'>
					<c:forEach var="galleryImage" items="${galleryImageList}"
						varStatus="imageStatus">
							<a id="evntImg_${galleryImage.id}" class="galimg"
								title="${galleryImage.description}"
								href="${pageContext.request.contextPath}/static/simg-org/${galleryImage.imageName}"
								rel="galleryImage_group"> 
							<img src="${pageContext.request.contextPath}/static/simg-fit/203x137/${galleryImage.imageName}" class="glthumb"
								alt="${galleryImage.imageName}" /> </a>
					</c:forEach>
				</c:if>
			</div>
		</div>
		<div style="clear: both;"></div>
	</div>
	
	
	
	<div id="mobilegallery" style="display: none">
		<div class="forImages">
			<div class="galleryImages gallery-container">
				<c:if test='${null!=galleryImageList }'>
					<c:forEach var="galleryImage" items="${galleryImageList}"
						varStatus="imageStatus">
						<div class="col-lg-2 col-md-2 col-xs-6 col-center galimg">
							<a id="evntImg_${galleryImage.id}"data-gallery=""
								title="${galleryImage.description}"
								href="${pageContext.request.contextPath}/static/simg-org/${galleryImage.imageName}"
								rel="galleryImage_group"> 
							<img src="${pageContext.request.contextPath}/static/simg-fit/203x137/${galleryImage.imageName}" class="glthumb"
								alt="${galleryImage.imageName}" /> </a>
							</div>
					</c:forEach>
				</c:if>
			</div>
		</div>
		<div style="clear: both;"></div>
	</div>
					
	
	
	<c:if test='${null!=galleryVideosList }'>
	<c:choose>
		<c:when test="${empty galleryVideosList}">

		</c:when>
		<c:otherwise>
						
						
	<h4 class="widget-title"><span>VIDEOS</span></h4>
	<div>
		<div class="forImages">
			<div class="galleryImages">
				
					<c:forEach var="galleryVideo" items="${galleryVideosList}"
						varStatus="videoStatus">
						<div class="col-lg-2 col-md-2 col-xs-6 col-center galvideo">
							<a id="evntVid_${galleryVideo.id}" class="vcontainer" 
								title="${galleryVideo.videoName}"
								href="http://www.youtube.com/v/${galleryVideo.vid}?fs=1&autoplay=1"
								rel="galleryVideo_group"> 
							<img src="http://img.youtube.com/vi/${galleryVideo.vid}/0.jpg" class="vthumb"
								alt="" /> 
								<div class="vplay"></div>
								</a>
							</div>
					</c:forEach>
				
			</div>
		</div>
		<div style="clear: both;"></div>
	</div>
	
	</c:otherwise>
	</c:choose>
	</c:if>
					<!-- <div class="galleryImages">
							<a id="" class="vcontainer"
								title="The Falltape"
								href="http://www.youtube.com/v/ZeStnz5c2GI?fs=1&autoplay=1"
								rel="galleryVideo_group"> 
							<img src="http://img.youtube.com/vi/ZeStnz5c2GI/0.jpg" class="vthumb"
								alt="" /> 
								<div class="vplay"></div>
								</a>
							<a id="" class="vcontainer"
								title="The Falltape"
								href="http://www.youtube.com/v/6svWrN52Eug?fs=1&autoplay=1"
								rel="galleryVideo_group"> 
							<img src="http://img.youtube.com/vi/6svWrN52Eug/0.jpg" class="vthumb"
								alt="" /> 
								<div class="vplay"></div>
								</a>
								
					</div> -->
	
	<!-- <a class="various fancybox.iframe" title="The Falltape"
					href="http://www.youtube.com/v/ZeStnz5c2GI?fs=1&autoplay=1"><img
					src="http://img.youtube.com/vi/ZeStnz5c2GI/1.jpg">
				</a> <a class="various fancybox.iframe" title="The Barn"
					href="http://www.youtube.com/v/uQ91AxUqHck?fs=1&autoplay=1"><img
					src="http://img.youtube.com/vi/uQ91AxUqHck/1.jpg">
				</a> -->
	
	
	</div>
</div>



	<div style="display: none;" id="blueimp-galleryx" class="blueimp-gallery blueimp-gallery-controls">
            <div style="width: 40470px;" class="slides"></div>
            <h3 class="title"></h3>
            <a class="prev"><!-- â¹ --></a>
            <a class="next"><!-- âº --></a>
            <a class="close"><!-- Ã --></a>
            <a class="play-pause"></a>
            <ol class="indicator"></ol>
            <div class="modal fade">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" aria-hidden="true">Ã</button>
                            <h4 class="modal-title"></h4>
                        </div>
                        <div class="modal-body next"></div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default pull-left prev">
                                <i class="glyphicon glyphicon-chevron-left"></i>
                                Previous
                            </button>
                            <button type="button" class="btn btn-primary next">
                                Next
                                <i class="glyphicon glyphicon-chevron-right"></i>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>


