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
			     var oTable =	$('#example').dataTable({
					"sPaginationType" : "full_numbers",
					"bJQueryUI" : true
				});
	
			
			  $('.nav-toggle').click(function(){
				  $(".filterTable").slideToggle(1000);
				  });
			  
			   
	});
	</script>
	
	

<div id="tabularDatax">
	<div id="titleBar">
		
 
	</div>
	
		
	
	<div>

		<form:form enctype="multipart/form-data" name="studentForm"
			id="studentForm" class="" method="POST"
			commandName="studentForm">
		
				<table aria-describedby="example_info" class="display dataTable"
					id="example" border="0" cellpadding="0" cellspacing="0">
					<thead>
						<tr >
							<th	style="width: 106px;" colspan="1"	rowspan="1" 
								 class="sorting">Admission No</th>
							<th style="width: 200px;" colspan="1" rowspan="1"
								class="sorting">Student Name</th>
							<c:if test='${null!=subjects }'>
								<c:forEach var="sub" items="${subjects}">
								<th	style="width: 78px;" colspan="1" rowspan="1"
								class="sorting">${sub.subjectName}</th>
								</c:forEach>
							</c:if>
						</tr>
					</thead>
					<tfoot style="display: none">
						<tr>
							<th colspan="1" rowspan="1">Admission No</th>
							<th colspan="1" rowspan="1">Student Name</th>
							<c:if test='${null!=subjects }'>
								<c:forEach var="sub" items="${subjects}">
								<th	colspan="1" rowspan="1"
								class="sorting">${sub.subjectName}</th>
								</c:forEach>
							</c:if>
						</tr>
					</tfoot>
				<tbody >
						<c:if test='${null!=students }'>
							<c:forEach var="student" items="${students}">
							
											<tr class="even_gradeA odd" id="student_${student.admNum}">
												<td class="sorting_1"><div class="fL">${student.firstName}, ${student.lastName}</div></td>
												
												<c:if test='${null!=student.marks }'>
													<c:forEach var="mark" items="${student.marks}">
													<td	>${mark.marks}</td>
													</c:forEach>
												</c:if>
											</tr>
								
							</c:forEach>
						</c:if>
					</tbody>
				</table>
</form:form>
</div>
</div>
			