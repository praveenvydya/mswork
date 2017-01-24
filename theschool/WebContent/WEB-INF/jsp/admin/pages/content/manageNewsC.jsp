<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%-- <%@ taglib prefix="ts" uri="http://www.ts.com/tags"%> --%>
<%@ taglib prefix="ts" uri="/WEB-INF/ts-tags.tld" %>
<%@ page import="com.vydya.theschool.web.constants.WebConstants" %> 
<%@ page import="com.vydya.theschool.common.constants.TSConstants" %>
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery.tablesorter.js"></script>
<script src="<spring:message code="static.application.name"/>/new/js/news_V.js"></script>
<script defer="defer">

$(document).ready(function() 
	    { 
	        	$("#sectionsTable").tablesorter({widthFixed: true, widgets: ['applyStyles']});
	    } 
		);


</script>

  <div ng-controller="newsCtrl" ng-init=load('c')>

	<div class="card">
		<div class="lv-header-alt clearfix">
			<h2 class="lvh-label">Manage News - List of Categories</h2>
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
							<th>Category </th>
							<th>Title </th>
							<th>Inserted</th>
							<th>Inserted by</th>
							<th>Updated</th>
							<th>Updated by</th>
							<th>Action</th>
						</tr>
					</thead>
					<tbody>
	<tr ng-repeat="cc in ccl track by $index">
							<%-- <td><form:radiobutton  path="userId" id="${userData.userId}" value="${userData.userId}" 
							disabled="${userData.userName==sessionScope.user_name ? true: false}"/></td> 
							ng-disabled="x.status == 'disabled'"--%>
							
							<td>{{cc.name}}</td>
							<td>{{cc.title}}</td>
							<td>{{cc.inserted}}</td>
							<td>{{cc.insertedby}}</td>
							<td>{{cc.lastmodified}}</td>
							<td>{{cc.lastmodifiedby}}</td>
							<td><ul class="actions">
                                  <li class="dropdown">
                                      <a href="" data-toggle="dropdown">
                                          <i class="zmdi zmdi-more-vert"></i>
                                      </a>
                                      
                                      <ul class="dropdown-menu dropdown-menu-right">
                                          <li>
                                              <a href="" ng-click="edit(cc)">Edit</a>
                                          </li>
                                          <li>
                                              <a href="" ng-click="delete(cc)">Delete</a>
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
						<div class="fs-upload-target">
							<a ng-click="add()" class="upload-btn2 waves-effect"><i
								class="zmdi zmdi-accounts-add"></i> Add New Category</a>
						</div>
	
					</div>
	
				</div>
				<%-- <div id="sectionBttns">
					<ts:button validateAction="true"
						action="<%=WebConstants.EDIT_GROUP_ACTION%>" type="submit"
						cssClass="large clButton green" name="Edit" title="Edit"
						value="Edit" onClick="document.pressed=this.name" />
					<ts:button validateAction="true"
						action="<%=WebConstants.DELETE_GROUP_ACTION%>" type="submit"
						cssClass="large clButton green" name="Delete" title="Delete"
						value="Delete" onClick="document.pressed=this.name" />
				</div> --%>
			</div>
		</div>

		
		<script type="text/ng-template" id="manageNewsC.html">
        <div class="modal-header">
            <h3 class="modal-title">{{dto.action}} News Category</h3>
        </div>
		<form ng-submit="save(dto)">
        <div class="modal-body">
				<div class="col-xs-6">
						<div class="fg-line form-group">
							<label class="col-sm-2 control-label">Category Name</label>
							<input ng-model="dto.name" type="text" class="form-control input-sm" required	placeholder="News Category Name" name="category name">
						</div>
				</div>
				<div class="col-xs-6">
						<div class="fg-line form-group">
							<label class="col-sm-2 control-label">Category Title</label>
							<input ng-model="dto.title" type="text" class="form-control input-sm" required	placeholder="Category Title" name="title">
						</div>
				</div>
        </div>
        <div class="modal-footer">
			<input type="submit" class="btn btn-primary"  value="Save">
            <button class="btn btn-warning" type="button" ng-click="cancel()">Cancel</button>
        </div>
</form>
    </script>
			    		
	</div>
			