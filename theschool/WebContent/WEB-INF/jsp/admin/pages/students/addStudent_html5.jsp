<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.vydya.theschool.common.constants.TSConstants"%>
<%@ page import="com.vydya.theschool.web.constants.WebConstants"%>
<script type="text/javascript">  
jQuery(document).ready(function($){
	//$('input').filter('.datepicker').datepicker({ changeMonth: true,changeYear: true, dateFormat:"yy-mm-dd"});

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
	   
}); 
</script>
<style>

</style>

	
<form:form enctype="multipart/form-data" name="studentForm" id="studentForm" class="addForm"
				method="POST" commandName="studentSearchForm">
			<form:input type="hidden" path="actionType" class="" value="add"/>
		<h1>Add Student</h1>
		<p>This is the basic look of my form without table</p>

<div style="" class="formDataDiv">
	<table width="660" border="0" class="order">
		<tbody>

			<tr>
				<td class="firstcol">Title:</td>
				<td><form:radiobutton path="gender" name="gender" id="" checked="checked"
										value="M" class="radio" />
					<label for="iIsMan1">Mr</label>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <form:radiobutton path="gender" name="gender" id="" checked="checked"
										value="F" class="radio" />
					<label for="iIsMan0">Mrs / Ms</label></td>
				<td rowspan="11">
					<div class="studentPhotoFemale">
						<img src="../../images/student_m.png"
							style="width: 200px; height: 250px" /> <label for="file" class="firstcol">Photo:</label>
						<input name="website" class="file"	type="file">
						<form:input type="file" path="files" class="file" id="fileUpload" />
					</div></td>
			</tr>


			<tr>
				<td class="firstcol"><label for="sFirstName" class="">First	Name:</label></td>
				<td><form:input type="text" path="studentName" placeholder="Enter First Name" value=""
					maxlength="200" size="24" /> 
				</td>
			</tr>

			<tr>
				<td class="firstcol"><label for="sLastName" class="">Last Name:</label></td>
				<td><input type="text" value="" maxlength="200" size="24"
					id="sLastName" name="sLastName" class="">
				</td>
			</tr>
			<tr>
				<td class="firstcol"><label for="sFatherName" class="">Father Name:</label></td>
				<td><form:input type="text" path="fatherName" class="" maxlength="200" size="24" id="" name="" /></td>
			</tr>
			<tr>
				<td class="firstcol"><label for="dateOfBirth" class="">Date Of Birth:</label></td>
				<td><form:input maxlength="200"  path="dateOfBirth" class="datepicker" required="" readonly="true"  />
				</td>
			</tr>	
			<tr>
				<td class="firstcol"><label for="rollNumber" class="">Roll	Number:</label></td>
				<td><form:input maxlength="15"  path="rollNumber" class="" maxlength="200" size="24" pattern="[0-9]*" required=""  />
				</td>
			</tr>
			<tr>
				<td class="firstcol"><label for="hallTiketNo" class="">Hall	Ticket Number:</label></td>
				<td><form:input maxlength="15"  path="hallTiketNo" class="" maxlength="200" size="24" pattern="[0-9]*" required=""  />
				</td>
			</tr>
			<tr>
				<td class="firstcol"><label for="emailId" class="">E-mail ID:</label></td>
				<td><form:input type="text" path="emailId" maxlength="50" size="24" placeholder="abcd@example.com" required="" type="email"
					id="" name="" />
				</td>
			</tr>
				<tr>
				<td class="firstcol"><label for="studentClass" class="">Class
						ID:</label>
				</td>
				<td><form:select path="studentClass"
								cssClass="galleryName" disabled="">
								<c:forEach items="${classList}" var="classRef">
									<form:option value="${classRef.idNum}"
										label="${classRef.description}"
										selected="${studentClass eq classRef.idNum ? 'selected': ''}" />
								</c:forEach>
							</form:select>
				</td>
			</tr>
				<tr>
				<td class="firstcol"><label for="sectionOfClass" class="">Section
						ID:</label>
				</td>
				<td><form:select path="sectionOfClass"
								cssClass="galleryName" disabled="">
								<c:forEach items="${classSectionList}" var="sectionRef">
									<form:option value="${sectionRef.idNum}"
										label="${sectionRef.description}"
										selected="${sectionOfClass eq sectionRef.idNum ? 'selected': ''}" />
								</c:forEach>
							</form:select>
				</td>
			</tr>
			<tr>
				<td class="firstcol"><label for="yearOfJoin" class="">Date Of Join:</label></td>
				<td><form:input maxlength="200"  path="yearOfJoin" class="datepicker" required="" readonly="true"  />
				</td>
			</tr>
			<tr>
				<td class="firstcol"><label for="sAddress1" class="">Address
						Line1:</label>
				</td>
				<td><input type="text" value="" maxlength="200" size="24"
					id="sAddress1" name="sAddress1" class="">
				</td>
			</tr>
			<tr>
				<td class="firstcol"><label for="sAddress2" class="">Address
						Line2:</label>
				</td>
				<td><input type="text" value="" maxlength="200" size="24"
					id="sAddress2" name="sAddress2" class="address">
				</td>
			</tr>
			<tr>
				<td class="firstcol"><label for="sStreet" class="">District:</label>
				</td>
				<td><input type="text" value="" maxlength="200" size="24"
					id="sStreet" name="sStreet" class="address">
				</td>
			</tr>

			<tr>
				<td class="firstcol"><label for="sState" class="">State:</label>
				</td>
				<td><input type="text" value="" maxlength="200" size="24"
					id="sState" name="sState" class="city "> <label class=""
					for="sZip"><b>ZIP code:</b>
				</label> <input type="text" value="" maxlength="200" size="24" id="sZip" pattern="[0-9]*"
					name="sZip" class="zip ">
				</td>
			</tr>
			<tr>
				<td class="firstcol"><label for="countryID" class="">Country:</label>
				</td>
				<td><select onchange="CountryChanged(this)" id="countryID"
					name="countryID" class="">
						<option selected="selected" value="0">choose country</option>
						<option value="223">United States of America</option>
				</select></td>
			</tr>
			<tr>
				<td class="firstcol"></td>
				<td><!-- <button type="submit" class="submit">Confirm</button> -->
					
					<input type="button" value="Add" class="submit" id="saveBttn" title="Add"/><button type="reset" class="submit">Reset</button>
				</td>
			</tr>
		</tbody>
	</table>
</div>
</form:form>

