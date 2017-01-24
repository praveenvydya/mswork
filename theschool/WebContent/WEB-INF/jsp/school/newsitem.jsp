<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%-- <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.vydya.theschool.common.constants.TSConstants"%>
<%@ page import="com.vydya.theschool.web.constants.WebConstants"%>

 
<div id="left-innerContent">
			<tiles:insertAttribute name="breadcrum" />
			<section style="font-size: 100%;" id="scMainbody"> 
				<div class="" style="">
					<div class="full-content">
						<div id="" class="layout-region content">
							<div class="layout-region-inner content">
								<div id="" 	class="content-fragment blog-post no-wrapper">
									<div class="content-fragment-content">
										<div class="full-post">
											<h3 class="post-namex">${content.name}</h3>
											<div class="post-date">
												<span class="icon-calendar" ></span><span class="value">${content.inserted}</span>
											</div>
											<hr>
											<div class="news-content">${content.contentData}</div>
										</div>
									</div>
								</div>
							</div>
						</div> 
					</div>
				</div>
				</section>
			<%-- <tiles:insertAttribute name="pagination" /> --%>
			</div>
	<div id="right-Column">
	<%@ include file="layout/contentLeftMenu.jsp" %>
	<%-- <jsp:include page="/index.jsp"></jsp:include> --%>

	</div>