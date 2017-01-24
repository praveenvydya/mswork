<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="ts" uri="/WEB-INF/ts-tags.tld"%>
<%@ page import="com.vydya.theschool.web.constants.WebConstants"%>
<%@ page import="com.vydya.theschool.common.constants.TSConstants"%>
<script type="text/javascript" 	src="${pageContext.servletContext.contextPath}/javascript/jquery.tablednd.js"></script>
<head>	
	<script type="text/javascript">  
	jQuery(document).ready(function($){
	
		
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
				$('#contentListBar, #contentData').css('height', currHeight);
				
				//ON RESIZE OF WINDOW
				$(window).resize(function() {
					
					//GET NEW HEIGHT
					var currHeight = $(window).height();	
					//RESIZE BOTH ELEMENTS TO NEW HEIGHT
					$('#contentListBar, #contentData').css('height', currHeight);
					
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
	#contentControl{
		float: left;
	}
</style>
</head>
<div id="">
		
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
					<input type="button"  class="large clButton yellow" id="editBttn" title="Back" value="Edit"/>
					<input type="button"  class="large clButton green" id="deleteBttn" title="Delete" value="Delete"/>
				</div>
				<div  id="contentData">
						<div class="contentDataDiv">
							${content.contentData}
						</div>
				</div>
		</div>	
</div>
