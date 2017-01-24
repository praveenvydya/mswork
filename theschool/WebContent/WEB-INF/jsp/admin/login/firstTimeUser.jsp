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

<div class="lc-block toggled">

	<form:form method="POST" commandName="credentials" class="form-horizontal ng-pristine ng-valid" role="form">
        
            <div class="card-header">
                <h2>First Time Login </h2>
            </div>
			<div class="card-sub-header">
                <div class="loginBreadcrums"><a href="${pageContext.servletContext.contextPath}<%=WebConstants.LOGIN_ACTION%>" class="breadcrumLink">Login</a>&nbsp;<span style="color:#fff;">&#187;</span>&nbsp;<span class="breadcrumText">First time user login </span></div>
    
            </div>

            <div class="card-body card-padding">
                <div class="form-group">
                    <label for="username" class="col-sm-2 control-label">User Name</label>
                    <div class="col-sm-10">
                        <div class="fg-line">
						<form:input maxlength="200" path="userName" cssClass="form-control input-sm" placeholder="Enter User Name"/>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label for="password" class="col-sm-2 control-label">Old Password</label>
                    <div class="col-sm-10">

                        <div class="fg-line">
						<form:password maxlength="200" path="Password" cssClass="form-control input-sm" placeholder="Old Password"/>
                           
                        </div>
                    </div>
                </div>
				
				<div class="form-group">
                    <label for="newPassword" class="col-sm-2 control-label">New Password</label>
                    <div class="col-sm-10">

                        <div class="fg-line">
						<form:password maxlength="200" path="newPassword" cssClass="form-control input-sm" placeholder="New Password"/>
                           
                          
                        </div>
                    </div>
                </div>
				
				<div class="form-group">
                    <label for="confirmPassword" class="col-sm-2 control-label">Confirm Password</label>
                    <div class="col-sm-10">

                        <div class="fg-line">
						<form:password maxlength="200" path="confirmPassword" cssClass="form-control input-sm" placeholder="Confirm Password"/>
                           
                           
                        </div>
                    </div>
                </div>
				
				<div class="form-group">
                    <label for="confirmPassword" class="col-sm-2 control-label">Security Question</label>
                    <div class="col-sm-10">

						<div class="fg-line">
						 <form:input maxlength="200" path="securityQuestion" cssClass="form-control input-sm" placeholder="Security Question"/>
                        </div>
                    </div>
                </div>
				
				<div class="form-group">
                    <label for="confirmPassword" class="col-sm-2 control-label">Security Answer</label>
                    <div class="col-sm-10">

                        <div class="fg-line">
						 <form:input maxlength="200" path="securityAnswer" cssClass="form-control input-sm" placeholder="Security Answer"/>
                                                    
                        </div>
                    </div>
                </div>
				
				<div class="form-group">
				 <p>Please enter the characters shown in the image below :</p>
				 </div>
				
				<div class="form-group">
                    <label for="confirmPassword" class="col-sm-2 control-label">Captcha</label>
                    <div class="col-sm-10">

                        <div class="fg-line">
						<form:input maxlength="20" path="captcha" cssClass="form-control" /><img  src="" id="imagecpt" alt="CAPTCHA IMAGE Code" title="CAPTCHA Code" />
                                                    
                        </div>
                    </div>
                </div>
				
				<div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                        <input type="submit" class="btn btn-primary waves-effect" id="submitBttn" title="Submit" value="Submit" />
					   <input name="button" type="reset" class="btn btn-info waves-effect" value="Reset"/>
					  <input class="btn" id="cancelBttn" title="Cancel" value="Cancel" type="button" onclick="location.href='${pageContext.servletContext.contextPath}/<%=WebConstants.LOGIN_ACTION%>'"/>

                    </div>
                </div>
				
            </div>
        </form:form>
    </div>
</body>
		<div id="tip" style="width: 200px; background-color: #FEE741; display:none;">
			<spring:message code="password.rules.help.tip" />                        
		</div>