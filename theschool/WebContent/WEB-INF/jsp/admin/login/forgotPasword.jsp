<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.vydya.theschool.web.constants.WebConstants" %> 

<script>

function getSecurityQuestion(val)
{
	document.forgotPassword.action ="getSecurityQuestion.htm";
	document.getElementById("securityQuestion").value='';
	document.forgotPassword.submit();
}
function clickForgotPassword()
{
	document.forgotPassword.action ="forgotPassword.htm";
	
}
</script>

<div id="primary" class="form-area">
	<form:form name="forgotPassword" method="POST" commandName="credentials" class="screenf content-form">
	
	<div class="">
	<div class="alertMsg">
			<%-- <form:errors path="*" cssClass="errorblock" element="div"/> --%>
	</div>
		<div class="loginBreadcrums"><a href="${pageContext.servletContext.contextPath}<%=WebConstants.LOGIN_ACTION%>" class="breadcrumLink">Login</a>&nbsp;<span style="color:#fff;">&#187;</span>&nbsp;<span class="breadcrumText">Forgot Password</span></div>
		
				<span class="spacer">&nbsp;</span>
				  <table width="100%" border="0" cellspacing="0" cellpadding="2" id="sectionsTable" class="logins-trans ">
				  		<thead>
			<tr>
				<th width="" colspan="2"><span class="title">Forgot Password</span></th>
		</tr></thead>
		<tbody>
                      <tr>
                        <td>User Name:<span class="mandatory">*</span></td>
                        <td><form:input maxlength="200" path="userName" id="userName" cssClass="" onblur="getSecurityQuestion(this.value);"/></td>
                      </tr>
                      <tr>
                        <td colspan="2" class="bottomBorder"><form:errors path="userName" cssClass="errormsg"/><span class="errormsg" id="userNameError"></span></td>
                      </tr>
                      <tr>
                     	 <td><strong>Security Question:</strong></td>
                        <td>&nbsp;&nbsp;${credentials.securityQuestion}
                        <form:hidden path="securityQuestion"/>
                        </td>
                      </tr>
                      <tr>
                        <td><strong>Answer:</strong><span class="mandatory">*</span></td>
                        <td><form:password maxlength="200" path="securityAnswer" cssClass="" /></td>
                      </tr>
                      <tr><td>&nbsp;</td><td><form:errors path="securityAnswer" cssClass="errormsg"/></td>
                      <tr>
                        <td>&nbsp;</td>
                       <td align="left">
                        <input id="forgotSubmit"<c:if test="${empty credentials.securityQuestion}"> disabled='disabled'</c:if>  type="submit" onclick="clickForgotPassword()" class="cms-btn"  title="Submit" value="Submit" />
                         <input name="button" type="reset"  type="reset" class="cms-btn" value="Reset"/>
                        <input class="cms-btn" id="cancelBttn" title="Cancel" value="Cancel" type="button" onclick="location.href='${pageContext.servletContext.contextPath}/<%=WebConstants.LOGIN_ACTION%>'"/>
                         </td>
                      </tr></tbody>
                    </table>
				</div>
	</form:form>
</div>