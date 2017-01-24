<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%-- <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.vydya.theschool.common.constants.TSConstants"%>
<%@ page import="com.vydya.theschool.web.constants.WebConstants"%>
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery.finescroll.min.js"></script>
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/common.js"></script>
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery-finetabs.js"></script>
<script src="<spring:message code="static.application.name"/>/new/js/gallery_V.js"></script>
 <script src="<spring:message code="static.application.name"/>/new/js/lightGallery.min.js"></script>
 
 
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


			var smartPhone = /ipad|iphone|ipod|android|bada|iemobile|mobile.+firefox|windows phone/i.test(navigator.userAgent.toLowerCase());
			if (smartPhone)
			{
				$("#mobilegallery").show();
				 //$import('${pageContext.servletContext.contextPath}/javascript/gallery/jquery-touch-gallery.js');
				$.extend(blueimp.Gallery.prototype.options, {
	            	container:"#blueimp-galleryx",
	                useBootstrapModal: false,
	                hidePageScrollbars: false
	                
	            });
				$("#browsergallery").hide();
				
			}
			else{
				$("#mobilegallery").hide();
				$("a[rel=galleryImage_group]").fancybox({
					
					prevEffect : 'fade',
					nextEffect : 'fade',
					openEffect:'elastic',
					closeEffect:'elastic',
					helpers : {
						/* thumbs : {
							width  : 50,
							height : 50
						}, */
						overlay : {
							closeClick : false
						}
					}
				});
			}
			
			
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


<div class="card">
   <div ng-controller="gImagesCtrl" ng-init="loadImages(${galleryForm.id})">
                         <div class="lv-header-alt clearfix">
                            <h2 class="lvh-label hidden-xs">${galleryForm.title} </h2>
                            
                            
                            <ul class="lv-actions actions">
                                <li class="dropdown">
                                    <a href="" data-toggle="dropdown" aria-expanded="true">
                                        <i class="zmdi zmdi-sort"></i>
                                    </a>
                        
                                    <ul class="dropdown-menu dropdown-menu-right">
                                        <li>
                                            <a href="">Last Modified</a>
                                        </li>
                                        <li>
                                            <a href="">Last Edited</a>
                                        </li>
                                        <li>
                                            <a href="">Name</a>
                                        </li>
                                        <li>
                                            <a href="">Date</a>
                                        </li>
                                    </ul>
                                </li>
                                <li>
                                    <a href="">
                                        <i class="zmdi zmdi-info"></i>
                                    </a>
                                </li>
                                <li class="dropdown">
                                    <a href="" data-toggle="dropdown" aria-expanded="false">
                                        <i class="zmdi zmdi-more-vert"></i>
                                    </a>
                        
                                    <ul class="dropdown-menu dropdown-menu-right">
                                        <li>
                                            <a href="">Refresh</a>
                                        </li>
                                        <li>
                                            <a href="">Listview Settings</a>
                                        </li>
                                    </ul>
                                </li>
                            </ul>
                        </div>
                 
                 <div class="card-body">   
                 
                 <div class="img-parent">
				<img src="${pageContext.request.contextPath}/static/simg-org/${galleryForm.imageName}" width="100%"/>
			</div>
			<div class="popover-content">
                        <p>${galleryForm.eventDesc}</p>
                    </div>
                    
                    
                 </div>
                         <div class="card-body card-padding">                     
                             <div class="lightbox photos">
                 <div ng-repeat='m in images' class="card-heade ch-alt i-over">
                 
<!--                  <div data-src='{{m.imageName|gEmbFUrl}}' class='col-md-2 col-sm-4 col-xs-6'>
	    			<div class=''><img src='{{m.imageName|gEmbUrl}}' alt='{{m.imageName}}'></div>
	    			</div> -->
	    			
	    			<a id="evntImg_{{m.id}}"  class='' 
								title="{{m.description}}"
								href="{{m.imageName|gEmbFUrl}}"
								rel="galleryImage_group"> 
							<img src="{{m.imageName|gEmbUrl}}" class=""
								alt="{{m.imageName}}" /> </a>
	    			 <ul class="actions">
                                  <li class="dropdown">
                                      <a href="" data-toggle="dropdown" class='i'>
                                          <i class="zmdi zmdi-more-vert"></i>
                                      </a>
                                      
                                      <ul class="dropdown-menu dropdown-menu-left">
                                          <li>
                                              <a href="#" modal-trigger  header="'Add Image'"
					   data="m" action="'edit'" template="'template/galleryImage.html'" c="'modalCtrl'">Edit</a>
                                              <a href="#" ng-click="delete(m)">Delete</a>
                                          </li>
                                          
                                      </ul>
                                  </li>
                              </ul> 
                              
                              <!-- col-md-2 col-sm-4 col-xs-6 -->
	    		</div>
                             </div>
                 
                             <div class="clearfix"></div>
                 
                             <div class="m-t-30">
                             <button modal-trigger  header="'Add Image'"
					   data="m" action="'add'" template="'template/galleryImage.html'" c="'modalCtrl'"
												class="btn btn-primary btn-sm waves-effect bgm-lightblue"><i class="zmdi zmdi-collection-image"></i> Add Image</button>
                                <!--  <input type="button" class="bgm-blue waves-effect" ng-click="openI()" value="Add Image"/> -->
    
                             </div>
                         </div>
                         
                         
								
								
								
								
                          <script type="text/ng-template" id="template/galleryImage.html">
<form name="giForm" enctype="multipart/form-data">
        <div class="modal-body">
				<div class="pmb-block ng-scope">
							<div class="pmbb-header">
								<h2>
									<i class="zmdi zmdi-person m-r-5"></i>Add Image
								</h2>
							</div>
							<div class="pmbb-body p-l-30">
								<dl class="dl-horizontal">
									<dt class="p-t-10">Image Description</dt>
									<dd>
										<div class="fg-line">
											<input data-ng-model="ng.description" name="description" type="text"
												class="form-control ng-pristine ng-valid ng-touched"
												value="" placeholder="Image Description" style="" gname>
										</div>
									</dd>
									<dt></dt>
									<dd><div ng-messages="giForm.description.$error" ng-show="giForm.name.$dirty || !submitted" >
						            </div>
									</dd>
								</dl>
								
								<dl class="dl-horizontal">
									<dt class="p-t-10">Image :</dt>
									<dd>
										<div class="">
											<label class="btn" for="inputImage" title="Upload image file">
												<input type="file" ng-model="ng.fileToUpload" file-model="ng.fileToUpload"
												id="inputImage"
												class="form-control ng-pristine ng-valid ng-touched"
												accept="image/*" placeholder="Image" name="image" image-file 
												crop="" width="640" height="320"
												method="getCroppedCanvas"> <img alt="Picture" image-preview
												id="croped-image">
										</div>
									</dd>
									<dt></dt>
									<dd><div ng-messages="giForm.image.$error" ng-show="giForm.image.$dirty || !submitted" >
						             <p class="help-block" ng-message="invalidImage">This is not valid Image format</p> 
									<p class="help-block" ng-message="required">Image is required</p>   
						            </div>
									</dd>
								</dl>
        </div>
</div>
        <div class="modal-footer">
			<input type="submit" class="btn btn-primary"  value="Add" ng-click="submitForm(giForm.$valid)">
           <input 	type="button" ng-click="close()"
										class="btn btn-link btn-sm waves-effect" value="Cancel" />
        </div>
    </script>          
            
          <!--   <div z-index=100 ng-show="hasPendingRequests()">
									<img src="../../stvydya/new/img/icons/spnif1.gif" />
									<p
										ng-show="giForm.filePath.$error.required && (giForm.gImage.$dirty || !submitted)"
										class="help-block">Gallery Image is required.</p>
								</div>
				</div>
			 <ul>
                <li ng-repeat="item in items">
                    <a href="#" ng-click="$event.preventDefault(); selected.item = item">{{ item }}</a>
                </li>
            </ul>
            Selected: <b>{{ selected.item }}</b> -->      
                  
                  
                  
              <div class="modal fade" id="galleryImageForm" data-backdrop="static"
			data-keyboard="false" tabindex="-1" role="dialog" aria-hidden="true"
			style="display: none;">
			<div class="modal-dialog">
				<form name="giForm"  novalidate>

					<div class="modal-content">

						<div class="pmb-block ng-scope">
							<div class="pmbb-header">
								<h2>
									<i class="zmdi zmdi-person m-r-5"></i>Add Image
								</h2>
							</div>
							<div class="pmbb-body p-l-30">
								<dl class="dl-horizontal" ng-class="{ 'has-error' : giForm.description.$invalid &&( giForm.description.$dirty|| !submitted) }">
									<dt class="p-t-10">Description:</dt>
									<dd>
										<div class="fg-line">
											<input data-ng-model="ngi.description" name="description" type="text"
												class="form-control ng-pristine ng-valid ng-touched" 
												value="" placeholder="Image Description" style="" gname>
										</div>
									</dd>
									<dt></dt>
									<dd><div ng-messages="giForm.description.$error" ng-show="giForm.description.$dirty || !submitted" >
              							 <p class="help-block" ng-message="invalidEntry">Invalid Characters are not allowed</p>
						            </div></dd>
								</dl>

								<dl class="dl-horizontal">
									<dt class="p-t-10">Gallery Image :</dt>
									<dd>
										<div class="">
											<label class="btn" for="inputImage" title="Upload image file">
												<input type="file" ng-model="ngi.fileToUpload" file-model="ngi.fileToUpload"
												id="inputImage"
												class="form-control ng-pristine ng-valid ng-touched"
												accept="image/*" placeholder="Image" name="image" image-file image-required
												crop="754/300" width="640" height="320"
												method="getCroppedCanvas"> <img alt="Picture" galleryImage
												id="croped-image" ng-src="{{ngi.filePath}}" >
										</div>
									</dd>
									<dt></dt>
									<dd><div ng-messages="giForm.image.$error" ng-show="giForm.image.$dirty || !submitted" >
						             <p class="help-block" ng-message="invalidImage">This is not valid Image format</p> 
									<p class="help-block" ng-message="imageRequired">Image is required</p>   
						            </div>
									</dd>
								</dl>


								<div class="m-t-30">
									<!-- <button class="btn btn-primary btn-sm waves-effect" ng-disabled="!giForm.$valid" type="submit">Save</button>
		                <button class="btn btn-link btn-sm waves-effect" data-ng-click="close()">Cancel</button> -->

									<input type="button"  ng-click="submitGiForm(giForm.$valid)"
										class="btn-primary btn-sm waves-effect bgm-lightblue" value="Save" /> 
										<input 	type="button" ng-click="close()"
										class="btn btn-link btn-sm waves-effect" value="Cancel" />


								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>  
                </div>
           </div>          
                     
             
                     
                     
                     
                  <!--    <-------------------------------------------------------------------------------------  > -->
                     
                     
                     
                     
                     
<%-- <div class="adminLRlayout">

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


		<c:choose>
			<c:when test="${empty galleryImageList}">
				<div class="alertMsg">No Images/ Add Images</div>
			</c:when>
			<c:otherwise>
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
											title="Cancel" value="C" /> <input type="button"  class="large clButton yellow im_delete" id="imd_${image.id}" title="Delete"  value="D"/>
											<div id="imd_${image.id}" title="Delete" style=""
												class="deleteicon im_delete"></div>
										</td>
									</tr>

								</c:forEach>
							</c:if>
						</tbody>
					</form:form>
				</table>

			</c:otherwise>
		</c:choose>


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
	</div> --%>





