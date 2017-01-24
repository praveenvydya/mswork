<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%-- <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.vydya.theschool.common.constants.TSConstants"%>
<%@ page import="com.vydya.theschool.web.constants.WebConstants"%>

<style>


div.allLibs div.cat-inner-boundary {
float: left;
height: auto;
padding: 0px;
}

#free-file .c-inner-border {
clear: both;
display: table-row;
padding: 5px 5px 0;
}

#free-file .cat-inner:hover {
border: 2px solid #A2F397;
}


#free-file .cat-inner {
background-color: #FFFFFF;
border: 2px solid #E4E3E1;
box-shadow: 0 1px 4px rgba(0, 0, 0, 0.067);
padding: 3px;
}

.cat-inner div.trans {
background-color:rgba(0,0,0,0.7);
filter: alpha(opacity=40); /* For IE8 and earlier */
filter: progid:DXImageTransform.Microsoft.gradient(startColorstr=#4C000000,endColorstr=#4C000000);
bottom: 14px;
color: #fff;
display: block;
left: 0;
height:21px;
padding: 2px 7px 2px 7px;
position: absolute;
word-wrap: break-word;
position: relative;
}

.cat-inner div.trans .lib-title{
text-overflow: ellipsis;
white-space: nowrap;
overflow: hidden;
width: 136px;
}

.cat-inner div.trans span{
float: left;
}


.cat-inner div.trans a{
color:#fff;
text-transform: uppercase;
font-weight: bold;
}
.catImage{

padding-left: 17%;
padding-top: 5%;
width: 66%;
}


</style>
	
		 
<div class="full-page">
	<div class="page-banner">
		<div class="img-parent">
			<img src="<spring:message code="static.application.name"/>/images/school/banners/library.jpeg" width="100%"/>
		</div>
	</div>	 
	<div id="free-file" class="allLibs">
	<h3>School Library</h3>
	<div class="outer-boundary">
		<c:if test='${null!=bookCatList }'>
			<c:forEach var="cat" items="${bookCatList}">
				<div class="cat-inner-boundary bookcat" id="bookCat_${cat.id}">
					<div class="c-inner-border">
						<div class="cat-inner">
							<div class="thumbnail bookcontainer">
									<a href="${pageContext.servletContext.contextPath}/library/${cat.url}" id="cat_${cat.id}_${cat.name}" class="gthumb">	
								<img src="${pageContext.request.contextPath}/static/simg-org/${cat.imageName}" id="cat_${cat.id}" class="catImage"
							 	alt="${cat.name}" /></a>
								<div class="trans"> 
								<a href="${pageContext.servletContext.contextPath}/library/${cat.url}" id="catName_${cat.id}_${cat.name}"  class="galleryName"><span class="lib-title"> ${cat.title}</span>&nbsp;(${cat.count})</a>
									<span class="fl-arrow"></span>
								</div>
				 			</div>
							
							</div>
						</div>
					</div>
			</c:forEach>
		</c:if>
		</div>
</div></div>
