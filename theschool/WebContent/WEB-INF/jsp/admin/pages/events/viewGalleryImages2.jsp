<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%-- <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.vydya.theschool.common.constants.TSConstants"%>
<%@ page import="com.vydya.theschool.web.constants.WebConstants"%>
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery.finescroll.min.js"></script>
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/common.js"></script>
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
div.galleryImages a disabledImage{
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

#galleryImagesTable textarea:HOVER {
	border: none;
}

</style>
<script type="text/javascript">
		$(document).ready(function() {

			$("a[rel=galleryImage_group]").fancybox({
				
				prevEffect : 'none',
				nextEffect : 'none',
				openEffect:'elastic',
				closeEffect:'elastic',
				helpers : {
					overlay : {
						closeClick : false
					}
				}
			});

			
			
			
			$('ul.tabs').each(
					function() {
						// For each set of tabs, we want to keep track of
						// which tab is active and it's associated content
						var $active, $content, $links = $(this).find('a');

						// If the location.hash matches one of the links, use that as the active tab.
						// If no match is found, use the first link as the initial active tab.
						$active = $($links.filter('[href="' + location.hash
								+ '"]')[0]
								|| $links[0]);
						$active.addClass('active');
						$content = $($active.attr('href'));

						// Hide the remaining content
						$links.not($active).each(function() {
							$($(this).attr('href')).hide();
						});

						// Bind the click event handler
						$(this).on('click', 'a', function(e) {
							// Make the old tab inactive.
							$active.removeClass('active');
							$content.hide();

							// Update the variables with the new link and content
							$active = $(this);
							$content = $($(this).attr('href'));

							// Make the tab active.
							$active.addClass('active');
							$content.fadeIn(1000);

							// Prevent the anchor's default click action
							e.preventDefault();
						});
					});

			$("#addEventGalleryTab").fineTabs({
				tabhead : 'h2',
				fx : "fadeIn",
				syncheights : true,
				saveState : true,
				clearfixClass : 'ym-clearfix',
				currentInfoText : ""

			});

			/* loadLeftgallery();
			function loadLeftgallery(){
				
				$.get('<spring:message code="application.name"/>${pageContext.servletContext.contextPath}/getlist.htm?t=G&y=2014', function( data ) {
					var html;
					$.each(data, function(index, e) {
						 html='<div class="admin-left-boundary" id="gallery_'+e.id+'"><div class="a-inner-border">'+
							'<div class="gallery-inner"><div class="thumbnail-lm itemcontainer"><img src="${pageContext.servletContext.contextPath}/static/simg-fit/203x137/'+e.url+
							'" id="galleryImage_'+e.id+'_'+e.url+'" class="galleryImage"	alt="'+e.name+'" /></div><div class="content-div">'+
								'<div class="gallery-decorator"><a href="${pageContext.servletContext.contextPath}/admin/manageGallery/viewAllImages.htm?g='+e.id+'" id="galleryName_'+e.id+'_'+e.url+'"  class="galleryName">'+e.description+'</a></div></div></div></div></div></div>';
								$(html).appendTo("#t2014 .scrollboxSDiv");
						});
					});
				} */
			
			$( document ).ajaxComplete(function() {

				 $('.scrollboxSDiv').finescroll({
					    verticalTrackClass: 'track',
					    verticalHandleClass: 'handle',
					    minScrollbarLength: 15,
					    showOnHover : true
					}); 
				});
			
			
			 
			  $('.scrollboxDiv').finescroll({
				    verticalTrackClass: 'track',
				    verticalHandleClass: 'handle',
				    minScrollbarLength: 15,
				    showOnHover : true
				});  
			 
			  loadLeftgalleryMenu('g','<spring:message code="application.name"/>${pageContext.servletContext.contextPath}','${pageContext.servletContext.contextPath}');
			function loadUpdatedGalleryImage(){
				$.getJSON('loadUpdatedGalleryImages.htm', $("#galleryForm").serialize(), function(data) {displayGalleryImages(data);});
			 }
			function displayGalleryImages(data) {
				/* $("form").validate({
					  rules: {
					    nameField: { notEqual: "Your Name" }
					  }
					}); http://stackoverflow.com/questions/3571347/how-to-add-a-not-equal-to-rule-in-jquery-validation*/
					
						//$(".galleryImages").append('<a rel="galleryImage_group" href="${pageContext.servletContext.contextPath}/galleryImage?id='+image.id+'" title=""><div><img alt="'+image.imageName+'" src="${pageContext.servletContext.contextPath}/galleryImage?id='+image.id+'" /></div></a>'); 
			
				$.each(data, function(index, image) {
					//$(".galleryImages").append('<a rel="galleryImage_group" href="data:image/jpg;base64,'+image.image+'" title=""><div><img alt="'+image.imageName+'" src="data:image/jpg;base64,'+image.image+'" /></div></a>');
					//src="${pageContext.servletContext.contextPath}/homePageImage?id=${page.id}"
						var imageIds = [];
						$('.galleryImage').each(function(){
							var imageV = $(this).attr("id").split('_');
							 imageIds.push(imageV[1]);
						});
						if($.inArray(image.id.toString(), imageIds)==-1){
							$(".galleryImages").prepend('<a rel="galleryImage_group" href="${pageContext.servletContext.contextPath}/galleryImage?id='+image.id+'" title=""><div><img alt="'+image.imageName+'" src="${pageContext.servletContext.contextPath}/galleryImage?id='+image.id+'" /></div></a>'); 
						}
					});
				}
			function imageContains(imageId){
				$(".galleryImage").each(function(ind, value) { 
							var imageV = $(this).attr("id").split('_');
						   alert('index ' + ind + ':' + $(this).attr('id')+"List image id ="+imageId); 
						   if(imageV[1]==imageId){
							   alert("if true");
							   return true;
						   }
						});
					 return false;
				}
			
			$("#deleteBttn").click(function(){ 
				alert("d");
				$.post('deleteGalleryImages.htm',$("#galleryForm").serialize(),function(data){updatedGalleryImages(data);});
			}); 
			
			function updatedGalleryImages(data){
				
				alert("yes deleted");
			}
			
			$("#addBttn").click(function(){
				$(".message").empty();
				$("#validity_label").empty();
				$("#addImageForm").show();
				$(this).hide();
				$("#addImageBttn").attr("disabled", false);	
			});
			
			
			$("#galleryVideoForm").validate({
				rules: {     
					description: {required: true},
					url: {required: true},
					videoName: {required: true}
				},
				messages: {
						description : {	required : "Please write about Video."},
						url : {	required : "Video URL required."},
						videoName : {required : "Please name Video."}
					},

					submitHandler : function(form) {
						$("#validity_label").html('<div class="alert alert-success">No errors. </div>');
						$(this).attr("disabled", true);
						var galId = $("#galId").val();
						var galName = $("#galName").val();
						$("#galleryIdForVideo").val(galId);
						$("#galleryNameForVideo").val(galName);
						$("#galleryVideoForm").ajaxSubmit(videoOptions);
						
						$('#galleryVideosTable').dataTable(
										{
											"sPaginationType" : "full_numbers",
											"bJQueryUI" : true,
											"bRetrieve" : true
										});
					},
					invalidHandler : function(form,
							validator) {
						$("#validity_label").html('<div class="alert alert-error">There be '
												+ validator.numberOfInvalids()
												+ ' error'
												+ (validator.numberOfInvalids() > 1 ? 's': '')
												+ ' here.</div>');
					}
				});
			
			$("#galleryImageForm").validate({
				rules: {     
					description: {required: true},
						   file: {
							   	required: true,
							   	extension: "jpeg|jpg",
								maxSize:true,
								minSize:true
								}
				},
				messages: {
					description:{
								required: "Please write about image."
								},
					file:{
						required: "Please Select an Image.",
						extension:"Please select a valid jpeg image"
						}
				},
				
				submitHandler: function(form) { 
					
					$("#validity_label").html('<div class="alert alert-success">No errors. </div>');
					$(this).attr("disabled", true);	
					var galId = $("#galId").val();
					var galName = $("#galName").val();
					$("#galleryIdForImage").val(galId);
					$("#galleryNameForImage").val(galName);
					$("#galleryImageForm").ajaxSubmit(imageOptions);
					$('#galleryImagesTable').dataTable({
						"sPaginationType" : "full_numbers",
						"bJQueryUI" : true,
						 "bRetrieve": true
					});
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

						$("#cancelImageBttn").click(function() {
							$("#galleryImageForm")[0].reset();
							$("#addImageForm").hide();
							$("#addBttn").show();
						});
						
						$("#cancelVideoBttn").click(function() {
							$("#galleryVideoForm")[0].reset();
							$("#addImageForm").hide();
							$("#addBttn").show();
						});

						$(".im_delete").click(function() {
											var imageId = $(this).attr("id").split('_')[1];

											if (confirm("Do you want to delete this image?")) {
												$("#imageTbId").val(imageId);
												$.post('deleteImage.htm',$("#imageTableForm").serialize(),
																function(data) {
																	if (data.success == true) {
																		var tr = $("tr#galImg_"+ imageId);
																		tr.css("background-color","#666666");
																		tr.fadeOut(400,function() {tr.remove();});
																		$(".message").empty().html("<font class='g'>"+ data.message+ "</font>");
																		return false;
																	} else {
																		$(".message").empty().html("<font class='r'>"+data.errormsg+ "</font>");
																	}
																});

											} else
												return false;

										});
						

						$(".im_edit").click(function() {
											var imageId = $(this).attr("id").split('_')[1];
											$("#imy_" + imageId).show();
											$(".im_edit").hide();
											$(".im_delete").hide();
											var desc = $(this).parents("tr").find("td.img_desc");
											var txra = '<textarea id="desc_'+imageId+'" cols="12" rows="3" resize="none">'
													+ desc.html()
													+ '</textarea>';
											desc.empty();
											desc.html(txra);
											$(this).parents("tr").find("td #imc_" + imageId).show();
											//<textarea id="desc_${image.id}" cols="19" rows="3" resize="none"  disabled="disabled">${image.description}</textarea>
											//$("#desc_"+imageId).attr("disabled",false);
										});

						$(".im_cancel").click(function() {
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

								$(".im_yes").click(function() {
										var imageId = $(this).attr("id")
												.split('_')[1];
										$("#imageTbId").val(imageId);
										$("#imy_"+imageId).show();
		
										var desc = $(this).parents("tr")
												.find("td.img_desc");
										var imagedesc = $(
												"#desc_" + imageId).val();
										$("#imageTbdesc").val(imagedesc);
										$.post('editImage.htm',$("#imageTableForm").serialize(),
											function(data) {
												if (data.success == true) {
													desc.empty();
													desc.html(imagedesc);
													$(".im_edit").show();
													$(".im_delete").show();
													$(".im_yes").hide();
													$(".im_cancel").hide();
													$(".message").empty().html("<font class='g'>"+ data.message+ "</font>");
												} else {
		
												}
											});
										});
								
								// Gallery Videos
								
								$(".vid_delete").click(function() {
									var vId = $(this).attr("id").split('_')[1];
									if (confirm("Do you want to delete this Video?")) {
										$("#vidTbId").val(vId);
										$.post('deleteVideo.htm',$("#videoTableForm").serialize(),
														function(data) {
															if (data.success == true) {
																var tr = $("tr#galVid_"+ vid);
																tr.css("background-color","#666666");
																tr.fadeOut(400,function() {tr.remove();});
																$(".message").empty().html("<font class='g'>"+ data.message+ "</font>");
																return false;
															} else {
																$(".message").empty().html("<font class='r'>"+data.errormsg+ "</font>");
															}
														});
									} else
										return false;
								});
								
								$(".vid_edit").click(function() {
									var vid = $(this).attr("id").split('_')[1];
									$("#vidy_" + vid).show();
									$(".vid_edit").hide();
									$(".vid_delete").hide();
									var desc = $(this).parents("tr").find("td.vid_desc");
									var txra = '<textarea id="vdesc_'+imageId+'" cols="12" rows="3" resize="none">'
											+ desc.html()
											+ '</textarea>';
									desc.empty();
									desc.html(txra);
									$(this).parents("tr").find("td #vidc_" + imageId).show();
									//<textarea id="desc_${image.id}" cols="19" rows="3" resize="none"  disabled="disabled">${image.description}</textarea>
									//$("#desc_"+imageId).attr("disabled",false);
								});

				$(".vid_cancel").click(function() {
									var vid = $(this).attr("id").split('_')[1];
									var desc = $(this).parents("tr")
											.find("td.vid_desc");
									var imagedesc = $("#vdesc_" + vid).val();
									desc.empty();
									desc.html(imagedesc);
									$(".vid_edit").show();
									$(".vid_delete").show();
									$(".vid_yes").hide();
									$(".vid_cancel").hide();
									//alert($(this).parents("tr").find("td textarea").val()	);
								});

						$(".vid_yes").click(function() {
								var vid = $(this).attr("id")
										.split('_')[1];
								$("#vidTbId").val(vid);
								$("#vidy_"+vid).show();

								var desc = $(this).parents("tr")
										.find("td.vid_desc");
								var imagedesc = $(
										"#vdesc_" + vid).val();
								$("#videoTbdesc").val(imagedesc);
								$.post('editVideo.htm',$("#videoTableForm").serialize(),
									function(data) {
										if (data.success == true) {
											desc.empty();
											desc.html(imagedesc);
											$(".vid_edit").show();
											$(".vid_delete").show();
											$(".vid_yes").hide();
											$(".vid_cancel").hide();
											$(".message").empty().html("<font class='g'>"+ data.message+ "</font>");
										} else {

										}
									});
								});
						
						var oTable = $('#galleryImagesTable').dataTable({
							"sPaginationType" : "full_numbers",
							"bJQueryUI" : true,
							"bRetrieve" : true
						});
						
						var vTable = $('#galleryVideosTable').dataTable({
							"sPaginationType" : "full_numbers",
							"bJQueryUI" : true,
							"bRetrieve" : true
						});

						//ADD FORM AJAX SUBMIT 
						var imageOptions = {
							type : 'POST',
							url : 'addImage.htm',
							extraData : $("#galleryImageForm").serialize(),
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
													+ '</font>');

									$("#imagesBody")
											.prepend(
													'<tr class="even_gradeA odd" id="galImg_'+data.id+
		        			'"><td class=""><a  title="'+data.description+'" href="${pageContext.request.contextPath}/static/simg-org/'+data.name+
		        			'" 	rel="galleryImage_group"><img class="std-thumb" src="${pageContext.request.contextPath}/static/simg-fit/'+data.url+  //src="data:image/jpg;base64,'+data.image+
		        			'"/></a></td><td class="img_desc">'
															+ data.description
															+ '</td><td class="center">'
															+ data.data[0]
															+ '</td><td class="center ">'
															+ data.data[1]
															+ '</td><td class="center">'
															+ data.data[2]
															+ '</td><td class=" ">'
															+ data.data[3]
															+ '</td><td class="buttons"><div id="ime_'+data.id+'" title="Edit" style="" class="editicon im_edit"></div>'
															+ '<input type="button" style="display: none;" class="large clButton green im_yes" id="imy_'+data.id+'" title="Yes" value="Yes"/>'
															+ '<div id="imd_'+data.id+'" title="Delete" style="" class="deleteicon im_delete"></div></td></tr>');


									$("#galleryImageForm")[0].reset();
									$("#addImageForm").hide();
									$("#addBttn").show();
								} else {
									$(".message").html(
											'<font class="r">' + data.message
													+ '</font>');
								}
							},
							complete : function(data) {

							},
							error : function() {
								$(".message").html(
										'<font class="g">' + data.message
												+ '</font>');
							}

						};

							
						var videoOptions = {
								type : 'POST',
								url : 'addVideo.htm',
								extraData : $("#galleryVideoForm").serialize(),
								dataType : 'json',
								iframe : true,
								beforeSend : function() {
								},
								
							success : function(data) {
							 if (data.success == true) {
									$(".message").html('<font class="g">' + data.message+ '</font>');
									$("#videosBody").prepend(
											'<tr class="even_gradeA odd" id="galVid'+data.id+'">'+
											'<td class=""> <a id="" class="vcontainer" title="'+data.id+'" href="http://www.youtube.com/v/'+data.image+'?fs=1&autoplay=1" rel="galleryVideo_group">'+
											'<img src="http://img.youtube.com/vi/'+data.image+'/0.jpg" class="vthumb" alt="" /><div class="vplay"></div></a>'+
											'</td><td class="vid_name">'+data.name+'</td><td class="vid_url">'+data.url+'</td><td class="img_desc">'
													+ data.description
													+ '</td><td class="center">'
													+ data.data[0]
													+ '</td><td class="center ">'
													+ data.data[1]
													+ '</td><td class="center">'
													+ data.data[2]
													+ '</td><td class=" ">'
													+ data.data[3]
													+ '</td><td class="buttons"><div id="vide_'+data.id+'" title="Edit" style="" class="editicon vid_edit"></div>'
													+ '<input type="button" style="display: none;" class="large clButton green vid_yes" id="vidy_'+data.id+'" title="Yes" value="Yes"/>'
													+ '<div id="vidd_'+data.id+'" title="Delete" style="" class="deleteicon vid_delete"></div></td></tr>');
									$("#galleryVideoForm")[0].reset();
									$("#addImageForm").hide();
									$("#addBttn").show();
								 } else {
									$(".message").html(
											'<font class="r">' + data.message
													+ '</font>');
									}
								},
							complete : function(data) {

							},
							error : function() {
								$(".message").html('<font class="r"> Error</font>');
							}

						};
						
						
						
						
						$("a[rel=galleryVideo_group]").fancybox({
							
							fitToView	: true,
							helpers : {
								overlay : {
									closeClick : false
								}
							},
							arrows:false,
				      	  title: this.title,
							autoSize	: true,
							openEffect	: 'elastic',
							nextClick  : false,
							closeEffect	: 'elastic',
							type: 'swf',
				      	  swf: {
				      	    'wmode': 'transparent',
				      	    'allowfullscreen': 'true'
				      	  }
						});
						
						
					});
</script>


<div class="adminLRlayout">

	<div id="left-img-Column">
	
	</div>
	</div>
	<div id="content-Column" style="width: 77%; float: right;">

		<form:form name="galleryForm" id="galleryForm" method="POST"
			commandName="galleryForm">
			<form:input type="hidden" path="id" class="" id="galId" />
			<form:input type="hidden" path="name" class="" id="galName" />
			<div class="piw">
			<div class="img-parent">
				<img src="${pageContext.request.contextPath}/static/simg-org/${galleryForm.imageName}" width="100%"/>
			</div>
			
			<div class="blockquote"
				style="border-left: 5px solid rgb(0, 138, 0); display: flex;">
				<div style="width: 60%">
					<h1>${galleryForm.title}</h1>
					<small>${galleryForm.eventDesc}</small>
				</div>
				<div style="width: 40%" class="Gd">
					<cite class="muted">${galleryForm.eventPlace},&nbsp;${galleryForm.eventDate}</cite>
					<small>Inserted By&nbsp; <strong>${galleryForm.insertedby}</strong>
						and Updated by&nbsp;<strong>${galleryForm.lastmodifiedby}</strong>
						on <b>${galleryForm.lastmodified}</b></small>
				</div>
			</div>
			</div>

			<input type="button" class="large clButton green" id="addBttn"
				title="Delete" value="Add" />
			<div class="message"></div>
		</form:form>


		<div id="addImageForm" style="display: none;">
			<div class="" id="validity_label"></div>
			<div class="tabs" id="addEventGalleryTab">
				<ul class="clearfix tabs-list tabamount3">
					<li class="current first" id="accessibletabsnavigation0-0"><a
						href="#accessibletabscontent0-0"><span class="current-info"></span>Add
							Image</a></li>
					<li id="accessibletabsnavigation0-1"><a
						href="#accessibletabscontent0-1">Add Video</a></li>
				</ul>
				<div class="tabBox">
					<div style="display: block;" class="tabbody">
						<div>
							<form:form enctype="multipart/form-data" name="galleryImageForm"
								id="galleryImageForm" method="POST"
								commandName="galleryImageForm">
								<form:input type="hidden" path="id" class="" id="imageId" />
								<form:input type="hidden" path="galleryId" class=""
									id="galleryIdForImage" />
								<form:input type="hidden" path="galleryName" class=""
									id="galleryNameForImage" />

								<div style="" class="formDataDiv addFormv">
									<table width="660" border="0" class="order">
										<tbody>
											<tr>
												<td><label class="text-right padding-top5">Gallery
														Image:<span class="mandatory">*</span>
												</label></td>
												<td><form:input type="file" path="file" class="upload"
														name="file" placeholder="Select File"
														data-placement="right" required="" /><br>
														<form:errors path="file" cssClass="error" />
														</td>
											</tr>
											<tr>
												<td><label class="text-right padding-top5">Description:<span
														class="mandatory">*</span>
												</label></td>
												<td colspan="2"><form:input path="description"
														name="description" required="" placeholder="Required"
														type="text" data-placement="right" class="" /></td>
											</tr>
											<tr>
												<td></td>
												<td><input type="button" class="large clButton yellow"
													id="cancelImageBttn" title="Cancel" value="Cancel" /> <input
													type="submit" class="large clButton green"
													id="addImageBttnx" title="Add" value="Add" /></td>
												<td></td>
											</tr>
									</table>
								</div>
							</form:form>
						</div>
					</div>
					<div style="display: block;" class="tabbody">
						<div>
							<form:form enctype="multipart/form-data" name="galleryVideoForm"
								id="galleryVideoForm" method="POST"
								commandName="galleryVideoForm">
								<form:input type="hidden" path="id" class="" id="imageId" />
								<form:input type="hidden" path="galleryId" class=""
									id="galleryIdForVideo" />
								<form:input type="hidden" path="galleryName" class=""
									id="galleryNameForVideo" />
								<div class="span5" id="validity_label"></div>
								<div style="" class="formDataDiv addFormv">
									<table width="660" border="0" class="order">
										<tbody>
											<tr>
												<td><label class="text-right padding-top5">Video
														URL:<span class="mandatory">*</span>
												</label></td>
												<td colspan="2"><form:input path="url" name="url"
														required="" placeholder="Required" type="text"
														data-placement="right" class="" /></td>
											</tr>
											<tr>
												<td><label class="text-right padding-top5">Name:<span
														class="mandatory">*</span>
												</label></td>
												<td colspan="2"><form:input path="videoName"
														name="videoName" required="" placeholder="Required"
														type="text" data-placement="right" class="" /></td>
											</tr>
											<tr>
												<td><label class="text-right padding-top5">Description:<span
														class="mandatory">*</span>
												</label></td>
												<td colspan="2"><form:input path="description"
														name="description" required="" placeholder="Required"
														type="text" data-placement="right" class="" /></td>
											</tr>
											<tr>
												<td></td>
												<td><input type="button" class="large clButton yellow"
													id="cancelVideoBttn" title="Cancel" value="Cancel" /> <input
													type="submit" class="large clButton green"
													id="addImageBttnx" title="Add" value="Add" /></td>
												<td></td>
											</tr>
									</table>
								</div>
							</form:form>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div style="clear: both;"></div>


		<%-- <c:choose>
			<c:when test="${empty galleryImageList}">
				<div class="alertMsg">No Images/ Add Images</div>
			</c:when>
			<c:otherwise> --%>
				<table class="display dataTable" id="galleryImagesTable" border="0"
					cellpadding="0" cellspacing="0">
					<thead>
						<tr>
							<th style="width: 94px;" colspan="1" rowspan="1"
								class="sorting_disabled">Image</th>
							<th style="width: 120px;" colspan="1" rowspan="1" class="sorting">Description</th>
							<th style="width: 100px;" colspan="1" rowspan="1" class="sorting">Inserted</th>
							<th style="width: 100px;" colspan="1" rowspan="1" class="sorting">Inserted
								By</th>
							<th style="width: 100px;" colspan="1" rowspan="1" class="sorting">Updated</th>
							<th style="width: 100px;" colspan="1" rowspan="1" class="sorting">Updated
								By</th>
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
					<form:form name="imageTableForm" action="" id="imageTableForm"
						class="" method="POST" commandName="imageTableForm">
						<form:input type="hidden" path="id" id="imageTbId" value="" />
						<form:input type="hidden" path="description" id="imageTbdesc"
							value="" />
						<tbody id="imagesBody">
							<c:if test='${null!=galleryImageList }'>
								<c:forEach var="image" items="${galleryImageList}">

									<tr class="even_gradeA odd" id="galImg_${image.id}">

										<td class="">
										<a id="evntImg_${image.id}"
								title="${image.description}"
								href="${pageContext.request.contextPath}/static/simg-org/${image.imageName}"
								rel="galleryImage_group"> 
							<img src="${pageContext.request.contextPath}/static/simg-fit/107x72/${image.imageName}" class=""
								alt="${image.imageName}" /> </a>
								
										</td>
										<td class="img_desc">${image.description}</td>
										<td class="center ">${image.inserted}</td>
										<td class="center ">${image.insertedby}</td>
										<td class="center ">${image.lastmodified}</td>
										<td class=" ">${image.lastmodifiedby}</td>
										<td class="buttons">
											<div id="ime_${image.id}" title="Edit" style=""
												class="editicon im_edit"></div> <input type="button"
											style="display: none;" class="large clButton green im_yes"
											id="imy_${image.id}" title="Ok" value="Ok" /> <input
											type="button" style="display: none;"
											class="large clButton green im_cancel" id="imc_${image.id}"
											title="Cancel" value="C" /> <%-- <input type="button"  class="large clButton yellow im_delete" id="imd_${image.id}" title="Delete"  value="D"/> --%>
											<div id="imd_${image.id}" title="Delete" style=""
												class="deleteicon im_delete"></div>
										</td>
									</tr>

								</c:forEach>
							</c:if>
						</tbody>
					</form:form>
				</table>
<%-- 
			</c:otherwise>
		</c:choose> --%>


		<h6>Videos</h6>

		<c:choose>
			<c:when test="${empty galleryVideosList}">
				<div class="alertMsg">No Videos/ Add Videos</div>
			</c:when>
			<c:otherwise>
				<table class="display dataTable" id="galleryVideosTable" border="0"
					cellpadding="0" cellspacing="0">
					<thead>
						<tr>
							<th style="width: 94px;" colspan="1" rowspan="1"
								class="sorting_disabled">Video</th>
							<th style="width: 120px;" colspan="1" rowspan="1" class="sorting">Name</th>
							<th style="width: 120px;" colspan="1" rowspan="1" class="sorting">Url</th>
							<th style="width: 120px;" colspan="1" rowspan="1" class="sorting">Description</th>
							<th style="width: 100px;" colspan="1" rowspan="1" class="sorting">Inserted</th>
							<th style="width: 100px;" colspan="1" rowspan="1" class="sorting">Inserted
								By</th>
							<th style="width: 100px;" colspan="1" rowspan="1" class="sorting">Updated</th>
							<th style="width: 100px;" colspan="1" rowspan="1" class="sorting">Updated
								By</th>
							<th style="width: 100px;" colspan="1" rowspan="1"
								class="sorting_disabled">Edit/Delete</th>
						</tr>
					</thead>
					<tfoot style="display: none">
						<tr>
							<th colspan="1" rowspan="1">Video</th>
							<th colspan="1" rowspan="1">Name</th>
							<th colspan="1" rowspan="1">Url</th>
							<th colspan="1" rowspan="1">Description</th>
							<th colspan="1" rowspan="1">Inserted</th>
							<th colspan="1" rowspan="1">Inserted By</th>
							<th colspan="1" rowspan="1">Updated</th>
							<th colspan="1" rowspan="1">Updated By</th>
							<th colspan="1" rowspan="1">Action</th>
						</tr>
					</tfoot>
					<form:form name="videoTableForm" action="" id="videoTableForm"
						class="" method="POST" commandName="videoTableForm">
						<form:input type="hidden" path="id" id="vidTbId" value="" />
						<form:input type="hidden" path="description" id="videoTbdesc"
							value="" />
						<tbody id="videosBody">
							<c:if test='${null!=galleryVideosList }'>
								<c:forEach var="video" items="${galleryVideosList}">

									<tr class="even_gradeA odd" id="galVid_${video.id}">
										<td class=""><a id="" class="vcontainer"
											title="${video.videoName}"
											href="http://www.youtube.com/v/${video.vid}?fs=1&autoplay=1"
											rel="galleryVideo_group"> <img
												src="http://img.youtube.com/vi/${video.vid}/0.jpg"
												class="vthumb" alt="" />
												<div class="vplay"></div>
										</a></td>
										<td class="vid_name">${video.videoName}</td>
										<td class="vid_url">${video.url}</td>
										<td class="vid_desc">${video.description}</td>
										<td class="center ">${video.inserted}</td>
										<td class="center ">${video.insertedby}</td>
										<td class="center ">${video.lastmodified}</td>
										<td class=" ">${video.lastmodifiedby}</td>
										<td class="buttons">
											<div id="vid_${video.id}" title="Edit" style=""
												class="editicon vid_edit"></div> <input type="button"
											style="display: none;" class="large clButton green vid_yes"
											id="vidy_${video.id}" title="Ok" value="Ok" /> <input
											type="button" style="display: none;"
											class="large clButton green vid_cancel" id="vidc_${video.id}"
											title="Cancel" value="C" />
											<div id="vidd_${video.id}" title="Delete" style=""
												class="deleteicon vid_delete"></div>
										</td>
									</tr>

								</c:forEach>
							</c:if>
						</tbody>
					</form:form>
				</table>

			</c:otherwise>
		</c:choose>
	</div>





