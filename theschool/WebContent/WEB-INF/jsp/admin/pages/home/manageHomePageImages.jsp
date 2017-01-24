<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%-- <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="ts" uri="/WEB-INF/ts-tags.tld" %>
<%@ page import="com.vydya.theschool.common.constants.TSConstants"%>
<%@ page import="com.vydya.theschool.web.constants.WebConstants"%>
<script src="<spring:message code="static.application.name"/>/new/js/homePage_V.js"></script>
<style>


</style>
	<script type="text/javascript">  
	jQuery(document).ready(function($){
	
$("a[rel=homeImage_group]").fancybox({
			
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
		
	});
	</script>

  <div ng-controller="homectrl" data-ng-init="init()">

<div class="card">

	<div class="lv-header-alt clearfix">
		<h2 class="lvh-label hidden-xs">Home Page Images</h2>
		<ul class="lv-actions actions">
			<li><a href=""> <i class="zmdi zmdi-info"></i>
			</a></li>
			<li class="dropdown"><a href="" data-toggle="dropdown"
				aria-expanded="true"> <i class="zmdi zmdi-more-vert"></i>
			</a>

				<ul class="dropdown-menu dropdown-menu-right">
					<li><a href="">Refresh</a></li>
					<li><a href="">Listview Settings</a></li>
				</ul></li>
		</ul>
	</div>
	

 <div ng-if="!hi.length" class="table-responsive ng-cloak" style="overflow: hidden; outline: none;">
 	<h5 class="p-15"> No Home Page Image found.! </h5>
 </div>
 
 
		<div class="table-responsive ng-cloak" tabindex="3"  ng-if="hi.length"
			style="overflow: hidden; outline: none;">
			<table class="table table-hover">
				<thead>
					<tr>
						<th>Image</th>
						<th>Title</th>
						<th>Description</th>
						<th>Title Pos</th>
						<th>Inserted</th>
						<th>Inserted by</th>
						<th>Updated</th>
						<th>Updated by</th>
						<th>Action</th>
					</tr>
				</thead>
				<tbody>
								<tr ng-repeat="i in hi track by $index">
									<td><a  title="{{i.description}}"
						href="${pageContext.request.contextPath}/static/simg-org/{{i.imageName}}"
						rel="homeImage_group">
							<img class="std-thumb" src="${pageContext.request.contextPath}/static/simg-fit/107x72/{{i.imageName}}" />
					</a></td>
						<td>{{i.title}}</td>
						<td>{{i.caption}}</td>
						<td>{{i.titlePosition}}</td>
						<td>{{i.inserted}}</td>
						<td>{{i.insertedby}}</td>
						<td>{{i.lastmodified}}</td>
						<td>{{i.lastmodifiedby}}</td>
						<td><ul class="actions">
                                  <li class="dropdown">
                                      <a href="" data-toggle="dropdown">
                                          <i class="zmdi zmdi-more-vert"></i>
                                      </a>
                                      
                                      <ul class="dropdown-menu dropdown-menu-right">
                                          <li>
                                             <!--  <a href="" ng-click="edit(i)">Edit</a> -->
                                              <a href="" modal-trigger  header="'Update Home Page'"
					   data="i" action="'edit'" template="'templates/home.html'" c="'modalCtrl'"
												class="waves-effect">Edit</a>
                                          </li>
                                          <li>
                                              <a href="" ng-click="delete(i)">Delete</a>
                                          </li>
                                          
                                      </ul>
                                  </li>
                              </ul></td>
								</tr>
				</tbody>
			</table>
			</div>
			
			
			
			<div class="lv-header-alt clearfix">
                                <div class="upload fs-upload-element fs-upload">
								<div class="fs-upload-target"><button modal-trigger  header="'Add Home Page'"
					   data="vm" action="'add'" template="'templates/home.html'" c="'modalCtrl'"
												class="btn btn-primary btn-sm waves-effect bgm-lightblue"><i class="zmdi zmdi-collection-image">
														   Add Home Page
														  </i></button></div>
							</div>
							
							
			<%-- <div id="sectionBttns">
				<ts:button validateAction="true" action="<%=WebConstants.DELETE_HOMEPAGE_IMAGES%>" type="button" cssClass="cms-btn gx-btn" title="Delete" value="Delete" name="Delete" id="deleteBttn" />
				<ts:button validateAction="true" action="<%=WebConstants.EDIT_HOMEPAGE_IMAGES%>" type="button" cssClass="cms-btn gx-btn" title="Edit" name="Edit" id="editBttn" value="Edit" />
		</div> --%>
		
		
			</div>
			
			
		
<script type="text/ng-template" id="templates/home.html">
	<form name="hiForm" novalidate>
		<div class="modal-content">
			
						<div class="pmb-block ng-scope">
							<div class="pmbb-header">
								<h2>
									<i class="zmdi zmdi-person m-r-5"></i>{{header}}
								</h2>
							</div>
							<div class="pmbb-body p-l-30">
								<dl class="dl-horizontal" ng-class="{ 'has-error' : hiForm.title.$invalid &&( hiForm.title.$dirty|| !submitted) }">
									<dt class="p-t-10">Title :</dt>
									<dd>
										<div class="fg-line">
											<input data-ng-model="ng.title" name="title" type="text"
												class="form-control
												value="" placeholder="Title" style="" required gname>
										</div>
									</dd>
									<dt></dt>
									<dd><div ng-messages="hiForm.title.$error" ng-show="hiForm.title.$dirty || !submitted" >
										<p class="help-block" ng-message="required">Title Required</p>
              							<p class="help-block" ng-message="invalidEntry">Invalid Characters are not allowed</p>
						            </div></dd>
								</dl>

								<dl class="dl-horizontal" ng-class="{ 'has-error' : hiForm.caption.$invalid &&( hiForm.caption.$dirty|| !submitted) }">
									<dt class="p-t-10">Caption :</dt>
									<dd>
										<div class="fg-line">
											<input data-ng-model="ng.caption" name="caption" type="text"
												class="form-control
												value="" placeholder="Caption" style="" required gname>
										</div>
									</dd>
									<dt></dt>
									<dd><div ng-messages="hiForm.caption.$error" ng-show="hiForm.caption.$dirty || !submitted" >
										<p class="help-block" ng-message="required">Caption Required</p>
              							<p class="help-block" ng-message="invalidEntry">Invalid Characters are not allowed</p>
						            </div></dd>
								</dl> 
								<dl class="dl-horizontal"
									ng-class="{ 'has-error' : uForm.position.$invalid &&( uForm.position.$dirty|| !submitted) }">
										<dt class="p-t-10">Title Position:</dt>
									<dd>
										<div class="fg-line select">
										<select ng-model="ng.titlePosition" required
										ng-options="s.val as s.text for s in hidden.tp"
										class="form-control" name="position">
											
										</select>
									</div>
									</dd>
										<dt></dt>
									<dd>
										<div ng-messages="uForm.position.$error"
											ng-show="uForm.position.$dirty || !submitted">
											<p class="help-block" ng-message="required">Set Title Position</p>

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
												crop="754/300" width="640" height="320"
												method="getCroppedCanvas"> <img alt="Picture" image-preview
												id="croped-image">
										</div>
									</dd>
									<dt></dt>
									<dd><div ng-messages="hiForm.image.$error" ng-show="hiForm.image.$dirty || !submitted" >
						             <p class="help-block" ng-message="invalidImage">This is not valid Image format</p> 
									<p class="help-block" ng-message="required">Image is required</p>   
						            </div>
									</dd>
								</dl>
							</div>
								<div class="m-t-30">
									<!-- <button class="btn btn-primary btn-sm waves-effect" ng-disabled="!hiForm.$valid" type="submit">Save</button>
		                <button class="btn btn-link btn-sm waves-effect" data-ng-click="close()">Cancel</button> -->

									<input type="button"  ng-click="submitForm(hiForm.$valid)"
										class="btn btn-primary btn-sm waves-effect bgm-lightblue" value="Save" /> 
										<input 	type="button" ng-click="close()"
										class="btn btn-link btn-sm waves-effect" value="Cancel" />


								</div>

				 
</div>
		</form>
</script>


		
</div>