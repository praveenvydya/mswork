<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div id="navigation_wrapper">
      <div id="navigation">
   
        <ul>
        
       <c:forEach items="${sessionScope.user_role_permissions}" var="section" varStatus="loop"  > 
       <c:choose><c:when  test='${loop.index=="0"}'>
        <li class="selected"><a href="#" class="activeTab"><c:out value="${section.sectionName}" /></a>
            <ul>
            <c:forEach items="${section.reports}" var="report" varStatus="loopReport"  > 
            <c:if test="${'COMMON'!=report.reportType }">
              <li><a href="${pageContext.servletContext.contextPath}/${report.reportName}/${report.actions[0].actionName}.htm"><c:out value="${report.uiDisplayName}" /></a></li>
              </c:if>
            </c:forEach>  
            </ul>
          </li>
          </c:when>
           <c:otherwise>
           
            <li ><a href="#" ><c:out value="${section.sectionName}" /></a>
            <ul>
            <c:forEach items="${section.reports}" var="report" varStatus="loopReport"  > 
             <c:if test="${'COMMON'!=report.reportType }">
              <li>
              	<a href="${pageContext.servletContext.contextPath}/${report.reportName}/${report.actions[0].actionName}.htm"><c:out value="${report.uiDisplayName}" /></a>
	    	  </li></c:if>
            </c:forEach>  
            </ul>
          </li>
           </c:otherwise>
         	</c:choose> 
        </c:forEach>         
          
        </ul>
        <div class="clear"></div>
      </div>
    </div>
    
    
    
  