<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.vydya.theschool.common.constants.TSConstants"%>
<%@ page import="com.vydya.theschool.web.constants.WebConstants"%>
<script type="text/javascript">  
jQuery(document).ready(function($){
	
	 var d = new Date();
	var year = d.getFullYear();
	var stY= year-19;
	var endY = year-2;
	 $(".datepicker").datepicker({  
	            changeMonth: true,
	            changeYear: true,
	            showButtonPanel: true,
				dateFormat:'yy-mm-dd',
				yearRange: stY+":"+endY,
				showButtonPanel: false
				//shortYearCutoff: 10
	        }); 
	 
	  $('#saveBttn').click(function(){
		
		$('#saveBttn').attr("disabled", true);	
		$("#studentForm").attr("action", '<%=TSConstants.ACTION_ADD%>.htm');
		$("#studentForm").submit();
		//loadEvents();
	});   
	 
	  $('#fileUpload').change(function(){
		    //ajaxFileUpload();
		});
	 
	  /* function ajaxFileUpload(){
		    $.ajaxFileUpload({
		        url:'upload.php',
		        secureuri:false,
		        fileElementId:'fileUpload',
		        dataType: 'json',
		        success: function(data,status){
		            if(typeof(data.error) != 'undefined'){
		                if(data.error){
		                    //print error
		                    alert(data.error);
		                }else{
		                    //clear
		                   // $('#img img').attr('src',url+'cache/'+data.msg);
		                    alert("else case");
		                }
		            }
		        },
		        error: function(data,status,e){
		            //print error
		            alert(e);
		        }
		    });
		    return false;
		} */
	   
		
		
	  updateMarksTotal();
		function updateMarksTotal(){
			$("table.examMarksTable").each(function(){
				var totals = 0;
				var tms = 0;
				 $(this).find('.mark').each(function(i){        
			         totals+=parseInt( $(this).html());
			     });
				 $(this).find('.finalMarks').html(totals);
				 
				 $(this).find('.tms').each(function(i){        
			         tms+=parseInt( $(this).html());
			     });
				 $(this).find('.totalMarks').html(tms);
			});
			
			//
		}
		
		 $('.editM').click(function(){
			 var exam = $(this).attr("id").split('_');
			 var examId = parseInt(exam[1]);
			 $(this).parents("table.examMarksTable").find("th #saveMarks_"+examId).css("display","inherit");
			 $(this).parents("table.examMarksTable").find("th #cancelMarks_"+examId).css("display","inherit");
			 $(this).css("display","none");
			// $(this).parents("table.examMarksTable").find("td .dis").css("display","none");
			 $(this).parents("table.examMarksTable").find("td .marks-s").removeAttr("disabled");
			 
			});
		 
		 
		 $('.cancelM').click(function(){
			 var exam = $(this).attr("id").split('_');
			 var examId = parseInt(exam[1]);
			 $(this).parents("tr").find("th #editMarks_"+examId).css("display","inherit");
			 $(this).parents("tr").find("th #saveMarks_"+examId).css("display","none");
			
			 $(this).css("display","none");
			// $(this).parents("table.examMarksTable").find("td .dis").css("display","block");
			 $(this).parents("tr").find("td .mark").attr("disabled", true);
			}); 
		 
		 $('.saveM').click(function(){
		
				 var exam = $(this).attr("id").split('_');
				 var examId =  (exam[1]);
				 $("#selectedExam").val(examId);
				 $.post('updateStudentMarks.htm',$("#studentForm").serialize(),function(data){updatedStudentMarks($(this),examId,data);});
			}); 
		 
		 function updatedStudentMarks(d,exmId,data){
			 
				$.each(data, function(index, subjMarks) {
						
						$("#m_"+subjMarks.studentMarksData.id).html(subjMarks.studentMarksData.marksGot);
					});

				$("th #editMarks_"+exmId).css("display","inherit");
				$("th #saveMarks_"+exmId).css("display","none");
				$("th #cancelMarks_"+exmId).css("display","none");
				//$("td .dis").css("display","block");
				$("td .mark").attr("disabled", true);
				updateMarksTotal();
		 }
		
			
		 $(".mark").keydown(function(event) {
		        // Allow: backspace, delete, tab, escape, and enter
		        if ( event.keyCode == 46 || event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 27 || event.keyCode == 13 || 
		             // Allow: Ctrl+A
		            (event.keyCode == 65 && event.ctrlKey === true) || 
		             // Allow: home, end, left, right
		            (event.keyCode >= 35 && event.keyCode <= 39)) {
		                 // let it happen, don't do anything
		                 return;
		        }
		        else {
		            // Ensure that it is a number and stop the keypress
		            if (event.shiftKey || (event.keyCode < 48 || event.keyCode > 57) && (event.keyCode < 96 || event.keyCode > 105 )) {
		                event.preventDefault(); 
		            } 
		            else {
			             //Ensure that it is a number and stop the keypress
			           if ($(this).val()>100) {
			            	event.preventDefault();
			            	//alert("try");
			            }   
			        }
		        }
		    });
		  
		  
		 /*  $('.mark').rules('add', {
		    required: true,
		    digits: true,
		    max: 255
		});
	  
	  
	 $(".mark").validate({
	        rules: {
	            field_name: {
	                numericOnly:true
	            }
	        }
	    });
	 
	 $.validator.addMethod('numericOnly', function (value) { 
		   return /[0-9 ]/.test(value); 
		}, 'Please only enter numeric values (0-9)');
	 
	  */
	  
		
}); 


</script>
<style>
th .link{
display: inline;
}
th div{
float: right;
}
</style>

	
<form:form enctype="multipart/form-data" name="studentForm" id="studentForm" class=""
				method="POST" commandName="student">
		<h1>${student.studentName}</h1>
		<p>This is the basic look of my form without table</p>
<c:if test='${null!=success_key }'>
		<div class="successMsg"><spring:message code="${success_key}" /></div>
		<c:remove var="success_key" scope="session" />
	</c:if>	
	<form:hidden	 path="studentId"/>
	<form:hidden	 path="studentClassData.id"/>
	
<div style="" class="formDataDiv addForm">
	<table width="660px" border="0" class="order">
		<tbody>
			<tr>
				
				<td rowspan="11">
					<div class="studentPhotoFemale">
					
						<c:choose>
							<c:when test="${null!=student.photo}">
								<img class="main-image" width="70%"
							src="data:image/jpg;base64,<c:out value='${student.photo}'/>" />
							</c:when>
							<c:otherwise>
								<img src="../../images/student_m.png"
							style="width: 200px; height: 250px" />
							</c:otherwise>
						</c:choose>
						
					</div></td>
			</tr>


			<tr>
				<td class="firstcol"><label for="sFirstName" class="">First	Name:</label></td>
				<td>${student.studentName}
				</td>
			</tr>

			
			<tr>
				<td class="firstcol"><label for="sFatherName" class="">Father Name:</label></td>
				<td>${student.fatherName}</td>
			</tr>
			<tr>
				<td class="firstcol"><label for="dateOfBirth" class="">Date Of Birth:</label></td>
				<td>${student.dateOfBirth}</td>
			</tr>	
			<tr>
				<td class="firstcol"><label for="rollNumber" class="">Roll	Number:</label></td>
				<td>${student.rollNumber}
				</td>
			</tr>
			<tr>
				<td class="firstcol"><label for="hallTiketNo" class="">Hall	Ticket Number:</label></td>
				<td>${student.hallTiketNo}
				</td>
			</tr>
			<tr>
				<td class="firstcol"><label for="emailId" class="">E-mail ID:</label></td>
				<td>${student.emailId}
				</td>
			</tr>
				<tr>
				<td class="firstcol"><label for="studentClass" class="">Class
						ID:</label>
				</td>
				<td>${student.studentClass.className}
				</td>
			</tr>
				<tr>
				<td class="firstcol"><label for="sectionOfClass" class="">Section
						ID:</label>
				</td>
				<td>${student.sectionOfClass}
				</td>
			</tr>
			<tr>
				<td class="firstcol"><label for="dateOfJoin" class="">Date Of Join:</label></td>
				<td>${student.dateOfJoin}
				</td>
			</tr>
			
			
		</tbody>
	</table>
		<form:hidden	 path="studentClass"/>
	<%-- <form:checkbox  id="exam_${examSubjectData.examData.id}" value="${examSubjectData.examData.id}" 
					checked="" path="examSubjectList[${examStatus.index}].examData.id"  cssClass="" cssStyle="display: none;"/> --%>
</div>

	<div width="" border="0"  class="formDataDiv">


		<c:forEach items="${student.examSubjectList}" var="examSubjectData" varStatus="examStatus">
			
			<form:hidden	 path="selectedExam" value="" id="selectedExam"/>
			
			<table class="examMarksTable">
			<form:hidden	 path="examSubjectList[${examStatus.index}].examData.id" value="" id="exam_${examSubjectData.examData.id}"/>
				<thead>
					<tr>
						<th >${examSubjectData.examData.examDesc}</th>
						<th  colspan="2" style="text-align: right;"><div class="editicon editM" style="" id="editMarks_${examSubjectData.examData.id}"></div>
							<div class="link cancelM" style="display: none;" id="cancelMarks_${examSubjectData.examData.id}">Cancel</div>
							<div class="link saveM" style="display: none;" id="saveMarks_${examSubjectData.examData.id}">Save</div>
						</th>
					</tr>
					<tr>
						<td scope="col" width="70%" >Subject</td><td scope="col" width="10%" > Marks</td><td scope="col" width="20%"> Total Marks</td>
					</tr>
				</thead>
				<tfoot>
				<tr>
				<td>Total Marks:</td><td><span class="finalMarks"></span></td><td><span class="totalMarks"></span></td>
				</tr>
				</tfoot>

				<tbody><c:forEach items="${examSubjectData.subjectMarksDataList}"
					var="subjectMarksData" varStatus="mStatus">
					<form:hidden path="examSubjectList[${examStatus.index}].subjectMarksDataList[${mStatus.index}].subjectData.id"/>
					<form:hidden path="examSubjectList[${examStatus.index}].subjectMarksDataList[${mStatus.index}].studentMarksData.id"/>
					<tr>
						<td ><form:label path="examSubjectList[${examStatus.index}].subjectMarksDataList[${mStatus.index}].subjectData.subjectName"/>
								<c:out value="${subjectMarksData.subjectData.subjectName}" />
								</td>
						<td ><form:input size="3" maxlength="" path="examSubjectList[${examStatus.index}].subjectMarksDataList[${mStatus.index}].studentMarksData.marksGot" 
								cssClass="marks-s mark" disabled="true"/>
								</td>
						<td class="" ><span class="tms" id="tm_${subjectMarksData.studentMarksData.id}">${subjectMarksData.studentMarksData.totalMarks}</span></td>
					</tr>
					

				</c:forEach>
				</tbody>
			</table>
		</c:forEach>



	</div>
</form:form>

