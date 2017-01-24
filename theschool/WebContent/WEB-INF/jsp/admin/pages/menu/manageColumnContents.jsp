<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="ts" uri="/WEB-INF/ts-tags.tld" %>
<%@ page import="com.vydya.theschool.web.constants.WebConstants"%>
<%@ page import="com.vydya.theschool.common.constants.TSConstants"%>
<script type="text/javascript"
	src="<spring:message code="static.application.name"/>/javascript/jquery.tablednd.js"></script>
	
	<script type="text/javascript">  
	jQuery(document).ready(function($){
	
		$("#sectionsTable").tableDnD({
		    onDragClass: "myDragClass",
		    onDrop: function(table, row) {
		        var rows = table.tBodies[0].rows;     
		        var debugStr = "Row dropped was "+row.id+". New order: ";
		        for (var i=0; i<rows.length; i++) {
		            debugStr += rows[i].id+" ";
		        }      
		    },
			onDragStart: null
		    
		});
		
		$("#reOrderBttn").click(function(){
			
			var chkCount = 0;
			var values = new Array();	
			$('#sectionsTable tr').each(function(){
				$(this).find('td:first').each(function(){	
					      if(($(this).children().eq(0).is(':checked'))){
					    	  chkCount = chkCount+1;
					    	  
					      }
					      else{
					    	  values.push($(this).children().eq(0).attr("id"));
					    	  }
			     });
			}) ;
			var allValues = values.join(",");
			
			$("reorderedIds").val(allValues);
			$("#columnMenuContentForm").attr("action", '<%=TSConstants.ACTION_REORDER%>.htm');
			$("#columnMenuContentForm").submit();
		});
		
		 $('#addBttn').click(function(){
				
				$('#addBttn').attr("disabled", true);	
				$("#columnMenuContentForm").attr("action", '<%=TSConstants.ACTION_ADD%>.htm');
				$("#columnMenuContentForm").submit();
			});  
		 
		 $('#reloadBttn').click(function(){
				
				$(this).attr("disabled", true);	
				$("#columnMenuContentForm").attr("action", '<%=TSConstants.ACTION_RELOAD%>.htm');
				$("#columnMenuContentForm").submit();
			});
			
			
			  $('.nav-toggle').click(function(){
				  $(".filterTable").slideToggle(1000);
				  });
			  
			
			  $("#editBttn").click(function() {
					if($(".columnContentId").is(':checked')==true){
						$('#columnMenuContentForm #actionType').val("<%=WebConstants.VIEW%>");
						$("#columnMenuContentForm").attr("action","<%=TSConstants.ACTION_EDIT%>.htm");
						$("#columnMenuContentForm").submit();
					}
					else{
						alert("Please Select One");
						return false;
					}
				});
			  $("#deleteBttn").click(function() {
					if($(".columnContentId").is(':checked')==true){
						$("#columnMenuContentForm").attr("action","<%=TSConstants.ACTION_DELETE%>.htm");
						$("#columnMenuContentForm").submit();
					}
					else{
						alert("Please Select One");
						return false;
					}
				}); 
			  
			  $('.message font').fadeIn().delay(5000).fadeOut();
				$('.successMsg').fadeIn().delay(5000).fadeOut();
	});
	</script>

<form:form method="POST" commandName="columnMenuContent" name="columnMenuContentForm" id="columnMenuContentForm">
		<form:input type="hidden" path="actionType" value="view"/>
		<form:hidden path="reorderedIds" id="reorderedIds"/>
			<table>
			<tr>
					<td class="" colspan="4"></td>
					<td><input type="button"  class="large clButton yellow" id="addBttn" title="Add" value="Add"/></td>
				</tr>
			</table>
			
			
	<div id="tabularData">
		<div id="titleBar">
			<div class="title">Available Column Contents</div>
			<%-- <div class="addSectionBttn">
				<ts:button validateAction="true"
					action="<%=WebConstants.ADD_COLUMNCONTENT%>" type="button" id="addBttn"
					cssClass="button3d_blue " name="AddSection" value="Add Section"
					title="Add Section" />
					<button type="" class="add" id="addBttn" title="Add">Add Column Content</button>
			</div> --%>
		</div>
			<div>
		<c:if test='${null!=success_key }'>
			<div class="successMsg">
				<spring:message code="${success_key}" />
			</div>
			<c:remove var="success_key" scope="session" />
		</c:if>
	
			<center>
				<form:errors path="error" cssClass="alertMsg" />
			</center>
		</div>
		<%-- <form:hidden path="reorderedIds" id="reorderedIds" /> --%>
		<form:hidden path="actionName" id="actionName" />
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			id="sectionTableHeader">
			<tr>
				<th width="4%">&nbsp;</th>
				<th width="5%">Order</th>
				<th width="24%">Content Name</th>
				<th width="9%">Content Type</th>
				<th width="7%">Contents/<br>ContentId</th>
				<th width="9%">Active</th>
				<th width="17%">Inserted/By</th>
				<th width="17%">Updated/By</th>
			</tr>

				</table>
				
		<table width="100%" border="0" cellspacing="0" cellpadding="0" id="sectionsTable">
			<c:forEach items="${columnContentList}" var="columnContent"
				varStatus="loop"> <%-- begin="0" end="0" step="1" --%>
				<tr  class="${columnContent.order % 2 == 0 ? 'altrow' : ''}">
					<td width="4%" style="text-align:center"><form:radiobutton  path="id" id="${columnContent.id}" value="${columnContent.id}" class="columnContentId"  name="columnContentId"/></td>
					<td width="5%">${columnContent.order}</td>
					<td width="24%" id="cc_${columnContent.id}" class="ccname">${columnContent.name}</td>
					<td width="9%">${columnContent.contentType}</td>
					<td width="7%">${columnContent.id}</td>
					
					<c:choose>
						<c:when test="${1 eq columnContent.active}">
							<td width ="9%" class="center status-active">Active</td>
					</c:when>
						<c:otherwise>
								<td width ="9%" class="center status-inactive">Inactive</td>
						</c:otherwise>
					</c:choose>	
					<td width="17%">${columnContent.inserted}/<br>${columnContent.insertedby}</td>
					<td width="17%">${columnContent.lastmodified}/<br>${columnContent.lastmodifiedby}</td>
				</tr>
			</c:forEach>
		</table>
	</div>
	<div id="">
					<%-- <ts:button validateAction="true" action="<%=WebConstants.EDIT_HOMEPAGE_IMAGES%>"   type="submit" cssClass="editBttn" name="Edit" value=""  />
					<ts:button validateAction="true" action="<%=WebConstants.DELETE_HOMEPAGE_IMAGES%>"    type="submit" cssClass="deleteBttn" name="Delete" value=""  />
					 --%>
						<input type="button"  class="large clButton yellow" id="editBttn" title="Back" value="Edit"/>
						<input type="button"  class="large clButton green" id="deleteBttn" title="Delete" value="Delete"/>
						<input type="button"  class="large clButton green" id="reloadBttn" title="Reload" value="Reload"/>
						<input type="button"  class="large clButton green" id="reOrderBttn" title="Re-Order" value="Re-Order"/>
							 
					 </div>
</form:form>