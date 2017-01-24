package com.vydya.theschool.web.validator;

import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.vydya.theschool.common.constants.ErrorConstants;
import com.vydya.theschool.common.dto.UserCredentials;
import com.vydya.theschool.services.spring.common.SchoolAdminProperties;

public class LoginValidator  implements Validator{

	@Override
	public boolean supports(Class clazz) {
		//just validate the User Login instances
		return UserCredentials.class.isAssignableFrom(clazz);

	}
	@Autowired(required=true)
	public SchoolAdminProperties properties;

	@Override
	public void validate(Object target, Errors errors) {

		UserCredentials user = (UserCredentials)target;

		if (ValidatorUtil.rejectIfEmptyOrWhitespace(user.getUserName()))
		{
			errors.rejectValue("userName", ErrorConstants.TS_1021);
			return;
		}
		else
		if (ValidatorUtil.rejectIfEmptyOrWhitespace(user.getPassword()))
		{
			errors.rejectValue("password", ErrorConstants.TS_1022);
			return;
		}		
	}
	
	public void validateChangePassword(UserCredentials user, Errors errors,
			boolean isFirstTimeLogin,String sessionCaptcha) {
		Pattern pattern = Pattern.compile(properties.getPasswordRulesRegex());
		
		if (ValidatorUtil.rejectIfEmptyOrWhitespace(user.getUserName()))
		{
			errors.rejectValue("userName", ErrorConstants.TS_1021);
			return;
		}
		else
		if (ValidatorUtil.rejectIfEmptyOrWhitespace(user.getPassword()))
		{
			errors.rejectValue("password", ErrorConstants.TS_1022);
			return;
		}
		else
		if (ValidatorUtil.rejectIfEmptyOrWhitespace(user.getNewPassword()))
		{
			errors.rejectValue("newPassword", ErrorConstants.TS_1023);
			return;
		}
		else
		if (ValidatorUtil.rejectIfEqual(user.getPassword(), user.getNewPassword()))
		{
			errors.rejectValue("newPassword", ErrorConstants.TS_1017);
			return;
		}
		else
		if (ValidatorUtil.rejectIfPasswordInvalid(user.getNewPassword(),pattern))
		{
			errors.rejectValue("newPassword", ErrorConstants.TS_1029);
			return;
		}
		else
		if (ValidatorUtil.rejectIfEmptyOrWhitespace(user.getConfirmPassword()))
		{
			errors.rejectValue("confirmPassword", ErrorConstants.TS_1024);
			return;
		}
		else
		if (ValidatorUtil.rejectIfNotEqual(user.getNewPassword(),user.getConfirmPassword()))
		{
			errors.rejectValue("confirmPassword", ErrorConstants.TS_1025);
			return;
		}
		if(isFirstTimeLogin){
			if (ValidatorUtil.rejectIfEmptyOrWhitespace(user.getSecurityQuestion()))
			{
				errors.rejectValue("securityQuestion", ErrorConstants.TS_1026);
				return;
			}
			
			if (ValidatorUtil.rejectIfEmptyOrWhitespace(user.getSecurityAnswer()))
			{
				errors.rejectValue("securityAnswer", ErrorConstants.TS_1027);
				return;
			}
		}
		if(ValidatorUtil.rejectIfNotEqual(sessionCaptcha,user.getCaptcha()))
		{
			errors.rejectValue("captcha", ErrorConstants.TS_1028);
			return;
		}
		
	}	
}