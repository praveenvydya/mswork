<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%-- <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.vydya.theschool.common.constants.TSConstants"%>
<%@ page import="com.vydya.theschool.web.constants.WebConstants"%>
<script type='text/javascript' src='<spring:message code="static.application.name"/>/javascript/jquery.marks.js'></script>
<script type='text/javascript' src='<spring:message code="static.application.name"/>/javascript/datatable/jquery.table2excel.js'></script>
<script type='text/javascript' src='<spring:message code="static.application.name"/>/javascript/jquery.charts.js'></script>
<script type='text/javascript' src='<spring:message code="static.application.name"/>/javascript/jquery.charts.pie.js'></script>
<script type='text/javascript' src='<spring:message code="static.application.name"/>/javascript/datatable/jquery.table2excel.js'></script>
<link href="<spring:message code="static.application.name"/>/css/tables.css" rel="stylesheet" type="text/css" />	
<style type="text/css">
.marksSheet{
	margin: 20px;
}
.ui-datepicker-calendar{
display: none;
}

#sectionsTable div {
width: auto;
min-height: 20px;
float: none;
margin: 0px;
padding: 0px 2px;
background-color: #EEE;
text-align: center;
}

table input[type="text"]{
height: 10px;
margin: 0px !important;
}
#sectionsTable td {
border-left: 1px solid #e4e3e1;
border-right: 1px solid #e4e3e1;
text-align: center;
padding: 5px;
}
select {
margin: 0px !important;
}

.legendLabel{
	margin: 2px;
}

.legend table td{
	vertical-align: middle !important;
	padding: 3px;
}
.pie{

padding-top: 20px;
display: inline-block;
}

.demo-container {
		position: relative;
		height: 400px;
	}

	#placeholder {
		width: 550px;
		height: 400px;
		margin: 15px auto;
	}
	.setCheck{
		margin: 10px auto;
	}
	.setCheck td input{
		margin: 0px 20px;
	}
	
	.setCheck td div{
		padding: 15px;
	}
	
	

</style>
<script type="text/javascript">  
	jQuery(document).ready(function($){
		$(".marksSheet").marks({
			path:'<spring:message code="application.name"/>${pageContext.servletContext.contextPath}',
			classId:$('#classId').val(),
			className:$('#className').val()
		}); 
		});
</script>



<div id="tabularData">
	
	<form:form name="classForm" id="classForm" class=""
		method="POST" commandName="classForm">
		<form:input type="hidden" path="id" id="classId"/>
		<form:input type="hidden" path="className" id="className"/>
		<div>Class: ${classForm.className} (${classForm.classid})</div>
		<div class="marksSheet"></div>
	</form:form>
	
	
</div>

