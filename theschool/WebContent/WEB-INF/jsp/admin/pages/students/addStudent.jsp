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
		$('#actionType').val("add");
		$("#studentForm").attr("action", '<%=TSConstants.ACTION_ADD%>.htm');
							$("#studentForm").submit();
						});


				formName = 'studentForm';
				cropRatio = 35 / 45;
				photoId = 'cropedImage';
				imageUrl = '../../images/student_m.png';
				/* $('#crop-submit').click(function(){
					alert("crp submit");
					 $("#studentForm").ajaxSubmit(optionsForCrop);
					 
					}); */
					
				 $("#cropedImage").click(function(){
					   $("#fileUpload").click();
					});

			});
</script>
<style>

.genderSelect label,.genderSelect input{
	float: left;
	margin: 4px;
}


</style>


<form:form enctype="multipart/form-data" name="studentForm"
	id="studentForm" class="" method="POST" commandName="studentSearchForm">
	<form:input type="hidden" path="addressId" class="" />
	<form:input type="hidden" path="x" class="" />
	<form:input type="hidden" path="y" class="" />
	<form:input type="hidden" path="height" class="" />
	<form:input type="hidden" path="width" class="" />
	<form:input type="hidden" path="actionType" class="" />
	<div class=""> <!-- blFormDivx form-header form-container-->

		<div class="clearfix">
			<h2 class="bg-header">Add Student</h2>
			<a id="" href=""></a>

		</div>
		<div class="clearfix" id="" style="position: relative;">
			<c:if test='${null!=success_key }'>
				<div class="successMsg">
					<spring:message code="${success_key}" />
				</div>
				<c:remove var="success_key" scope="session" />
			</c:if>

			<div style="" class="formDataDiv addForm">
				<table width="660" border="0" class="order">
					<tbody>
						<tr>
							<td class="firstcol">Title:</td>
							<td class="genderSelect"><div><form:radiobutton path="gender" name="gender" id=""
									checked="checked" value="M" class="radio" /> <label
								for="iIsMan1">Mr</label> </div><div><form:radiobutton
									path="gender" name="gender" id="" value="F" class="radio" /> <label
								for="iIsMan0">Mrs / Ms</label></div>
							</td>
							<td rowspan="11">
								<div class="studentPhotoFemale">

									<label for="file" class="firstcol">Photo:</label>
									<form:input type="file" path="file" class="file"
										id="fileUpload" />
								</div> <img src="../../images/student_m.png" id="cropedImage"
								style="width: 150px; height: auto" /> <span class="errormsg"
								id="ImageError"></span>
							</td>
						</tr>


						<tr>
							<td class="firstcol"><label for="sFirstName" class="">First
									Name:</label>
							</td>
							<td><form:input type="text" path="studentName" value=""
									required="true" maxlength="200" size="24" /></td>
						</tr>

						<tr>
							<td class="firstcol"><label for="sLastName" class="">Last
									Name:</label>
							</td>
							<td><input type="text" value="" maxlength="200" size="24"
								id="sLastName" name="sLastName" class=""></td>
						</tr>
						<tr>
							<td class="firstcol"><label for="sFatherName" class="">Father
									Name:</label>
							</td>
							<td><form:input type="text" path="fatherName" class=""
									maxlength="200" size="24" id="" name="" />
							</td>
						</tr>
						<tr>
							<td class="firstcol"><label for="dateOfBirth" class="">Date
									Of Birth:</label>
							</td>
							<td><form:input maxlength="200" path="dateOfBirth"
									class="datepicker" required="" readonly="true" /></td>
						</tr>
						<tr>
							<td class="firstcol"><label for="rollNumber" class="">Roll
									Number:</label>
							</td>
							<td><form:input maxlength="15" path="rollNumber" class=""
									size="24" required="true" /></td>
						</tr>
						<tr>
							<td class="firstcol"><label for="hallTiketNo" class="">Hall
									Ticket Number:</label>
							</td>
							<td><form:input maxlength="15" path="hallTiketNo" class=""
									size="24" /></td>
						</tr>
						<tr>
							<td class="firstcol"><label for="emailId" class="">E-mail
									ID:</label>
							</td>
							<td><form:input type="text" path="emailId" maxlength="50"
									size="24" id="" name="" /></td>
						</tr>
						<tr>
							<td class="firstcol"><label for="studentClass" class="">Class
									Name:</label></td>
							<td><form:select path="studentClass" cssClass="galleryName"
									disabled="">
									<c:forEach items="${classRefList}" var="classRef">
										<form:option value="${classRef.idValue}"
											label="${classRef.description}"
											selected="${studentClass eq classRef.idNum ? 'selected': ''}" />
									</c:forEach>
								</form:select></td>
						</tr>
						<tr>
							<td class="firstcol"><label for="sectionOfClass" class="">Section:</label>
							</td>
							<td><form:select path="sectionOfClass" cssClass=""
									disabled="">
									<c:forEach items="${classSectionRefList}" var="sectionRef">
										<form:option value="${sectionRef.idValue}"
											label="${sectionRef.description}"
											selected="${sectionOfClass eq sectionRef.idNum ? 'selected': ''}" />
									</c:forEach>
								</form:select></td>
						</tr>
						<tr>
							<td class="firstcol"><label for="campus" class="">Campus
									:</label></td>
							<td><form:select path="campus" cssClass="" disabled="">
									<c:forEach items="${campusRefList}" var="campusRef">
										<form:option value="${campusRef.idValue}"
											label="${campusRef.description}"
											selected="${campus eq campusRef.idNum ? 'selected': ''}" />
									</c:forEach>
								</form:select></td>
						</tr>
						<tr>
							<td class="firstcol"><label for="dateOfJoin" class="">Date
									Of Join:</label>
							</td>
							<td><form:input maxlength="200" path="dateOfJoin"
									class="datepicker" readonly="true" /></td>
						</tr>
						<tr>
							<td class="firstcol"><label for="sAddress1" class="">Address
									Line1:</label></td>
							<td><form:input maxlength="200" path="addressLine1" class="" />
							</td>
						</tr>
						<tr>
							<td class="firstcol"><label for="sAddress2" class="">Address
									Line2:</label></td>
							<td><form:input maxlength="200" path="addressLine2" class="" />
							</td>
						</tr>
						<tr>
							<td class="firstcol"><label for="sStreet" class="">District:</label>
							</td>
							<td><form:input maxlength="100" path="district" class="" />
							</td>
						</tr>

						<tr>
							<td class="firstcol"><label for=state class="">State:</label>
							</td>
							<td><form:input maxlength="100" path="state" class=" " /></td>
						</tr>
						<tr>
							<td class="firstcol"><label for="sZip" class="">Zip
									Code:</label></td>
							<td><form:input path="zipcode" class=" " maxlength="6"
									size="24" type="text" />
							</td>
							</td>
						</tr>

						<tr>
							<td class="firstcol"></td>
							<td>
								<button type="" class="large clButton green" id="saveBttn" title="Add">Add</button>
								<button type="reset" class="large clButton gray">Reset</button></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>




	</div>


</form:form>

