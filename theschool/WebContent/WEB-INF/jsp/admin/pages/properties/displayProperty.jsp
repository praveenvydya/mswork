<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="ts" uri="/WEB-INF/ts-tags.tld" %>
<%@ page import="com.vydya.theschool.web.constants.WebConstants" %> 
<%@ page import="com.vydya.theschool.common.constants.TSConstants" %> 
<script language="javascript">
function onPropertiesSubmit()
{
	
	if(document.pressed == 'Reload')
	{
		document.PropertiesForm.action ="<%=TSConstants.ACTION_RELOAD_ALL_PROPERTIES%>.htm";
	}

$('input:submit').click(function(){
        
        $('input:submit').attr("disabled", true); 
  });
}
</script>
<form:form name="PropertiesForm"  method="POST"  action="saveAllProperties.htm"  modelAttribute="properties" onsubmit="return onPropertiesSubmit();">
				<c:if test='${null!=success_key }'>
				<div class="successMsg"><spring:message code="${success_key}" /></div>
				<c:remove var="success_key" scope="session" />
				</c:if>
				  <div class="title">Properties Details </div>
				 
<table width="100%" border="0" cellspacing="0" cellpadding="0" id="sectionTableHeader">
				   <tr>					
					<th width="35%">Key</th>
					<th width="30%">Value</th>	
					<th width="35%">Property Description</th>					
				  </tr>
				  <c:forEach items="${properties.propertyList}"  var="property"  varStatus="status">
				  <tr><form:hidden path="propertyList[${status.index}].key" />
				  <td><form:label  path="propertyList[${status.index}].key" id="propertyList[${status.index}].key"/><c:out value="${property.key}" /></td>
					<td><form:input size="50" maxlength="200" path="propertyList[${status.index}].value" id="propertyList[${status.index}].value"/></td>
					<td><form:input size="50" maxlength="200" path="propertyList[${status.index}].propertyDesc" id="propertyList[${status.index}].propertyDesc"/></td>
				  </tr>
				  </c:forEach>
				  </table>
				   <div id="sectionBttns">
				  <ts:button validateAction="true" action="<%=WebConstants.SAVE_PROPERTIES_ACTION%>"  type="submit" cssClass="large clButton green"    name="Save"   title="Save"  value="Save"   />
				  <ts:button validateAction="true" action="<%=WebConstants.RELOAD_PROPERTIES_ACTION%>"  type="submit" cssClass="large clButton green"  name="Reload" title="Reload" value="Reload" onClick="document.pressed=this.name;" />
				  <!-- <input type="reset" class="resetBttnBlack" value="" title="Reset"/> -->
				 
				  </div>
</form:form>