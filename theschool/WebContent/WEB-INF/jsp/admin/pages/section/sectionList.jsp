<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="ts" uri="/WEB-INF/ts-tags.tld" %>
<%@ page import="com.vydya.theschool.web.constants.WebConstants" %> 
<%@ page import="com.vydya.theschool.common.constants.TSConstants" %> 
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery.tablednd.js"></script>
<script>
$(document).ready(function(){
// Initialise the second table specifying a dragClass and an onDrop function that will display an alert
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


});

var chkCount = 0;
function onSubmit()
{
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
	     })
	}) ;
	var allValues = values.join(",");
	
	document.getElementById("reorderedIds").value=allValues;
	if(document.pressed == 'Edit')
		{		 
		if(chkCount==0){
			alert('<spring:message code="section.selection.required.common" />');
			return false;
		}
		else if(chkCount>1){
			alert('<spring:message code="section.selection.single.required" />');
			return false;
		}
		 document.getElementById("actionName").value='EditView';
		 document.myform.action ="<%=TSConstants.ACTION_EDIT_SECTION%>.htm";
		    }
     else  if(document.pressed == 'Delete')  
          {   
    	 if(chkCount==0 ){
			alert('<spring:message code="section.selection.required.common" />');
			return false;
		}
    	 var selectedSection='';
     	$('#sectionsTable tr').each(function(){
     		$(this).find('td:first').each(function(){	
     		      if(($(this).children().eq(0).is(':checked'))){
     		    	 selectedSection = selectedSection + $(this).next("td").next("td").text()+",";     		    	
     		      }
     	     })
     	}) ;
     	selectedSection = selectedSection.substring(0,selectedSection.length-1); 
     	 var answer =confirm('<spring:message code="section.delete.confirmation" />'.replace("this",selectedSection)); 
    	if(!answer)
        	 return false;    	
          document.myform.action ="<%=TSConstants.ACTION_DELETE_SECTION%>.htm";  
          
           } 
     else if(document.pressed == 'Reorder'){
    	 document.myform.action ="<%=TSConstants.ACTION_REORDER_SECTION%>.htm";
         }
     else if(document.pressed == 'AddSection'){
    	 document.getElementById("actionName").value='AddView';
    	 document.myform.action ="<%=TSConstants.ACTION_ADD_SECTION%>.htm";
         }
      return true;
}


</script>


<div class="card">

					<div class="lv-header-alt clearfix">
                                <h2 class="lvh-label hidden-xs">Available Sections</h2>
                                <ul class="lv-actions actions">
                                    <li>
                                        <a href="">
                                            <i class="zmdi zmdi-info"></i>
                                        </a>
                                    </li>
                                    <li class="dropdown">
                                        <a href="" data-toggle="dropdown" aria-expanded="true">
                                            <i class="zmdi zmdi-more-vert"></i>
                                        </a>
                            
                                        <ul class="dropdown-menu dropdown-menu-right">
                                            <li>
                                                <a href="">Refresh</a>
                                            </li>
                                            <li>
                                                <a href="">Listview Settings</a>
                                            </li>
                                        </ul>
                                    </li>
                                </ul>
                            </div>
                        <form:form method="POST"  commandName="section" name="myform" onsubmit="return onSubmit()">
                        <div class="table-responsive" tabindex="3" style="overflow: hidden; outline: none;">
                            <table class="table table-hover">
                                <thead>
                                <tr>
									<th></th>
									<th >Index</th>
									<th >Section Name</th>
									<th>Description</th>
									<th >Status</th>
									<th >Action</th>
								  </tr>
                                </thead>
                                <tbody>
                                
                                <c:forEach items="${sectionsList}" var="section" varStatus="loop"  begin="0" end="0"
					               step="1">
									 	<c:choose><c:when  test='${section.sectionIndex=="1"}'>				
										   <tr>
											<td><form:checkbox  id="${section.sectionId}" value="${section.sectionId}" disabled="true" path="selectedSectionId"/></td>
											<td><c:out value="${section.sectionIndex}" /></td>
											<td><c:out value="${section.sectionName}" /></td>
											<td><c:out value="${section.sectionDesc}" /></td>
											<td class="activeStatus"><c:out value="${section.activeStatus}" /></td>
											<td></td>
										  </tr>
									  </c:when>
									   <c:otherwise>
									   <tr>
										<td><form:checkbox  id="${section.sectionId}" value="${section.sectionId}" disabled="true" path="selectedSectionId"/></td>
										<td>1</td>
										<td>Index 1 is empty</td>
										<td>Index 1 is empty</td>
										<td></td>
										<td></td>
									  </tr>
                                    </c:otherwise>
                                      </c:choose>
                                      </c:forEach>
                                      </tbody>
                                      </table>
                                      <table class="table table-hover">
                                      <c:forEach items="${sectionsList}" var="section" varStatus="loop">
								<c:if test='${section.sectionIndex!="1"}'>
								   <tr class="${section.sectionIndex % 2 == 0 ? 'altrow' : ''}">
									<td><form:checkbox  id="${section.sectionId}" value="${section.sectionId}" path="selectedSectionId" /></td>
									<td><c:out value="${section.sectionIndex}" /></td>
									<td><c:out value="${section.sectionName}" /></td>
									<td><c:out value="${section.sectionDesc}" /></td>
									<td><c:out value="${section.activeStatus}" /></td>
									<td><ul class="actions">
                                        <li class="dropdown">
                                            <a href="" data-toggle="dropdown">
                                                <i class="zmdi zmdi-more-vert"></i>
                                            </a>
                                            
                                            <ul class="dropdown-menu dropdown-menu-right">
                                                <li>
                                                    <a href="">Edit</a>
                                                </li>
                                                <li>
                                                    <a href="">Delete</a>
                                                </li>
                                                
                                            </ul>
                                        </li>
                                    </ul></td>
								  </tr>
								  </c:if>
								  </c:forEach>
								
                                </table>
                        </div>
                        </form:form>
                        
                        	<div class="lv-header-alt clearfix">
                                <div class="upload fs-upload-element fs-upload">
								<div class="fs-upload-target"> <a data-toggle="modal" href="#preventClick" class="upload-btn2 waves-effect">Add new section</a></div>
								
							</div>
							
                            </div>
                    </div>
                    
                    
                    
                    
<%-- <div class="card">
                        <div class="card-header">
                            <h2>Available Sections</h2>
                        </div>

                        <div class="card-body card-padding">
                        
<form:form method="POST"  commandName="section" name="myform" onsubmit="return onSubmit()">
				
					<div class="">
					<ts:button validateAction="true" action="<%=WebConstants.ADD_SECTION_ACTION%>"   type="submit" cssClass="cms-btn gx-btn " name="AddSection" value="Add Section" title="Add Section"  onClick="document.pressed=this.name"/>
					</div>
				<c:if test='${null!=success_key }'>
				<div class="successMsg"><spring:message code="${success_key}" /></div>
				<c:remove var="success_key" scope="session" />
				</c:if>
				<div><center><form:errors path="error" cssClass="alertMsg" /></center></div>
				 <form:hidden path="reorderedIds" id="reorderedIds"/>
				  <form:hidden path="actionName" id="actionName"/>
				<table width="100%" border="0" cellspacing="0" cellpadding="0" id="sectionTableHeader">
				   <tr>
					<th width="8%">&nbsp;</th>
					<th width="8%">Index</th>
					<th width="28%">Section Name</th>
					<th width="41%">Description</th>
					<th width="15%">Status</th>
				  </tr>
				  
				  <c:forEach items="${sectionsList}" var="section" varStatus="loop"  begin="0" end="0"
               step="1">
				 <c:choose><c:when  test='${section.sectionIndex=="1"}'>				
				   <tr>
					<td style="text-align:center"><form:checkbox  id="${section.sectionId}" value="${section.sectionId}" disabled="true" path="selectedSectionId"/></td>
					<td><c:out value="${section.sectionIndex}" /></td>
					<td><c:out value="${section.sectionName}" /></td>
					<td><c:out value="${section.sectionDesc}" /></td>
					<td class="activeStatus"><c:out value="${section.activeStatus}" /></td>
				  </tr>
				  </c:when>
				  
				   <c:otherwise>
				   <tr>
					<td><form:checkbox  id="${section.sectionId}" value="${section.sectionId}" disabled="true" path="selectedSectionId"/></td>
					<td>1</td>
					<td>Index 1 is empty</td>
					<td>Index 1 is empty</td>
				  </tr>
         		 </c:otherwise>
         		  </c:choose> 
				  </c:forEach>
				</table>
				<table width="100%" border="0" cellspacing="0" cellpadding="0" id="sectionsTable">
				<c:forEach items="${sectionsList}" var="section" varStatus="loop">
				<c:if test='${section.sectionIndex!="1"}'>
				   <tr class="${section.sectionIndex % 2 == 0 ? 'altrow' : ''}">
					<td width="8%" style="text-align:center"><form:checkbox  id="${section.sectionId}" value="${section.sectionId}" path="selectedSectionId" /></td>
					<td width="8%"><c:out value="${section.sectionIndex}" /></td>
					<td width="28%"><c:out value="${section.sectionName}" /></td>
					<td width="41%"><c:out value="${section.sectionDesc}" /></td>
					<td width="15%" class="activeStatus"><c:out value="${section.activeStatus}" /></td>
				  </tr>
				  </c:if>
				   </c:forEach>
				  
				</table>
				
				<div id="sectionBttns">
				 <ts:button validateAction="true" action="<%=WebConstants.REORDER_SECTION_ACTION%>" type="submit" cssClass="btn btn-default waves-effect waves-effect" title="Apply Changes " name="Reorder" value="Reset Order" onClick="document.pressed=this.name" />
				<input type="button" class="resetReorderBttnBlack" title="Reset" onClick="location.href='${pageContext.servletContext.contextPath}/admin/manageSections/viewSections.htm'"/>
				 <ts:button validateAction="true" action="<%=WebConstants.EDIT_SECTION_ACTION%>" type="submit" cssClass="btn btn-info waves-effect waves-effect" title="Edit" value="Edit" name="Edit"  onClick="document.pressed=this.name" />
				 <ts:button validateAction="true" action="<%=WebConstants.DELETE_SECTION_ACTION%>" type="submit" cssClass="btn bgm-amber waves-effect waves-effect" title="Delete"  value="Delete" name="Delete"  onClick="document.pressed=this.name" />
			  	</div>
			</form:form></div></div> --%>