<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="ts" uri="/WEB-INF/ts-tags.tld"%>
<%@ page import="com.vydya.theschool.web.constants.WebConstants"%>
<%@ page import="com.vydya.theschool.common.constants.TSConstants"%>
<script type="text/javascript" 	src="<spring:message code="static.application.name"/>/javascript/jquery.tablednd.js"></script>
	
	<script type="text/javascript">  
	jQuery(document).ready(function($){
	
		
		//$("#sectionsTable").tablesorter({widthFixed: true, widgets: ['applyStyles']});
		 $('#addBttn').click(function(){
				
				$('#addBttn').attr("disabled", true);	
				$("#contentForm").attr("action", '<%=TSConstants.ACTION_ADD%>.htm');
				$("#contentForm").submit();
			});  
		 
			  $("#editBttn").click(function() {
					if($(".contentId").is(':checked')==true){
						$('#contentForm #actionType').val("<%=WebConstants.VIEW%>");
						$("#contentForm").attr("action","<%=TSConstants.ACTION_EDIT%>.htm");
						$("#contentForm").submit();
					}
					else{
						alert("Please Select One");
						return false;
					}
				});
			  $("#deleteBttn").click(function() {
					if($(".contentId").is(':checked')==true){
						$("#contentForm").attr("action","<%=TSConstants.ACTION_DELETE%>.htm");
						$("#contentForm").submit();
					}
					else{
						alert("Please Select One");
						return false;
					}
				}); 
			//GET BROWSER WINDOW HEIGHT
				var currHeight = $(window).height();
				$('#contentListBar, #contentData').css('height', currHeight-10);
				
				//ON RESIZE OF WINDOW
				$(window).resize(function() {
					
					//GET NEW HEIGHT
					var currHeight = $(window).height();	
					//RESIZE BOTH ELEMENTS TO NEW HEIGHT
					$('#contentListBar, #contentData').css('height', currHeight-10);
					
				});
	});
	</script>

<style>
#innerContentAdmin .page {
	display: inline-block;
	padding: 0px!important;
}

#contentListBar { 
		
		float: left;
		/* left: 250px;
		margin-left: -250px; */
		position: relative;
		width: 200px;
		overflow-y: auto;
		position: relative;
		border-right: 1px solid #DDDDDD;
		}
	#contentListBar h1 {
		padding: 10px;
		}
	#contentListBar ul {
		margin: 0px 10px 0px 10px;
		list-style: disc;
		}
	
	#contentWrapper { 
		float: left;
		width: 100%;
		}
	#contentData {
		
		/* margin-left: 200px; */
		overflow-y: auto;
		}
	#contentData h1 {
		padding: 10px;
		font-size: 26px;
		}
	#contentData p {
		padding: 0px 10px 10px;
		}
	.contentDataDiv{
		padding-left: 10px;
	}
</style>
<div id="">
		<form:form method="POST" commandName="content" name="contentForm" id="contentForm">
		<form:input type="hidden" path="actionType" value="view"/>
		<div id="contentListBar">
			<h1>Contents </h1>
			<nav>
				<div class="categoryList">
					<ul>
						<c:forEach items="${contentCatList}" var="contentCat" 	varStatus="catloop">
							<li><c:out value="${contentCat.scubCat}" />
								<ul>
									<c:forEach items="${contentCat.contentList}" var="catContent" 	varStatus="mnloop">
										<li id="${catContent.id}">
											<a href="${pageContext.servletContext.contextPath}/admin/manageContents/viewAll.htm?contentId=${catContent.id}">	
											<c:out value="${catContent.name}" /></a>
										</li>
									</c:forEach>
								</ul>
							</li>
						</c:forEach>
					</ul>
				</div>
			</nav>
		</div>
		
		<div id="contentWrapper">
			
			<div id="contentControl">
					<input type="button"  class="large clButton yellow" id="addBttn" title="Add" value="Add"/>
				</div>
		<div  id="contentData">
			<div class="contentDataDiv">
			
						<div id="tabularData">
							<div id="titleBar">
								<div class="title">Available Contents</div>
								
							</div>
							<c:if test='${null!=success_key }'>
								<div class="successMsg">
									<spring:message code="${success_key}" />
								</div>
								<c:remove var="success_key" scope="session" />
							</c:if>
							<div>
								<center>
									<form:errors path="error" cssClass="alertMsg" />
								</center>
							</div>
							<%-- <form:hidden path="reorderedIds" id="reorderedIds" />
							<form:hidden path="actionName" id="actionName" /> --%>
							<c:if test='${null!=contentList }'>
							<table width="100%" border="0" cellspacing="0" cellpadding="0"
								id="sectionsTable">
								<thead>
								<tr>
									<th width="">&nbsp;</th>
									<th width="">Name</th>
									<th width="">Content</th>
									<th width="">Description</th>
									<th width="">Category</th>
									<th width="">Status</th>
									<th width="">Inserted/By</th>
									<th width="">Updated/By</th>
									
									
								</tr>
						</thead>
							<tbody>	<c:forEach items="${contentList}" var="content"
									varStatus="loop">
									<tr>
										<td width="" style="text-align:center"><form:radiobutton  path="id" id="${content.id}" value="${content.id}" class="contentId"  name="contentId"/></td>
										<td width="">${content.name}</td>
										<td class=" "></td>
										<td width="">${content.description}</td>
										<td width="">${content.category}</td>
										<c:choose>
											<c:when test="${1 eq content.active}">
												<td class="center status-active">Active</td>
										</c:when>
											<c:otherwise>
													<td class="center status-inactive">Inactive</td>
											</c:otherwise>
										</c:choose>	
										<td width="">${content.inserted}/<br>${content.insertedby}</td>
										<td width="">${content.lastmodified}/<br>${content.lastmodifiedby}</td>
									</tr>
								</c:forEach>
							</tbody></table>
							
							</c:if>
						</div>
				</div>
</div></div>
</form:form>
</div>

	<%-- <div>Year Wise Contents</div>
	<div class="categoryList">
		<ul>
			<c:forEach items="${contentYrList}" var="contentYr" 	varStatus="yrloop">
				<li><c:out value="${contentYr.cat}" />
					<ul>
						<c:forEach items="${contentYr.contentSubList}" var="monthCat" 	varStatus="mnloop">
							<li><c:out value="${monthCat.scubCat}" />
								<ul>
									<c:forEach items="${monthCat.contentList}" var="content" 	varStatus="cnt">
										<li><c:out value="${content.name}" />
										
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
	
	<div>Category Wise Contents</div>
	<div class="categoryList">
		<ul>
			<c:forEach items="${contentCatList}" var="contentCat" 	varStatus="catloop">
				<li><c:out value="${contentCat.scubCat}" />
					<ul>
						<c:forEach items="${contentCat.contentList}" var="catContent" 	varStatus="mnloop">
							<li>
								<a href="/${catContent.url}">	<c:out value="${catContent.name}" /></a>
							</li>
						</c:forEach>
					</ul>
				</li>
			</c:forEach>
		</ul>
	</div>
	
	<div id="">
				
						<ts:button validateAction="true" action="<%=WebConstants.EDIT_HOMEPAGE_IMAGES%>"   type="submit" cssClass="editBttn" name="Edit" value=""  />
					<ts:button validateAction="true" action="<%=WebConstants.DELETE_HOMEPAGE_IMAGES%>"    type="submit" cssClass="deleteBttn" name="Delete" value=""  />
					
						
							 <input type="button"  class="large clButton yellow" id="editBttn" title="Back" value="Edit"/>
						<input type="button"  class="large clButton green" id="deleteBttn" title="Delete" value="Delete"/>
					 </div> --%>
