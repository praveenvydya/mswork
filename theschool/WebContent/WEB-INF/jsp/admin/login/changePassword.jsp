<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.vydya.theschool.web.constants.WebConstants" %> 
<script type="text/javascript">

  
    function refreshCaptcha(){
		document.getElementById("imagecpt").src="${pageContext.servletContext.contextPath}/captcha";
		document.getElementById("captcha").value="";
	}

   
    $("#tip-image").live("mouseover",function(){
    		var imagePos =  $("#tip-image").offset();
    		var tipLeft = imagePos.left + $("#tip-image").outerWidth();
    		var tipTop = imagePos.top + $("#tip-image").outerHeight();
    		$("#tip").show();
    		$("#tip").css({"position":"absolute","top":tipTop+"px","left":tipLeft+"px"});
    	});
    	$("#tip-image").live("mouseout",function(){
    		$("#tip").hide();
    	});
</script>
<body onload="javascript:refreshCaptcha()">  
<div id="primary" class="form-area">
	<form:form method="POST" commandName="credentials" class="screenf content-form">
		<div id=" ">
		<div class="alertMsg">
			<form:errors path="error" cssClass="errormsg"/>
		</div>
		<div class="loginBreadcrums"><a href="${pageContext.servletContext.contextPath}/<%=WebConstants.LOGIN_ACTION%>" class="breadcrumLink">Login</a>&nbsp;<span style="color:#fff;">&#187;</span>&nbsp;<span class="breadcrumText">Change Password</span></div>
			<span class="spacer">&nbsp;</span>
		<table border="0" cellspacing="0" cellpadding="2" id="sectionsTable" class="logins-trans">
			<thead>
			<tr>
				<th width="" colspan="2"><span class="title">Change Password</span></th>
		</tr></thead>
		<tbody>
					<tr>
                        <td>User Name:<span class="mandatory">*</span></td>
                        <td  >
                        <form:input maxlength="200"path="userName" cssClass="" />
                        <form:errors path="userName" cssClass="errormsg"/>
						</td>
                      </tr>
                      
                      <tr>
                        <td>Old Password:<span class="mandatory">*</span> </td>
                        <td ><form:password maxlength="200"path="password" cssClass="" />
                        <form:errors path="password" cssClass="errormsg"/>
                        </td>
                      </tr>
                      <tr>
                        <td>New Password:<span class="mandatory">*</span> </td>
                        <td ><form:password maxlength="200"path="newPassword" cssClass="" />
                        <img src="<spring:message code="static.application.name"/>images/q_mark.gif" width="16" height="16" id="tip-image"/><form:errors path="newPassword" cssClass="errormsg"/>
						</td>
                      </tr>
                      <tr>
                        <td>Confirm Password:<span class="mandatory">*</span> </td>
                        <td ><form:password maxlength="200" path="confirmPassword" id="confirmPassword" name="confirmPassword" class="" />
                        <form:errors path="confirmPassword" cssClass="errormsg" />
                        </td>
                      </tr>
                      
                      <%-- <tr>
                        <td colspan="3"><img src="<spring:message code="static.application.name"/>images/spacer.gif" width="1" height="5" /></td>
                      </tr> --%>
                      <tr>
                     	 <td>&nbsp;</td>
                        <td  style="text-align: left;">Please enter the characters shown in the image below :<span class="mandatory">*</span>&#13;</td>
                      </tr>
                      <tr>
                        <td>&nbsp;</td>
                        <td>
                        <form:input maxlength="20" path="captcha" cssClass="" /><img  src="" id="imagecpt" alt="CAPTCHA IMAGE Code" title="CAPTCHA Code" />
                        <form:errors path="captcha" cssClass="errormsg"/>
                        </td>
                      </tr>
                     
                      <tr>
                        <td>&nbsp;</td>
                        <td align="left" class="noRightPadding">
                        <input type="submit" class="cms-btn" id="submitBttn" title="Submit" value="Submit" />
                           <input name="button" type="reset" class="cms-btn" value="Reset"/>
                          <input class="cms-btn" id="cancelBttn" title="Cancel" value="Cancel" type="button" onclick="location.href='${pageContext.servletContext.contextPath}/<%=WebConstants.LOGIN_ACTION%>'"/>
                          
                           </td> 
                      </tr>
                     <%--  <tr>
                        <td colspan="3"><img src="<spring:message code="static.application.name"/>images/spacer.gif" width="1" height="5" /></td>
                      </tr>
                      <tr>
                        <td colspan="3"><img src="<spring:message code="static.application.name"/>images/spacer.gif" width="1" height="5" /></td>
                      </tr> --%>
                      </tbody>
                    </table>
		<%-- <div class="userScenarioBox_bg">
			<div class="fieldArea">
				<span class="title">Change Password</span>
				<span class="spacer">&nbsp;</span>
				<div class="userInfo">				
				  <table width="100%" border="0" cellspacing="0" cellpadding="4">
                      <tr>
                        <td width="27%">User Name:<span class="mandatory">*</span></td>
                        <td width="66%" align="right">
                        <form:input maxlength="200"path="userName" cssClass="userInfoTextBox" />
                        <form:errors path="userName" cssClass="errormsg"/>
						</td>
                        <td width="7%">&nbsp;</td>
                      </tr>
                      
                      <tr>
                        <td>Old Password:<span class="mandatory">*</span> </td>
                        <td><form:password maxlength="200"path="password" cssClass="userInfoTextBox" />
                        <form:errors path="password" cssClass="errormsg"/>
                        </td>
                        <td>&nbsp;</td>
                      </tr>
                      <tr>
                        <td>New Password:<span class="mandatory">*</span> </td>
                        <td><form:password maxlength="200"path="newPassword" cssClass="userInfoTextBox" />
                        <form:errors path="newPassword" cssClass="errormsg"/>
                       

                        </td>
                        <td valign="middle"><div id="tip-image" style="vertical-align:middle;">
                        <img src="<spring:message code="static.application.name"/>images/q_mark.gif" width="16" height="16" />
                        </div>
						</td>
                      </tr>
                      <tr>
                        <td>Confirm Password:<span class="mandatory">*</span> </td>
                        <td><form:password maxlength="200" path="confirmPassword" id="confirmPassword" name="confirmPassword" class="userInfoTextBox" />
                        <form:errors path="confirmPassword" cssClass="errormsg" />
                        </td>
                        <td>&nbsp;</td>
                      </tr>
                      
                      <tr>
                        <td colspan="3"><img src="<spring:message code="static.application.name"/>images/spacer.gif" width="1" height="5" /></td>
                      </tr>
                      <tr>
                        <td colspan="3">Please enter the characters shown in the image below :<span class="mandatory">*</span>&#13;</td>
                      </tr>
                      <tr>
                        <td>&nbsp;</td>
                        <td><img width="100" height="40" src="" id="imagecpt" alt="CAPTCHA IMAGE Code" title="CAPTCHA Code" /></td>
                        <td>&nbsp;</td>
                      </tr>
                      <tr>
                        <td>&nbsp;</td>
                        <td>
                        <form:input maxlength="20" path="captcha" cssClass="userInfoTextBox" />
                        <form:errors path="captcha" cssClass="errormsg"/>
                        </td>
                        <td>&nbsp;</td>
                      </tr>
                     
                      <tr>
                        <td>&nbsp;</td>
                        <td align="right" class="noRightPadding">
                        <input value="" type="submit" class="userInfoSubmitBttn" />
                           <input name="button" type="reset" value="" class="userInforesetBttn"/>
                          <input class="userInfoCancelBttn" type="button" onclick="location.href='${pageContext.servletContext.contextPath}/<%=WebConstants.LOGIN_ACTION%>'"/>
                           </td> 
                        <td>&nbsp;</td>
                      </tr>
                      <tr>
                        <td colspan="3"><img src="<spring:message code="static.application.name"/>images/spacer.gif" width="1" height="5" /></td>
                      </tr>
                      <tr>
                        <td colspan="3"><img src="<spring:message code="static.application.name"/>images/spacer.gif" width="1" height="5" /></td>
                      </tr>
                    </table>
                    
				</div>
			</div>
		</div> --%>
	</div>
	
</form:form></div>
</body>


<div>





</div>
	
		<div id="tip" class = "helpText"  style="display: none;">
        	<spring:message code="password.rules.help.tip" /> 
		</div>