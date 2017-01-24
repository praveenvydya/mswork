<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.vydya.theschool.common.constants.TSConstants"%>
<%@ page import="com.vydya.theschool.web.constants.WebConstants"%>
<script type="text/javascript">  
jQuery(document).ready(function($){
	//$('input').filter('.datepicker').datepicker({ changeMonth: true,changeYear: true, dateFormat:"yy-mm-dd"});

		
	  $('#saveBttn').click(function(){
		
		$('#saveBttn').attr("disabled", true);	
		$("#studentForm").attr("action", '<%=TSConstants.ACTION_ADD%>.htm');
		$("#studentForm").submit();
		//loadGalleries();
	});   
	 
		$('.loadBttn').click(function(){
			
			loadGalleries();
		}); 
	 
		/*  $("#saveBttn").click(function(){ 
			alert("d");
			$.post('add.htm',$("#studentForm").serialize(),
					
					
					function(data){updatedStudentStatus(data);}); 
			
			
			$.ajax({
                url: 'add.htm',
                type:"POST",
                data:$('#studentForm').serialize(),
                cache: false,
		        contentType: false,
		        processData: false,
		        success: function (data) {updatedStudentStatus(data);}
                
		});  
		 
		 }); */
		 
		
	 function loadGalleries(){
		 
		 $.getJSON('viewGalleries.htm',  function(data) {
				displayGalleryImages(data);
			});
	 }
	 function displayGalleryImages(data) {
	
			$("#gallerysList").empty();
			$.each(data, function(index, gallery) {

				$("#gallerysList").append("<div class='gallery'><div class='imageDiv'><img width='auto' height='120px' border='0' class='galleryImage' id='galleryImage_"+gallery.id+"' src='data:image/jpg;base64,"+gallery.image+"'/></div><div class='gallery-decorator'><h3 class='galleryName' id='galleryName_"+gallery.id+"'>"+gallery.name+"</h3><p>"+gallery.galleryDesc+"</p></div></div>");//galleryData
				/* $.each(element, function(ind, el) {

					$.each(el, function(i, e) {

						$("#jsondata").append("<li>" + e + "</li>");

					});
				});
				$("#jsondata").append("</ul>"); */

			});
		}
	 
	 function updatedStudentStatus(data){
		 
		 alert(" ajax resp"+data.isSuccess);
		 
	 }
	 
	    function ajaxFileUpload()
	    {
	        //starting setting some animation when the ajax starts and completes
	        $("#loading")
	        .ajaxStart(function(){
	            $(this).show();
	        })
	        .ajaxComplete(function(){
	            $(this).hide();
	        });
	        
	        var uploadresponse = [false, "by default"];
	        
	        $.ajaxFileUpload(
	                {
	                    url:'EditData.aspx?MyIdentifier=' + $("#MyIdentifier").val(),
	                    secureuri:false,
	                    fileElementId:'filename',
	                    dataType: 'JSON',
	                    data: {id: formid},
	                    async:false,                
	                    success: function (dataIn, status)
	                    {
	                        var errorResponse = $.parseJSON(dataIn);
	                        if((errorResponse != null)&&(typeof(errorResponse.error) != 'undefined'))
	                        {
	                            if(errorResponse.error != '')
	                            {
	                                uploadresponse = [false, errorResponse.explanation];
	                            }
	                        }
	                        else
	                        {
	                            uploadresponse = [true, "Successfully uploaded file"];
	                        }
	                    },
	                    error: function (datain, status, e)
	                    {
	                        uploadresponse = [false, e];
	                    }
	                }
	            );
      
      return false;

  } 
	   
}); 
</script>
<style>
body {
	font-family: "Lucida Grande", "Lucida Sans Unicode", Verdana, Arial,
		Helvetica, sans-serif;
	font-size: 12px;
}

p,h1,form,button {
	border: 0;
	margin: 0;
	padding: 0;
}

.spacer {
	clear: both;
	height: 1px;
}
/* ----------- My Form ----------- */
.myform {
	margin: 0 auto;
	width: 400px;
	padding: 14px;
}

/* ----------- stylized ----------- */
#stylized {
	border: solid 2px #b7ddf2;
	background: #ebf4fb;
}

#stylized h1 {
	font-size: 14px;
	font-weight: bold;
	margin-bottom: 8px;
}

#stylized p {
	font-size: 11px;
	color: #666666;
	margin-bottom: 20px;
	border-bottom: solid 1px #b7ddf2;
	padding-bottom: 10px;
}

#stylized label {
	display: block;
	font-weight: bold;
	text-align: right;
	width: 140px;
	float: left;
}

#stylized .small {
	color: #666666;
	display: block;
	font-size: 11px;
	font-weight: normal;
	text-align: right;
	width: 140px;
}

#stylized input {
	float: left;
	font-size: 12px;
	padding: 4px 2px;
	border: solid 1px #aacfe4;
	width: 200px;
	margin: 2px 0 20px 10px;
}

#stylized button {
	clear: both;
	margin-left: 150px;
	width: 125px;
	height: 31px;
	background: #666666 url(img/button.png) no-repeat;
	text-align: center;
	line-height: 31px;
	color: #FFFFFF;
	font-size: 11px;
	font-weight: bold;
}
</style>
	<%-- <div id="titleBar">
		<div class="title">Add Student</div>
	</div>
	
	<div id="Galleries">
		<div class="">
			<form:form enctype="multipart/form-data" name="studentForm" id="studentForm"
				method="POST" commandName="studentSearchForm">
			<form:input type="hidden" path="actionType" class="" value="add"/>
				<table width="500" border="0" cellspacing="0" cellpadding="2">
					<tr>
						<td>Gallery Name<span class="mandatory">*</span></td>
						<td colspan="2"><form:input type="text" path="studentName" class="searchTextBoxes" />
						<br><form:errors path="studentName" cssClass="errormsg"/><span class="errormsg" id="nameError"></span></td>
					</tr>
					<tr>
						<td>Gallery Image<span class="mandatory">*</span></td>
						<td><form:input type="file" path="files" class="upload" multiple=""/> 
						<br><button class="button" id="buttonUpload" onclick="return ajaxFileUpload();">Upload</button></span></td>
					</tr>
					
					<tr>
						<td>Roll Number<span class="mandatory">*</span></td>
						<td colspan="2"><form:input type="text" path="rollNumber" class="searchTextBoxes" />
						<br><form:errors path="rollNumber" cssClass="errormsg"/><span class="errormsg" id="nameError"></span></td>
					</tr>
					
					<tr>
						<td>Hall Tkct Number<span class="mandatory">*</span></td>
						<td colspan="2"><form:input type="text" path="hallTiketNo" class="searchTextBoxes" />
						<br><form:errors path="hallTiketNo" cssClass="errormsg"/><span class="errormsg" id="nameError"></span></td>
					</tr>
					
					<tr>
						<td>Year Of Class<span class="mandatory">*</span></td>
						<td colspan="2"><form:input type="text" path="yearOfClass" class="searchTextBoxes" />
						<br><form:errors path="yearOfClass" cssClass="errormsg"/><span class="errormsg" id="nameError"></span></td>
					<tr>
						<td>Year Of PassOut<span class="mandatory">*</span></td>
						<td colspan="2"><form:input type="text" path="yearOfPassOut" class="searchTextBoxes" />
						<br><form:errors path="yearOfPassOut" cssClass="errormsg"/><span class="errormsg" id="nameError"></span></td>
					</tr>
					<tr>
						<td>Year Of Join<span class="mandatory">*</span></td>
						<td colspan="2"><form:input type="text" path="yearOfJoin" class="searchTextBoxes" />
						<br><form:errors path="yearOfJoin" cssClass="errormsg"/><span class="errormsg" id="nameError"></span></td>
					</tr>	
					<tr>
						<td>Class<span class="mandatory">*</span></td>
						<td colspan="2"><form:input type="text" path="studentClass" class="searchTextBoxes" />
						<br><form:errors path="studentClass" cssClass="errormsg"/><span class="errormsg" id="nameError"></span></td>
					</tr>
									
						<tr>
						<td>Section<span class="mandatory">*</span></td>
						<td colspan="2"><form:input type="text" path="sectionOfClass" class="searchTextBoxes" />
						<br><form:errors path="sectionOfClass" cssClass="errormsg"/><span class="errormsg" id="nameError"></span></td>
					</tr>	
						
					
					
					
				</table>
				<div id="sectionBttns">
					<input type="button" value="Add" class="clButton1 blue2" id="saveBttn" title="Add"/>
				</div>
			</form:form>
		</div>
	</div> --%>


<div id="stylized" class="myform">

	<form:form enctype="multipart/form-data" name="studentForm" id="studentForm"
				method="POST" commandName="studentSearchForm">
			<form:input type="hidden" path="actionType" class="" value="add"/>
		<h1>Add Student</h1>
		<p>This is the basic look of my form without table</p>

		<label>Name <span class="small">Add student name</span> </label> 
		<form:input type="text" path="studentName" class="" /> 
		
		<label>Father Name <span class="small">Add father name</span> </label> 
		<form:input type="text" path="fatherName" class="" /> 
		
		<label>Roll Number </label> 
		<form:input type="text" path="rollNumber" class="" /> 
		
		<label>Hall Ticket Number </label> 
		<form:input type="text" path="hallTiketNo" class="" /> 
		
		<label>Year Of Class <span
			class="small">Add a valid address</span> </label> 
		<form:input type="text" path="yearOfClass" class="" /> 
		
		<label>Year Of PassOut </label> 
		<form:input type="text" path="yearOfPassOut" class="" /> 
		
		<label>Year Of Join </label> 
		<form:input type="text" path="yearOfJoin" class="" /> 
		
		<label>Student Class </label> 
		<form:select path="studentClass"
								cssClass="galleryName" disabled="">
								<c:forEach items="${classList}" var="classRef">
									<form:option value="${classRef.idNum}"
										label="${classRef.description}"
										selected="${studentClass eq classRef.idNum ? 'selected': ''}" />
								</c:forEach>
							</form:select>
		<label>Section Of Class </label> 
		<form:select path="sectionOfClass"
								cssClass="galleryName" disabled="">
								<c:forEach items="${classSectionList}" var="sectionRef">
									<form:option value="${sectionRef.idNum}"
										label="${sectionRef.description}"
										selected="${sectionOfClass eq sectionRef.idNum ? 'selected': ''}" />
								</c:forEach>
							</form:select>

		<input type="button" value="Add" class="clButton1 blue2" id="saveBttn" title="Add"/>
		<div class="spacer"></div>

	</form:form>
</div>

<%-- 
<div id="stylized" class="myform">
		<h1>Sign-up form</h1>
		<p>This is the basic look of my form without table</p>

		<label>Name <span class="small">Add your name</span> </label> 
		<input	type="text" name="name" id="name" /> <label>Email <span
			class="small">Add a valid address</span> </label> 
			
		<input type="text"	name="email" id="email" /> <label>Password <span
			class="small">Min. size 6 chars</span> </label> 
		<input type="text"	name="password" id="password" />

		<button type="submit">Sign-up</button>
		<div class="spacer"></div>

	</form>
</div> --%>

