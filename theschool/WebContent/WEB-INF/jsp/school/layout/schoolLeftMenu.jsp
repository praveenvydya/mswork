<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%-- <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> --%>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld" %>
<%@ page import="com.vydya.theschool.common.constants.TSConstants"%>
<%@ page import="com.vydya.theschool.web.constants.WebConstants"%>	

<%-- <script type="text/javascript" src="${pageContext.servletContext.contextPath}/javascript/jquery.finescroll.min.js"></script> --%>
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/columnslider.js"></script>
<style>
<!--

-->
#menu-items li{
padding-left: 10px;
}
#menuSlider {
width: 100%;
}

.lfcolumnslider{
	position: relative; /*leave as is*/
	overflow: hidden;
	border-bottom-width: 0px;
	width: 262px; /*width of featured content slider*/
	height: 140px;
	
}



.lfcolumnslider .contentdiv{
	visibility: hidden; /*leave as is*/
	position: absolute; /*leave as is*/
	left: 0;  /*leave as is*/
	top: 0;
	background: white;
	width: 262px; /*width of content DIVs within slider. Total width should equal slider's inner width (390+5+5=400) */
	

filter:progid:DXImageTransform.Microsoft.alpha(opacity=100);
	-moz-opacity: 1;
	opacity: 1;
}

.lfcpagination{
	/* width: 230px; */ /*Width of pagination DIV. Total width should equal slider's outer width (400+10+10=420)*/
	text-align: center;
	padding-top: 5px;
	padding-right: 5px;
	padding-bottom: 5px;
	padding-left: 5px;
	position:relative;
	z-index:20;
	/* top:-21px; */
	font-family: "Lucida Sans Unicode","Lucida Grande",sans-serif;
    font-size: 9px;
}

.lfcpagination a{
	text-decoration: none;
	background-color: #EAEAEA;
    background-image: linear-gradient(#FAFAFA, #EAEAEA);
    background-repeat: repeat-x;
    border-color: #DDDDDD #DDDDDD #C5C5C5;
    border-image: none;
    border-radius: 0 !important;
    border-style: solid;
    border-width: 1px;
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
    color: #333333;
    height: 7px !important;
    margin: 2px !important;
    width: 7px !important;
    text-indent: -1000px;
    float: left;
    opacity:0.8;
}

.lfcpagination a:hover, .lfcpagination a.selected{
	
	  background-color: #60B044;
    background-image: linear-gradient(#8ADD6D, #60B044);
    background-repeat: repeat-x;
    border-color: #5CA941;
    border-radius: 0 !important;
    color: #FFFFFF;
    text-shadow: 0 -1px 0 rgba(0, 0, 0, 0.25);
    opacity:1;
}

.lfTb{
/* height: auto; */
margin-bottom: 5px;
border: 1px solid #eeeeee;
}



</style>
<script type="text/javascript">
	$(document).ready(
			function() {

		function loadLeftMenuData(){
				$.getJSON('<spring:message code="application.name"/>/home/leftmenu', function(data) {displayLeftMenu(data);});
			 }
			
			
			$('.lfcolumnslider').each(function(){
				featuredcontentslider.init({
					id : $(this).attr("id"),
					contentsource : [ "inline", "" ],
					toc : "#increment",
					nextprev : [ "", "" ],
					revealtype : "click",
					enablefade : [ true, 0.2 ],
					autorotate : [ true, 3000 ],
					onChange : function(previndex, curindex) { 
					}
				});
			});
			
			$('.scroll-text').scrolldiv({
				  linear: true,
				  step: 1,
				  delay: 0,
				  speed: 100
				});
	});
</script>


<div class="advt1 d" style="height: 300px;" id="leftnavigation">
		<h6 class="ui-borderBottom">MAIN MENU</h6>
		<div style="overflow:hidden;margin: 5px;height: auto; width: autp">
			  <div id="" class="menuboard">
				  <ul id="" class="" style="margin-top: 0;">
				  	<li class="">
						<a href="${pageContext.servletContext.contextPath}/home"><span class="icon-home"></span>Home</a>	
					</li>
					<li class="">
						<a href="${pageContext.servletContext.contextPath}/gallery"><span class="icon-pictures2"></span>Gallery</a>	
					</li>
					<li class="">
						<a href="${pageContext.servletContext.contextPath}/toppers"><span class="icon-medal2"></span>Toppers</a>	
					</li>
					<li class="">
						<a href="${pageContext.servletContext.contextPath}/news"><span class="icon-uniE74F" ></span>News</a>	
					</li>
					<li class="">
						<a href="${pageContext.servletContext.contextPath}/library"><span class="icon-uniE758" ></span>Library</a>	
					</li>
					<li class="">
						<a href="${pageContext.servletContext.contextPath}/notifications"><span class="icon-file3" ></span>Notifications</a>	
					</li>
					<li class="">
						<a href="${pageContext.servletContext.contextPath}/events"><span class="icon-uniE772" ></span>Events</a>	
					</li>
					<li class="">
						<a href="${pageContext.servletContext.contextPath}/contactus"><span class="icon-profile" ></span>Contact</a>	
					</li>
				</ul>
			  </div>
		</div>
		</div>


<c:if test='${null!=newslist }'>

<div class="advt1 d">
		<h6 class="ui-borderBottom">&nbsp;NEWS</h6>
		<div style="overflow:hidden;margin: 5px;height: auto; width: auto">
			  <div id="" class="newsboard scroll-text">
			  
			      <ul>
			      <c:forEach var="news" items="${newslist}" varStatus="cin">
			        <li id=""><!-- » --><span class="icon-grid2" ></span>&nbsp;<a href="${pageContext.request.contextPath}/news/${news.type}/${news.url}" >${news.name}.</a></li>
			        </c:forEach>
			        </ul>
			       </div>
		</div>
		</div>
	</c:if>
		
 <c:if test='${null!=leftContentList }'>
	<c:forEach var="content" items="${leftContentList}" varStatus="cin">
	<c:choose>
	<c:when test="${'TOPPERS' eq content.type}">
		<div class="advt1 d">
		<h6 class="ui-borderBottom lfhlink"><a href="${pageContext.request.contextPath}/toppers/${content.url}">${content.name}</a></h6>
		<div style="overflow:hidden;margin: 5px;height: auto;">
		<div style=""><img class="lfTb" src="${pageContext.request.contextPath}/static/simg-fit/262x140/${content.image1}"/></div>
		<c:forEach var="element" items="${content.elementsList}">
			<div class="lfm-topers">
				<c:choose>
					<c:when test="${null ne element.description}">
						<div class="std-img-div">
							<img class="lm-st-thmb" src="${pageContext.request.contextPath}/static/simg-fit/96x120/${element.description}" />
						</div>
					</c:when>
					<c:otherwise>
					<div class="std-img-div">
						<img class="lm-st-thmb" src="<spring:message code="static.application.name"/>/images/student_m.png" />
						</div>
					</c:otherwise>
				</c:choose>

				<div class="name-div">
					${element.name}
				</div>
				
				
				<div class="name-div">
					${element.content1}
				</div>
			</div>
		</c:forEach>
		</div>
		</div>
	</c:when>
		<c:when test="${'GALLERY' eq content.type}">
		<div class="awardglryx d">
			<h6 class="ui-borderBottom lfhlink"><a href="${pageContext.request.contextPath}/gallery/${content.url}">${content.name}</a></h6>
			<div style="overflow:hidden;margin: 5px;height: auto "> 
			
			<div class="lfcolumnslider" id="ccsl-${cin.index}">
				<c:if test='${null!=content.elementsList }'>
					<c:forEach var="element" items="${content.elementsList}">
                            <div class="contentdiv" ><a href="${pageContext.request.contextPath}/gallery/${content.url}">
						        <img src="${pageContext.request.contextPath}/context/images/${element.url}"> </a></div>
                    </c:forEach>
                 </c:if>
            </div>
            <div class="lfcpagination">
				<div id="paginate-ccsl-${cin.index}" style="float:right"></div>  
	 		</div>
		</div>
		</div>
	</c:when>
	<c:when test="${'NOTIFICATIONS' eq content.type}">
		<div class="notification1 d">
			<h6 class="ui-borderBottom">NOTICE</h6>
			<div><a href="${pageContext.request.contextPath}/notification/${content.url}" target="_blank">${content.name} <div class="fileIcon"><span class="fileType ${content.dataType}f"></span></div></a></div>
				<div>
					<c:out value='${content.description}'/>
				</div>
		</div>
		
		
	</c:when>
	</c:choose>
	
	</c:forEach>
</c:if>	
			


<!-- <div class="fbbox d">
	<iframe
		src="//www.facebook.com/plugins/likebox.php?href=https%3A%2F%2Fwww.facebook.com%2FFacebookDevelopers&amp;width=220&amp;height=400&amp;show_faces=true&amp;colorscheme=light&amp;stream=false&amp;show_border=true&amp;header=true"
		scrolling="no" frameborder="0"
		style="border: none; overflow: hidden; width: 220px; height: 400px;"
		allowTransparency="true"></iframe>
</div> -->
