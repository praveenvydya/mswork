package com.vydya.theschool.web.validator;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.vydya.theschool.common.constants.ErrorConstants;
import com.vydya.theschool.common.dto.User;

public class UserValidator  implements Validator{

	@Override
	public boolean supports(@SuppressWarnings("rawtypes") Class clazz) {
		return User.class.isAssignableFrom(clazz);

	}

	@Override
	public void validate(Object target, Errors errors) {

		User user = (User)target;
		if (ValidatorUtil.rejectIfEmptyOrWhitespace(user.getUserName()))
		{
			errors.rejectValue("userName", ErrorConstants.TS_5001);
			return;
		}
		else
		if(ValidatorUtil.rejectIfNotAlphaNumericUserName(user.getUserName())){
			errors.rejectValue("userName", ErrorConstants.TS_5002);
			return;
		}
		else
		if (ValidatorUtil.rejectIfEmptyIndex(user.getGroup()))
		{
			errors.rejectValue("group", ErrorConstants.TS_5003);
			return;
		}
		else
		if (ValidatorUtil.rejectIfEmptyIndex(user.getUserRole()))
		{
			errors.rejectValue("userRole", ErrorConstants.TS_5005);
			return;
		}
		else 
		if (ValidatorUtil.rejectIfEmptyOrWhitespace(user.getFirstName()))
		{
			errors.rejectValue("firstName", ErrorConstants.TS_5006);
			return;
		}
		else
		if (ValidatorUtil.rejectIfEmptyOrWhitespace(user.getLastName()))
		{
			errors.rejectValue("lastName", ErrorConstants.TS_5007);
			return;
		}
		else
		if (ValidatorUtil.rejectIfEmailInvalid(user.getEmail()))
		{
			errors.rejectValue("email", ErrorConstants.TS_5008);
			return;
		}
	}
}