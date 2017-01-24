<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
        <script type="text/javascript">
        $(document).ready(function() {
        	
				loadMenu();
				var serverName = $("#website").val();
		/* 	function loadMenu(){
				$.get('<spring:message code="application.name"/>${pageContext.servletContext.contextPath}/getMenu.htm', function( data ) {
					var divid = $(".navigationArea ul li:eq(1)");
					display(data,divid);
				});
			};
			 */
				function loadMenu(){
					$.get('<spring:message code="application.name"/>${pageContext.servletContext.contextPath}/getMenu.htm', function( data ) {
						var $node = $(".navigationArea ul li:eq(1)");
						var html = $.parseHTML( data);
						$node.append( html );
					});
				};
			 
			
			function displayMenu(data,divid){
				
				var ul =$('<ul/>',{
					'class':'navigationElements'
				}).insertAfter(divid);
				display(data,ul);
					}
			
		function display(data,divid){
				   $.each( data, function( key, menu ) {
					   var sub1 = menu.subMenu;
						// var id = "menu_"+menu.menuId; 
						 var  li = $('<li/>',{
							 'class':'cl'+key,
							 id:'menuli',
							 html:'<a href="${pageContext.servletContext.contextPath}/school/page/'+menu.path+'">'+menu.name+'</a>'
						 }).insertBefore(divid);
						 
						if(sub1 != null){
							var ul =$('<ul/>',{
								'class':'ul-menu'
							}).appendTo(li);
							displayU(sub1,ul);
							}
					  });
					}
		
		function displayU(data,divid){
			
			 
			   $.each( data, function( key, menu ) {
				   var sub1 = menu.subMenu;
					 //var id = "menu_"+menu.menuId;
					  var  li = $('<li/>',{
							 
						 id:'menuli',
						 html:'<a href="${pageContext.servletContext.contextPath}/page/'+menu.path+'">'+menu.name+'</a>'
					 }).appendTo(divid);
					 
					if(sub1 != null){
						var ul =$('<ul/>',{
							'class':'ul-menu'
						}).appendTo(li);
						
						displayU(sub1,ul);
						}
				  });
				}
			
			
        });        
        
    </script>
	
<style>


</style>

<div class="bodyHeader megamenu_wrapper">
	<div class="headerContent">
		

		<div class="navigationArea">
			<ul class="navigationElements">
				<li class="cl8">
					<a href="${pageContext.servletContext.contextPath}/home">Home</a>	
				</li>
				
				<li class="cl0">
					<a href="${pageContext.servletContext.contextPath}/gallery">Gallery</a>	
				</li>
				<li class="cl1">
					<a href="${pageContext.servletContext.contextPath}/toppers">Toppers</a>	
				</li>
				<li class="cl2">
					<a href="${pageContext.servletContext.contextPath}/news">News</a>	
				</li>
				<li class="cl3">
					<a href="${pageContext.servletContext.contextPath}/library">Library</a>	
				</li>
				<li class="cl4">
					<a href="${pageContext.servletContext.contextPath}/notifications">Notifications</a>	
				</li>
				<li class="cl5">
					<a href="${pageContext.servletContext.contextPath}/events">Events</a>	
				</li>
				<li class="cl6">
					<a href="${pageContext.servletContext.contextPath}/contactus">Contact</a>	
				</li>			
			</ul>
		</div>
	</div>
</div>
<div class="pagecontentclear"></div>
      