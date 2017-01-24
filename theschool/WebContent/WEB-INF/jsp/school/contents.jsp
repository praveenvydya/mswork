<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%-- <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.vydya.theschool.common.constants.TSConstants"%>
<%@ page import="com.vydya.theschool.web.constants.WebConstants"%>
<head>
<style>

</style>
</head>


					<c:choose>
						<c:when test="${empty contentsList}">
							<div class="alertMsg">No News with this Name</div>
						</c:when>
						<c:otherwise>
							<div id="" class="layout-region content">
									<div class="layout-region-inner content">
									<div>
										<c:choose>
					
											<c:when test="${null!=displayname}">
												<h4 class="cont-name">News of <b style="font-weight: 400;" class="cont-disp-name">${displayname}</b></h4>
											</c:when>
											<c:otherwise>
												<h4 class="cont-name">All News</h4>
											</c:otherwise>
										</c:choose>
										
										
										</div>
										<div id="" class="news-contents genericListItem" style="padding-left: 0px;">
											<c:forEach items="${contentsList}" var="con" 	varStatus="catloop">
												<div class="nw-content">
													<div style="" class="nw-th-img"><a href="${pageContext.request.contextPath}/news/${con.categoryUrl}/${con.url}">
													<c:choose>
													
														<c:when test="${null!=con.image}">
															<img class="" src="${pageContext.request.contextPath}/static/simg-fit/96x68/${con.image}" />
														</c:when>
														<c:otherwise>
															
														</c:otherwise>
													</c:choose>
													</a></div>
													<p class="nHeader">
														<a target="" class="ncText9" href="${pageContext.request.contextPath}/news/${con.categoryUrl}/${con.url}">${con.name}</a>
													</p>
													<p id="ArticleInfo">
														<span class="gyText1" id="" >${con.inserted}	</span> 
													</p>
													<p id="" class="ncText6">${con.title}</p>
												</div>	
											</c:forEach>
										</div>
									</div>
								</div>
							</c:otherwise>
						</c:choose>

<%-- <div id="contentData">
	<h1>${content.name}</h1>
	<p>${content.title}</p>
	<hr>
	<div class="news-content">${content.contentData} </div>
</div> --%>