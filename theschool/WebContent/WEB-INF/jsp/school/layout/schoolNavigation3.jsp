<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

        <script type="text/javascript">
        $(document).ready(function() {
          //* if ($.browser.msie && $.browser.version.substr(0,1)<7)
			$('#shmenu li').has('ul').mouseover(function(){
				$(this).children('ul').show();
				}).mouseout(function(){
				$(this).children('ul').hide();
				});
        });        
    </script>
	
<style>


</style>

<div class="bodyHeader megamenu_wrapper">
	<div class="headerContent">
		

		<div class="navigationArea">
			<ul class="navigationElements">
				<li class="cl1"><a href="${pageContext.servletContext.contextPath}/school/home">Home</a></li>
				<li class="cl2"><a href="${pageContext.servletContext.contextPath}/school/aboutus">About Us</a>
					<ul>
						<li>
							<a href="${pageContext.servletContext.contextPath}/school/aboutus/founder">Founder</a>
						</li>
						<li>
							<a href="${pageContext.servletContext.contextPath}/school/aboutus/overview">Overview</a>
						</li>
						<li>
							<a href="${pageContext.servletContext.contextPath}/school/aboutus/vission">Vission</a>
						</li>
						<li>
							<a href="${pageContext.servletContext.contextPath}/school/aboutus/management">Management</a>
						</li>
						
					</ul>
				</li>
				<li class="cl3">
					<a href="${pageContext.servletContext.contextPath}/school/academics">Academics</a>
					<ul>
						<li>
							<a href="${pageContext.servletContext.contextPath}/school/">Work Item1</a>
						</li>
						<li>
							<a href="${pageContext.servletContext.contextPath}/school/#">Work Item2</a>
						</li>
					</ul>		
				</li>
				<li class="cl4">
					<a href="${pageContext.servletContext.contextPath}/school/administration">Administration</a>	
					<ul>
						<li>
							<a href="${pageContext.servletContext.contextPath}/school/administration/examination">Examination</a>
						</li>
						<li>
							<a href="${pageContext.servletContext.contextPath}/school/administration/admissions">Admissions</a>
						</li>
					</ul>	
				</li>
				
				<li class="cl5">
					<a href="${pageContext.servletContext.contextPath}/school/fecilities">Fecilities</a>
					<ul>
						<li>
							<a href="${pageContext.servletContext.contextPath}/school/fecilities/hostel">Hostel</a>
						</li>
						<li>
							<a href="${pageContext.servletContext.contextPath}/school/fecilities/transport">Transport</a>
						</li>
						<li>
							<a href="${pageContext.servletContext.contextPath}/school/infrastructure">Infrastructure</a>
						</li>
					</ul>		
				</li>
				<li class="cl6">
					<a href="${pageContext.servletContext.contextPath}/school/gallery">Gallery</a>	
				</li>
				<li class="cl7">
					<a href="${pageContext.servletContext.contextPath}/school/achievements">Achievements</a>	
				</li>
				<li class="cl8">
					<a href="${pageContext.servletContext.contextPath}/school/toppers">Toppers</a>	
				</li>
				<li class="cl9">
					<a href="${pageContext.servletContext.contextPath}/school/news">News</a>	
				</li>
				<li class="cl2">
					<a href="${pageContext.servletContext.contextPath}/school/library">Library</a>	
				</li>
				<li class="cl3">
					<a href="${pageContext.servletContext.contextPath}/school/notifications">Notifications</a>	
				</li>
				<li class="cl10">
					<a href="${pageContext.servletContext.contextPath}/school/contactus">Contact</a>	
				</li>

			</ul>
		</div>
	</div>
</div>
<div class="pagecontentclear"></div>
      