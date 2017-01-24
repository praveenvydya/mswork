<%-- <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld" %>
<%@ page import="com.vydya.theschool.common.constants.TSConstants"%>
<%@ page import="com.vydya.theschool.web.constants.WebConstants"%>	
 --%>
<style>



.right-sidebar .content-fragment.with-header .content-fragment-header {
	border: medium none;
}

.layout-content.content-left-sidebar-right .right-sidebar .content-fragment-header
	{
	background: none repeat scroll 0 center rgba(0, 0, 0, 0);
	padding-left: 0;
}

.content-fragment.with-header .content-fragment-header div,.layout-content.content-left-sidebar-right .right-sidebar .content-fragment-header div,h2
	{
	color: #999999;
}

.right-sidebar .content-fragment-header div {
	background: none repeat scroll 0 center rgba(0, 0, 0, 0);
	font-size: 165%;
	height: auto;
	margin: 5px 0 3px;
	padding: inherit;
}

.content-list {
	list-style: none outside none;
	margin: 0;
	padding: 0;
}

.content-list .content-item {
	border-bottom: 1px dotted #CCCCCC;
	margin: 0;
	padding: 0.25em 0;
	border-bottom: 0 none;
	list-style: none;
}

.content-list .content-item a {
font-size: 13px;
}

.user-defined-markup {
	max-width: 100%;
	overflow: hidden;
	position: relative;
}

.content-fragment-content ul {
	padding: 1px 0 1px 5px;
}

.content-fragment-content{
	padding: 0px;
}
.content-fragment{
	padding: 10px 3px 3px 3px;
}


.cont-name{
	font-weight: 100;
	margin: 7px 0 10px;
	padding: 0;
}

.content-fragment.blog-post .full-post .post-author,.content-fragment.blog-post .full-post .post-date,.content-fragment.blog-post-msdn-technet .full-post .post-author,.content-fragment.blog-post .full-post .post-date
	{
	color: #666666;
	display: inline;
	font-size: 12px;
	font-weight: bold;
	padding: 6px 0;
	position: relative;
}


/* in the nEWS  */
div.rightRail {
border-left: 2px solid #08B0F1;
padding-left: 8px;
margin-top: 10px;
}

div.genericListItem {
	overflow: hidden;
}

div.genericListItem_marginBottom5 {
	margin-bottom: 5px;
}

.glControlTitle {
	clear: left;
	line-height: 20px;
	padding-left: 0px;
}
.rn-content-fragment-list p{
	line-height: 16px;
}
.prHeader {
	color: #4F4F4F;
	font-family: 'segoe UI';
	font-size: 20px;
	font-weight: 100;
}


.gyText9 {
	color: #0060A6 !important;
	font-family: 'Segoe UI';
	font-size: 12px;
	font-weight: normal !important;
}

.gyText1 {
	color: #999999 !important;
	font-family: 'Segoe UI';
	font-size: 12px;
}


/* CONTENT LIST  */

div.genericListItem {
    overflow: hidden;
}
div.genericListItem_marginBottom25 {
    margin-bottom: 25px;
}
.genericListItem div p {
    margin-bottom: 2px;
    padding: 0 !important;
}
.news-contents p.nHeader a {
    font-size: 14px;
    font-weight: normal;
}

.news-contents p.nHeader a:hover{
color:#00749E;
text-decoration: underline;
}

p.smHeader a:hover{
	text-decoration: underline;
}

.content-tilte-h{
	font-size: 16px;
	font-weight: bold;
	padding: 5px 0;
} 

.nw-content:hover{
	/*  background-color: #F9F9F9;
   border: 1px solid #E4E3E1; 
    box-shadow: 0 1px 4px rgba(0, 0, 0, 0.067); */
	
}
.genericListItem div p {
    margin-bottom: 2px;
}
.cont-disp-name{
	text-transform: capitalize;
}
.grText6 {
    color: #4F4F4F;
    font-family: 'Segoe UI';
    font-size: 12px;
}

</style>
<script type="text/javascript">


</script>
<div id="ctl00_content_ctl00_right-sidebar"
		class="layout-region right-sidebar" >
	
	<c:if test='${null!=contentList }'>
	<div class="content-fragment">
		<div class="content-fragment-content">
	
					<div style="" class="user-defined-markup">
						<h4 class="widget-title "><span>${content.categoryName}</span></h4>
							<%-- <span class="content-tilte-h" style="font-size: 16px; font-weight: bold">${content.categoryName}</span> --%>
						<ul>
						 <c:forEach var="con" items="${contentList}" varStatus="cin">
							<li><a style="font-size: 12px" id="con${cin}" class="conli"
								href="${pageContext.request.contextPath}/news/${con.categoryUrl}/${con.url}">${con.name}</a></li>
						 </c:forEach>
					        </ul>
					</div>
		</div>
	</div>
	</c:if>
	
	<c:if test='${null!=contentRecList }'>
	
	<div style="border-left-color:" class="rn-content-fragment-list rightRail">
		<h4 class="glControlTitle ">Recent News</h4>
		<div id="ItemContainer">
			 <c:forEach var="cont" items="${contentRecList}" varStatus="con">
			<div class="genericListItem genericListItem_marginBottom5" 	id="">

				<div class="smHeader">
					<a href="${pageContext.request.contextPath}/news/${cont.categoryUrl}/${cont.url}" 
					class="gyText9">${cont.name}</a>
				</div>
				<div class="gyText1" id="date">${cont.inserted}</div>
				<div class="gyText1" id="showPublicationName">${cont.categoryName}</div>
			</div>
			</c:forEach>
		</div>
		</div>
		
	</c:if>	
	
	
	
	
	
	<%-- <c:if test='${null!=catRefList }'>
`<div class="content-fragment">
			<div class="cbox cd">
				<h2 class="ui-borderBottom">Categories</h2>
				<div
					style="overflow: hidden; margin: 5px 0 5px 5px; height: auto; width: 100%">
					<div id="" class="newsboard">
						<ul>
							<c:forEach var="cat" items="${catRefList}" varStatus="cin">
								<li id=""><a class=""
									href="${pageContext.request.contextPath}/news/${cat.idValue}">
										<!-- » -->${cat.description}.</a>
								</li>
							</c:forEach>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</c:if>		 --%>
	
	<c:if test='${null!=catList }'>
		<div id="fragment-93644" class="content-fragment with-header">
			<div class="content-fragment-headerx">
				<h4 class="widget-title"><span>Categories</span></h4>
			</div>
			<div class="content-fragment-content">
				<ul class="content-list">
				<c:forEach items="${catList}" var="cat" 	varStatus="cin">
					<li class="content-item"><a
						href="${pageContext.request.contextPath}/news/${cat.url}"
						class="internal-link view-post-archive-list">${cat.name}</a> (${cat.contentsSize})
					</li>
				</c:forEach>
				</ul>
			</div>
		</div>
	</c:if>	
	
	<c:if test='${null!=contentYrMonthList }'>
		<div id="fragment-93644" class="content-fragment with-header">
			<div class="content-fragment-headerx">
				<h4 class="widget-title"><span>Archives</span></h4>
			</div>
			
			<div class="content-fragment-content">
				<ul class="content-list">
				<c:forEach items="${contentYrMonthList}" var="contentYM" 	varStatus="ymloop">
					<li class="content-item"><a
						href="${pageContext.request.contextPath}/news/${contentYM.url}"
						class="internal-link view-post-archive-list">${contentYM.title}</a> (${contentYM.count})
					</li>
				</c:forEach>
				</ul>
			</div>
		</div>
	</c:if>	
		
	
		
		
 </div>
 
 
