<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%-- <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.vydya.theschool.common.constants.TSConstants"%>
<%@ page import="com.vydya.theschool.web.constants.WebConstants"%>

<script defer="defer">



</script>

<style type="text/css">
.std-thumb{
	padding: 2px 0px;
}
.std-name{
	 height: 37px;
    line-height: 20px;
    padding: 2px 0 2px 4px;
    width: 156px;
}
.float-left,.float-left div{
	float:left;
}

input[type="text"]{
	width: auto !important; 
}

</style>	
	<script type="text/javascript">  
	jQuery(document).ready(function($){
			  $('.nav-toggle').click(function(){
				  $(".filterTable").slideToggle(1000);
				  });
	});
	</script>
	
	

<div id="tabularDatax">
	<div id="titleBar">
		<div class="title">Search Page</div>
		<div class="addSectionBttn">
			</div> 
	</div>
	<c:if test='${null!=success_key }'>
		<div class="successMsg">
			<spring:message code="${success_key}" />
		</div>
		<c:remove var="success_key" scope="session" />
	</c:if>
		
	</div>
	

<div id="">
		<form:form enctype="multipart/form-data" name="studentSearchForm"
			id="studentSearchForm" class="" method="POST"
			commandName="studentSearchForm">
			<form:input type="hidden" path="actionType" class="" value="view"/>
			<table class="searchTable">
				<tr>
					<td class=""><label for="studentClass" class="">Class</label>
					</td>
					<td class=""><label for="studentClass" class="">Section</label>
					</td>
				</tr>
				<tr>
					<td><form:select path="studentClass" cssClass=""
							disabled="">
							<form:option value="0" 	label="Class" selected="true" />
							<c:forEach items="${classRefList}" var="classRef">
								<form:option value="${classRef.idValue}"
									label="${classRef.description}" />
							</c:forEach>
						</form:select></td>
					<td><form:select path="sectionOfClass" cssClass="" disabled="">
						<form:option value="0" 	label="Section" selected="true"/>
							<c:forEach items="${classSectionRefList}" var="sectionRef">
								<form:option value="${sectionRef.idValue}"
									label="${sectionRef.description}" />
							</c:forEach>
						</form:select></td>
						<tr>
				
				<tr>
					<td colspan="2" style="text-align: center;">
						<button type="submit" class="large clButton blue" id="searchBttn" title="Add">Search</button>
						</td>
				</tr>
			</table>
			
		</form:form>
	<div>
		<c:if test='${null!=classes }'>
		
			<table width="100%" border="0" cellspacing="0" cellpadding="0" id="sectionTableHeader">
				   <tr>
					<th width="8%">&nbsp;</th>
					<th width="8%">Class</th>
					<th width="28%">Class Desc</th>
				  </tr>
				  
			<c:forEach var="class" items="${classes}" >
				
				<tr>
					<td style="text-align:center"></td>
					<td><a href="viewAll.htm?c=${class.id}" >${class.className}</a></td>
					<td>${class.classDesc}</td>
					
					</tr>
			</c:forEach>
			</table>
		</c:if>
	</div>
</div>