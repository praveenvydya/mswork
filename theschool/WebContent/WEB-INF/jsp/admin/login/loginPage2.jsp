<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<form:form method="POST" commandName="credentials" autocomplete="off">
	<div class="alertMsg">
		<form:errors path="error" cssClass="errorblock" element="div" />
	</div>

	<div id="">
		<c:if test='${null!=success_key }'>
			<div class="successMsg">
				<spring:message code="${success_key}" />
			</div>
			<c:remove scope="session" var="success_key" />
		</c:if>
		<div class="welcomeText"></div>
		<div class="spaceHolder">
			<ul>
				<li>hello 1</li>
				<li>message two</li>
			</ul>
		</div>
	</div>

	<div id="primary" class="form-area">
		<div id="layer-box" class="content-form logins-trans">
			<h2 class="page-title">
				<span class="header-login"> <span class="sp">Admin
						Login </span>
				</span>
			</h2>
			<div class="content-box">
				<div id="">
					<a name="login"></a>
					<fieldset>
						<!-- <legend>Existing Users Log In</legend> -->
						<label for="log">Username</label>
						<div class="div_text">
							<form:input maxlength="200" path="userName" cssClass=""
								placeholder="Username" />
						</div>
						<div>
							<form:errors path="userName" cssClass="error" />
						</div>
						<label for="pwd">Password</label>
						<div class="div_text">
							<form:password maxlength="200" path="password" cssClass=""
								placeholder="Password" />
						</div>
						<div>
							<form:errors path="password" cssClass="error" />
						</div>
						<input name="redirect_to" type="hidden"
							value="http://chirec.ac.in/index.php/staff-login/"><input
							name="a" type="hidden" value="login">
						<div class="button_div">
							<input type="submit" value="Log In" class="cms-btn" />
						</div>
						<div align="right" class="link-text">
							<span class="forgotPswd"><a
								href="${pageContext.servletContext.contextPath}/admin/loginModule/forgotPassword.htm"
								class="loginLink">Forgot Password ?</a></span> <span class="changePswd"><a
								href="${pageContext.servletContext.contextPath}/admin/loginModule/changePassword.htm"
								class="loginLink">Change Password ?</a></span>

						</div>
					</fieldset>
				</div>
			</div>
		</div>
	</div>



</form:form>
