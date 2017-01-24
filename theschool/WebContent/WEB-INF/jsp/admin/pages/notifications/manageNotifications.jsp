
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="ts" uri="/WEB-INF/ts-tags.tld"%>
<%@ page import="com.vydya.theschool.web.constants.WebConstants"%>
<%@ page import="com.vydya.theschool.common.constants.TSConstants"%>
<script type="text/javascript"
	src="<spring:message code="static.application.name"/>/javascript/jquery.tablednd.js"></script>
	<script src="<spring:message code="static.application.name"/>/new/js/notification_V.js"></script>

<script type="text/javascript">
	jQuery(document).ready(function($) {

	});
</script>


<div ng-app="hApp">
	<div ng-controller="hctrl" data-ng-init="init()">
		<div class="card">
			<div class="lv-header-alt clearfix">
				<h2 class="lvh-label hidden-xs">Notifications</h2>
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
				<table class="table table-hover">
					<thead>
						<tr>
							<th>Name</th>
							<th>Description</th>
							<th>Category</th>
							<th>Status</th>
							<th>Inserted/By</th>
							<th>Updated/By</th>
						</tr>
					</thead>
					<tbody>


						<tr ng-repeat="n in ns track by $index">
							<td><a
								href="${pageContext.request.contextPath}/notification/{{n.url]}"
								target="_blank"><span class="fileIcon"> <span
										class="fileType {{n.fileType}f"></span></span>{{n.name}}</a></td>
							<td width="">{{n.description}}</td>
							<td width="">{{n.category}}</td>

							<td class="center status-inactive">Inactive</td>
							<td width="">{{n.inserted}}/<br>{{n.insertedby}}
							</td>
							<td width="">{{n.lastmodified}}/<br>{{n.lastmodifiedby}}
							</td>
						</tr>

						<tr>
							<td colspan="8">
								<%-- <ts:button validateAction="true" action="<%=WebConstants.EDIT_HOMEPAGE_IMAGES%>"   type="submit" cssClass="editBttn" name="Edit" value=""  />
					<ts:button validateAction="true" action="<%=WebConstants.DELETE_HOMEPAGE_IMAGES%>"    type="submit" cssClass="deleteBttn" name="Delete" value=""  />
					 --%> <input type="button" class="large clButton yellow"
								id="editBttn" title="Back" value="Edit" /> <input type="button"
								class="large clButton green" id="deleteBttn" title="Delete"
								value="Delete" />
							</td>
						</tr>
					</tbody>
				</table>

			</div>
		</div>
	</div>
</div>