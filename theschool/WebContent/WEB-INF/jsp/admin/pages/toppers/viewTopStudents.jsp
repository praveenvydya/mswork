<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%-- <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.vydya.theschool.common.constants.TSConstants"%>
<%@ page import="com.vydya.theschool.web.constants.WebConstants"%>
<%@ page import="com.vydya.theschool.common.util.ImageUtil"%>
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery.finescroll.min.js"></script>
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/common.js"></script>
<style>
.image{
	width: 123px;
}


</style>
<script type="text/javascript">


	 
		$(document).ready(function() {

			$("#deleteBttn").click(function(){ 
				alert("d");
				$.post('delete.htm',$("#topStudentsForm").serialize(),function(data){updatedGalleryImages(data);});
			}); 
			
			function updatedGalleryImages(data){
				
				alert("yes deleted");
			}
			<%-- $('#addGalleryImage').click(function(){
				$('#galleryForm').attr("disabled", true);	
				$("#galleryForm").attr("action", '<%=TSConstants.ACTION_ADD_GALLERY_IMAGES%>.htm');
				$('#galleryForm #actionType').val("view");
				$("#galleryForm").submit();
			});  --%> 
			
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
							}
						       
					},
					messages: {
						imageFile : {
							required : "Please Select student Image.",
							extension:"Please select a valid format(.jpeg or .jpg)"
						}
					}
			 });
			 
			 $("#rank").ForceNumericOnly();
			 $("#marks").ForceNumericOnly();
			 $("#studentName").ForceAlphabetsOnly();
			 $("#hallTiketNo").ForceAlphaNumericOnly();
			 
			 $("#topStudentsForm").validate({
					rules: {   
						studentName: {required: true,
										alphasp: true,
										maxlength:30},
						   imageFile: {required: {depends: function(element) { return ($('#cropedImage').src == '');}}},
						   hallTiketNo: {required: true
						   				},
						   rank: {required: true,
							  	 rangelength: [1, 4]
						   		},
			   			 marks: {required: false,
						  	 max:parseInt($('#totalMarks').val()),
						  	rangelength: [1, 3]
					   		}
						   
					},
					messages: {
						imageFile:{required: "Please Select student photo image."},
						rank:{	required: "Student Rank is required."},
						hallTiketNo:{	required: "Student hallTiket number is required."},
						studentName:{	required: "Student Name is required."},
						marks:{ max:"Marks cann't be more than total Marks."}
					},
					
					submitHandler: function(form) { 
						
						$("#validity_label").html('<div class="alert alert-success">No errors.</div>');
						$(this).attr("disabled", true);	
						//$("#topStudentsForm").submit();
							$.post('add.htm', $("#topStudentsForm").serialize(), function(data) {displayStudentPhoto(data);});
						
						},
					invalidHandler: function(form, validator) {
						$("#validity_label").html('<div class="alert alert-error">There be '+validator.numberOfInvalids()+' error'+(validator.numberOfInvalids()>1?'s':'')+' here.</div>');
					}
				});
			 
			$("#cancelDelete").click(function(){
				$(".forImage").hide();
				$("#deleteBttn").hide();
				$("#cancelDelete").hide();
				$("#deleteImages").show();
				$('.galleryImage input[type="image"]').removeClass("disabledImage").attr("disabled", false);
				$('.galleryImage input[type="image"]').attr("disabled", false);
			});
			
			
			/* $("#saveBttn").click(function(){
				$.post('add.htm', $("#topStudentsForm").serialize(), function(data) {displayStudentPhoto(data);});
			}); */
			
			function displayStudentPhoto(data){
			var image;
			if(null!=data.imageName){
				
				image = '<img class="image" src="${pageContext.request.contextPath}/static/simg-fit/262x140/'+data.imageName+'" />';
			}
			else{
				image= '<img class="image"	src="<spring:message code="static.application.name"/>/images/student_m.png" />';
			}
				
				$("#imagesBody")
				.prepend(
						'<tr class="even_gradeA odd" id="galImg_'+data.studentId+'"><td class="">'+image
						
						+'</td><td class="img_desc">'
								+ data.studentName
								+ '</td><td class="center">'
								+ data.rank  
								+ '</td><td class="center ">'
								+ data.hallTiketNo 
								+ '</td><td class="center">'
								+ data.marks 
								+ '</td><td class="center">'
								+ data.inserted +' by '+data.insertedby 
								+ '</td><td class=" ">'
								+ data.lastmodified +' by '+data.lastmodifiedby
								+ '</td><td class="buttons"><div id="ime_'+data.studentId+'" title="Edit" style="" class="editicon im_edit"></div>'
								+ '<input type="button" style="display: none;" class="large clButton green im_yes" id="imy_'+data.studentId+'" title="Yes" value="Yes"/>'
								+ '<div id="imd_'+data.studentId+'" title="Delete" style="" class="deleteicon im_delete"></div></td></tr>');

		
				
				//var html =  '<div class="topper"><div class="image-div"><img class="image" src="data:image/jpg;base64,'+data.image+'"/></div><div class="sub-div"><b>Rank:'+data.size+'</b></div><div class="name-div">'+data.name+'</div><div class="sub-div">HT.No:'+data.description+'</div></div>';
				// $(".toppers").append(html);
				 $('#topStudentsForm')[0].reset();
				 $('#imageForm')[0].reset();
				 $("#addTopperForm").hide();
				 $("#cropedImage").attr("src","../../images/student_m.png");
			}
			
			
			loadLeftgalleryMenu('t','<spring:message code="application.name"/>${pageContext.servletContext.contextPath}','${pageContext.servletContext.contextPath}');
			//loadLeftgallery();
			
			 $('.scrollboxSDiv').finescroll({
				    verticalTrackClass: 'track',
				    verticalHandleClass: 'handle',
				    minScrollbarLength: 15,
				    showOnHover : true
				}); 
			 
			$("#addBttn").click(function(){
				$(".message").empty();
				$("#validity_label").empty();
				$("#addTopperForm").show();
				$.get('<spring:message code="application.name"/>${pageContext.servletContext.contextPath}/ajaxGetValue.htm?key=uuid', function( data ) {
					var unid = data;
					$("#uuid").val(unid);
					$("#tsuuid").val(unid);
					}); 
				$("#addTopperBttn").attr("disabled", false);		
			});
			var oTable = $('#topsTable').dataTable({
				"sPaginationType" : "full_numbers",
				"bJQueryUI" : true,
				"bRetrieve" : true
			});
		
			$("#cancelAdd").click(function(){
				$("#addTopperForm").hide();
			});
			
			$("#deleteImages").click(function() {
				
				$(".forImage").css("display","block");
				$("#deleteImages").hide();
				$("#deleteBttn").show();
				$("#cancelDelete").show();
				$('.galleryImage input[type="image"]').attr("disabled", true).addClass("disabledImage");;
			});
			
				
				 formName = 'imageForm';
					 cropRatio = 96 / 120;//762/330; 680 / 460:W/H
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
					 
				$(".im_delete").click(function(){
					var imageId = $(this).attr("id").split('_')[1];
					
					if(confirm("Do you want to delete ?")){
						$("#imageTbId").val(imageId);
						$.post('delete.htm',$("#imageTableForm").serialize(),function(data){
							if(data.success==true){
								var tr = $("tr#galImg_"+imageId);
								tr.css("background-color","#666666");
								tr.fadeOut(400,function(){
									tr.remove();
								});
								$(".message").empty().html("<font class='g'>"+data.message+"</font>");
								return false;
							}
							else{
								$(".message").empty().html("<font class='r'>"+data.errormsg+"</font>");
							}
						});
						
					}
					else return false;
					
					
				});
				
	$(".im_edit").click(function(){
		var imageId = $(this).attr("id").split('_')[1];
		$("#imy_"+imageId).show();
		$(".im_edit").hide();
		$(".im_delete").hide();
		var desc = $(this).parents("tr").find("td.img_desc");
		
		var txra = '<textarea id="desc_'+imageId+'" cols="12" rows="3" resize="none">'+desc.html()+'</textarea>';
		desc.empty();
		desc.html(txra);
		
		$(this).parents("tr").find("td #imc_"+imageId).show();
		
		//<textarea id="desc_${image.id}" cols="19" rows="3" resize="none"  disabled="disabled">${image.description}</textarea>
		//$("#desc_"+imageId).attr("disabled",false);
	});

				$(".im_cancel").click(function(){
					var imageId = $(this).attr("id").split('_')[1];
					var desc = $(this).parents("tr").find("td.img_desc");
					var imagedesc = $("#desc_"+imageId).val();
					desc.empty();
					desc.html(imagedesc);
					$(".im_edit").show();
					$(".im_delete").show();
					$(".im_yes").hide();
					$(".im_cancel").hide();
					//alert($(this).parents("tr").find("td textarea").val()	);
				});
				
				
				$(".im_yes").click(function(){
					var imageId = $(this).attr("id").split('_')[1];
					$("#imageTbId").val(imageId);
					$("#imy_").show();
					
					var desc = $(this).parents("tr").find("td.img_desc");
					var imagedesc = $("#desc_"+imageId).val();
					$("#imageTbdesc").val(imagedesc);
					$.post('edit.htm',$("#imageTableForm").serialize(),function(data){
						
						if(data.success==true){
							//$("#desc_"+imageId).html(imagedesc);
							
							desc.empty();
							desc.html(imagedesc);
							$(".im_edit").show();
							$(".im_delete").show();
							$(".im_yes").hide();
							$(".im_cancel").hide();
							$(".message").empty().html("<font class='g'>"+data.message+"</font>");
						}
						else{
							
							
						}
					});
				});
				
		});
	</script>


<div class="adminLRlayout">

	<div id="left-img-Column">
	
	
	</div>
	<div id="content-Column" style="width: 76%; float: right;">

		<form:form name="toppersGroup" id="toppersGroup" method="POST"
			commandName="toppersGroup">
			<form:input type="hidden" path="id" class="" id="tgId" />
			<form:input type="hidden" path="name" class="" id="tgName" />
			<form:input type="hidden" path="totalMarks" class="" />
			
			<div class="piw">
			<div class="img-parent">
				<img src="${pageContext.request.contextPath}/static/simg-org/${toppersGroup.imageName}" alt="${toppersGroup.name}" 
									style="display: inline-block;" width="100%" /> 
			</div>
			
			<div class="blockquote"
				style="display: flex;">
				<div style="width: 60%">
					<h1>${toppersGroup.title}</h1>
					<small>${toppersGroup.description}</small>
				</div>
				<div style="width: 40%" class="Gd">
					<cite class="muted"> </cite>
					<small>Inserted By&nbsp; <strong>${toppersGroup.insertedby}</strong>
						and Updated by&nbsp;<strong>${toppersGroup.lastmodifiedby}</strong>
						on <b>${toppersGroup.lastmodified}</b></small>
				</div>
			</div>
			</div>

			<input type="button" class="large clButton green" id="addBttn"
				title="Add" value="Add" />
			<div class="message"></div>
		</form:form>


<div id="addTopperForm" style="display: none;">
				<div style="" class="formDataDiv addForm">
				
				<table border="0" cellspacing="0" cellpadding="2">
					<tr>
						<td>
						
							<form:form enctype="multipart/form-data" name="topStudentsForm" id="topStudentsForm"
						method="POST" commandName="topStudentsForm">
						<form:input type="hidden" path="toppersGroupId"  value="${toppersGroup.id}" />
						<form:input type="hidden" path="actionType" class="" id="tactionType" />
								<form:hidden path="uuid" id="tsuuid"/>
					<table border="0" class="order">
						<tbody>
							<tr>
								<td class="firstcol">Title:</td>
								<td class="gtd"><form:radiobutton path="gender" name="gender" id="" checked="checked"
														value="M" class="radio" />
									<label for="iIsMan1">Mr</label>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <form:radiobutton path="gender" name="gender" id=""
														value="F" class="radio" />
									<label for="iIsMan0">Mrs / Ms</label></td>
							</tr>
							
							<tr>
								<td class="firstcol"><label for="sFirstName" class="">Name:</label></td>
								<td><form:input type="text" path="studentName" value=""  required="true"
									maxlength="200" size="24" /> 
								</td>
							</tr>
							<tr>
								<td class="firstcol"><label for="hallTiketNo" class="">Hall	Ticket Number:</label></td>
								<td><form:input maxlength="15"  path="hallTiketNo" class="" size="24"  required="true" />
								</td>
							</tr>
							<tr>
								<td class="firstcol"><label for="sRank" class="">Rank:</label></td>
								<td><form:input type="text" path="rank" value=""  required="true" 
									maxlength="10" size="24" /> 
								</td>
							</tr>
							<tr>
								<td class="firstcol"><label for="sMarks" class="">Marks:</label></td>
								<td><form:input type="text" path="marks" value="" required="true" name="marks"
									maxlength="10" size="24" /> 
								</td>
							</tr>
							<tr>
								<td class="firstcol"></td>
								<td>
									<button type="submit" class="large clButton" title="Add" id="addTopperBttn" >Add</button>
									<button type="reset" class="large clButton">Reset</button>
									<button type="button" class="large clButton" id="cancelAdd">Cancel</button>
								</td>
							</tr>
						</tbody>
					</table></form:form>
					</td>
					
						<td><form:form enctype="multipart/form-data" name="imageForm"
								id="imageForm" method="POST" commandName="imageForm">

								<form:input type="hidden" path="actionType" class=""
									id="actionType" />
								<form:input type="hidden" path="x" class="" />
								<form:input type="hidden" path="y" class="" />
								<form:input type="hidden" path="height" class="" />
								<form:input type="hidden" path="width" class="" />
								<form:input type="hidden" path="uuid" />
								<form:input type="hidden" path="priority" value="2" />
								<table>
									<tr>
										<td><c:choose>
												<c:when test="${null!=toppersGroupForm.bannerPhoto}">
													<img
														src="data:image/jpg;base64,${toppersGroupForm.bannerPhoto}"
														id="cropedImage"
														style="height: 147px; display: inline-block;" />
												</c:when>
												<c:otherwise>
													<img src="" id="cropedImage"
														style="height: 159px; width:131px; display: inline-block;" />
												</c:otherwise>
											</c:choose> <span class="errormsg" id="cropedImageError"></span></td>
									</tr>
									<tr>
										<td>Banner Image<span class="mandatory">*</span> <form:input
												type="file" path="imageFile" class="upload" id="fileUpload"
												name="imageFile" required="" placeholder="Required"
												data-placement="right" /> <form:errors path="imageFile"
												cssClass="errormsg" /><span class="errormsg" id="fileError"></td>
									</tr>
								</table>
							</form:form></td>
					
					</tr></table>
				</div>
			</div>

		<div style="clear: both;"></div>
	


		<table  class="display dataTable"
					id="topsTable" border="0" cellpadding="0" cellspacing="0">
					<thead>
						<tr >
							<th	style="width: 40px;" colspan="1"	rowspan="1" 
								 class="sorting_disabled">Photo</th>
							<th style="width: 100px;" colspan="1" rowspan="1"
								class="sorting">Name</th>
							<th	style="width: 20px;" colspan="1" rowspan="1"
								class="sorting">Rank</th>
							<th	style="width: 70px;" colspan="1" rowspan="1"
								class="sorting">H.T No</th>
							<th	style="width: 50px;" colspan="1" rowspan="1"
								class="sorting">Marks Got</th>	
							<th	style="width: 100px;" colspan="1" rowspan="1"
								class="sorting">Added</th>
							<th style="width: 100px;" colspan="1" rowspan="1"
								class="sorting">Updated</th>
							<th style="width: 40px;" colspan="1" rowspan="1"
							class="sorting_disabled">Edit/Delete</th>
						</tr>
					</thead>
					<tfoot style="display: none">
						<tr>
							<th colspan="1" rowspan="1">Photo</th>
							<th colspan="1" rowspan="1">Name</th>
							<th colspan="1" rowspan="1">Rank</th>
							<th colspan="1" rowspan="1">H.T.No</th>
							<th colspan="1" rowspan="1">Marks Got</th>
							<th colspan="1" rowspan="1">Added</th>
							<th colspan="1" rowspan="1">Updated</th>
							<th colspan="1" rowspan="1">Action</th>
						</tr>
					</tfoot>
	<form:form  name="imageTableForm" action=""
										id="imageTableForm" class="" method="POST"
										commandName="imageTableForm">
										<form:input type="hidden" path="studentId"  id="imageTbId" value=""/>
										
					<tbody id="imagesBody">
						<c:if test='${null!=topStudentsList }'>
							<c:forEach var="tstd" items="${topStudentsList}">
							
											<tr class="even_gradeA odd" id="galImg_${tstd.studentId}">
											
												<td class=""> 
													<c:choose>
														<c:when test="${null ne tstd.imageName}">
															<img class="image" src="${pageContext.request.contextPath}/static/simg-fit/96x120/${tstd.imageName}" />
														</c:when>
														<c:otherwise>
															<img class="image"	src="<spring:message code="static.application.name"/>/images/student_m.png" />
														</c:otherwise>
													</c:choose>
												</td>
												<td class="img_desc">${tstd.studentName}</td>
												<td class="center ">${tstd.rank}</td>
												<td class="center ">${tstd.hallTiketNo}</td>
												<td class="center ">${tstd.marks}</td>
												<td class="center ">${tstd.inserted} By ${tstd.insertedby}</td>
												<td class="center ">${tstd.lastmodified} By ${tstd.lastmodifiedby}</td>
												<td class="buttons">
												<div id="ime_${tstd.studentId}" title="Edit" style="" class="editicon im_edit"></div>
												
												<input type="button" style="display: none;" class="large clButton green im_yes" id="imy_${tstd.studentId}" title="Ok" value="Ok"/>
												<input type="button" style="display: none;" class="large clButton green im_cancel" id="imc_${tstd.studentId}" title="Cancel" value="C"/>
												<div id="imd_${tstd.studentId}" title="Delete" style="" class="deleteicon im_delete"></div>
												</td>
											</tr>
								
							</c:forEach>
						</c:if>
					</tbody>
					</form:form>
				</table>


			
		</div>
	</div>





