<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%-- <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="ts" uri="/WEB-INF/ts-tags.tld" %>
<%@ page import="com.vydya.theschool.common.constants.TSConstants"%>
<%@ page import="com.vydya.theschool.web.constants.WebConstants"%>
<script src="<spring:message code="static.application.name"/>/new/js/jquery-ui-timepicker.js"></script>
<script src="<spring:message code="static.application.name"/>/new/js/events_V.js"></script>
<script defer="defer">
	
</script>
<script type="text/javascript">
            $(document).ready(function(){
				$("a[rel=newe_group]").fancybox({
					
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
			$("a[rel=preve_group]").fancybox({
					
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
            	/*  $('.datepick').datetimepicker({
        			 minDate:0,
        			 ampm: true,
        			 dateFormat: 'dd M yy'
        		 }); */
            	 
               /*  //Basic Example
                 $("#data-table-basic-n").bootgrid({
                    css: {
                        icon: 'zmdi icon',
                        iconColumns: 'zmdi-view-module',
                        iconDown: 'zmdi-expand-more',
                        iconRefresh: 'zmdi-refresh',
                        iconUp: 'zmdi-expand-less'
                    },
                });
                $("#data-table-basic-p").bootgrid({
                    css: {
                        icon: 'zmdi icon',
                        iconColumns: 'zmdi-view-module',
                        iconDown: 'zmdi-expand-more',
                        iconRefresh: 'zmdi-refresh',
                        iconUp: 'zmdi-expand-less'
                    },
                });  */
                
             
            });
        </script>


<div ng-controller="eventsCtrl" ng-cloak>


	<div class="card">
		<div class="card-header">
			<h2>
				Upcomming Events <small>It's just that simple. Turn your simple
					table into a sophisticated data table and offer your users a nice
					experience and great features without any effort.</small>
			</h2>
		</div>

		<div class="table-responsive" tabindex="0"
						style="overflow: hidden; outline: none;">
						<table id="data-table-basic-n"
							class="table table-striped bootgrid-table" aria-busy="false">
							<thead>
								<tr>
									<th data-column-id="id" class="text-left"><a
										href="javascript:void(0);"
										class=""><span class="text"></span><span
											class="zmdi icon "></span></a></th>
									<th data-column-id="id" class="text-left"><a
										href="javascript:void(0);"
										class="column-header-anchor sortable"><span class="text">Name</span><span
											class="zmdi icon "></span></a></th>
									<th data-column-id="title" class="text-left"><a
										href="javascript:void(0);"
										class="column-header-anchor sortable"><span class="text">title</span><span
											class="zmdi icon "></span></a></th>
									<th data-column-id="date" class="text-left"><a
										href="javascript:void(0);"
										class="column-header-anchor sortable"><span class="text">Date</span><span
											class="zmdi icon zmdi-expand-more"></span></a></th>
									<th data-column-id="inserted" class="text-left"><a
										href="javascript:void(0);"
										class="column-header-anchor sortable"><span class="text">Inserted</span><span
											class="zmdi icon zmdi-expand-more"></span></a></th>
									<th data-column-id="insertedby" class="text-left"><a
										href="javascript:void(0);"
										class="column-header-anchor sortable"><span class="text">Inserted By</span><span
											class="zmdi icon zmdi-expand-more"></span></a></th>
									<th data-column-id="updated" class="text-left"><a
										href="javascript:void(0);"
										class="column-header-anchor sortable"><span class="text">Updated</span><span
											class="zmdi icon zmdi-expand-more"></span></a></th>
									<th data-column-id="updatedby" class="text-left"><a
										href="javascript:void(0);"
										class="column-header-anchor sortable"><span class="text">Updated By</span><span
											class="zmdi icon zmdi-expand-more"></span></a></th>
									<th data-column-id="actions" class="text-left"><a
										href="javascript:void(0);"
										class="column-header-anchor"><span class="text">Actions</span><span
											class="zmdi icon zmdi-expand-more"></span></a></th>
								</tr>
							</thead>
							<tbody>
								<tr ng-repeat="e in upevents">
								
									<td class="text-left"><a  title="{{i.description}}"
											href="${pageContext.request.contextPath}/static/simg-org/{{e.imageName}}"
											rel="newe_group">
												<img class="std-thumb" src="${pageContext.request.contextPath}/static/simg-fit/107x72/{{e.imageName}}" />
										</a></td>
									<td class="text-left">{{e.name}}</td>
									<td class="text-left">{{e.title}}</td>
									<td class="text-left">{{e.eventDateDis}}</td>
									<td class="text-left">{{e.inserted}}</td>
									<td class="text-left">{{e.insertedby}}</td>
									<td class="text-left">{{e.lastmodified}}</td>
									<td class="text-left">{{e.lastmodifiedby}}</td>
									<td class="text-left"><ul class="actions"">
		                                  <li class="dropdown">
		                                      <a href="" data-toggle="dropdown">
		                                          <i class="zmdi zmdi-more-vert"></i>
		                                      </a>
		                                      
		                                      <ul class="dropdown-menu dropdown-menu-right">
		                                          <li>
		                                              <a href="#" modal-trigger  header="'Edit Event'"
					   data="e" action="'edit'" template="'template/events.html'" c="'modalCtrl'">Edit</a>
		                                          </li>
		                                          <li>
		                                              <a href="" ng-click="delete($index)">Delete</a>
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
								<div class="fs-upload-target"><button modal-trigger  header="'Add Event'"
					   data="vm" action="'add'" template="'template/events.html'" c="'modalCtrl'"
												class="btn btn-primary btn-sm waves-effect bgm-lightblue"><i class="zmdi zmdi-collection-image">
</i>Add Event</button></div>
							</div>
				</div>

<div class="card">
		<div class="card-header">
			<h2>
				Previous Events <small>It's just that simple. Turn your simple
					table into a sophisticated data table and offer your users a nice
					experience and great features without any effort.</small>
			</h2>
		</div>

		<div class="table-responsive" tabindex="0"
						style="overflow: hidden; outline: none;">
						<table id="data-table-basic-p"
							class="table table-striped bootgrid-table" aria-busy="false">
							<thead>
								<tr>
									<th data-column-id="id" class="text-left">
									</th>
									<th data-column-id="id" class="text-left"><a
										href="javascript:void(0);"
										class="column-header-anchor sortable"><span class="text">Name</span><span
											class="zmdi icon "></span></a></th>
									<th data-column-id="title" class="text-left"><a
										href="javascript:void(0);"
										class="column-header-anchor sortable"><span class="text">title</span><span
											class="zmdi icon "></span></a></th>
									<th data-column-id="date" class="text-left"><a
										href="javascript:void(0);"
										class="column-header-anchor sortable"><span class="text">Event Date</span><span
											class="zmdi icon zmdi-expand-more"></span></a></th>
									<th data-column-id="inserted" class="text-left"><a
										href="javascript:void(0);"
										class="column-header-anchor sortable"><span class="text">Inserted</span><span
											class="zmdi icon zmdi-expand-more"></span></a></th>
									<th data-column-id="insertedby" class="text-left"><a
										href="javascript:void(0);"
										class="column-header-anchor sortable"><span class="text">Inserted By</span><span
											class="zmdi icon zmdi-expand-more"></span></a></th>
									<th data-column-id="updated" class="text-left"><a
										href="javascript:void(0);"
										class="column-header-anchor sortable"><span class="text">Updated</span><span
											class="zmdi icon zmdi-expand-more"></span></a></th>
									<th data-column-id="updatedby" class="text-left"><a
										href="javascript:void(0);"
										class="column-header-anchor sortable"><span class="text">Updated By</span><span
											class="zmdi icon zmdi-expand-more"></span></a></th>
									
								</tr>
							</thead>
							<tbody>
								<tr ng-repeat="e in prvevents">
								<td class="text-left"><a  title="{{e.description}}"
											href="${pageContext.request.contextPath}/static/simg-org/{{e.imageName}}"
											rel="preve_group">
												<img class="std-thumb" src="${pageContext.request.contextPath}/static/simg-fit/107x72/{{e.imageName}}" />
										</a></td>
									<td class="text-left">{{e.name}}</td>
									<td class="text-left">{{e.title}}</td>
									<td class="text-left">{{e.eventDateDis}}</td>
									<td class="text-left">{{e.inserted}}</td>
									<td class="text-left">{{e.insertedby}}</td>
									<td class="text-left">{{e.lastmodified}}</td>
									<td class="text-left">{{e.lastmodifiedby}}</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>

<!-- self.upevents = new NgTableParams({}, { dataset: $scope.upevents});
		 self.prvevents = new NgTableParams({}, { dataset: $scope.prvevents});
	 -->	 
</div>

<script type="text/ng-template" id="template/events.html">
<form name="eForm" novalidate>
<div class="modal-content">
				<div class="pmb-block ng-scope">
							<div class="pmbb-header">
								<h2>
									<i class="zmdi zmdi-person m-r-5"></i>{{header}}
								</h2>
							</div>
							<div class="pmbb-body p-l-30">
								<dl class="dl-horizontal" ng-class="{ 'has-error' : eForm.name.$invalid &&( eForm.name.$dirty|| !submitted) }">
									<dt class="p-t-10">Event Name :</dt>
									<dd>
										<div class="fg-line">
											<input data-ng-model="ng.name" name="name" type="text"
												class="form-control
												value="" placeholder="Event Name" style="" required gname>
										</div>
									</dd>
									<dt></dt>
									<dd><div ng-messages="eForm.name.$error" ng-show="eForm.name.$dirty || !submitted" >
										<p class="help-block" ng-message="required">Event Name Required</p>
              							<p class="help-block" ng-message="invalidEntry">Invalid Characters are not allowed</p>
						            </div></dd>
								</dl>
								<dl class="dl-horizontal" ng-class="{ 'has-error' : eForm.title.$invalid &&( eForm.title.$dirty|| !submitted) }">
									<dt class="p-t-10">Title :</dt>
									<dd>
										<div class="fg-line">
											<input data-ng-model="ng.title" name="title" type="text"
												class="form-control
												value="" placeholder="Title" style="" required gname>
										</div>
									</dd>
									<dt></dt>
									<dd><div ng-messages="eForm.title.$error" ng-show="eForm.title.$dirty || !submitted" >
										<p class="help-block" ng-message="required">Title Required</p>
              							<p class="help-block" ng-message="invalidEntry">Invalid Characters are not allowed</p>
						            </div></dd>
								</dl>
								<dl class="dl-horizontal" ng-class="{ 'has-error' : eForm.eventDate.$invalid &&( eForm.eventDate.$dirty|| !submitted) }">
									<dt class="p-t-10">Event Date :</dt>
									<dd>
										<div class="fg-line">
											<input data-ng-model="ng.eventDateS" name="eventDate" type="text"  ui-date-picker ng-readonly="true" df="dd/mm/yy"
												class="form-control"
												value="" placeholder="Event Date" style="" required>
										</div>
									</dd>
									<dt></dt>
									<dd><div ng-messages="eForm.eventDate.$error" ng-show="eForm.eventDate.$dirty || !submitted" >
										<p class="help-block" ng-message="required">Event Date Required</p>
						            </div></dd>
								</dl>
								<dl class="dl-horizontal" ng-class="{ 'has-error' : eForm.description.$invalid &&( eForm.description.$dirty|| !submitted) }">
									<dt class="p-t-10">Description :</dt>
									<dd>
										<div class="fg-line">
											<input data-ng-model="ng.eventDesc" name="description" type="text"
												class="form-control
												value="" placeholder="Description" style="" required>
										</div>
									</dd>
									<dt></dt>
									<dd><div ng-messages="eForm.description.$error" ng-show="eForm.description.$dirty || !submitted" >
										<p class="help-block" ng-message="required">Description Required</p>
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
									<dd><div ng-messages="hiForm.image.$error" ng-show="hiForm.image.$dirty || !submitted" >
						             <p class="help-block" ng-message="invalidImage">This is not valid Image format</p> 
									<p class="help-block" ng-message="required">Image is required</p>   
						            </div>
									</dd>
								</dl>
						</div>
								<div class="m-t-30">
									<input type="button"  ng-click="submitForm(eForm.$valid)"
										class="btn btn-primary btn-sm waves-effect bgm-lightblue" value="Save" /> 
										<input 	type="button" ng-click="close()"
										class="btn btn-link btn-sm waves-effect" value="Cancel" />
								</div>
					</div>
		</form>
    </script>
    


