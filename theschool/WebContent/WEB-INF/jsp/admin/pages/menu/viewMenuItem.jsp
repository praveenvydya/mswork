<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="ts" uri="/WEB-INF/ts-tags.tld"%>
<%@ page import="com.vydya.theschool.web.constants.WebConstants"%>
<%@ page import="com.vydya.theschool.common.constants.TSConstants"%>
<script type="text/javascript" 	src="<spring:message code="static.application.name"/>/javascript/jquery.tablednd.js"></script>
<head>	
	<script type="text/javascript">  
jQuery(document).ready(function($){
	
		 $('#mainSplitter').jpsSplitter({ width: 1156, height: 500, panels: [{ size: 210}, { size: 936}] });//,min: 745,max:770
         
		 $('#addBttn').click(function(){
				
					
				$("#menuForm").attr("action", '<%=TSConstants.ACTION_ADD%>.htm');
				$("#menuForm").submit();
				$('#addBttn').attr("disabled", true);
			});  
		 
			  $("#editBttn").click(function() {
					//if($(".contentId").is(':checked')==true){
						$(this).attr("disabled", true);
						$('#menuForm #actionType').val("<%=WebConstants.VIEW%>");
						$("#menuForm").attr("action","<%=TSConstants.ACTION_EDIT%>.htm");
						$("#menuForm").submit();
						
					/* //}
					else{
						alert("Please Select One");
						return false;
					} */
				});
			  $("#deleteBttn").click(function() {
						$("#menuForm").attr("action","<%=TSConstants.ACTION_DELETE%>.htm");
						$("#menuForm").submit();
						$(this).attr("disabled", true);
				}); 
			  
			//GET BROWSER WINDOW HEIGHT
				var currHeight = $(window).height();
				$('#contentcatListBar, #contentPanel').css('height', currHeight-10);
				
				//ON RESIZE OF WINDOW
				$(window).resize(function() {
					
					//GET NEW HEIGHT
					var currHeight = $(window).height();	
					//RESIZE BOTH ELEMENTS TO NEW HEIGHT
					$('#contentcatListBar, #contentPanel').css('height', currHeight-10);
					
				});
			
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
	});
	</script>

<style>
#innerContentAdmin .page {
	display: inline-block;
	padding: 0px!important;
}

</style>
</head>
<div id="">
<form:form method="POST" commandName="menuForm" name="menuForm" id="menuForm">
						<form:input type="hidden" path="actionType" value="view"/>
						<form:input type="hidden" path="menuId" />
		<div id="mainSplitter">
		             <div class="" id="contentcatListBar">
		             <div class="contentHeader pnl">
		            	 	<input type="button" style="float: left;" class="cms-btn"  title="" value="Back" onClick="location.href='${pageContext.servletContext.contextPath}/<%=WebConstants.VIEW_ALL_MENUS%>'"/>
							<input type="button"  class="cms-btn btn-s" id="addBttn" title="Add" value="ADD"/>
						</div>
		               <div id="menuData">
					
						</div>
					

                </div>
                
                <div style="overflow: hidden;">
                    <div style="border: none;" id="rightSplitter">
                        <div class="contentHeader pnl">
                        	<div style="float:left;width: 82%;line-height: 18px;"> This is Menu is added by ${menuForm.insertedby} on ${menuForm.inserted} and updated by ${menuForm.lastmodifiedby} on ${menuForm.lastmodified}</div>
                            <input type="button"  class="cms-btn btn-s" id="editBttn" title="Back" value="Edit"/>
							<input type="button"  class="cms-btn" id="deleteBttn" title="Delete" value="Delete"/>
						</div>
                        <div class="contentPanel">
								${menuForm.html}
                         </div>
                    </div>
                </div>
               	
            </div>
	 </form:form>
</div>
