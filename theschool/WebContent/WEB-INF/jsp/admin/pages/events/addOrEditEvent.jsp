<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.vydya.theschool.common.constants.TSConstants"%>
<%@ page import="com.vydya.theschool.web.constants.WebConstants"%>
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/datatable/jquery_002.js"></script>
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery-ui-timepicker.js"></script>
<script type="text/javascript">  
jQuery(document).ready(function($){
	
	
	$("#imageForm").validate({
		rules: {   
			 	imageFile : {
					required : {
						depends : function(
								element) {
							return ($('#cropedImage').src == '');
						}
					},
					extension: "jpeg|jpg",
				},
		},
		messages: {
			imageFile : {
				required : "Please Select a Book category Image.",
				extension:"Please select a valid format(.jpeg)"
			}
		}
 });
	
	 $("#eventForm").validate({
			rules: {   
				 	name: {required: true},
				   eventDesc: {required: true},
				   eventPlace: {required: true},
				   eventDateS: {required: true},
				   eventCategory: {required: true},
				   title: {required: true}
				       
			},
			messages: {
				eventDesc:{	required: "Please write about Event."},
				eventPlace:{	required: "Event Place is required."},
				eventDateS:{	required: "Please select event date."},
				eventCategory:{	required: "Event Category is required."},
				title:{	required: "Event title is required."},
				name:{	required: "Event Name is required."}
			},
			
			submitHandler: function(form) { 
				
				$("#validity_label").html('<div class="alert alert-success">No errors.</div>');
				$(this).attr("disabled", true);	
				$("#eventForm").submit();
				},
			invalidHandler: function(form, validator) {
				$("#validity_label").html('<div class="alert alert-error">There be '+validator.numberOfInvalids()+' error'+(validator.numberOfInvalids()>1?'s':'')+' here.</div>');
			}
		});
	 
	 var d = new Date();
		var year = d.getFullYear();
		var stY= year-19;
		var endY = year-2;
		 
		
		
		 
		/*  $(".datepick").datepicker({
	         numberOfMonths: 1,
			 changeMonth: true,
			changeYear: true,
			dateFormat:'yy-mm-dd',
			yearRange: stY+":"+new Date().getFullYear(),
			maxDate:'0'

	     });
		  */
		 $('.datepick').datetimepicker({
			 minDate:0,
			 ampm: true,
			 dateFormat: 'dd M yy'
				
		 });
				//formattedDate: 'dd/MM/yyyy',
				//formattedTime: 'hh:mm tt'
			// formattedDateTime:"dd/MM/yyyy hh:mm tt" */
			//ampm:true;
		  //numberOfMonths: 2,
		//	minDate: 0,
		//	maxDate: 30
		//dateFormat: 'dd M yy', 
			//http://trentrichardson.com/examples/timepicker/
		//	minDate: new Date(2010, 11, 20, 8, 30),
		//	maxDate: new Date(2010, 11, 31, 17, 30)
		 // controlType: 'select'
		 /* 
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
		        });  */
		 
		 formName = 'imageForm';
		        cropRatio = '<spring:message code="image.cropratio.width"/>' / '<spring:message code="image.cropratio.height"/>';//762/330; 680 / 460:W/H
			photoId = 'cropedImage';
			imageUrl = '';
			$('#fileUpload').change(function() {
				var validator = $("#imageForm").validate();
				if(validator.element('#fileUpload')){
					$("#" + formName).ajaxSubmit(options);
				}
			});
			 $("#cropedImage").click(function(){
				   $("#fileUpload").click();
				});
}); 
</script>
<style>
#bar{
	background-color: #2981E4;
	height: 10px;
	width:0%;
}
</style>



	<div id="tabularData">
	
			
			
			<div class="blFormDiv">

					<div class="form-header clearfix">
						<h2 class="bg-header"><c:out value='${eventForm.actionType}'/> Event</h2>
						<a id="" href=""></a>
			
					</div>
					
					<div class="clearfix form-container" id="" style="position: relative;">
						<div><center><form:errors path="error" cssClass="alertMsg" /></center></div>
							<c:if test='${null!=messagekey }'>
								<div class="successMsg">
									<spring:message code="${messagekey}" />
									<c:remove var="success_key" scope="session" />
								</div>
							</c:if>
							<c:remove var="messagekey" scope="session" />
							<c:if test='${null!=success_key }'>
								<div class="successMsg"><spring:message code="${success_key}" /></div>
								<c:remove var="success_key" scope="session" />
							</c:if>	
			<div class="span5" id="validity_label"></div>
			<div style="" class="formDataDiv addFormv">

				<table border="0" cellspacing="0" cellpadding="2">
					<tr>
						<td><form:form enctype="multipart/form-data"
								name="eventForm" id="eventForm" method="POST"
								commandName="eventForm">
								<div>
									<center>
										<form:errors path="error" cssClass="alertMsg" />
									</center>
								</div>
								<form:input type="hidden" path="id" class="" />
								<form:input type="hidden" path="actionType" id="gactionType" class="" />
								<form:hidden path="unid" />
								<form:hidden path="uuid" />
								<table border="0" cellspacing="0" cellpadding="2">
									<tr>
										<td>Event Name<span class="mandatory">*</span></td>
										<td><form:input type="text" path="name" class=""
												required="" placeholder="Event Name"
												data-placement="right" /> <form:errors path="name"
												cssClass="errormsg" /><span class="errormsg" id="nameError"></span></td>
									</tr>
									<tr>
										<td>Event Title<span class="mandatory">*</span></td>
										<td><form:input type="text" path="title" class=""
												name="title" required="" placeholder="Event Title"
												data-placement="right" /> <form:errors path="title"
												cssClass="errormsg" /><span class="errormsg" id="nameError"></span></td>
									</tr>
									<tr>
										<td>Event Category<span class="mandatory">*</span></td>
										<td><form:input type="text" path="eventCategory"
												class="" name="eventCategory" required=""
												placeholder="Event Category" data-placement="right" /> <form:errors
												path="eventCategory" cssClass="errormsg" /><span
											class="errormsg" id="eventCategoryError"></span></td>
									</tr>

									<tr>
										<td>Event Date <span class="mandatory">*</span></td>
										<td colspan="2"><form:input path="eventDateS"
												class="datepick" name="eventDateS" required="true"
												placeholder="Event Date" readonly="true"/> <form:errors path="eventDateS"
												cssClass="errormsg" /><span class="errormsg"
											id="eventDateError"></span></td>
									</tr>
									<tr>
										<td>Event Place<span class="mandatory">*</span></td>
										<td><form:input type="text" path="eventPlace" class=""
												name="eventPlace" required="" placeholder="Event Place"
												data-placement="right" /> <form:errors path="eventPlace"
												cssClass="errormsg" /><span class="errormsg"
											id="eventPlaceError"></span></td>
									</tr>

									<tr>
										<td>Event Description<span class="mandatory">*</span></td>
										<td><form:textarea type="text" path="eventDesc" class="" rows="5"
												name="eventDesc" required="" placeholder="Description"
												data-placement="right" /> <form:errors path="eventDesc"
												cssClass="errormsg" /><span class="errormsg"
											id="galleryDescError"></span></td>
									</tr>
									
									<!-- <tr>
										<td></td>
										<td colspan="2"><div id="bar"></div>
											<div id="percent"></div></td>
									</tr> -->

									<tr>
										<td colspan="2"><input type="button"
											class="large clButton gray" id="backBttn" title="Back"
											onClick="history.back();return false;" value="Back" /> <input
											type="submit" class="large clButton blue" id="" title="Save"
											value="Save" /></td>
									</tr>
								</table>
							</form:form></td>
						<td><form:form enctype="multipart/form-data" name="imageForm"
								id="imageForm" method="POST" commandName="imageForm">

								<form:input type="hidden" path="actionType" id="actionType" />
								<form:input type="hidden" path="x" />
								<form:input type="hidden" path="y" />
								<form:input type="hidden" path="height" />
								<form:input type="hidden" path="width" />
								<form:hidden path="uuid" />

								<table>
									<tr>
										<td><c:choose>
												<c:when test="${null!=imageForm.url}">
													<img
														src="${pageContext.request.contextPath}/static/simg-fix/352x140/${imageForm.url}"
														id="cropedImage"
														style="height: 140px; width: 352px; display: inline-block;" />
												</c:when>
												<c:otherwise>
													<img src="" id="cropedImage"
														style="height: 140px; width: 352px; display: inline-block;" />
												</c:otherwise>
											</c:choose> <span class="errormsg" id="cropedImageError"></span></td>
									</tr>
									<tr>
										<td style="float: left"><spna>Image</spna></span><span
											class="mandatory">*</span> <form:input type="file"
												path="imageFile" class="upload" id="fileUpload"
												name="imageFile" required="" placeholder="Required"
												data-placement="right" /> <form:errors path="imageFile" cssClass="errormsg" /><span class="errormsg" id="fileError"></span></td>
									</tr>
									<tr>
										<td style="float: left"><span>Don't Crop</span> &nbsp;<form:checkbox
												path="dontCrop" style="margin:5px;" /><span class="errormsg"
											id="cropedImageError"></span></td>
									</tr>
								</table>
							</form:form></td>
					</tr>
				</table>
			</div>
				
				</div>
	</div>

</div>

