<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%-- <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.vydya.theschool.common.constants.TSConstants"%>
<%@ page import="com.vydya.theschool.web.constants.WebConstants"%>

<style type="text/css">

.examMarksTable th.examName{
	width: 17%
}
.examMarksTable td{
	width: 11%;
	 text-align: center;
    vertical-align: middle;
     padding: 1px 5px;
	
}
.marksTable{
	width: 100%;
	 padding: 5px 10px;
}

.examMarksTable td.butns{
	width: 50px;
}

.examMarksTable td.butns div{
	float: left;
}

.examMarksTable{
	width: 100% !important;
}
table.display td {
    padding: 3px 5px;
}
table.display thead th {
    padding: 3px !important;
}

.subjects table th {
    padding: 1px 5px;
    text-align: center;
    vertical-align: middle;
    width: 17%;
}


</style>
<script type="text/javascript">  
	jQuery(document).ready(function($){
	
		updateMarksTotal();
			function updateMarksTotal(){
				$(".studentMarksRow").each(function(){
					var totals = 0;
					 $(this).find('.mark').each(function(i){        
				         totals+=parseInt( $(this).html());
				     });
					 $(this).find('.finalMarks').html(totals);
				});
			}	
			
			 $("#marksSearchForm").validate({
				rules: {   
						studentClass: {required: true},
					 	sectionOfClass: {required: true},
					 	campus: {required: true},
					 	exam: {required: true}
				},
				messages: {
					studentClass: {required: "Please Select Class."},
				 	sectionOfClass: {required: "Please Select Section."},
				 	campus: {required: "Please Select Campus."},
				 	exam: {required: "Please Select Exam."}
				},
				submitHandler: function(form) { 
					$(this).attr("disabled", true);	
					$("#marksSearchForm").submit();
					},
				invalidHandler: function(form, validator) {
				}
			}); 		 
			updateColspanForSubjects();
		function updateColspanForSubjects(){
			
			var numItems = $('.subject').length;
			
			$(".subTableExamMarks").attr('colspan',numItems+3);
		}
		
		 $('.editM').click(function(){
			 var exam = $(this).attr("id").split('_');
			 var studentId = parseInt(exam[1]);
			 var examId = parseInt(exam[2]);
			 $(this).parents("tr").find("td #saveMarks_"+studentId+"_"+examId).css("display","inherit");
			 $(this).parents("tr").find("td #cancelMarks_"+studentId+"_"+examId).css("display","inherit");
			 $(this).css("display","none");
			// $(this).parents("tr.studentMarksRow").find("td .dis").css("display","none");
			 $(this).parents("tr").find("td .mark").removeAttr("disabled");
			 
			});
		 
		 $('.cancelM').click(function(){
			 var exam = $(this).attr("id").split('_');
			 var studentId = parseInt(exam[1]);
			 var examId = parseInt(exam[2]);
			 $(this).parents("tr.studentMarksRow").find("td #editMarks_"+studentId+"_"+examId).css("display","inherit");
			 $(this).parents("tr.studentMarksRow").find("td #saveMarks_"+studentId+"_"+examId).css("display","none");
			
			 $(this).css("display","none");
			 //$(this).parents("tr.studentMarksRow").find("td .dis").css("display","block");
			 $(this).parents("tr.studentMarksRow").find("td .mark").attr("disabled", true);
			 
			}); 
		 
		 $('.saveM').click(function(){
		
				 var exam = $(this).attr("id").split('_');
				 var studentId = parseInt(exam[1]);
				 var examId = parseInt(exam[2]);
				 $("#selectedExam").val(examId);
				 $("#seletctedStudent").val(studentId);
				 
				 $.post('update.htm',$("#marksSearchForm").serialize(),function(data){updatedStudentMarks($(this),studentId,examId,data);});
			}); 
		 
		 $('#expexel').click(function(){
				
			 $('#expexel').attr("disabled", true);	
				$('#exportOptn').val(true);
				$("#marksSearchForm").submit();
			});
		
		 
		 
		 function updatedStudentMarks(d,stdId,exmId,data){
			 
				$.each(data, function(index, subjMarks) {
						 $("#m_"+subjMarks.studentMarksData.id).html(subjMarks.studentMarksData.marksGot);
					});
				
				$("#editMarks_"+stdId+"_"+exmId).css("display","inherit");
				$("#saveMarks_"+stdId+"_"+exmId).css("display","none");
				$("#cancelMarks_"+stdId+"_"+exmId).css("display","none");
				 
				//$("td .dis").css("display","block");
				$("td .mark").attr("disabled", true); 
				 updateMarksTotal();
			}
		
		});
</script>



<div id="tabularDatax">
	<div id="titleBar">
		<div class="title">Search Page</div>
		<div class="addSectionBttn"></div>
	</div>
	<c:if test='${null!=success_key }'>
		<div class="successMsg">
			<spring:message code="${success_key}" />
		</div>
		<c:remove var="success_key" scope="session" />
	</c:if>

</div>


<div id="tabularDataWidex">
	<form:form name="marksSearchForm" id="marksSearchForm" class=""
		method="POST" commandName="marksSearch">
		
		<form:hidden	 path="export" value="" id="exportOptn"/>
		<form:hidden	 path="selectedExam" value="" id="selectedExam"/>
		<form:hidden	 path="seletctedStudent" value="" id="seletctedStudent"/>
		<table class="searchTable">
			<tr>
				<td class=""><label for="studentClass" class="">Class</label></td>
				<td class=""><label for="studentClass" class="">Section</label>
				</td>
				<td class=""><label for="campus" class="">Campus</label></td>
				<td class=""><label for="exam" class="">Exam</label></td>

			</tr>
			<tr>
				<td><form:select path="studentClass" cssClass="" disabled="">
						<form:option value="" label="Class" selected="true" />
						<c:forEach items="${classRefList}" var="classRef">
							<form:option value="${classRef.idNum}"
								label="${classRef.description}" />
						</c:forEach>
					</form:select>
				</td>
				<td><form:select path="sectionOfClass" cssClass="" disabled="">
						<form:option value="" label="Section" selected="true" />
						<c:forEach items="${classSectionRefList}" var="sectionRef">
							<form:option value="${sectionRef.idValue}"
								label="${sectionRef.description}" />
						</c:forEach>
					</form:select>
				</td>
				<td><form:select path="campus" cssClass="" disabled="">
						<form:option value="" label="Campus" selected="true" />
						<c:forEach items="${campusRefList}" var="campusRef">
							<form:option value="${campusRef.idValue}"
								label="${campusRef.description}" />
						</c:forEach>
					</form:select>
				</td>
				<td><form:select path="exam" cssClass="" disabled="">
						<form:option value="" label="Exam" selected="true" />
						<c:forEach items="${examRefList}" var="examRef">
							<form:option value="${examRef.idNum}"
								label="${examRef.description}" />
						</c:forEach>
					</form:select>
				</td>
			<tr>
			<tr>
				<td colspan="4" style="text-align: center;">
					<button type="submit" class="submit" id="searchBttn" title="Add">Search</button>
				</td>
			</tr>
		</table>
		<table>
		</table>


	<c:if test='${null!=marksSearch.studentList }'>
		<c:choose>
			<c:when test="${empty marksSearch.studentList}">
				<div class="alertMsg">No Records Found</div>
			</c:when>
			<c:otherwise>
			<!-- display dataTable marksTable -->
				<table  class="" id="sectionTableHeader" border="0" cellpadding="0" cellspacing="0">
					<thead>
						<tr>
							<th style="width: 100px;" colspan="1" rowspan="1"
								class="sorting_asc">Student Name</th>
							<th style="width: 50px;" colspan="1" rowspan="1" class="sorting">Roll Number</th>
							<th style="width: 50px;" colspan="1" rowspan="1" class="sorting">Class</th>
							<th style="width: 75px;" colspan="1" rowspan="1" class="sorting">Section</th>
							<th style="width: 55px;" colspan="1" rowspan="1" class="sorting">Exam</th>
							<!-- <th style="" colspan="1" rowspan="1" class="subjects">
								<table width="100%">
									<tr> -->
										<c:forEach var="subject" items="${marksSearch.subjectList}" varStatus="sub">
											<th style="" colspan="1" rowspan="1" class="subject"><form:input disabled="true" class="displayInput" path="subjectList[${sub.index}].subjectName"/></th>
											
									 	</c:forEach><%--
									</tr>
								</table>
							</th> --%>
							<th style="width:34px" colspan="1" rowspan="1" class="sorting">Total</th>
							<th style="width: 60px;" colspan="1" rowspan="1" class="sorting">&nbsp;</th>
							
						</tr>
					</thead>
					<tbody>
						<c:forEach var="student" items="${marksSearch.studentList}" varStatus="std">
							<form:hidden	 path="studentList[${std.index}].studentId" value="" id=""/>
							<form:hidden	 path="studentList[${std.index}].studentClassData.id" value="" id=""/>
									<tr id="student_${student.studentId}" class="studentMarksRow">
											<td class="" width="15%">
												<form:input disabled="true" class="displayInput" path="studentList[${std.index}].studentName"/>
											</td>
											<td class="" width="10%"><form:input disabled="true" class="displayInput" path="studentList[${std.index}].rollNumber"/></td>
											<td class="" width="7%"><form:input disabled="true" class="displayInput" path="studentList[${std.index}].studentClassData.className"/></td>
											<td class="" width="3%"><form:input disabled="true" class="displayInput" path="studentList[${std.index}].sectionOfClass"/></td>
											<!-- <td class="subTableExamMarks" width="65%"  colspan="8"> -->
												<c:forEach items="${student.examSubjectList}" var="examSubjectData" varStatus="examStatus">
													<%-- <table class="examMarksTable" style="margin: 0px;" id="std_${student.studentId}_exam_${examSubjectData.examData.id}"> --%>
													<form:hidden	 path="studentList[${std.index}].examSubjectList[${examStatus.index}].examData.id" value="" id="exam_${examSubjectData.examData.id}"/>
														<!-- <tr> -->
															<td class="examName"><form:input disabled="true" class="displayInput" path="studentList[${std.index}].examSubjectList[${examStatus.index}].examData.examDesc"/></td>
														<c:forEach items="${examSubjectData.subjectMarksDataList}"
															var="subjectMarksData" varStatus="mStatus">
															<form:hidden path="studentList[${std.index}].examSubjectList[${examStatus.index}].subjectMarksDataList[${mStatus.index}].subjectData.id"/>
															<form:hidden path="studentList[${std.index}].examSubjectList[${examStatus.index}].subjectMarksDataList[${mStatus.index}].studentMarksData.id"/>
																<td >
																	<form:input size="3" maxlength="" path="studentList[${std.index}].examSubjectList[${examStatus.index}].subjectMarksDataList[${mStatus.index}].studentMarksData.marksGot" 
																	cssClass="marks-s mark" disabled="true" />
																		</td>
																
														</c:forEach>
														<td><span class="finalMarks"></span></td>
														<td  colspan="2" style="text-align: right;" class="butns">
																	<div class="editicon editM " style="" title="Edit" id="editMarks_${student.studentId}_${examSubjectData.examData.id}"></div>
																	<div class="link cancelM" style="display: none;" title="Cancel" id="cancelMarks_${student.studentId}_${examSubjectData.examData.id}">C</div>
																	<div class="link saveM" style="display: none;"  title="Save" id="saveMarks_${student.studentId}_${examSubjectData.examData.id}">S</div>
																</td>
														<!-- </tr>
														</tbody>
													</table> -->
												</c:forEach>
											<!-- </td> -->
										</tr>
									</c:forEach>
										
									</tbody>
								</table>
							
				<div class="exportDiv"><div id="expexel">Export To Exel</div></div>
			</c:otherwise>
		</c:choose>

	</c:if></form:form>
</div>
</div>