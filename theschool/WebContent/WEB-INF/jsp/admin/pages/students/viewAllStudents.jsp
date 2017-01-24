<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%-- <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.vydya.theschool.common.constants.TSConstants"%>
<%@ page import="com.vydya.theschool.web.constants.WebConstants"%>

<script defer="defer">



</script>

<style type="text/css">


</style>	
	<script type="text/javascript">  
	jQuery(document).ready(function($){
			  $('.nav-toggle').click(function(){
				  $(".filterTable").slideToggle(1000);
				  });
	});
	</script>
	
	

<div id="tabularDatax">
	
<c:if test='${null!=studentlist }'>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" id="sectionTableHeader">
				   <tr>
					<th width="8%">&nbsp;</th>
					<th width="8%">Name</th>
					<th width="28%"></th>
				  </tr>
			<c:forEach var="student" items="${studentlist}" >
				<tr>
					<td style="text-align:center">${student.admNum}</td>
					<td><a href="view.htm?s=${student.studentId}" >${student.firstName}, ${student.lastName} </a></td>
					<td></td>
					</tr>
			</c:forEach>
			</table>
		</c:if>
</div>