 <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld" %>
<%@ page import="com.vydya.theschool.common.constants.TSConstants"%>
<%@ page import="com.vydya.theschool.web.constants.WebConstants"%>

<%-- <div class="megamenu_wrapper">
<span class="logo"><img src="<spring:message code="static.application.name"/>/images/kakathiya_logo.png"
							style="width: 220px;height: 55px;" /></span> 
	
 </div>  --%>
 
 <div class="social-icons-sidebar" style="">
<a class="social-icon social-facebook" target="_blank" href="http://www.facebook.com/sharer.php?u=http://praveenvydya.in" title="share on Facebook"></a>
<a class="social-icon social-twitter" target="_blank" href="http://twitter.com/share?url=http://praveenvydya.in&amp;text=jQuery%20Image%20Slider/Slideshow/Carousel/Gallery/Banner%20javascript+html%20TOUCH%20SWIPE%20Responsive" title="share on Twitter"></a>
<a class="social-icon social-googleplus" target="_blank" href="https://plus.google.com/share?url=http://praveenvydya.in" title="share on Google Plus"></a>
<a class="social-icon social-linkedin" target="_blank" href="http://www.linkedin.com/shareArticle?mini=true&amp;url=http://praveenvydya.in" title="share on LinkedIn"></a>
<a class="social-icon social-stumbleupon" target="_blank" href="http://www.stumbleupon.com/submit?url=http://praveenvydya.in&amp;title=jQuery%20Image%20Slider/Slideshow/Carousel/Gallery/Banner%20javascript+html%20TOUCH%20SWIPE%20Responsive" title="share on StumbleUpon"></a>
<a class="social-icon social-pinterest" target="_blank" href="http://pinterest.com/pin/create/button/?url=http://praveenvydya.in&amp;media=http://praveenvydya.in/img/site/jssor.slider.jpg&amp;description=jQuery%20Image%20Slider/Slideshow/Carousel/Gallery/Banner%20javascript+html%20TOUCH%20SWIPE%20Responsive" title="share on Pinterst"></a>
<a class="social-icon social-email" target="_blank" href="mailto:?Subject=Jssor%20Slider&amp;Body=Highly%20recommended%20jQuery%20Image%20Slider/Slideshow/Carousel/Gallery/Banner%20javascript+html%20TOUCH%20SWIPE%20Responsive%20http://praveenvydya.in" title="share by Email"></a>
</div>

<c:set var="website"><spring:message code="application.name"/></c:set>
<input id="website" type="hidden" value="${website}"/>