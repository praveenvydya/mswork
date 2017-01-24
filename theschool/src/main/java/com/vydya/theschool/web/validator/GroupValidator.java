
package com.vydya.theschool.web.validator;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.vydya.theschool.common.constants.ErrorConstants;
import com.vydya.theschool.common.dto.Group;

//@Component
public class GroupValidator  implements Validator{
	
	private static final Logger logger = Logger.getLogger(GroupValidator.class.getName());
	@Override
	public boolean supports(Class clazz) {
		return Group.class.isAssignableFrom(clazz);

	}

	@Override
	public void validate(Object target, Errors errors) {
		Group group= (Group)target;
		if(ValidatorUtil.rejectIfEmptyOrWhitespace(group.getGroupName())){
			errors.rejectValue("groupName", ErrorConstants.TS_3011);
			return;
		}
		if(ValidatorUtil.rejectIfNotAlphaNumericSpace(group.getGroupName())){
			errors.rejectValue("groupName", ErrorConstants.TS_3018);
			return;
		}
		logger.debug("Calling manual validation method if merchant checked");
		if((null != group)&&(null != group.getMerchantIdChecked()))
		{
			logger.debug("If merchant checked");
			if(ValidatorUtil.rejectIfEmptyOrWhitespace(group.getMerchantId()))	{		
			errors.rejectValue("merchantId", ErrorConstants.TS_3012);
			return;
			}
			else if(ValidatorUtil.rejectIfEmptyOrWhitespace(group.getPayeeId())){			
			errors.rejectValue("payeeId", ErrorConstants.TS_3013);
			return;
			}
		}
			
	}
}