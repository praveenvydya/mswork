  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

        <script type="text/javascript">
     /*    $(function() {
          //if ($.browser.msie && $.browser.version.substr(0,1)<7)
          //{
			$('#shmenu li').has('ul').mouseover(function(){
				$(this).children('ul').show();
				}).mouseout(function(){
				$(this).children('ul').hide();
				});
          //}
        });   */      
    </script>
	
<style>

</style>

<section id="main">


<aside id="sidebar">
                <div class="sidebar-inner c-overflow" tabindex="1" style="overflow: hidden; outline: none;">
                    <div class="profile-menu">
                        <a href="">
                            <div class="profile-pic">
                                <img src="../../stvydya/new/img/profile.png" alt="">
                            </div>

                            <div class="profile-info">
                               ${sessionScope.user_display_name}<i class="zmdi zmdi-arrow-drop-down"></i>
                            </div>
                        </a>

                        <ul class="main-menu">
                            <li>
                                <a href="http://192.185.228.226/projects/ma/1-5/jquery/profile-about.html"><i class="zmdi zmdi-account"></i> View Profile</a>
                            </li>
                            <li>
                                <a href=""><i class="zmdi zmdi-input-antenna"></i> Privacy Settings</a>
                            </li>
                            <li>
                                <a href=""><i class="zmdi zmdi-settings"></i> Settings</a>
                            </li>
                            <li>
                                <a href="${pageContext.servletContext.contextPath}/admin/loginModule/logout.htm"><i class="zmdi zmdi-time-restore"></i> Logout</a>
                            </li>
                        </ul>
                    </div>

			<ul class="main-menu">

				<c:forEach items="${sessionScope.user_role_permissions}"
					var="section" varStatus="loop">
					<c:choose>
						<c:when test='${loop.index=="0"}'>
							<li class="sub-menu"><a href="#" class=""> <i class="zmdi zmdi-collection-item"></i> <c:out
										value="${section.sectionName}" /></a>
								<ul>
									<c:forEach items="${section.reports}" var="report"
										varStatus="loopReport">
										<c:if test="${'COMMON'!=report.reportType }">
											<li><a
												href="${pageContext.servletContext.contextPath}/admin/${report.reportName}/${report.actions[0].actionName}.htm"><c:out
														value="${report.uiDisplayName}" /></a></li>
										</c:if>
									</c:forEach>
								</ul></li>
						</c:when>
						<c:otherwise>

							<li class="sub-menu"><a href="#"><i class="zmdi zmdi-collection-item"></i> <c:out value="${section.sectionName}" /></a>
								<ul>
									<c:forEach items="${section.reports}" var="report"
										varStatus="loopReport">
										<c:if test="${'COMMON'!=report.reportType }">
											<li><a
												href="${pageContext.servletContext.contextPath}/admin/${report.reportName}/${report.actions[0].actionName}.htm"><c:out
														value="${report.uiDisplayName}" /></a></li>
										</c:if>
									</c:forEach>
								</ul></li>
						</c:otherwise>
					</c:choose>
				</c:forEach>

			</ul>


			
                </div>
            <div id="ascrail2002" class="nicescroll-rails nicescroll-rails-vr" style="width: 5px; z-index: 5; cursor: default; position: absolute; top: 0px; left: 263px; height: 568px; display: block; opacity: 0;"><div class="nicescroll-cursors" style="position: relative; top: 0px; float: right; width: 5px; height: 398px; border: 0px; border-radius: 0px; background-color: rgba(0, 0, 0, 0.498039); background-clip: padding-box;"></div></div><div id="ascrail2002-hr" class="nicescroll-rails nicescroll-rails-hr" style="height: 5px; z-index: 5; top: 563px; left: 0px; position: absolute; cursor: default; display: none; width: 263px; opacity: 0;"><div class="nicescroll-cursors" style="position: absolute; top: 0px; height: 5px; width: 268px; border: 0px; border-radius: 0px; background-color: rgba(0, 0, 0, 0.498039); background-clip: padding-box;"></div></div><div id="ascrail2005" class="nicescroll-rails nicescroll-rails-vr" style="width: 5px; z-index: 5; cursor: default; position: absolute; top: 0px; left: 263px; height: 337px; display: block; opacity: 0;"><div class="nicescroll-cursors" style="position: relative; top: 0px; float: right; width: 5px; height: 140px; border: 0px; border-radius: 0px; background-color: rgba(0, 0, 0, 0.498039); background-clip: padding-box;"></div></div><div id="ascrail2005-hr" class="nicescroll-rails nicescroll-rails-hr" style="height: 5px; z-index: 5; top: 332px; left: 0px; position: absolute; cursor: default; display: none; width: 263px; opacity: 0;"><div class="nicescroll-cursors" style="position: absolute; top: 0px; height: 5px; width: 268px; border: 0px; border-radius: 0px; background-color: rgba(0, 0, 0, 0.498039); background-clip: padding-box;"></div></div></aside>
      