<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%-- <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.vydya.theschool.common.constants.TSConstants"%>
<%@ page import="com.vydya.theschool.web.constants.WebConstants"%>

 

<div class="full-page">
	<div class="full-content">
		<div id="" class="layout-region content">
			<div class="layout-region-inner content">
				<div id="" 	class="content-fragment blog-post no-wrapper">
					<div class="content-fragment-content">
						<div class="full-post">
							<h3 class="post-namex">${notf.name}</h3>
							<div class="post-date">
								<span class="value">${notf.inserted}</span>
							</div>
							<hr>
							<div class="news-content">${notf.content}</div>
						</div>
					</div>
				</div>
			</div>
		</div> 
	</div>
</div>