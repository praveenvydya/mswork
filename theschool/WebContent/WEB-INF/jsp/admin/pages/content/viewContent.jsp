<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="ts" uri="/WEB-INF/ts-tags.tld"%>
<%@ page import="com.vydya.theschool.web.constants.WebConstants"%>
<%@ page import="com.vydya.theschool.common.constants.TSConstants"%>
<script type="text/javascript" 	src="<spring:message code="static.application.name"/>/javascript/jquery.tablednd.js"></script>
<head>	
	<script type="text/javascript">  
jQuery(document).ready(function($){
	
		 $('#mainSplitter').jpsSplitter({ width: 1156, height: 500, panels: [{ size: 210}, { size: 936}] });//,min: 745,max:770
         
		 $('#addBttn').click(function(){
				
					
				$("#contentForm").attr("action", '<%=TSConstants.ACTION_ADD%>.htm');
				$("#contentForm").submit();
				$('#addBttn').attr("disabled", true);
			});  
		 
			  $("#editBttn").click(function() {
					//if($(".contentId").is(':checked')==true){
						
						$('#contentForm #actionType').val("<%=WebConstants.VIEW%>");
						$("#contentForm").attr("action","<%=TSConstants.ACTION_EDIT%>.htm");
						$("#contentForm").submit();
						$(this).attr("disabled", true);
					/* //}
					else{
						alert("Please Select One");
						return false;
					} */
				});
			  $("#deleteBttn").click(function() {
						$("#contentForm").attr("action","<%=TSConstants.ACTION_DELETE%>.htm");
						$("#contentForm").submit();
						$(this).attr("disabled", true);
				}); 
			  
			//GET BROWSER WINDOW HEIGHT
				var currHeight = $(window).height();
				$('#contentcatListBar, #contentPanel').css('height', currHeight-10);
				
				//ON RESIZE OF WINDOW
				$(window).resize(function() {
					
					//GET NEW HEIGHT
					var currHeight = $(window).height();	
					//RESIZE BOTH ELEMENTS TO NEW HEIGHT
					$('#contentcatListBar, #contentPanel').css('height', currHeight-10);
					
				});
			
	});
	</script>

<style>
#innerContentAdmin .page {
	display: inline-block;
	padding: 0px!important;
}

</style>
</head>
<div id="">
<form:form method="POST" commandName="content" name="contentForm" id="contentForm">
						<form:input type="hidden" path="actionType" value="view"/>
						<form:input type="hidden" path="id" />
		<div id="mainSplitter">
		             <div class="" id="contentcatListBar">
		             <div class="contentHeader pnl">
		            	 	<input type="button" style="float: left;" class="cms-btn"  title="" value="Back" onClick="location.href='${pageContext.servletContext.contextPath}/<%=WebConstants.VIEW_ALL_CONTENTS%>'"/>
							<input type="button"  class="cms-btn btn-s" id="addBttn" title="Add" value="ADD"/>
						</div>
		                <%-- <h1>Contents </h1>
					<div class="categoryList">
						<ul>
							<c:forEach items="${contentCatList}" var="contentCat" 	varStatus="catloop">
								<li><c:out value="${contentCat.scubCat}" />
									<ul>
										<c:forEach items="${contentCat.contentList}" var="catContent" 	varStatus="mnloop">
											<li id="${catContent.id}">
												<a href="${pageContext.servletContext.contextPath}/admin/manageContents/viewAll.htm?contentId=${catContent.id}">	
												<c:out value="${catContent.name}" /></</a>
											</li>
										</c:forEach>
									</ul>
								</li>
							</c:forEach>
						</ul>
					</div> --%>
					<div class="contentCatList pnl">
						<ul style="" class="nav bs-docs-sidenav"
							id="CategoryList1"> 
							<li class="cncat navcat0">${content.categoryName}</li>
							<c:forEach items="${contentsList}" var="cont" 	varStatus="catloop">
								
								<li id="cnt_${cont.id}"><a href="${pageContext.servletContext.contextPath}/admin/manageContents/view.htm?contentId=${cont.id}" 
								style="font-weight:${content.id eq cont.id ? 'bold': 'none'}"><c:out value="${cont.name}" /><!-- <span
										class="label label-info pull-right">34</span>  --></a></li>
								
							</c:forEach>
						</ul>
					</div>
                </div>
                
                <div style="overflow: hidden;">
                    <div style="border: none;" id="rightSplitter">
                        <div class="contentHeader pnl">
                        	<div style="float:left;width: 82%;line-height: 18px;"> This is content is added by ${content.insertedby} on ${content.inserted} and updated by ${content.lastmodifiedby} on ${content.lastmodified}</div>
                            <input type="button"  class="cms-btn btn-s" id="editBttn" title="Back" value="Edit"/>
							<input type="button"  class="cms-btn" id="deleteBttn" title="Delete" value="Delete"/>
						</div>
                        <div class="contentPanel">
								${content.contentData}
                         </div>
                    </div>
                </div>
               	
            </div>
	 </form:form>
</div>
