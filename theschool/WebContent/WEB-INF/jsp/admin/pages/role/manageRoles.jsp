
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="ts" uri="/WEB-INF/ts-tags.tld" %>
<%@ page import="com.vydya.theschool.web.constants.WebConstants" %> 
<%@ page import="com.vydya.theschool.common.constants.TSConstants" %> 
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery.tablesorter.js"></script>
<script src="<spring:message code="static.application.name"/>/new/js/roles_V.js"></script>
<link href="<spring:message code="static.application.name"/>/css/jquery.checktree.css" rel="stylesheet" type="text/css" charset="utf-8"/>
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery.checktree.js"></script> 
    <script type="text/javascript">
    $(document).ready(function() { 
    var $checktree;
	$(function(){
	    //$checktree = $("ul.tree").checkTree();
	});
	 /*    	function load(id) {
	$.getJSON("data/" + id + ".txt",{},function(json){
		$checktree.clear();
		$.updateWithJSON(json);
		$checktree.update();
	});
} */

	function clearAll(){
		$checktree.clear();
		$checktree.update();
	} 
	
	$("#roleTypeD").change(function(){
			if($(this).val()=='Individual Administrator')
				{
					$("#isUserRole").show();
				}
			else{
					$("#isUserRole").hide();				
					$('input:checkbox[name=userRoleRequired]').attr('checked',false);
					
				}
			
			          });
	
	
    });
</script>  
			
			
	<div ng-controller="rolesctrl" ng-cloak>

<div class="card" ng-hide ="editmode">

	<div class="lv-header-alt clearfix">
		<h2 class="lvh-label hidden-xs">Admin Roles</h2>
		<ul class="lv-actions actions">
			<li><a href=""> <i class="zmdi zmdi-info"></i>
			</a></li>
			<li class="dropdown"><a href="" data-toggle="dropdown"
				aria-expanded="true"> <i class="zmdi zmdi-more-vert"></i>
			</a>

				<ul class="dropdown-menu dropdown-menu-right">
					<li><a ng-click="refresh()">Refresh</a></li>
					<li><a href="">Listview Settings</a></li>
				</ul></li>
		</ul>
	</div>


<div class="table-responsive" tabindex="3" 
			style="overflow: hidden; outline: none;">
			<table class="table table-hover" id="sectionsTable">
				<thead>
					<tr>
						<th>Role Name </th>
						<th>Role Type </th>
						<th>Role Description</th>
						<th>Status</th>
						<th>Actions</th>
					</tr>
				</thead>
				<tbody>
<tr ng-repeat="r in roles track by $index">
						<%-- <td><form:radiobutton  path="userId" id="${userData.userId}" value="${userData.userId}" 
						disabled="${userData.userName==sessionScope.user_name ? true: false}"/></td> 
						ng-disabled="x.status == 'disabled'"--%>
						
						<td>{{r.roleName}}</td>
						<td>{{r.roleType}}</td>
						<td>{{r.roleDescription}}</td>
			    		<td>{{r.status}}</td>
						<td><ul class="actions" ng-hide="hideAction(r)"> <%-- ng-hide="hideAction(${sessionScope.user_name}) --%>
                                  <li class="dropdown">
                                      <a href="" data-toggle="dropdown">
                                          <i class="zmdi zmdi-more-vert"></i>
                                      </a>
                                      
                                      <ul class="dropdown-menu dropdown-menu-right">
                                          <li>
                                              <a href="#" modal-trigger  header="'Edit Role'"
					   data="r" action="'edit'" template="'template/role.html'" c="'roleModalCtrl'">Edit</a>
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
					<div class="lv-header-alt clearfix">
                                <div class="upload fs-upload-element fs-upload">
								<div class="fs-upload-target"><button modal-trigger  header="'Add Role'"
					   data="vm" action="'add'" template="'template/role.html'" c="'roleModalCtrl'"
												class="btn btn-primary btn-sm waves-effect bgm-lightblue"><i class="zmdi zmdi-collection-add"></i>
												Add Role</button></div>
							</div>
				
				</div>	
		
</div>


<!-- <div class="modal fade" id="roleActionForm" data-backdrop="static"
	data-keyboard="false" tabindex="-1" role="dialog" aria-hidden="true"
	style="display: none;"> -->
<script type="text/ng-template" id="template/role.html">

<form name="rForm" novalidate>
		<div class="modal-content">
			
						<div class="pmb-block ng-scope">
							<div class="pmbb-header">
								<h2>
									<i class="zmdi zmdi-person m-r-5"></i>{{header}}
								</h2>
							</div>
							<div class="pmbb-body p-l-30">
								<dl class="dl-horizontal" ng-class="{ 'has-error' : rForm.roleName.$invalid &&( rForm.roleName.$dirty|| !submitted) }">
									<dt class="p-t-10">Title :</dt>
									<dd>
										<div class="fg-line">
											<input data-ng-model="ng.roleName" name="roleName" type="text"
												class="form-control
												value="" placeholder="Role Name" style="" required gname>
										</div>
									</dd>
									<dt></dt>
									<dd><div ng-messages="rForm.roleName.$error" ng-show="rForm.roleName.$dirty || !submitted" >
										<p class="help-block" ng-message="required">Role Name Required</p>
              							<p class="help-block" ng-message="invalidEntry">Invalid Characters are not allowed</p>
						            </div></dd>
								</dl>
								<dl class="dl-horizontal" ng-hide="ng.roleType=='Portal Administrator'"
									ng-class="{ 'has-error' : rForm.roleType.$invalid &&( rForm.roleType.$dirty|| !submitted) }">
									<dt class="p-t-10">Role Type:</dt>
									<dd>
										<div class="fg-line select">
											<select ng-model="ng.roleType"
												ng-disabled="${ (true eq ng.roleAssigned) ? true: false}"
												name="roleType"
												class="editable-input form-control  required w-100 localytics-chosen"
												required>
												<option value=""  label="Select Role Type"/>
												<option value="Individual Administrator" label="Individual Administrator" ng-show="${sessionScope.user_role_type=='PA'} && ng.adminRoleFlag!='adminRoleCreated'"/> 
												<option value="User" label="User" />
											</select>
										</div>
									</dd>
									<dt></dt>
									<dd>
										<div ng-messages="rForm.roleType.$error"
											ng-show="rForm.roleType.$dirty || !submitted">
											<p class="help-block" ng-message="required">Role Type is
												Required</p>
										</div>
									</dd>
								</dl>
								<dl class="dl-horizontal" ng-show="ng.roleType=='Individual Administrator'" id="isUserRole">
									<dt class="p-t-10"></dt>
									<dd>
										<div class="">
						                    <div class="toggle-switch" data-ts-color="blue">
						                        <label for="ts3" class="ts-label">Is User Role Required</label>
						                        <input id="ts3" type="checkbox" hidden="hidden"  ng-model="ng.userRoleRequired"
							     					 ng-true-value="'yes'" ng-false-value="'no'">
						                        <label for="ts3" class="ts-helper"></label>
						                    </div>
						                </div>
									</dd>
									<dt></dt>
									<dd>
									</dd>
								</dl>
								<dl class="dl-horizontal" ng-class="{ 'has-error' : rForm.description.$invalid &&( rForm.description.$dirty|| !submitted) }">
									<dt class="p-t-10">Title :</dt>
									<dd>
										<div class="fg-line">
											<input data-ng-model="ng.roleDescription" name="description" type="text"
												class="form-control
												value="" placeholder="Role Description" style="" required gname>
										</div>
									</dd>
									<dt></dt>
									<dd><div ng-messages="rForm.description.$error" ng-show="rForm.description.$dirty || !submitted" >
										<p class="help-block" ng-message="required">Description Required</p>
              							<p class="help-block" ng-message="invalidEntry">Invalid Characters are not allowed</p>
						            </div></dd>
								</dl>
								

								<dl class="dl-horizontal"
									ng-class="{ 'has-error' : rForm.status.$invalid &&( rForm.status.$dirty|| !submitted) }">
									<dt class="p-t-10">Status:</dt>
									<dd>
										<div class="fg-line select">
											<select ng-model="ng.status"
												name="status"
												class="form-control"
												required>
												<option value="" label="Select Status"/>
												<option value="Active" label="Active" />
												<option value="Inactive" label="Inactive" />
											</select>
										</div>
									</dd>
									<dt></dt>
									<dd>
										<div ng-messages="rForm.status.$error"
											ng-show="rForm.status.$dirty || !submitted">
											<p class="help-block" ng-message="required">Status is
												Required</p>
										</div>
									</dd>
								</dl>

								<%--<dl class="dl-horizontal">
									<dt class="p-t-10">Status:</dt>
									<dd>
										<div class="col-sm-4 m-b-20">
						                    <div class="toggle-switch" data-ts-color="blue">
						                        <label for="ts3" class="ts-label">Status</label>
						                        <input id="ts3" type="checkbox" hidden="hidden"  ng-model="ng.status"
							      				ng-true-value="'Active'" ng-false-value="'Inactive'">
						                        <label for="ts3" class="ts-helper"></label>
						                    </div>
						                </div>
									</dd>
									<dt></dt>
									<dd>
									</dd>
								</dl> --%>

								<div>{{ng.selectedReportActions|json}}</div>
								
								<ul class="rolesData tree" ng-check-tree ng-repeat="section in ng.reportActions">
									<li> 
									<input type="checkbox" ng-model="section.selected"  name="selectedSection" style="display: none !important;">
									<label> {{section.sectionDesc}}</label>
									<ul class="" ng-repeat="report in section.reports">
										<li> 
											<input type="checkbox" ng-model="report.selected" name="selectedReport" style="display: none !important; ">
											<label> {{report.reportDesc}}</label>
											<ul class="" ng-repeat="action in report.actions">
												<li> 
													<%-- <input type="checkbox" ng-model="action.selected" name="selectedAction"> --%>
													<input type="checkbox" checklist-model="ng.selectedReportActions" checklist-value="action.reportActionId" checklist-change="hidden.listChanged()">
													<label> {{action.actionDesc}}</label>
												</li>
											</ul>
										</li>
									</ul>
									</li>
								</ul>
								
								
             				<%-- <input type="checkbox" ng-model="ch" />with children
             				<choice-tree ng-model="ng.reportActions"></choice-tree> --%>
				</div>
				<div class="m-t-30">
					<input type="button"  ng-click="submitForm(rForm.$valid)"
						class="btn btn-primary btn-sm waves-effect bgm-lightblue" value="Save" /> 
						<input 	type="button" ng-click="close()"
						class="btn btn-link btn-sm waves-effect" value="Cancel" />
				</div>
		</div>
	</div>
	
</form>
	</script>