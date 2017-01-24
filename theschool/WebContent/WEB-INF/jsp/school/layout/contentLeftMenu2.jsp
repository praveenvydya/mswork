<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%-- <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> --%>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld" %>
<%@ page import="com.vydya.theschool.common.constants.TSConstants"%>
<%@ page import="com.vydya.theschool.web.constants.WebConstants"%>	

<style>





</style>
<script type="text/javascript">
	$(document).ready(
			function() {



			$('.columnslider').each(function(){
				var id = $(this).attr('id');
				$('#'+id).lfslider({	
					navigation: true, 
					delay: 2000 
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


<c:if test='${null!=contentList }'>

	<div class="cbox cd">
		<h2 class="ui-borderBottom">${content.categoryName}</h2>
		<div style="overflow:hidden;margin: 5px 0 5px 5px;height: auto; width: 100%">
			  <div id="" class="newsboard">
			  
			      <ul>
			      <c:forEach var="con" items="${contentList}" varStatus="cin">
			        <li id=""><a href="${pageContext.request.contextPath}/news/${con.categoryUrl}/${con.url}" ><!-- » -->${con.name}.</a></li>
			        </c:forEach>
			        </ul>
			       </div>
		</div>
		</div>
	</c:if>
	
	<c:if test='${null!=contentRecList }'>

	<div class="cbox cd">
		<h2 class="ui-borderBottom">Recent Updates</h2>
		<div style="overflow:hidden;margin: 5px 0 5px 5px;height: auto; width: 100%">
			  <div id="" class="newsboard">
			  
			      <ul>
			      <c:forEach var="cont" items="${contentRecList}" varStatus="con">
			        <li id=""><a href="${pageContext.request.contextPath}/news/${cont.categoryUrl}/${cont.url}" ><!-- » -->${cont.name}.</a></li>
			        </c:forEach>
			        </ul>
			       </div>
		</div>
		</div>
	</c:if>	
	
	<c:if test='${null!=catRefList }'>

	<div class="cbox cd">
		<h2 class="ui-borderBottom">Categories</h2>
		<div style="overflow:hidden;margin: 5px 0 5px 5px;height: auto; width: 100%">
			  <div id="" class="newsboard">
			  
			      <ul>
			      <c:forEach var="cat" items="${catRefList}" varStatus="cin">
			        <li id=""><a class="" href="${pageContext.request.contextPath}/news/${cat.idValue}"><!-- » -->${cat.description}.</a></li>
			        </c:forEach>
			        </ul>
			       </div>
		</div>
		</div>
	</c:if>		
	
		<c:if test='${null!=contentYrList }'>

	<div class="cbox cd">
		<h2 class="ui-borderBottom">Archives</h2>
		
		<div class="categoryList">
		<ul>
			<c:forEach items="${contentYrList}" var="contentYr" 	varStatus="yrloop">
				<li><c:out value="${contentYr.cat}" />
					<ul>
						<c:forEach items="${contentYr.contentSubList}" var="monthCat" 	varStatus="mnloop">
							<li><c:out value="${monthCat.scubCat}" />
								<ul>
									<c:forEach items="${monthCat.contentList}" var="content" 	varStatus="cnt">
										<li>
										 <li id=""><a class="" href="${pageContext.request.contextPath}/news/${content.categoryUrl}/${content.url}"><c:out value="${content.name}" /></a></li>
										</li>
									</c:forEach>
								</ul>
							</li>
						</c:forEach>
					</ul>
				</li>
			</c:forEach>
		</ul>
	</div>
		</div>
	</c:if>	
 
 
 
