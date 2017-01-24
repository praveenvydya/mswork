<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%-- <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.vydya.theschool.common.constants.TSConstants"%>
<%@ page import="com.vydya.theschool.web.constants.WebConstants"%>

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
</style>
<script type="text/javascript">
		$(document).ready(function() {

			$("a[rel=galleryImage_group]").fancybox({
				'transitionIn'		: 'elastic',
				'transitionOut'		: 'elastic',
				'titlePosition' 	: 'over',
				'overlayColor'		: '#000',
				'overlayShow'	: true,
				'hideOnOverlayClick':false,
				'overlayOpacity'	: 0.5,
				/* 'onStart' : function() {
				}, */
				'titleFormat'		: function(title, currentArray, currentIndex, currentOpts) {
					return '<span id="fancybox-title-over"><span class="imageDesc">' +(title.length ? ' &nbsp; ' + title : '') +'</span><span class="imageIndex"> Image:'+ (currentIndex + 1) + ' / ' + currentArray.length+ '</span>';
				}
			});

			
		/* 	$("#addGalleryImage").fancybox({
				'width'				: '75%',
				'height'			: '75%',
				'autoScale'			: false,
				'overlayShow'	: true,
				'hideOnOverlayClick':false,
				'transitionIn'		: 'none',
				'transitionOut'		: 'none',
				'type'				: 'iframe',
				'onClosed'			:function() {
					loadUpdatedGalleryImage();
					
				}
			}); */

			
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
			<%-- $('#addGalleryImage').click(function(){
				$('#galleryForm').attr("disabled", true);	
				$("#galleryForm").attr("action", '<%=TSConstants.ACTION_ADD_GALLERY_IMAGES%>.htm');
				$('#galleryForm #actionType').val("view");
				$("#galleryForm").submit();
			});  --%> 
			$("#cancelDelete").click(function(){
				$(".forImage").hide();
				$("#deleteBttn").hide();
				$("#cancelDelete").hide();
				$("#deleteImages").show();
				$('.galleryImage input[type="image"]').removeClass("disabledImage").attr("disabled", false);
				$('.galleryImage input[type="image"]').attr("disabled", false);
			});
			
			$("#deleteImages").click(function() {
				
				$(".forImage").css("display","block");
				$("#deleteImages").hide();
				$("#deleteBttn").show();
				$("#cancelDelete").show();
				$('.galleryImage input[type="image"]').attr("disabled", true).addClass("disabledImage");;
			});
			
			$("#addBttnaddGalleryImage").click(function(){
				$("#addImageForm").show();
				$(this).hide();
			})
			
			$("#addImageBttn").click(function(){
				var galId = $().val("#galId");
				$("#galleryIdForImage").val(galId);
				$("#galleryImageForm").ajaxSubmit(imageOptions);
			})
			
			$("#cancelImageBttn").click(function(){
				$("#addImageForm").hide();
				$("#addBttnaddGalleryImage").show();
			})
			
			
			//ADD FORM AJAX SUBMIT 
			var optionsForCrop = { 
				type:'POST',
			url:'addImage.htm',
			extraData:$("#galleryImageForm").serialize(),
			dataType:'json',
			iframe:true,
		    beforeSend: function() 
		    {
		    	
		    },
		    uploadProgress: function(event, position, total, percentComplete) 
		    {
		 
		    },
		    success: function(data) 
		    {
		        if(data.success==true){
		        	
		        	$("#message").html("<font color='green'>"+data.message+"</font>");
		        }
		        else{
		        	$("#message").html("<font color='red'>"+data.errormsg+"</font>");
		        }
		    },
		    complete: function(data) 
		    {
		    },
		    error: function()
		    {
		        $("#message").html("<font color='red'> ERROR: unable to upload files</font>");
		    }
		 
		}; 
		});
	</script>

<form:form  name="galleryForm" id="galleryForm"
	method="POST" commandName="galleryForm">
	<form:input type="hidden" path="id" class="" id="galId" />
	<form:input type="hidden" path="name" class="" />
	
	<h2 class="pagehead">${galleryForm.name}</h2>
	<h4 class="pagetext">${galleryForm.title}</h4>
	<h4 class="pageSubtext"><span>${galleryForm.eventPlace}</span><span>${galleryForm.eventDate}</span></h4>
	
	<input type="button"  class="large clButton green" id="deleteImages" title="Delete" value="Delete Images"/>
	<input type="button"  class="large clButton green" id="deleteBttn" title="Delete" value="Delete" style="display: none;"/>
	<input type="button"  class="large clButton green" id="cancelDelete" title="Canel" value="Cancel" style="display: none;"/>
	<input type="button"  class="large clButton green" id="addBttn" title="Delete" value="Add"/>
</form:form>	
<div id="addImageForm" style="display: none;">
<form:form enctype="multipart/form-data" name="galleryImageForm" id="galleryImageForm"
	method="POST" commandName="galleryImageForm">
		<form:input type="hidden" path="id" class="" id="imageId"/>
		<form:input type="hidden" path="galleryId" class=""  id="galleryIdForImage"/>
		<form:input type="hidden" path="galleryName" class="" id="galleryNameForImage"/>
		<div id="message"></div>
		<div style="" class="formDataDiv addForm">
			<table width="660" border="0" class="order">
				<tbody>

					<tr>
						<td>Gallery Image<span class="mandatory">*</span></td>
						<td><form:input type="file" path="file"	class="upload" />
						</td>
					</tr>
					<tr>
						<td>Description<span class="mandatory">*</span></td>
						<td colspan="2"><form:input type="text" path="description"
								class="searchTextBoxes" /></td>
					</tr>
					<tr>
						<td>Gallery Name<span class="mandatory">*</span></td>
						<td colspan="2"><form:select path="galleryId"
								cssClass="galleryName" disabled="">
								<c:forEach items="${galleryRefList}" var="galleryRef">
									<form:option value="${galleryRef.idNum}"
										label="${galleryRef.description}"
										selected="${galleryId eq galleryRef.idNum ? 'selected': ''}" />
								</c:forEach>
							</form:select></td>
					</tr>
					<tr>
					<td colspan="2">
						<input type="button"  class="large clButton green" id="addImageBttn" title="Add" value="Add"/>
						<input type="button"  class="large clButton yellow" id="cancelImageBttn" title="Cancel"  value="Cancel"/>
						
					</td>
					</tr>
			</table>
			<!-- <div id="sectionBttns">
				<input type="button" class="backBttn" title="Back"
					onClick="history.back();return false;" /> <input name="Add Gallery"
					type="button" class="saveBttn" title="Save" value="" /> <input
					type="reset" value="" class="resetBttnBlack" title="Reset" />
			</div> -->
			
			</div>
	

</form:form>	
</div>

		
		<div class="forImages">
		<div class="galleryImages">

			<c:if test='${null!=galleryImageList}'>
				<c:forEach var="galleryImage" items="${galleryImageList}" varStatus="imageStatus">
				<div class="galleryImage">
					<a   id="evntImg_${galleryImage.id}" title="${galleryImage.description}"
						href="${pageContext.request.contextPath}/galleryImage/${galleryImage.id}_${galleryImage.imageName}"
						rel="galleryImage_group">
							<input type="image" src="/theschool/galleryImage/${galleryImage.id}_${galleryImage.imageName}"
								alt="${galleryImage.imageName}"  />
					</a>
					<span class="forImage">
					<form:checkbox  id="${galleryImage.id}" value="${galleryImage.id}" 
					checked="false" path="galleryImages[${imageStatus.index}].id"  cssClass=""/>
					</span>
				</div>
				</c:forEach>
			<!-- 	<spring:message code="application.name"/>/theschool/admin/manageGalleries/viewGalleryImages.htm -->
			</c:if>
		</div>
		</div>
		<div style="clear: both;"></div>





