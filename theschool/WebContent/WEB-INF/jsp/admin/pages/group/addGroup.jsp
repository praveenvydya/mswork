<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.vydya.theschool.web.constants.WebConstants" %> 
<script>
$(document).ready(function(){
			   
	
	
	
	
$(".saveBttn").click(function (){
		
			$("#groupForm").submit();
		
	});

	function loadCheckBox()
	{
		 
	}
	function callSubmit() 
	{
		$('input:submit').click(function(){
		     $('input:submit').attr("disabled", true); 
		});
	}
	
	
});
</script>
<style>
.errormsg {
	color: #ff0000;
	font-weight: normal;
}

.errorblock{
	color: #000;
	background-color: #ffEEEE;
	border: 3px solid #ff0000;
	padding:8px;
	margin:16px; 
}
</style>
<body onload =loadCheckBox()>
<form:form method="POST" commandName="group" id="groupForm" >
 <form:hidden path="groupId" id="groupId"/>
  		<div id="tabularData">
  			<div id="add_titleBar"><div class="title">Add or Edit Group</div>
		</div>
		<div><center><form:errors path="error" cssClass="errormsg" /></center></div>
		<table width="100%" border="0" cellspacing="0" cellpadding="5" class="add_group">
		  
		  <tr>
			<td width="15%">Group Name&#13;<span class="mandatory">*</span>
			</td>
			<td width="30%"><form:input maxlength="200" name="groupName" id="groupName" class="searchTextBoxes"  path="groupName"/><br/>
			<form:errors path="groupName" cssClass="errormsg" /></td>
		    <td width="15%">Group Description</td>
		    <td width="40%"><form:input maxlength="200" name="groupDesc" class="searchTextBoxes" path="groupDesc" />
		    </td>
		  </tr>
		  <tr>
		  	<td>Status </td>
		  	<td class="">
		  	<c:choose>
				<c:when test="${'EditView' eq group.actionName}">
							<form:select path="groupStatus" disabled="${1 eq group.groupStatus || empty group.groupStatus ? true : false}"> 
								<form:option value="1" label="Active" /> 
								<form:option value="0" label="Inactive" /> 
							</form:select>
				</c:when>
				<c:otherwise>
							<form:select path="groupStatus"> 
								<form:option value="1" label="Active" /> 
								<form:option value="0" label="Inactive" /> 
							</form:select>
				</c:otherwise>
			</c:choose>		
		  		  	  		
		  	</td>
			<td>&nbsp;</td>
	        <td>&nbsp;</td>
		  </tr>		  
		  
		 </table>
	
	 
		<div id="sectionBttns">
			<input type="button" class="large clButton gray" title="Back" value="Cancel" onClick="location.href='${pageContext.servletContext.contextPath}/<%=WebConstants.VIEW_GROUPS_ACTION%>'"/>
			<input type="button" class="large clButton blue" title="Save"  value="Save"/>
		 	<input type="reset" class="large clButton gray " title="Reset" value="Reset"/></div>
		</div>
</form:form> 
</body>