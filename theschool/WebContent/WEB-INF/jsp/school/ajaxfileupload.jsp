<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<link href="<spring:message code="static.application.name"/>/css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery-1.9.1.js"></script>

<title>jQuery File Upload Example</title>
 
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery.ui.widget.js"></script>
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery.iframe-transport.js"></script>
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery.fileupload.js"></script>
 
<!-- bootstrap just to have good looking page -->
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/bootstrap.js"></script>
 
<!-- we code these -->
<script type="text/javascript">
$(document).ready(function() {

    $('#ajaxForm').fileupload({
       dataType: 'json',
 		/* submit:function (e, data) {
 	        	data.formData = $("#ajaxForm").serialize();
 		}, */
        done: function (e, data) {
            $("tr:has(td)").remove();
            $.each(data.result, function (index, file) {
 
                $("#uploaded-files").append(
                        $('<tr/>')
                        .append($('<td/>').text(file.fileName))
                        .append($('<td/>').text(file.fileSize))
                        .append($('<td/>').text(file.fileType))
                        .append($('<td class="dImage"/>').html('<img class="main-image"	src="data:image/jpg;base64,'+file.image+'"/>'))
                        .append($('<td/>').html("<a href='/get/"+index+"'>Click</a>"))
                        )
            }); 
        },
 
        progressall: function (e, data) {
            var progress = parseInt(data.loaded / data.total * 100, 10);
            $('#progress .bar').css(
                'width',
                progress + '%'
            );
        },
 
        dropZone: $('#dropzone')
    });
    
   /*  $('#ajaxForm').bind('fileuploadsubmit', function (e, data) {
        data.formData = $("#ajaxForm").serialize();
    }); */


});
</script>
<style type="text/css">

#dropzone {
    background: #ccccc;
    width: 150px;
    height: 50px;
    line-height: 50px;
    text-align: center;
    font-weight: bold;
}
#dropzone.in {
    width: 600px;
    height: 200px;
    line-height: 200px;
    font-size: larger;
}
#dropzone.hover {
    background: lawngreen;
}
#dropzone.fade {
    -webkit-transition: all 0.3s ease-out;
    -moz-transition: all 0.3s ease-out;
    -ms-transition: all 0.3s ease-out;
    -o-transition: all 0.3s ease-out;
    transition: all 0.3s ease-out;
    opacity: 1;
}
.dImage .main-image{
	max-width: 85px;
	height: 60px
}
.searchTextBoxes{
	display: table;
}
</style>
</head>
 
<body>
<h1>Spring MVC - jQuery File Upload</h1>
			
			<div id="Galleries">
				<div class="">
					<form:form enctype="multipart/form-data" name="ajaxForm" id="ajaxForm"
						method="POST" commandName="ajaxForm"	>
					<div><center><form:errors path="error" cssClass="alertMsg" /></center></div>
					<form:input type="hidden" path="id" class="" />
						<table width="500" border="0" cellspacing="0" cellpadding="2">
		
							<tr>
								<td>Name<span class="mandatory">*</span></td>
								<td colspan="2"><form:input type="text" path="name" class="searchTextBoxes" />
								<br><form:errors path="name" cssClass="errormsg"/><span class="errormsg" id="nameError"></span></td>
							</tr>
							<tr>
								<td> Title<span class="mandatory">*</span></td>
								<td colspan="2"><form:input type="text" path="title" class="searchTextBoxes" />
								<br><form:errors path="title" cssClass="errormsg"/><span class="errormsg" id="nameError"></span></td>
							</tr>
							<tr>
								<td>Image<span class="mandatory">*</span></td>
								<td><form:input  type="file" path="files" class="upload" id="fileupload" data-url="upload"/>
								<br><form:errors path="files" cssClass="errormsg"/><span class="errormsg" id="fileError"></span></td>
							</tr>
						</table>
						<div id="sectionBttns">
							 <input name="Add Gallery" type="button" class="saveBttn" title="Save" value=""/>
						</div>
					</form:form>
				</div>
		</div>
 
    <!-- <input id="fileupload" type="file" name="files[]" data-url="upload" multiple>
 
    <div id="dropzone">Drop files here</div>
 
    <div id="progress">
        <div style="width: 0%;"></div>
    </div> -->
 
    <table id="uploaded-files">
        <tr>
            <th>File Name</th>
            <th>File Size</th>
            <th>File Type</th>
            <th>Download</th>
        </tr>
    </table>
 
</div>
</body> 
</html>