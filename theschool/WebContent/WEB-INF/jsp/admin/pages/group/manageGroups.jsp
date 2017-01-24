<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%-- <%@ taglib prefix="ts" uri="http://www.ts.com/tags"%> --%>
<%@ taglib prefix="ts" uri="/WEB-INF/ts-tags.tld" %>
<%@ page import="com.vydya.theschool.web.constants.WebConstants" %> 
<%@ page import="com.vydya.theschool.common.constants.TSConstants" %>
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery.tablesorter.js"></script>
<script src="<spring:message code="static.application.name"/>/new/js/groups_V.js"></script>
<script defer="defer">

$(document).ready(function() 
	    { 
		   
	        	$("#sectionsTable").tablesorter({widthFixed: true, widgets: ['applyStyles']});
	    	
	    } 
		);


</script>

  <div ng-controller="groupsctrl">

<div class="card">

	<div class="lv-header-alt clearfix">
		<h2 class="lvh-label hidden-xs">Admin Groups</h2>
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


<div class="table-responsive" tabindex="3"
			style="overflow: hidden; outline: none;">
			<table class="table table-hover" id="sectionsTable">
				<thead>
					<tr>
						<th>Name</th>
						<th>Description</th>
						<th>Status</th>
						<th>Actions</th>
					</tr>
				</thead>
				<tbody>
<tr ng-repeat="g in groups track by $index">
									
						<td>{{g.groupName}}</td>
						<td>{{g.groupDesc}}</td>
						
						<td>{{g.groupStatus}}</td>
						<td><ul class="actions">
                                  <li class="dropdown">
                                      <a href="" data-toggle="dropdown">
                                          <i class="zmdi zmdi-more-vert"></i>
                                      </a>
                                      
                                      <ul class="dropdown-menu dropdown-menu-right">
                                          <li>
                                              <a href="" ng-click="edit($index,g)">Edit</a>
                                          </li>
                                          <li>
                                              <a href="" ng-click="delete($index)">Delete</a>
                                          </li>
                                          
                                      </ul>
                                  </li>
                              </ul>
                        </td>
						</tr>
				</tbody>
			</table>
			</div>
		
		<%-- <div id="sectionBttns">
					<ts:button validateAction="true" action="<%=WebConstants.EDIT_GROUP_ACTION%>"  type="submit" cssClass="large clButton green"    name="Edit"   title="Edit"  value="Edit"   onClick="document.pressed=this.name"/>
					<ts:button validateAction="true" action="<%=WebConstants.DELETE_GROUP_ACTION%>"  type="submit" cssClass="large clButton green"  name="Delete" title="Delete" value="Delete"  onClick="document.pressed=this.name"/>
					</div>
					 --%>
					<ts:html validateAction="true" action="<%=WebConstants.ADD_GROUP_ACTION%>" >
					<div class="lv-header-alt clearfix">
						<div class="upload fs-upload-element fs-upload">
							<div class="fs-upload-target">
								<a ng-click="add()" class="upload-btn2 waves-effect">Add new
									Group</a>
							</div>
						</div>
					</div>
					
					</ts:html>
					
				</div>



<div class="modal fade" id="groupForm" data-backdrop="static"
			data-keyboard="false" tabindex="-1" role="dialog" aria-hidden="true"
			style="display: none;">
			<div class="modal-dialog">
				<form name="giForm"  novalidate>

					<div class="modal-content">

						<div class="pmb-block ng-scope">
							<div class="pmbb-header">
								<h2>
									<i class="zmdi zmdi-person m-r-5"></i>{{mode}} Group
								</h2>
							</div>
							<div class="pmbb-body p-l-30">
								<dl class="dl-horizontal" ng-class="{ 'has-error' : groupForm.name.$invalid &&( groupForm.name.$dirty|| !submitted) }">
									<dt class="p-t-10">Description:</dt>
									<dd>
										<div class="fg-line">
											<input data-ng-model="ng.name" name="name" type="text"
												class="form-control ng-pristine ng-valid ng-touched" 
												value="" placeholder="Group Name" style="" gname>
										</div>
									</dd>
									<dt></dt>
									<dd><div ng-messages="groupForm.name.$error" ng-show="groupForm.name.$dirty || !submitted" >
										 <p class="help-block" ng-message="required">Group Name required</p>
              							 <p class="help-block" ng-message="invalidEntry">Invalid Characters are not allowed</p>
						            </div></dd>
								</dl>
								
								<dl class="dl-horizontal" ng-class="{ 'has-error' : groupForm.description.$invalid &&( groupForm.description.$dirty|| !submitted) }">
									<dt class="p-t-10">Description:</dt>
									<dd>
										<div class="fg-line">
											<input data-ng-model="ng.description" name="description" type="text"
												class="form-control ng-pristine ng-valid ng-touched" 
												value="" placeholder="Group Description" style="" gname>
										</div>
									</dd>
									<dt></dt>
									<dd><div ng-messages="groupForm.description.$error" ng-show="groupForm.description.$dirty || !submitted" >
										 <p class="help-block" ng-message="required">Group Description required</p>
              							 <p class="help-block" ng-message="invalidEntry">Invalid Characters are not allowed</p>
						            </div></dd>
								</dl>
								
								<dl class="dl-horizontal" ng-class="{ 'has-error' : groupForm.description.$invalid &&( groupForm.description.$dirty|| !submitted) }">
									<dt class="p-t-10">Description:</dt>
									<dd>
										<div class="fg-line">
											<select ng-model="ng.groupStatus"  name="status" ng-options="s.val as s.text for s in json" class="editable-input form-control ng-pristine ng-valid required">
				       							 <option value ="">Select</option>
				      						</select>
										</div>
									</dd>
									<dt></dt>
									<dd><div ng-messages="groupForm.status.$error" ng-show="groupForm.status.$dirty || !submitted" >
										 <p class="help-block" ng-message="required">Select Group Status</p>
						            </div></dd>
								</dl>
								
								
								
      						

								


								<div class="m-t-30">
									<!-- <button class="btn btn-primary btn-sm waves-effect" ng-disabled="!giForm.$valid" type="submit">Save</button>
		                <button class="btn btn-link btn-sm waves-effect" data-ng-click="close()">Cancel</button> -->

									<input type="button"  ng-click="save(groupForm.$valid)"
										class="btn-primary btn-sm waves-effect bgm-lightblue" value="Save" /> 
										<input 	type="button" ng-click="cancel()"
										class="btn btn-link btn-sm waves-effect" value="Cancel" />


								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div> 


		<script type="text/ng-template" id="managegroup.html">
        <div class="modal-header">
            <h3 class="modal-title">{{dto.action}} Group</h3>
        </div>
<form ng-submit="save(dto)">
        <div class="modal-body">
				<div class="col-xs-6">
						<div class="fg-line form-group">
							<input ng-model="dto.groupName" type="text" class="form-control input-sm" required	placeholder="Group Name" name="desc">
						</div>
				</div>
				<div class="col-xs-6">
						<div class="fg-line form-group">
							<input ng-model="dto.groupDesc" type="text" class="form-control input-sm" required	placeholder="Group Description" name="desc">
						</div>
				</div>
				<div class="col-xs-6">
						<div class="fg-line form-group">
						 <div class="select">
<select ng-model="dto.groupStatus" ng-options="s.val as s.text for s in json" class="editable-input form-control ng-pristine ng-valid required">
       							 <option value ="">Select</option>
      						</select>
</div>
						</div>
				</div>
        </div>
        <div class="modal-footer">
			<input type="submit" class="btn btn-primary"  value="Save">
            <button class="btn btn-warning" type="button" ng-click="cancel()">Cancel</button>
        </div>
    </script>


	</div>
			