<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="ts" uri="/WEB-INF/ts-tags.tld" %>
<%@ page import="com.vydya.theschool.web.constants.WebConstants" %> 
<%@ page import="com.vydya.theschool.common.constants.TSConstants" %> 
<script src="<spring:message code="static.application.name"/>/new/js/props_V.js"></script>

<%-- <form:form name="PropertiesForm"  method="POST"  action="saveAllProperties.htm"  modelAttribute="properties" onsubmit="return onPropertiesSubmit();">
				<c:if test='${null!=success_key }'>
				<div class="successMsg"><spring:message code="${success_key}" /></div>
				<c:remove var="success_key" scope="session" />
				</c:if>
				  <div class="title">Properties Details </div>
				 
<table width="100%" border="0" cellspacing="0" cellpadding="0" id="sectionTableHeader">
				   <tr>					
					<th width="35%">Key</th>
					<th width="30%">Value</th>	
					<th width="35%">Property Description</th>					
				  </tr>
				  <c:forEach items="${properties.propertyList}"  var="property"  varStatus="status">
				  <tr><form:hidden path="propertyList[${status.index}].key" />
				  <td><form:label  path="propertyList[${status.index}].key" id="propertyList[${status.index}].key"/><c:out value="${property.key}" /></td>
					<td><form:input size="50" maxlength="200" path="propertyList[${status.index}].value" id="propertyList[${status.index}].value"/></td>
					<td><form:input size="50" maxlength="200" path="propertyList[${status.index}].propertyDesc" id="propertyList[${status.index}].propertyDesc"/></td>
				  </tr>
				  </c:forEach>
				  </table>
				   <div id="sectionBttns">
				  <ts:button validateAction="true" action="<%=WebConstants.SAVE_PROPERTIES_ACTION%>"  type="submit" cssClass="large clButton green"    name="Save"   title="Save"  value="Save"   />
				  <ts:button validateAction="true" action="<%=WebConstants.RELOAD_PROPERTIES_ACTION%>"  type="submit" cssClass="large clButton green"  name="Reload" title="Reload" value="Reload" onClick="document.pressed=this.name;" />
				  <!-- <input type="reset" class="resetBttnBlack" value="" title="Reset"/> -->
				 
				  </div>
</form:form>
 --%>
<div ng-controller="propsCtrl">
<div class="card">
	<div class="lv-header-alt clearfix">
		<h2 class="lvh-label hidden-xs">Admin Properties</h2>
		<ul class="lv-actions actions">
			<li><a href=""> <i class="zmdi zmdi-info"></i>
			</a></li>
			<li class="dropdown"><a href="" data-toggle="dropdown"
				aria-expanded="true"> <i class="zmdi zmdi-more-vert"></i>
			</a>

				<ul class="dropdown-menu dropdown-menu-right">
					<li><a ng-click="load()">Refresh</a></li>
					<li><a href="">Listview Settings</a></li>
				</ul></li>
		</ul>
	</div>
	

 <div ng-if="!props.length" class="table-responsive ng-cloak" style="overflow: hidden; outline: none;">
 	<h5 class="p-15"> No Admin Properties found.! </h5>
 </div>
 
 
		<div class="table-responsive ng-cloak" tabindex="3"  ng-if="props.length"
			style="overflow: hidden; outline: none;">
			<table class="table table-hover">
				<thead>
					<tr>
						<th>Key</th>
						<th>Value</th>
						<th>Description</th>
						<th>Inserted</th>
						<th>Inserted by</th>
						<th>Updated</th>
						<th>Updated by</th>
						<th>Action</th>
					</tr>
				</thead>
				<tbody>
					<tr ng-repeat="i in props track by $index">
						<td>{{i.key}}</td>
						<td>{{i.value}}</td>
						<td>{{i.propertyDesc}}</td>
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
                                              <a href="" modal-trigger  header="'Update Property'"
					   data="i" action="'edit'" template="'templates/props.html'" c="'modalCtrl'"
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
		
<script type="text/ng-template" id="templates/props.html">
	<form name="propsForm" novalidate>
		<div class="modal-content">
			
						<div class="pmb-block ng-scope">
							<div class="pmbb-header">
								<h2>
									<i class="zmdi zmdi-person m-r-5"></i>{{header}}
								</h2>
							</div>
							<div class="pmbb-body p-l-30">
								<dl class="dl-horizontal">
									<dt class="p-t-10">KEY :</dt>
									<dd>
										<div class="fg-line">
											<p ng-bind="ng.key"></p>
										</div>
									</dd>
									<dt></dt>
									<dd></dd>
								</dl>

								<dl class="dl-horizontal" ng-class="{ 'has-error' : propsForm.value.$invalid &&( propsForm.value.$dirty|| !submitted) }">
									<dt class="p-t-10">Value :</dt>
									<dd>
										<div class="fg-line">
											<input data-ng-model="ng.value" name="value" type="text"
												class="form-control
												value="" placeholder="Value" style="" required gname>
										</div>
									</dd>
									<dt></dt>
									<dd><div ng-messages="propsForm.value.$error" ng-show="propsForm.value.$dirty || !submitted" >
										<p class="help-block" ng-message="required">Value Required</p>
              							<p class="help-block" ng-message="invalidEntry">Invalid Characters are not allowed</p>
						            </div></dd>
								</dl> 
								<dl class="dl-horizontal"
									ng-class="{ 'has-error' : uForm.propertyDesc.$invalid &&( uForm.propertyDesc.$dirty|| !submitted) }">
										<dt class="p-t-10">Property Description:</dt>
									<dd>
										<div class="fg-line">
											<input data-ng-model="ng.propertyDesc" name="propertyDesc" type="text"
												class="form-control
												value="" placeholder="Description" style="" required gname>
										</div>

								
									</dd>
										<dt></dt>
									<dd>
										<div ng-messages="uForm.propertyDesc.$error"
											ng-show="uForm.propertyDesc.$dirty || !submitted">
											<p class="help-block" ng-message="required">Property Description required</p>

										</div>
									</dd>
								</dl>
							</div>
							<div class="m-t-30">
									<input type="button"  ng-click="submitForm(propsForm.$valid)"
										class="btn btn-primary btn-sm waves-effect bgm-lightblue" value="Save" /> 
										<input 	type="button" ng-click="close()"
										class="btn btn-link btn-sm waves-effect" value="Cancel" />
							</div>
						</div>
					</form>
</script>

</div>