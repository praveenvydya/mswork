<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="ts" uri="/WEB-INF/ts-tags.tld"%>
<%@ page import="com.vydya.theschool.web.constants.WebConstants"%>
<%@ page import="com.vydya.theschool.common.constants.TSConstants"%>
<script type="text/javascript" 	src="<spring:message code="static.application.name"/>/javascript/jquery.tablednd.js"></script>
<script type="text/javascript" src="<spring:message code="static.application.name"/>/javascript/jquery.tablesorter.js"></script>
<script src="<spring:message code="static.application.name"/>/new/js/news_V.js"></script>
	
	<script type="text/javascript">  
	jQuery(document).ready(function($){
	
		loadMenu();
		function loadMenu(){
			var divid= $("#menuData");
			$.get('load.htm?', function( data ) {
				displayMenu(data,divid);
			});
		};
		
		
		
		function displayMenu(d,divid) {
			
			 var ul =$('<ul/>',{
				 class:'ulmenu',
			 }).appendTo(divid);
			 
			   $.each( d, function( key, menu ) {
				   var sub1 = menu.subMenu;
					 var id = "menu_"+menu.menuId;
					 
					 var  li = $('<li/>',{
						 id:'c_'+menu.menuId,
						 class:'clmenu'
					 }).appendTo(ul);
					 
					 var a = $('<div/>',{
						 class:'bt1',
						 href:menu.path,
						 id:'name_'+menu.menuId
					 }).appendTo("#c_"+menu.menuId);
					 
					 var hrf = '<span class="hw12"><a href="${pageContext.request.contextPath}/admin/manageMenu/view.htm?id='+menu.menuId+'">'+menu.name+'</a></span>';
					 $(hrf).appendTo('#name_'+menu.menuId);
					/*  var a = $('<span/>',{
						 class:'hw12',
						 text:menu.name
					 }).appendTo('#name_'+menu.menuId); */
					if(sub1 != null){
						//appendChilds(sub1,li);
						displayMenu(sub1,li);
						}
				  });
			
			
			}
		
		function appendChilds(el,id){
					 $(el).each(function(index, cel) {
						 var idn = cel.menuId;
					 var  li = $('<li/>',{
						 id:'c_'+idn
					 }).appendTo("#"+id);
					 
					 var a = $('<a/>',{
						 title:cel.title,
						 href:'#',
						 text:cel.title
					 }).appendTo("#c_"+idn);

							if(null!=cel.subMenu){
								var nid= 'p_'+cel.menuId;
								var ul =$('<ul/>',{
									 id:nid
								 }).appendTo("#c_"+idn);
								appendChilds(cel.subMenu,nid);
								}
						});
					
		}
		
		
		 $('#addBttn').click(function(){
			 	
				$('#addBttn').attr("disabled", true);	
				$("#menuForm").attr("action", '<%=TSConstants.ACTION_ADD%>.htm');
				//$("#menuForm").attr("action", 'add.htm');
				$("#menuForm").submit();
			});  
		 
		 $('.successMsg').fadeIn().delay(5000).fadeOut();  
			  <%-- $("#deleteBttn").click(function() {
					if($(".contentId").is(':checked')==true){
						$("#menuForm").attr("action",'<%=TSConstants.ACTION_DELETE%>.htm');
						$("#menuForm").submit();
					}
					else{
						alert("Please Select One");
						return false;
					}
				});  --%>
			
	});
	</script>

  <div ng-controller="menuCtrl" ng-init="load('m')">

<div class="col-sm-8">
	<div class="card">
		<div class="lv-header-alt clearfix">
			<h2 class="lvh-label">Manage Menu Pages</h2>
			<ul class="lv-actions actions">
				<li><a href=""> <i class="zmdi zmdi-info"></i>
				</a></li>
				<li class="dropdown"><a href="" data-toggle="dropdown"
					aria-expanded="true"> <i class="zmdi zmdi-more-vert"></i>
				</a>
	
					<ul class="dropdown-menu dropdown-menu-right">
						<li><a href="">Refresh</a></li>
						<li><a href="">Listview Settings</a></li>
						<li><a href="">Reload</a></li>
					</ul></li>
			</ul>
		</div>
		<div class="table-responsive" tabindex="3"
				style="overflow: hidden; outline: none;">
				<table class="table table-hover" id="sectionsTable">
					<thead>
						<tr>
							<th>Name</th>
							<th>Path </th>
							<th>Parent</th>
							<th>Status</th>
							<th>Inserted</th>
							<th>Inserted by</th>
							<th>Updated</th>
							<th>Updated by</th>
							<th>Action</th>
						</tr>
					</thead>
				<tbody>
	<tr ng-repeat="m in menus track by $index">
							<%-- <td><form:radiobutton  path="userId" id="${userData.userId}" value="${userData.userId}" 
							disabled="${userData.userName==sessionScope.user_name ? true: false}"/></td> 
							ng-disabled="x.status == 'disabled'"--%>
							
							<td>{{m.name}}</td>
							<td>{{m.path}}</td>
							<td>{{m.parent}}</td>
							<td>{{m.status}}</td>
							<td>{{m.inserted}}</td>
							<td>{{m.insertedby}}</td>
							<td>{{m.lastmodified}}</td>
							<td>{{m.lastmodifiedby}}</td>
							<td><ul class="actions">
                                  <li class="dropdown">
                                      <a href="" data-toggle="dropdown">
                                          <i class="zmdi zmdi-more-vert"></i>
                                      </a>
                                      
                                      <ul class="dropdown-menu dropdown-menu-right">
                                          <li>
                                              <a href="" ng-click="edit(m)">Edit</a>
                                          </li>
                                          <li>
                                              <a href="" ng-click="delete(m)">Delete</a>
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
								class="zmdi zmdi-accounts-add"></i> Add New Menu</a>
						</div>
	
					</div>
	
				</div>
				<%-- <div id="sectionBttns">
					<ts:button validateAction="true" action="<%=WebConstants.ADD_MENU%>"  type="button"   id="addBttn" cssClass="large clButton green " name="Add" value="Add" title="Add" />
					
					
				</div> --%>
			</div>
		</div>
		
		<div class="col-sm-4">
				<div class="card-header ch-alt m-b-20">
                            <h2>Menu Tree <small> Some Description</small></h2>
                            <ul class="actions">
                                <li>
                                    <a href="">
                                        <i class="zmdi zmdi-refresh-alt"></i>
                                    </a>
                                </li>
                                <li>
                                    <a href="">
                                        <i class="zmdi zmdi-download"></i>
                                    </a>
                                </li>
                                <li class="dropdown" uib-dropdown="" style="">
                                    <a href="" uib-dropdown-toggle="" class="dropdown-toggle" aria-haspopup="true" aria-expanded="false">
                                        <i class="zmdi zmdi-more-vert"></i>
                                    </a>

                                    <ul class="dropdown-menu dropdown-menu-right">
                                        <li>
                                            <a href="">Change Date Range</a>
                                        </li>
                                        <li>
                                            <a href="">Change Graph Type</a>
                                        </li>
                                        <li>
                                            <a href="">Other Settings</a>
                                        </li>
                                    </ul>
                                </li>
                            </ul>

                            <button class="btn bgm-cyan btn-float waves-effect waves-circle"><i class="zmdi zmdi-plus"></i></button>
                        </div>
		</div>
</div>

<script type="text/ng-template" id="manageNews.html">
        <div class="modal-header">
            <h3 class="modal-title">{{dto.action}} News Item</h3>
        </div>
		<form ng-submit="save(dto)">
        <div class="modal-body">
				<div class="col-xs-6">
						<div class="fg-line form-group">
							<label class="col-sm-2 control-label">Name</label>
							<input ng-model="dto.name" type="text" class="form-control input-sm" required	placeholder="News Name" name="name">
						</div>
				</div>
				
				<div class="col-xs-6">
						<div class="fg-line form-group">
							<label class="col-sm-2 control-label">Is Menu Child?</label>
							 <input type="checkbox" ng-true-value="Y" ng-false-value="N" ng-model="isChild"/> 
						</div>
				</div>
				<div class="col-xs-6" ng-show="isChild == 'Y'">
						<div class="fg-line form-group">
							<label class="col-sm-2 control-label">Parent</label>
							<select name="selectedMenuId" ng-model="parentId">
         						<option ng:repeat="m in parents" value="{{m.menuId}}">{{m.name}}</option>
     						</select>  
						</div>
				</div>
				
				<div class="col-xs-6">
						<div class="fg-line form-group">
							<label class="col-sm-2 control-label">Status</label>
							<select name="status" ng-model="status">
         						<option value="1">Active</option>
								<option value="0">Inactive</option>
     						</select>  

						</div>
				</div>
				<div class="col-xs-12">
						<div class="fg-line form-group">
							<label class="col-sm-2 control-label">Status</label>
							<textarea  ng-model="html" id="contentTextarea" name="xhtml_field" style="height:300px;width:100%" /> 
						</div>
				</div>
			
        </div>
        <div class="modal-footer">
			<input type="submit" class="btn btn-primary"  value="Save">
            <button class="btn btn-warning" type="button" ng-click="cancel()">Cancel</button>
        </div>

		<div> Attachements </div>

</form>
    </script>		
