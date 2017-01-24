<span class="logo"></span> <span class="welcome">
    <p>Welcome:&nbsp;<strong>${sessionScope.user_display_name}</strong> &nbsp; | &nbsp; <a href="${pageContext.servletContext.contextPath}/loginModule/logout.htm" class="logoutLink">Logout</a></p>
    <p class="lastLogin">Last Login: ${sessionScope.user_last_login}</p>
    </span>