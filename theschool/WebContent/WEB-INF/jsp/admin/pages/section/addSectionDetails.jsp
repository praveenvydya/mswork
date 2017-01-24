     <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.vydya.theschool.web.constants.WebConstants" %> 
     	<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/sectionScript.js"></script>
     <script><!--
    
     function onSubmit(){
         
    		$('input:submit').click(function(){
    	        
    	        $('input:submit').attr("disabled", true); 
    	  });  		
      	  
 		var select1 = document.getElementById('list2');
 		 var values = new Array();
 		   for(var i=0; i < select1.options.length; i++){ 
 			       values.push(select1.options[i].value);
 			        }  
 	        var allValues = values.join(",");
 	       
 	       document.getElementById("selectedReports").value=allValues;       
 	        
 		}

	
     </script>
      <form:form method="POST" commandName="section" onsubmit="return onSubmit()">
      <div id="tabularData">
        <div id="add_titleBar">
          <div class="title">Add or Edit Section Details </div>
        </div>
        <div class="addArea">
       
       
        <form:hidden path="selectedReports" id="selectedReports"/> 
        <form:hidden path="deletedReports" id="deletedReports"/>        
         <form:hidden path="sectionId" id="sectionId"/>
         <form:hidden path="sectionIndex" id="sectionIndex"/>
      <div><center> <form:errors path="error" cssClass="errormsg" /></center></div>
			<table width="100%" border="0" cellspacing="0" cellpadding="2">
			<tr><td colspan="3"></td></tr>
			  <tr>
				<td width="12%">Section Name <span class="mandatory">*</span></td>
				<td width="30%"><form:input maxlength="15"name="sectionName" id="sectionName" class="searchTextBoxes" path="sectionName"/><br/><form:errors path="sectionName" cssClass="errormsg" />
				</td>
				<td width="15%">Section Description </td>
				<td width="27%"><form:input maxlength="200"name="textfield3" class="searchTextBoxes" path="sectionDesc"/></td>
			  </tr>
			</table>
		</div>	
		
		<div class="addReportsText">Add Reports to Section</div>
		<div class="selectReports">
			<table width="100%" border="0" align="center" cellpadding="5" cellspacing="0">
			  <tr>
				<td width="200" class="formheadings">Available Reports</td>
				<td width="57"><img src="<spring:message code="static.application.name"/>/images/spacer.gif" width="20" height="1" /></td>
				<td width="200" class="formheadings">Selected Reports </td>
			    <td width="403" class="formheadings">&nbsp;</td>
			  </tr>
			  <tr>
				<td><form:select name="reportsList"	id="list1" multiple="multiple" class="multiSelectBox" path="reportsAvail">
				<form:options items="${reportsList}" itemLabel="uiDisplayName" itemValue="reportId"/>
				</form:select>
							</td>
				<td style="vertical-align:middle"><table width="100%" border="0" cellspacing="0" cellpadding="4">
                  
                  <tr>
                    <td align="center"><input type="button" class="add_arrow" title="Add" id="addSelected"/></td>
                  </tr>
                  
                  
                  <tr>
                    <td align="center">&nbsp;</td>
                  </tr>
                  <tr>
                    <td align="center"><input type="button" class="remove_arrow" title="Remove" id="removeSelected" /></td>
                  </tr>
                  
                </table></td>
				<td><form:select id="list2" path="reportsSelect" class="multiSelectBox" multiple="true">
				<form:options items="${reportsSelectedList}" itemLabel="uiDisplayName" itemValue="reportId"/>
				</form:select>
				</td>
			    <td style="vertical-align:middle"><table width="10%" border="0" cellspacing="0" cellpadding="4">
                  
                  <tr>
                    <td width="25%" align="center"><input name="button" type="button" class="moveUp_arrow" id="btn-up" title="Move Up"/></td>
                  </tr>
                  
                  
                  <tr>
                    <td align="center">&nbsp;</td>
                  </tr>
                  
                  <tr>
                    <td align="center"><input name="button" type="button" class="moveDown_arrow" id="btn-down" title="Move Down"/></td>
                  </tr>
                  
                  
                </table></td>
			  </tr>
		  </table>
		</div>
        <div id="sectionBttns">
          <input type="button" class="large clButton gray" value="Cancel" title="Cancel" onClick="location.href='${pageContext.servletContext.contextPath}/<%=WebConstants.VIEW_SECTIONS_ACTION%>'"/>
           <input type="submit" class="large clButton blue" title="Save" value="Save" />
            <input type="reset" class="large clButton green" title="Reset" value="Reset"/> 
        </div>
      </div>
    </form:form>
