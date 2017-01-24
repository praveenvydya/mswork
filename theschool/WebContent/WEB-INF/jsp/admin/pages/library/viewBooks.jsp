<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%-- <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.vydya.theschool.common.constants.TSConstants"%>
<%@ page import="com.vydya.theschool.web.constants.WebConstants"%>

<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery-finetabs.js"></script>
<script defer="defer">

</script>
<style>
.forImage{
	display: none;
	position: absolute;
}
.link:hover{
	text-decoration: none;
}
div.books a disabledImage{
z-index: 100;
opacity:0.5;
}
.imageCk{
float: none;
    height: 115px;
    margin: 4px;
    position: inherit;
    width: 188px;
}
.link{
display: inline;
}

#booksTable textarea:HOVER {
	border: none;
}

</style>
<script type="text/javascript">
		$(document).ready(function() {

			$("#addBttn").click(function(){
				$(".message").empty();
				$("#validity_label").empty();
				$("#addBookDiv").show();
				$.get('<spring:message code="application.name"/>${pageContext.servletContext.contextPath}/ajaxGetValue.htm?key=uuid', function( data ) {
					var unid = data;
					$("#uuid").val(unid);
					$("#bcuuid").val(unid);
					}); 
				$("#addBookBttn").attr("disabled", false);	
				$(this).hide();
			});
			
			
			
			$("#addBookForm").validate({
				rules: {     
					description: {required: true},
						   file: {
							   	required: true,
							   	extension: "pdf",
								pdfMaxSize:true,
								pdfMinSize:true
								}
							
				},
				messages: {
					description:{
								required: "Please write about Book."
								},
							file:{
								extension:"Please select a Pdf file"
								}
				},
				
				submitHandler: function(form) { 
					
					$("#validity_label").html('<div class="alert alert-success">No errors. </div>');
					$(this).attr("disabled", true);	
					$("#addBookForm").ajaxSubmit(bookOptions);
					$('#booksTable').dataTable({
						"sPaginationType" : "full_numbers",
						"bJQueryUI" : true,
						 "bRetrieve": true
					});
					$("#validity_label").empty();
					},
				invalidHandler: function(form, validator) {
					$("#validity_label").html('<div class="alert alert-error">There be '+validator.numberOfInvalids()+' error'+(validator.numberOfInvalids()>1?'s':'')+' here.</div>');
				}
			});
			
						$.validator.addMethod("maxSize",
								function(val, element) {
									var size = element.files[0].size;
									if (size > 5242880) {//5MB =5242880
										return false;
									} else {
										return true;
									}

								}, "Image size cannot be more than 5Mb");

						$.validator.addMethod("minSize",
								function(val, element) {
									var ext = $(element).val().split('.').pop()
											.toLowerCase();

									var allow = new Array('jpeg', 'jpg');
									var size = element.files[0].size;

									if (size < 10240) {//1048576
										return false;
									} else {
										return true;
									}

								}, "Image size cannot be less than 10kb");
						$.validator.addMethod("pdfMaxSize",
								function(val, element) {
									var size = element.files[0].size;
									if (size > 52428800) {//5MB =5242880
										return false;
									} else {
										return true;
									}

								}, "Pdf size cannot be more than 50Mb");

						$.validator.addMethod("pdfMinSize",
								function(val, element) {
									var ext = $(element).val().split('.').pop()
											.toLowerCase();

									var allow = new Array('jpeg', 'jpg');
									var size = element.files[0].size;

									if (size < 10240) {//1048576
										return false;
									} else {
										return true;
									}

								}, "Pdf size cannot be less than 10kb");

						
						

						$(".b_delete").click(function() {
											var bookid = $(this).attr("id").split('_')[1];

											if (confirm("Do you want to delete this Book?")) {
												$("#bookId").val(bookid);
												$.post('deleteBook.htm',$("#bookForm").serialize(),
																function(data) {
																	if (data.success == true) {
																		var tr = $("tr#book_"+ bookid);
																		tr.css("background-color","#666666");
																		tr.fadeOut(400,function() {tr.remove();});
																		$(".message").empty().html("<font class='g'>"+ data.message+ "</font>").fadeIn().delay(5000).fadeOut();
																		return false;
																	} else {
																		$(".message").empty().html("<font class='r'>"+data.errormsg+ "</font>").fadeIn().delay(5000).fadeOut();
																		
																	}
																});

											} else
												return false;

										});
						

						$(".b_edit").click(function() {
											var imageId = $(this).attr("id").split('_')[1];
											$("#by_" + imageId).show();
											$(".b_edit").hide();
											$(".b_delete").hide();
											var desc = $(this).parents("tr").find("td.book_desc");
											var txra = '<textarea id="desc_'+imageId+'" cols="12" rows="3" resize="none">'
													+ desc.html()
													+ '</textarea>';
											desc.empty();
											desc.html(txra);
											$(this).parents("tr").find("td #imc_" + imageId).show();
											//<textarea id="desc_${book.id}" cols="19" rows="3" resize="none"  disabled="disabled">${image.description}</textarea>
											//$("#desc_"+imageId).attr("disabled",false);
										});

						$(".b_cancel").click(function() {
											var imageId = $(this).attr("id")
													.split('_')[1];
											var desc = $(this).parents("tr")
													.find("td.img_desc");
											var imagedesc = $(
													"#desc_" + imageId).val();
											desc.empty();
											desc.html(imagedesc);
											$(".im_edit").show();
											$(".im_delete").show();
											$(".im_yes").hide();
											$(".im_cancel").hide();
											//alert($(this).parents("tr").find("td textarea").val()	);
										});

								$(".b_yes").click(function() {
										var imageId = $(this).attr("id")
												.split('_')[1];
										$("#bookId").val(imageId);
										$("#by_"+imageId).show();
		
										var desc = $(this).parents("tr")
												.find("td.img_desc");
										var imagedesc = $(
												"#desc_" + imageId).val();
										$("#imageTbdesc").val(imagedesc);
										$.post('editBook.htm',$("#bookForm").serialize(),
											function(data) {
												if (data.success == true) {
													desc.empty();
													desc.html(imagedesc);
													$(".b_edit").show();
													$(".b_delete").show();
													$(".b_yes").hide();
													$(".b_cancel").hide();
													$(".message").empty().html("<font class='g'>"+ data.message+ "</font>").fadeIn().delay(5000).fadeOut();
												} else {
		
												}
											});
										});
								
						var oTable = $('#booksTable').dataTable({
							"sPaginationType" : "full_numbers",
							"bJQueryUI" : true,
							"bRetrieve" : true
						});
						
						$("#cancelBookBttn").click(function() {
							$("#addBookForm")[0].reset();
							$("#addBookDiv").hide();
							$("#addBttn").show();
						});
						
						//ADD FORM AJAX SUBMIT 
						var bookOptions = {
							type : 'POST',
							url : 'addBook.htm',
							extraData : $("#addBookForm").serialize(),
							dataType : 'json',
							iframe : true,
							beforeSend : function() {

							},
							uploadProgress : function(event, position, total,
									percentComplete) {

							},
							success : function(data) {
								if (data.success == true) {
									$(".message").html(
											'<font class="g">' + data.message
													+ '</font>').fadeIn().delay(5000).fadeOut();;
									//$(".books").prepend('<div class="book"><a rel="book_group" href="${pageContext.servletContext.contextPath}/book/'+data.name+'" title="'+data.description+'" id="galImg_"'+data.id+'"><input type="image" src="/theschool/book/thumb_'+data.name+'" title="'+data.description+'" /></a></div>');

									$("#booksBody")
											.prepend(
													'<tr class="even_gradeA odd" id="book_'+data.id+
		        			'"><td class=""><a  title="'+data.description+'" href="${pageContext.request.contextPath}/books/'+data.url+
		        			'" 	rel="book_group"><img class="std-thumb" src="data:image/jpg;base64,'+data.image+
		        			'"/></a></td><td class="book_desc">'
															+ data.description
															+ '</td><td class="center">'
															+ data.data[0]
															+ '</td><td class="center ">'
															+ data.data[1]
															+ '</td><td class="center">'
															+ data.data[2]
															+ '</td><td class=" ">'
															+ data.data[3]
															+ '</td><td class="buttons"><div id="be_'+data.id+'" title="Edit" style="" class="editicon b_edit"></div>'
															+ '<input type="button" style="display: none;" class="large clButton green b_yes" id="by_'+data.id+'" title="Yes" value="Yes"/>'
															+ '<div id="bd_'+data.id+'" title="Delete" style="" class="deleteicon b_delete"></div></td></tr>');

								
									$("#addBookForm")[0].reset();
									$("#addBookDiv").hide();
									$("#addBttn").show();
								} else {
									$(".message").html(
											'<font class="r">' + data.message
													+ '</font>').fadeIn().delay(5000).fadeOut();
								}
							},
							complete : function(data) {

							},
							error : function() {
								$(".message").html('<font class="g">' + data.message+ '</font>').fadeIn().delay(5000).fadeOut();
												
							}

						};

						 formName = 'imageForm';
						 cropRatio = 119 / 168;//762/330; 680 / 460:W/H
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
						
					});
</script>




<div class="" id="validity_label"></div>
<input type="button"  class="large clButton green" id="addBttn" title="Add" value="Add"/>
<div class="message"></div>

<div class="" id="addBookDiv" style="display: none;"   class="formDataDiv addFormv">
				
	<table border="0" cellspacing="0" cellpadding="2">
		<tr>
			<td>
			<form:form enctype="multipart/form-data" name="addBookForm"
						id="addBookForm" method="POST" commandName="addBookForm">
						<form:input type="hidden" path="actionType" class="" id="actionType" />
						<form:input type="hidden" path="categoryId" class="" id="categoryId" />
						<form:input type="hidden" path="categoryUrl"/>
						<form:hidden path="uuid" id="bcuuid"/>
		
						<table border="0" class="order">
						<tbody>
									<tr>
										<td><label class="text-right padding-top5">Upload Book:
												<span class="mandatory">*</span> </label></td>
										<td><form:input type="file" path="file" class="upload"
												name="book" placeholder="Select Book" data-placement="right"
												/>
										</td>
									</tr>
									<tr>
										<td><label class="text-right padding-top5">Name:<span class="mandatory">*</span> </label></td>
										<td colspan="2"><form:input type="text" path="name"
												class="searchTextBoxes" /> <br> <form:errors
												path="name" cssClass="errormsg" /><span class="errormsg"
											id="nameError"></span></td>
									</tr>
									<tr>
										<td><label class="text-right padding-top5">Author:<span class="mandatory">*</span> </label></td>
										<td colspan="2"><form:input type="text" path="author"
												class="searchTextBoxes" /> <br> <form:errors
												path="author" cssClass="errormsg" /><span class="errormsg"
											id="authorError"></span></td>
									</tr>
									<tr>
										<td><label class="text-right padding-top5">Description:<span class="mandatory">*</span> </label></td>
										<td colspan="2"><form:input path="description"
												name="description" required="" placeholder="Required"
												type="text" data-placement="right" class="" /></td>
									</tr>
									<tr>
										<td></td>
										<td><input type="button" class="large clButton yellow"
											id="cancelBookBttn" title="Cancel" value="Cancel" /> <input
											type="submit" class="large clButton green" id="addBookBttn"
											title="Add" value="Add" />
										</td>
										<td></td>
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
										<td>
													<img src="" id="cropedImage"
														style="width: 119px; height: 168px; display: inline-block;" />
												<span class="errormsg" id="cropedImageError"></span></td>
									</tr>
									<tr>
										<td>Book Image<span class="mandatory">*</span> <form:input
												type="file" path="imageFile" class="upload" id="fileUpload"
												name="imageFile" required="" placeholder="Required"
												data-placement="right" /> <form:errors path="imageFile"
												cssClass="errormsg" /><span class="errormsg" id="fileError"></td>
									</tr>
								</table>
							</form:form></td>
					
					</tr></table>
				</div>



<div style="clear: both;"></div>


<%-- <c:choose>
	<c:when test="${empty books}">
		<div class="alertMsg">No Books/ Add Books</div>
	</c:when>
	<c:otherwise> --%>
		<table  class="display dataTable"
					id="booksTable" border="0" cellpadding="0" cellspacing="0">
				<thead>
						<tr >
							<th	style="width: 94px;" colspan="1"	rowspan="1" 
								 class="sorting_disabled">Image</th>
							<th style="width: 120px;" colspan="1" rowspan="1"
								class="sorting">Description</th>
							<th	style="width: 100px;" colspan="1" rowspan="1"
								class="sorting">Inserted</th>
							<th	style="width: 100px;" colspan="1" rowspan="1"
								class="sorting">Inserted By</th>
							<th	style="width: 100px;" colspan="1" rowspan="1"
								class="sorting">Updated</th>
							<th style="width: 100px;" colspan="1" rowspan="1"
								class="sorting">Updated By</th>
							<th style="width: 100px;" colspan="1" rowspan="1"
							class="sorting_disabled">Edit/Delete</th>
						</tr>
					</thead>
					<tfoot style="display: none">
						<tr>
							<th colspan="1" rowspan="1">Image</th>
							<th colspan="1" rowspan="1">Description</th>
							<th colspan="1" rowspan="1">Inserted</th>
							<th colspan="1" rowspan="1">Inserted By</th>
							<th colspan="1" rowspan="1">Updated</th>
							<th colspan="1" rowspan="1">Updated By</th>
							<th colspan="1" rowspan="1">Action</th>
						</tr>
					</tfoot>
	<form:form  name="bookForm" action=""
										id="bookForm" class="" method="POST"
										commandName="bookForm">
										<form:input type="hidden" path="id"  id="bookId" value=""/>
										<form:input type="hidden" path="description"  id="bookdesc" value=""/>
					<tbody id="booksBody">
						<c:if test='${null!=books }'>
							<c:forEach var="book" items="${books}">
							
											<tr class="even_gradeA odd" id="book_${book.id}">
											
												<td class=""> <a  title="${book.description}"
						href="${pageContext.request.contextPath}/books/r/${cat.url}/${book.url}" target="_blank">
							<img class="std-thumb" src="data:image/jpg;base64,<c:out value='${book.image}'/>" style="width:55px;"/>
					</a></td>
												<td class="img_desc">${book.description}</td>
												<td class="center ">${book.inserted}</td>
												<td class="center ">${book.insertedby}</td>
												<td class="center ">${book.lastmodified}</td>
												<td class=" ">${book.lastmodifiedby}</td>
												<td class="buttons">
												<div id="be_${book.id}" title="Edit" style="" class="editicon b_edit"></div>
												
												<input type="button" style="display: none;" class="large clButton green b_yes" id="by_${book.id}" title="Ok" value="Ok"/>
												<input type="button" style="display: none;" class="large clButton green b_cancel" id="bc_${book.id}" title="Cancel" value="C"/>
												<div id="bd_${book.id}" title="Delete" style="" class="deleteicon b_delete"></div>
												</td>
											</tr>
								
							</c:forEach>
						</c:if>
					</tbody>
					</form:form>
				</table>
	
<%-- 	</c:otherwise>
	</c:choose>	 --%>



