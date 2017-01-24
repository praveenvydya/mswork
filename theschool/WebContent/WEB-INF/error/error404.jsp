<%@page isELIgnored="false" %>
<%@page contentType="text/html"%>
<%@ page session="true" %>
<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>


 
<c:choose>
      <c:when test="${null!=session.user_name}">
    	 <tiles:insertDefinition name="admin404" /> 
      </c:when>
      <c:otherwise>
     <%--   <tiles:insertDefinition name="404" />   --%>
		 
      </c:otherwise>
</c:choose>
			
				 
				 
   <%--  <% if (session.getAttribute("user_name")== null) { %>
    <tiles:insertDefinition name="404" /> 
    <% } else { %>
    <tiles:insertDefinition name="admin404" /> 
    <% } %>
 --%>
						
 