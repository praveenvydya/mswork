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
		 $('#addCatBttn').click(function(){
				$('#addCatBttn').attr("disabled", true);	
				$("#contentCategoryForm").attr("action", 'addCategory.htm');
				$("#contentCategoryForm").submit();
			});  
		 $('#addBttn').click(function(){
			 	$("#contentForm").attr("action", '<%=TSConstants.ACTION_ADD%>.htm');
				$('#addBttn').attr("disabled", true);	
				$("#contentForm").attr("action", 'add.htm');
				$("#contentForm").submit();
			});  
		 
			  $("#editCatBttn").click(function() {
					if($(".categoryId").is(':checked')==true){
						var selected = $("#contentCategoryForm input[type='radio'][name='categoryId']:checked");
						if (selected.length > 0) {
							$('#contentCategoryForm #catId').val(selected.val());
						}
						$('#contentCategoryForm #actionType').val("<%=WebConstants.VIEW%>");
						$("#contentCategoryForm").attr("action","<%=TSConstants.ACTION_EDIT%><%=WebConstants.CATEGORY%>.htm");
						$("#contentCategoryForm").submit();
					}
					else{
						alert("Please Select One");
						return false;
					}
				});
			  
			  $("#deleteBttn").click(function() {
					if($(".categoryId").is(':checked')==true){
						
						if(confirm("You will loose all contents under this category.Do you want to delete this category?")){	
							
							var selectedVal = "";
							var selected = $("#contentCategoryForm input[type='radio'][name='categoryId']:checked");
							if (selected.length > 0) {
								$('#contentCategoryForm #catId').val(selected.val());
							}
							
							$('#contentCategoryForm #actionType').val("<%=WebConstants.DELETE%>");
							
							$("#contentCategoryForm").attr("action",'editCategory.htm');
							$("#contentCategoryForm").submit();
						}
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

.radioBttnC {
 left: 8px;
position: relative;
/* top: 8px; */
vertical-align: top;
float: right;
margin: 5px !important;
}


/* #innerContentAdmin .page {
	display: inline-block;
	padding: 0px!important;
}

#contentListBar { 
		
		float: left;
		
		margin-left: -250px; 
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
	} */
	
</style>
		<%-- <form:form method="POST" commandName="content" name="contentCategoryForm" id="contentCategoryForm">
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
		</form:form></div> --%>
		
		
		
		
		<c:if test='${null!=success_key }'>
		<div class="successMsg"><spring:message code="${success_key}" /></div>
		<c:remove var="success_key" scope="session" />
		
	</c:if>	
				
		<form:form method="POST" commandName="contentCategory" name="contentCategoryForm" id="contentCategoryForm">
		<form:input type="hidden" path="actionType" value="view"/>
		<form:input type="hidden" path="id" id="catId"/>
		<div class="" style="width: 100%;display: inline-block;">
					<ts:button validateAction="true" action="<%=WebConstants.EDIT_CONTENT_CAT%>" type="button" cssClass="large clButton green" title="Delete Category" value="Delete Category" name="Delete Category" id="deleteBttn" />
					<ts:button validateAction="true" action="<%=WebConstants.EDIT_CONTENT_CAT%>" type="button" cssClass="large clButton green" title="Edit Category" value="Edit Category" name="Edit Category" id="editCatBttn" />
					<ts:button validateAction="true" action="<%=WebConstants.ADD_CONTENT_CAT%>"  type="button"   id="addCatBttn" cssClass="large clButton green " name="Add Category" value="Add Category" title="Add Category" />
					</div>
					
				<c:forEach items="${cattList}" var="contentCat" 	varStatus="catloop">
					<div class="contentCatListDiv">
						<ul style="margin-top: 0;" class="nav bs-docs-sidenav span12" 
							id="CategoryList${catloop}">
								<li class="cncat navcat0 contentCategory" id="cc_${contentCat.id}"><c:out value="${contentCat.name}" /> 
								<input type="radio"  value="${contentCat.id}" class="radioBttnC categoryId" name="categoryId"  />
								</li>
												   
					<c:forEach items="${contentCat.contentlist}" var="catContent" 	varStatus="mnloop">
					<li id="cnt_${catContent.id}"><a href="${pageContext.servletContext.contextPath}/admin/manageContents/view.htm?contentId=${catContent.id}"><c:out value="${catContent.name}" /><!-- <span
							class="label label-info pull-right">34</span>  --></a></li>
					</c:forEach>
				</ul>
			</div>
		</c:forEach>
		</form:form>
		
			
			<form:form method="POST" commandName="content" name="contentForm" id="contentForm">
				<form:input type="hidden" path="actionType" value="view"/>
					<div class="" style="width: 100%;display: inline-block;">
					<ts:button validateAction="true" action="<%=WebConstants.ADD_CONTENT%>"  type="button"   id="addBttn" cssClass="large clButton green " name="Add" value="Add" title="Add" />
					<a href="attachments.htm"  class="large clButton blue " name="Attachments" value="Attachments" title="Attachments" >Attachments</a>
						</div>
		</form:form>
