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

<div class="megamenu_wrapper">    
<ul id="shmenu">
	<li><a href="${pageContext.servletContext.contextPath}/school/home">Home</a></li>
	<li>
		<a href="${pageContext.servletContext.contextPath}/school/aboutus">About Us</a>
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
	<li>
		<a href="${pageContext.servletContext.contextPath}/school/academics">Academics</a>
		<ul>
			<li>
				<a href="${pageContext.servletContext.contextPath}/school/">Work Item1</a>
			</li>
			<li>
				<a href="${pageContext.servletContext.contextPath}/school/#">Work Item2</a>
			</li>
			<li>
				<a href="${pageContext.servletContext.contextPath}/school/#">Work Item3</a>
			</li>
		</ul>		
	</li>
	<li>
		<a href="${pageContext.servletContext.contextPath}/school/administration">Administation</a>	
	</li>
	<li>
		<a href="${pageContext.servletContext.contextPath}/school/fecilities">Fecilities</a>
		<ul>
			<li>
				<a href="${pageContext.servletContext.contextPath}/school/fecilities/hostel">Hostel</a>
			</li>
			<li>
				<a href="${pageContext.servletContext.contextPath}/school/fecilities/transport">Transport</a>
			</li>
		</ul>		
	</li>
	<li>
		<a href="${pageContext.servletContext.contextPath}/school/gallery">Gallery</a>	
	</li>
	<li>
		<a href="${pageContext.servletContext.contextPath}/school/achievements">Achievements</a>	
	</li>
	<li>
		<a href="${pageContext.servletContext.contextPath}/school/events">Events</a>	
	</li>
	<li>
		<a href="${pageContext.servletContext.contextPath}/school/contactus">Contact</a>	
	</li>
</ul>
</div>
<div class="pagecontentclear"></div>
      