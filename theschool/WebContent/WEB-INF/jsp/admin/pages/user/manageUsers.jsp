<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%-- <%@ taglib prefix="ts" uri="http://www.ts.com/tags"%> --%>
<%@ taglib prefix="ts" uri="/WEB-INF/ts-tags.tld" %>
<%@ page import="com.vydya.theschool.web.constants.WebConstants" %> 
<%@ page import="com.vydya.theschool.common.constants.TSConstants" %>
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery.tablesorter.js"></script>
<script src="<spring:message code="static.application.name"/>/new/js/users_V.js"></script>
<script defer="defer">

$(document).ready(function() 
	    { 
		   
	        	$("#sectionsTable").tablesorter({widthFixed: true, widgets: ['applyStyles']});
	    	} 
		);


</script>

  <div ng-controller="usersctrl">

<div class="card">

	<div class="lv-header-alt clearfix">
		<h2 class="lvh-label hidden-xs">Admin Users</h2>
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
						<th>User Name </th>
						<th>Name </th>
						<th>Role</th>
						<th>Password Expiry</th>
						<th>Last Login</th>
						<th>Currently Logged</th>
						<th>Status</th>
						<th>Actions</th>
					</tr>
				</thead>
				<tbody>
				
					<tr ng-repeat="u in users track by $index" ng-show="users.length>0">
						<%-- <td><form:radiobutton  path="userId" id="${userData.userId}" value="${userData.userId}" 
						disabled="${userData.userName==sessionScope.user_name ? true: false}"/></td> 
						ng-disabled="x.status == 'disabled'"--%>
						
						<td>{{u.userName}}</td>
						<td>{{u.firstName}}, {{u.lastName}}</td>
						<td>{{u.userRole}}</td>
						<td>{{u.passwordExpiryDate}}</td>
						<td>{{u.lastAccessDate}}</td>
						<td>{{u.loginStatus}}</td>						
			    		<td>{{u.status}}</td>
						<td><ul class="actions"> <%-- ng-hide="hideAction(${sessionScope.user_name})"> --%>
                                  <li class="dropdown">
                                      <a href="" data-toggle="dropdown">
                                          <i class="zmdi zmdi-more-vert"></i>
                                      </a>
                                      
                                      <ul class="dropdown-menu dropdown-menu-right">
                                          <li>
                                             <!--  <a href="" ng-click="edit($index,u)">Edit</a> -->
                                         <a href="#" header="'Update User'" modal-trigger
   data="u" template="'templates/adminuser.html'" action="'edit'" c="'adminUser'">Edit</a>
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
					<div class="fs-upload-target waves-effect"> <button modal-trigger
    header="'Add User'"
   data="vm" action="'add'" template="'templates/adminuser.html'" c="'adminUser'"><i class="zmdi zmdi-accounts-add"></i> Add New User</button></div>
				</div>
            </div>
	</div>
						    		
	</div>
	
	<!-- <div class="modal" id="userForm" data-backdrop="static"
	data-keyboard="false" tabindex="-1" role="dialog" aria-hidden="true">
	
		<div class="modal-dialog">
		<div class="modal-content"> -->
		
	
	<script type="text/ng-template" id="templates/adminuser.html">


			<form name="uForm" novalidate>
				<div class="pmb-block ng-scope">
					<div class="pmbb-header">
						<h2>
							<i class="zmdi zmdi-person m-r-5"></i>{{title}}
						</h2>
					</div>

					<div class="pmbb-body p-l-30">
						<dl class="dl-horizontal"
							ng-class="{ 'has-error' : uForm.username.$invalid &&( uForm.username.$dirty|| !submitted) }">
							<dt class="p-t-10">User Name :</dt>
							<dd>
								<div class="fg-line">
									<input data-ng-model="ng.userName" name="username"
										ng-disabled="'edit' == action" type="text"
										class="form-control" value="" placeholder="User Name" style=""
										required check-unique="{key:'username'}" fn="verify" username
										ng-model-options="{ updateOn: 'blur' }">
								</div>
							</dd>
							<dt></dt>
							<dd>
								<div ng-messages="uForm.username.$error"
									ng-show="uForm.username.$dirty || !submitted">
									<p class="help-block" ng-message="required">User Name
										Required</p>
									<p class="help-block" ng-message="minl">User Name cann't be
										less than 6 characters</p>
									<p class="help-block" ng-message="unique">User Name is
										already used</p>
									<p class="help-block" ng-message="invalidEntry">Invalid
										Characters are not allowed</p>
									<p class="help-block" ng-message="username">Start User Name
										with 'ap'.</p>
									<p class="help-block" ng-message="checking">checking..</p>
								</div>
							</dd>
						</dl>

						<dl class="dl-horizontal"
							ng-class="{ 'has-error' : uForm.firstname.$invalid &&( uForm.firstname.$dirty|| !submitted) }">
							<dt class="p-t-10">First Name :</dt>
							<dd>
								<div class="fg-line">
									<input data-ng-model="ng.firstName" name="firstname"
										type="text" class="form-control" value=""
										placeholder="First Name" style="" required pname>
								</div>
							</dd>
							<dt></dt>
							<dd>
								<div ng-messages="uForm.firstname.$error"
									ng-show="uForm.firstname.$dirty || !submitted">
									<p class="help-block" ng-message="required">First Name
										Required</p>

									<p class="help-block" ng-message="invalidEntry">Invalid
										Characters are not allowed</p>
								</div>
							</dd>
						</dl>

						<dl class="dl-horizontal"
							ng-class="{ 'has-error' : uForm.lastname.$invalid &&( uForm.lastname.$dirty|| !submitted) }">
							<dt class="p-t-10">Last Name :</dt>
							<dd>
								<div class="fg-line">
									<input data-ng-model="ng.lastName" name="lastname" type="text"
										class="form-control" value="" placeholder="Last Name" style=""
										required gname>
								</div>
							</dd>
							<dt></dt>
							<dd>
								<div ng-messages="uForm.lastname.$error"
									ng-show="uForm.lastname.$dirty || !submitted">
									<p class="help-block" ng-message="required">Last Name is
										Required</p>

									<p class="help-block" ng-message="invalidEntry">Invalid
										Characters are not allowed</p>
								</div>
							</dd>
						</dl>

						<dl class="dl-horizontal"
							ng-class="{ 'has-error' : uForm.email.$invalid &&( uForm.email.$dirty|| !submitted) }">
							<dt class="p-t-10">Email :</dt>
							<dd>
								<div class="fg-line">
									<input data-ng-model="ng.email" name="email" type="text"
										ng-disabled="'edit'==action" class="form-control" value=""
										placeholder="Email" style="" required email
										check-unique="{key:'email',mode:action}" fn="verify"
										ng-model-options="{ updateOn: 'blur' }">
								</div>
							</dd>
							<dt></dt>
							<dd>
								<div ng-messages="uForm.email.$error"
									ng-show="uForm.email.$dirty || !submitted">
									<p class="help-block" ng-message="required">Email is
										Required</p>
									<p class="help-block" ng-message="invalidEmail">Invalid
										Email</p>
									<p class="help-block" ng-message="unique">Email already
										used</p>

									<p class="help-block" ng-message="checking">checking..</p>
								</div>
							</dd>
						</dl>

						<dl class="dl-horizontal"
							ng-class="{ 'has-error' : uForm.group.$invalid &&( uForm.group.$dirty|| !submitted) }">
							<dt class="p-t-10">User Group:</dt>
							<dd>
								<div class="fg-line select">
									<select ng-model="ng.groupId"
										ng-options="g.groupId as g.groupName for g in ug"
										ng-disabled="${ ('edit' eq action)&&('IA' eq sessionScope.user_role_type || ng.disabled) ? true: false}"
										name="group"
										class="editable-input form-control  required w-100 localytics-chosen"
										required>
										<option value="">Select Group</option>
									</select>
								</div>
							</dd>
							<dt></dt>
							<dd>
								<div ng-messages="uForm.group.$error"
									ng-show="uForm.group.$dirty || !submitted">
									<p class="help-block" ng-message="required">User Group is
										Required</p>

								</div>
							</dd>
						</dl>
						<dl class="dl-horizontal"
							ng-class="{ 'has-error' : uForm.role.$invalid &&( uForm.role.$dirty|| !submitted) }">
							<dt class="p-t-10">User Role:</dt>
							<dd>
								<div class="fg-line select">
									<select ng-model="ng.roleId" required
										ng-options="ur.roleId as ur.roleName for ur in urs"
										class="editable-input form-control  required"
										ng-disabled="{{ng.disabled}}" name="role">
										<option value="">Select User Role</option>
									</select>
								</div>
							</dd>
							<dt></dt>
							<dd>
								<div ng-messages="uForm.role.$error"
									ng-show="uForm.role.$dirty || !submitted">
									<p class="help-block" ng-message="required">User Role is
										Required</p>

								</div>
							</dd>
						</dl>
						<dl class="dl-horizontal"
							ng-class="{ 'has-error' : uForm.status.$invalid &&( uForm.status.$dirty|| !submitted) }">
							<dt class="p-t-10">User Status:</dt>
							<dd>
								<div class="fg-line select">
									<select ng-model="ng.status" required
										ng-options="s.val as s.text for s in us"
										class="editable-input form-control  required" name="status"
										ng-disabled="{{ng.disabled}}">

										<option value="">Select User Status</option>
									</select>
								</div>
							</dd>
							<dt></dt>
							<dd>
								<div ng-messages="uForm.status.$error"
									ng-show="uForm.status.$dirty || !submitted">
									<p class="help-block" ng-message="required">Set status for
										User</p>

								</div>
							</dd>
						</dl>

						<dl class="dl-horizontal"
							ng-class="{ 'has-error' : uForm.adminRole.$invalid &&( uForm.adminRole.$dirty|| !submitted) }">
							<dt class="p-t-10">Admin Role:</dt>
							<dd>
								<div class="fg-line select">
									<select ng-model="ng.adminRoleId" ng-options="ar.roleId as ar.roleName for ar in ars"
										class="form-control" ng-disabled="{{ng.disabled}}"
										name="adminRole" data-placeholder="Select Admin Role">
										<option value="">Select Admin Role</option>
									</select>
								</div>
							</dd>
							<dt></dt>
							<dd>
								<!-- <div ng-messages="uForm.adminRole.$error" ng-show="uForm.adminRole.$dirty || !submitted" >
									<p class="help-block">Select AdminRole</p>
						            </div>  -->
								<!-- <div class="toggle-switch" data-ts-color="blue">
				                        <label for="ts10" class="ts-label">Portal Administrator</label>
				                        <input id="ts10" type="checkbox" hidden="hidden" name="adminRole" value="1">
				                        <label for="ts10" class="ts-helper"></label>
				                    </div> -->
							</dd>
						</dl>

					</div>
					<div class="m-t-30">
						<!-- <button class="btn btn-primary btn-sm waves-effect" ng-disabled="!uForm.$valid" type="submit">Save</button>
		                <button class="btn btn-link btn-sm waves-effect" data-ng-click="close()">Cancel</button> -->

						<input type="button" ng-click="submitUserForm(uForm.$valid)"
							class="btn-primary btn-sm waves-effect bgm-lightblue"
							value="Save" /> <input type="button" ng-click="cancel()"
							class="btn-link btn-sm waves-effect" value="Cancel" />
					</div>

				</div>
			</form>
</script>
			