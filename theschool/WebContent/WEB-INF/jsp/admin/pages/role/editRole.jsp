<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.vydya.theschool.web.constants.WebConstants" %> 
<link href="<spring:message code="static.application.name"/>/css/jquery.checktree.css" rel="stylesheet" type="text/css" charset="utf-8"/>




<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery.checktree.js"></script>  
    <script type="text/javascript">
    jQuery(document).ready(function($){
    	
		    
    	var $checktree;
    	$(function(){
    	    $checktree = $("ul.tree").checkTree();
    	});
    	function load(id) {
    		$.getJSON("data/" + id + ".txt",{},function(json){
    			$checktree.clear();
    			$.updateWithJSON(json);
    			$checktree.update();
    		});
    	}
    	function clearAll(){
    		$checktree.clear();
    		$checktree.update();
    	} 

		
		function callSubmit(){
			$('input:submit').click(function(){
		        $('input:submit').attr("disabled", true); 
		  });
			var val = document.getElementById("roleType").value;
			document.getElementById("selectedRoleType").value = val;
		}
    });
</script>    

 
   
    
  <form:form method="POST" commandName="role" onSubmit="return callSubmit()">  
  <form:hidden path="roleId" id="roleId"/> 
   <c:choose><c:when  test="${'true' eq role.roleAssigned ? true : false}">  
  <form:hidden path="roleType" id="selectedRoleType"/>   
  </c:when>
<c:otherwise>
<form:hidden path="" id="selectedRoleType"/>   
 </c:otherwise></c:choose> 
 
  <c:choose><c:when  test="${'Active' eq role.status ? true : false}">  
  <form:hidden path="status" id="status"/>   
  </c:when>
<c:otherwise>
<form:hidden path="" id="status"/>   
 </c:otherwise></c:choose> 
      <div id="tabularData">
        <div id="titleBar1">
          <div class="title">Edit Role</div>
        </div> 
  <div><center><form:errors path="error" cssClass="alertMsg" />
  <form:errors path="selectedActions" cssClass="errormsg" />
  <c:if test='${null!=alert_key }'>
					<div class="alertMsg"><spring:message code="${alert_key}" /></div>
					<c:remove scope="session" var ="alert_key"/>
				</c:if></center></div>      
        <table width="100%" border="0" cellspacing="0" cellpadding="5" class="add_group">
          <tr>
            <td width="13%">Role Name:<span class="mandatory">*</span></td>
            <td width="38%"><form:input maxlength="200" name="roleName" id="roleName" class=""  path="roleName"/><br/>
			<form:errors path="roleName" cssClass="errormsg" />
            </td>
            <td width="10%">Role Type:<span class="mandatory">*</span></td>
            <td width="39%">
          
            <form:select  name="select4" path="roleType" id= "roleType" class="searchSelectMenu" disabled="${'true' eq role.roleAssigned ? true : false}"> 
            <form:option value="0"  label="Select Role Type"/>
             <c:if test="${'PA' eq sessionScope.user_role_type}">
								<form:option value="Individual Administrator" label="Individual Administrator" /> 
								</c:if>
								
								
								<form:option value="User" label="User" /> 
							</form:select><br><form:errors path="roleType" cssClass="errormsg" /> </td>
          </tr>
          <tr>
            <td width="13%">Role Description:&#13;</td>
            <td width="38%"><form:input maxlength="200" name="roleDescription" class="" path="roleDescription" />
            </td>
            <td width="10%">Status:</td>
             <td width="39%">
              
           
             <form:select  name="select5" path="status"  class="searchSelectMenu" disabled="${'Active' eq role.status ? true : false}">
             
             				<form:option value="Active" label="Active" /> 
             				<form:option value="Inactive" label="Inactive" /> 								
								
				</form:select>
             </td>
          </tr>
        </table>   
        <div id="roleDetails">
        
          <div class="addRoleTitle">Role Details</div>
          
      
  
           <div class="treeStructure">
            <ul class="tree">
              <c:forEach items="${role.sections}" var="section" varStatus="loop" >
              <li>
                 <form:checkbox path="selectedSections" value='${section.sectionId}' name='${section.sectionId}' id='${section.sectionId}'/>
                <label>${section.sectionName}</label>
                <ul>
                 <c:forEach items="${section.reports}" var="report" varStatus="reportLoop" >
                  <li>
                    <form:checkbox path="selectedReports" value="${section.sectionId}_${report.reportId}" id='${section.sectionId}_${report.reportId}'
                     name='${section.sectionId}_${report.reportId}'/>
                    <label>${report.uiDisplayName}</label>
                    <ul>
                   <c:forEach items="${report.actions}" var="action" varStatus="actionLoop" >
                      <li>
                       <form:checkbox path="selectedActions" value='${report.reportId}_${action.actionId}' 
                       id='${report.reportId}_${action.actionId}' name='${report.reportId}_${action.actionId}'/>
                        <label>${action.uiDisplayName}</label>
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
        <div id="sectionBttns">
          <input type="button" class="large clButton gray" title="Back" value="Cancel" onClick="location.href='${pageContext.servletContext.contextPath}/<%=WebConstants.VIEW_ROLES_ACTION%>'"/>
          <input type="submit" class="large clButton blue" title="Save" value="Save"  />
        </div>
      </div>
   </form:form>  
