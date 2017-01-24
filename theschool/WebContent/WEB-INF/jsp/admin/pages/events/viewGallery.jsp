<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%-- <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.vydya.theschool.common.constants.TSConstants"%>
<%@ page import="com.vydya.theschool.web.constants.WebConstants"%>
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/ajc.js">
</script>

<script src="<spring:message code="static.application.name"/>/new/js/gallery_V.js"></script>

<script type="text/javascript">
	
</script>
<script type="">
	$(document).ready(function() {
			loadY('g','<spring:message code="application.name"/>${pageContext.servletContext.contextPath}');
	});
</script>
    
    
<style>
/* .modal .modal-body{
display: flex;
} */
</style>
<div class="card">
  <div ng-controller="galleryCtrl" data-ng-init="init()" ng-cloak>
  <div id="galery-list">
  <div ng-show="gs!=null">
<div class="col-sm-4" ng-repeat="g in gs"> <!-- g in gs track by $index -->

    <div class="card">
     <div class="card-body ">
       <img ng-src="${pageContext.request.contextPath}/static/simg-fit/302x180/{{g.imageName}}" alt="{{g.name}}" />
       <i class="tmn-counts">{{g.gallerysize}}</i>
	</div>
	<div class="card-header ch-alt">
	<a href="viewAllImages.htm?g={{g.id}}" id="galleryName_{{g.id}}_{{g.url}}" class="gthumb">
                              <h2 class="galleryName">{{g.name}}&nbsp;</h2>
				<small>{{g.title}}</small>
				</a>
                              <ul class="actions">
                                  <li class="dropdown">
                                      <a href="" data-toggle="dropdown">
                                          <i class="zmdi zmdi-more-vert"></i>
                                      </a>
                                      
                                      <ul class="dropdown-menu dropdown-menu-right">
                                          <li>
                                             <!--  <a href="" ng-click="edit(g,$index)">Edit</a> -->
                                              <a href="#" modal-trigger  header="'Update Gallery'"
   data="g" action="'edit'" template="'templates/gallery.html'" c="'modalCtrl'">Edit</a>
                                          </li>
                                          <li>
                                              <a href="" ng-click="delete(g,$index)">Delete</a>
                                          </li>
                                          
                                      </ul>
                                  </li>
                              </ul>
                          </div>
                      </div>
                  </div>
</div>
</div>
<!-- <div class="lv-header-alt clearfix">
                 <div class="upload fs-upload-element fs-upload">
					<div class="fs-upload-target waves-effect"> <button modal-trigger
    header="'Add User'"
   data="vm" action="'add'" template="'templates/adminuser.html'" c="'adminUser'"><i class="zmdi zmdi-accounts-add"></i> Add New User</button></div>
				</div>
 </div> -->



		 <div class="col-sm-4">
			<div class="card">
				<div class="upload fs-upload-element fs-upload">
					<div class="fs-upload-target">
						<button modal-trigger  header="'Add Gallery'"
   data="vm" action="'add'" template="'templates/gallery.html'" c="'modalCtrl'"
							class="upload-btn waves-effect"><i class="zmdi zmdi-collection-image"></i>Add Gallery</button>
					</div>

				</div>
			</div>
		</div> 

		<!-- <div class="modal fade" id="galleryForm" data-backdrop="static"
			data-keyboard="false" tabindex="-1" role="dialog" aria-hidden="true"
			style="display: none;"> -->
			
			<script type="text/ng-template" id="templates/gallery.html">
				<form name="gForm"  novalidate>
					<div class="modal-content">
						<div class="pmb-block ng-scope">
							<div class="pmbb-header">
								<h2>
									<i class="zmdi zmdi-person m-r-5"></i>{{header}}
								</h2>
							</div>
							<div class="pmbb-body p-l-30">
								<dl class="dl-horizontal" ng-class="{ 'has-error' : gForm.name.$invalid &&( gForm.name.$dirty|| !submitted) }">
									<dt class="p-t-10">Gallery Name :</dt>
									<dd>
										<div class="fg-line">
											<input data-ng-model="ng.name" name="name" type="text"
												class="form-control ng-pristine ng-valid ng-touched" 
												value="" placeholder="Gallery Name" style="" required gname check-unique="{key:'name'}" fn="hidden.verify"
										ng-model-options="{ updateOn: 'blur' }">
										</div>
									</dd>
									<dt></dt>
									<dd><div ng-messages="gForm.name.$error" ng-show="gForm.name.$dirty || !submitted" >
										<p class="help-block" ng-message="required">Gallery Name Required</p>
              							 <p class="help-block" ng-message="invalidEntry">Invalid Characters are not allowed</p>
						            </div></dd>
								</dl>

								<dl class="dl-horizontal" ng-class="{ 'has-error' : gForm.title.$invalid &&( gForm.title.$dirty||!submitted) }">
									<dt class="p-t-10">Gallery Title :</dt>
									<dd>
										<div class="fg-line">
											<input data-ng-model="ng.title" type="text" name="title"
												class="form-control ng-pristine ng-valid ng-touched"
												value="" placeholder="Gallery Title" style="" required gname>
										</div>
									</dd>
									<dt></dt>
									<dd><div ng-messages="gForm.title.$error" ng-show="gForm.title.$dirty || !submitted" >
						                <p class="help-block" ng-message="required"> This is required field</p>
              							 <p class="help-block" ng-message="invalidEntry">Invalid Characters are not allowed</p>
              							 <p class="help-block" ng-message="invalidStart">Start with Alphabet</p>
  				
						            </div></dd>
								</dl>

								<dl class="dl-horizontal" ng-class="{ 'has-error' : gForm.eventDesc.$invalid &&( gForm.eventDesc.$dirty||!submitted) }">
									<dt class="p-t-10">Gallery Description :</dt>
									<dd>
										<div class="fg-line">
											<input data-ng-model="ng.eventDesc" name="eventDesc"
												type="text"
												class="form-control"
												value="" placeholder="Gallery Description" style="" required gname>
										</div>
									</dd>
									<dt></dt>
									<dd><div ng-messages="gForm.eventDesc.$error" ng-show="gForm.eventDesc.$dirty || !submitted" >
						               <p class="help-block" ng-message="required"> This is required field</p>
              							 <p class="help-block" ng-message="invalidEntry">Invalid Characters are not allowed</p>
              							 <p class="help-block" ng-message="invalidStart">Start with Alphabet</p>
						            </div></dd>
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
												crop="754/300" width="640" height="320"
												method="getCroppedCanvas"> <img alt="Picture" image-preview
												id="croped-image">
										</div>
									</dd>
									<dt></dt>
									<dd><div ng-messages="gForm.image.$error" ng-show="gForm.image.$dirty || !submitted" >
						             <p class="help-block" ng-message="invalidImage">This is not valid Image format</p> 
									<p class="help-block" ng-message="required">Image is required</p>   
						            </div>
									</dd>
								</dl>


								<div class="m-t-30">
									<!-- <button class="btn btn-primary btn-sm waves-effect" ng-disabled="!gForm.$valid" type="submit">Save</button>
		                <button class="btn btn-link btn-sm waves-effect" data-ng-click="close()">Cancel</button> -->

									<input type="button"  ng-click="submitForm(gForm.$valid)"
										class="btn btn-primary btn-sm waves-effect bgm-lightblue" value="Save" /> 
										<input 	type="button" ng-click="close()"
										class="btn btn-link btn-sm waves-effect" value="Cancel" />


								</div>
							</div>
						</div>
					</div>
				</form>
			</script>
		<!-- </div> -->
		
		<!-- <div z-index=100 ng-show="hasPendingRequests()">
									<img src="../../stvydya/new/img/icons/spnif1.gif" />
									<div ng-messages="gForm.image.$error" ng-show="gForm.image.$dirty || !submitted" >
						             <p class="help-block" ng-message="invalidImage">This is not valid Image format</p> 
									<p class="help-block" ng-message="imageRequired">Image is required</p>   
						            </div>
								</div> -->




		<%-- <div class="modal-header">
					<h4 class="modal-title">{{btnText}}</h4>
				</div>
				<div class="modal-body">
					<div class="col-xs-6">
						<div class="fg-line form-group">
							<input ng-model="ng.name" type="text" class="form-control input-sm" required galleryname
								placeholder="Gallery Name" name="name">
						</div>
						<p ng-show="gForm.name.$error.required && (gForm.name.$dirty || submitted)" class="help-block">Gallery Name is required.</p>
						<div class="fg-line form-group">
							<input ng-model="ng.title" type="text" class="form-control input-sm" required
								placeholder="Gallery Title" name="title">
						</div>
						<p ng-show="gForm.title.$error.required && (gForm.title.$dirty || submitted)" class="help-block">Title is required.</p>
						<div class="fg-line form-group">
							<input ng-model="ng.eventDesc" type="text" class="form-control input-sm" required
								placeholder="Gallery Description" name="eventDesc">
						</div>
						<p ng-show="gForm.eventDesc.$error.required && (gForm.eventDesc.$dirty || submitted)" class="help-block">Description is required.</p>	
					</div>
					<div class="col-xs-6">
								<label class="btn btn-primary btn-upload" for="inputImage" title="Upload image file"> 
								<input type="file" 	class="sr-only" id="inputImage" name="gImage" accept="image/*" galleryImage >
								<img alt="Picture" id="croped-image" ng-src="{{ng.filePath}}" required>
								</label>
								
								<input type="button" ng-click="saveImage(ng)"
						class="btn btn-default waves-effect waves-effect" value="SaveImage"/>
						</div>
						
						<div class="fg-line form-group">
								<label class="btn" for="inputImage" title="Upload image file"> 
								<input type="file" class="form-control input-sm sr-only" id="inputImage" accept="image/*" required file-model="ng.fileToUpload"	placeholder="Image" name="image" image-file crop="754/300" width="640" height="320"   method="getCroppedCanvas">
								<img alt="Picture" id="croped-image" ng-src="{{ng.filePath}}" required>
								</label>
						</div>
				</div>		
				
					
								
						<div z-index=100 ng-show="hasPendingRequests()"><img src="stvydya/new/img/icons/spnif1.gif" />
								<p ng-show="gForm.filePath.$error.required && (gForm.gImage.$dirty || submitted)" class="help-block">Gallery Image is required.</p>
							</div>
							
							</div>



				<div class="modal-footer">
					<input  type="submit" ng-disabled="!gForm.$valid"
						class="btn bgm-lightblue waves-effect" value="Save"/>
					<input type="button" ng-click="close()"
						class="btn bgm-gray waves-effect"  
						 value="Cancel"/>
				</div>
</div>
		</form>
	</div>
</div> --%>



<!-- <div class="modal fade" id="cropper-modal">
  <div class="modal-dialog">
    <div class="modal-content">
       <div class="modal-header">
        
        <h4 class="modal-title">Crop Image</h4>
      </div>  
      <div class="modal-body">
	  <div class="img-containerx" id="cropper-image" >
          <img src="../assets/img/picture.jpg" alt="Picture" crossOrigin="anonymous" class="img-responsive cropper-hidden">
        </div>
       
      </div>
	  <div class="modal-footer">
          <button type="button" class="btn btn-primary" data-method="getCroppedCanvas" data-option="{ &quot;width&quot;: 754, &quot;height&quot;: 300 }">OK</button>
	<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
    
      </div>
   </div>
  </div>
</div>
 -->

</div>
</div>
<!-- <div class="out2">
		<h4 class="widget-titlex">
			<span>PREVIOUS GALLERIES</span>
		</h4>
		<div id="previous-years" class="ol"></div>
	</div> -->

<div class="card2 picture-list col-sm-12 ">
             <div class="card-header">
                 <h2>Load Previous Galleries
                 </h2>
								<!-- <div class="fg-line select">
									<select ng-model="selectedYear"
										ng-options="py as py for py in pylist"
										ng-select="loadPYG(selectedYear)"
										class="form-control localytics-chosen">
										<option value="">Select Year</option>
									</select>
								</div> -->
								<div class="dropdown optionload">
                                    <button type="button" class="btn btn-default waves-effect" data-toggle="dropdown" aria-expanded="false">Load
                                    </button>

                                    <ul class="dropdown-menu pull-right">
                                        <li ng-repeat="py in pylist"><a ng-click="loadPYG(py)">{{py}}</a></li>
                                    </ul>
                                </div>								

                              <!--   <div class="btn-group optionload">
                                    <button type="button" class="btn btn-default waves-effect">Load</button>
                                    <button type="button" class="btn btn-default dropdown-toggle waves-effect" data-toggle="dropdown" aria-expanded="false">
                                        <span class="caret"></span>
                                    </button>
                                    <ul class="dropdown-menu">
                                        <li ng-repeat="py in pylist"><a ng-click="loadPYG(py)">{{py}}</a></li>
                                    </ul>
                                </div> -->
             </div>

<li ng-repeat="py in pylist"><a ng-click="loadPYG(py)">{{py}}</a></li>

             <div class="pl-body" ng-repeat="pg in pglist">
                 <div class="card">
     <div class="card-body ">
       <img ng-src="${pageContext.request.contextPath}/static/simg-fit/302x180/{{pg.imageName}}" alt="{{pg.name}}" />
       <i class="tmn-counts">{{pg.gallerysize}}</i>
	</div>
	<div class="card-header ch-alt">
	<a href="viewAllImages.htm?g={{pg.id}}" id="galleryName_{{pg.id}}_{{pg.url}}" class="gthumb">
                              <h2 class="galleryName">{{pg.name}}&nbsp;</h2>
				<small>{{pg.title}}</small>
				</a>
                              <ul class="actions">
                                  <li class="dropdown">
                                      <a href="" data-toggle="dropdown">
                                          <i class="zmdi zmdi-more-vert"></i>
                                      </a>
                                      
                                      <ul class="dropdown-menu dropdown-menu-right">
                                          <li>
                                             <!--  <a href="" ng-click="edit(g,$index)">Edit</a> -->
                                              <a href="#" modal-trigger  header="'Update Gallery'"
   data="pg" action="'edit'" template="'templates/gallery.html'" c="'modalCtrl'">Edit</a>
                                          </li>
                                          <li>
                                              <a href="" ng-click="delete(pg,$index)">Delete</a>
                                          </li>
                                          
                                      </ul>
                                  </li>
                              </ul>
                          </div>
                      </div>
             </div>
         </div>

