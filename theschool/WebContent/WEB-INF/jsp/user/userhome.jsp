<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

    <p>Welcome:&nbsp;<strong>${sessionScope.user_display_name}</strong> &nbsp; | &nbsp; <a href="${pageContext.servletContext.contextPath}/user/logout.htm" class="logoutLink">Logout</a></p>
    <p class="lastLogin">Last Login: ${sessionScope.user_last_login}</p>
    
    <p class="lastLogin">User TYpe: ${sessionScope.user_type}</p>
    </span>
    