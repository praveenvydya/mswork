package com.vydya.theschool.web.validator;

import org.apache.log4j.Logger;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.vydya.theschool.common.constants.ErrorConstants;
import com.vydya.theschool.common.dto.Role;

public class RoleValidator  implements Validator{
	private static final Logger logger = Logger.getLogger(RoleValidator.class.getName());
	@Override
	public boolean supports(@SuppressWarnings("rawtypes") Class clazz) {
		return Role.class.isAssignableFrom(clazz);

	}

	@Override
	public void validate(Object target, Errors errors) {
		Role role= (Role)target;
		if(ValidatorUtil.rejectIfEmptyOrWhitespace(role.getRoleName())){
			errors.rejectValue("roleName", ErrorConstants.TS_4011);
			return;
		}
		if(ValidatorUtil.rejectIfNotAlphaNumericSpace(role.getRoleName())){
			errors.rejectValue("roleName", ErrorConstants.TS_4018);
			return;
		}
		if(ValidatorUtil.rejectIfEmptyIndex(role.getRoleType())){
			errors.rejectValue("roleType", ErrorConstants.TS_4022);
			return;
		}
		if(null ==  role.getSelectedActions())
		{
			errors.rejectValue("selectedActions", ErrorConstants.TS_4025);
			return;
		}
		///*if(role.getSelectedActions().length <= 0){
		//	errors.rejectValue("selectedActions", ErrorConstants.TS_4021);
		//	return;
		//}*/
		
		
		logger.debug("Passed successfully validator");			
	}
	
}