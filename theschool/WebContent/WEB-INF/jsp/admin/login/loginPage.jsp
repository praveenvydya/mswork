<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<style>
.card {
  width: ;
 
}
</style>
<div id="loginContent">
	<form:form method="POST" commandName="credentials" autocomplete="off">
		<div class="alertMsg">
			<form:errors path="error" cssClass="errorblock" element="div"/>
		</div> 
		
		 <%-- <div class="login-card">
                        <div class="card-header">
                            <h2>Basic Example <small> 100%; by default. Wrap labels and controls in .form-group for optimum spacing.
</small></h2>
                        </div>
                        
                        <div class="card-body card-padding">
                            <form role="form">
                                <div class="form-group fg-line">
                                    <label for="exampleInputEmail1">Email address</label>
                                    <form:input maxlength="200" path="userName" cssClass="form-control input-sm" placeholder="User name"/>
                                </div>
                                <div class="form-group fg-line">
                                    <label for="exampleInputPassword1">Password</label>
                                    <form:password maxlength="200"path="password"  cssClass="form-control input-sm" id="" placeholder="Password"  />
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" value="">
                                        <i class="input-helper"></i>
                                        Don't forget to check me out
                                    </label>
                                </div>
                                
                                <button type="submit" class="btn btn-primary btn-sm m-t-10 waves-effect">Submit</button>
                            </form>
                        </div>
                    </div> --%>
                    
     <div class="lc-block toggled" id="l-login">
            <div class="input-group m-b-20">
                <span class="input-group-addon"><i class="zmdi zmdi-account"></i></span>
                <div class="fg-line">
                    <form:input  path="userName" type="text" class="form-control" placeholder="Username" autocomplete="off"/>
                </div>
            </div>
            
            <div class="input-group m-b-20">
                <span class="input-group-addon"><i class="zmdi zmdi-male"></i></span>
                <div class="fg-line">
                   <form:password maxlength="200" path="password" class="form-control" placeholder="Password" autocomplete="off"/>
                </div>
            </div>
            
            <div class="clearfix"></div>
            
            <div class="checkbox">
                <label>
                    <input type="checkbox" value="">
                    <i class="input-helper"></i>
                    Keep me signed in
                </label>
            </div>
            <div class="m-t-30">
            <button type="submit" class="btn btn-primary waves-effect">Submit</button>
            <span class="forgotPswd"><a href="${pageContext.servletContext.contextPath}/admin/loginModule/forgotPassword.htm" class="loginLink">Forgot Password ?</a></span>
        	</div>
        </div>               
                    
                    
		<%-- <div class="mainContent">
			<div id="leftContent">
			      <c:if test='${null!=success_key }'>
					<div class="successMsg"><spring:message code="${success_key}" /></div>
					<c:remove scope="session" var ="success_key"/>
				 </c:if>
				<div class="welcomeText"></div>
				<div class="spaceHolder">
					<ul>
						<li>hello 1</li>
						<li>message two</li>
					</ul>
				</div>
			</div>
			<div id="rightContent">
				<div class="loginBox">
					<div class="detailsTable">
					<table width="100%" border="0" align="center" cellpadding="2" cellspacing="0">
					  <tr>
						<td width="24%">&nbsp;</td>
						<td width="76%">&nbsp;</td>
					  </tr>
					  <tr>
						<td class="userDetails">User Name<span class="mandatory">*</span> </td>
						<td>
							<div class="textBoxdivx">
							  <form:input maxlength="200"path="userName" cssClass="" />
							</div>					</td>
					  </tr>
						<tr>
				    	<td>&nbsp;</td>
				    	<td class="errormsg">
							<form:errors path="userName" cssClass="error" />
						</td>
				      </tr>
					  <tr>
						<td class="userDetails">Password<span class="mandatory">*</span></td>
						<td>
							<div class="textBoxdivx">
							  <form:password maxlength="200"path="password"  cssClass=""  />
							</div>					</td>
					  </tr>
 					  <tr>
				    	<td>&nbsp;</td>
				    	<td class="errormsg">
							<form:errors path="password" cssClass="error" />
						</td>
				      </tr>
				  	  <tr>
						<td>&nbsp;</td>
						<td>
							<input type="submit" value="" class="loginBttn""/>
							<!-- <input type="reset" class="resetBttn" value=""/> -->					</td>
						</tr>
					  <tr>
						<td>&nbsp;</td>
						<td><span class="forgotPswd"><a href="${pageContext.servletContext.contextPath}/admin/loginModule/forgotPassword.htm" class="loginLink">Forgot Password ?</a></span>
							<span class="changePswd"><a href="${pageContext.servletContext.contextPath}/admin/loginModule/changePassword.htm" class="loginLink">Change Password ?</a></span></td>
						</tr>
				  </table>
					</div>
				</div>
			</div>
		</div> --%>
	</form:form>
</div>
