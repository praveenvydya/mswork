package com.vydya.theschool.web.validator;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.vydya.theschool.common.constants.ErrorConstants;
import com.vydya.theschool.common.dto.Section;

public class SectionValidator implements Validator{

	@Override
	public boolean supports(Class clazz) {
		//just validate the Customer instances
		return Section.class.isAssignableFrom(clazz);

	}

	@Override
	public void validate(Object target, Errors errors) {
		
		Section section = (Section)target;
		if(ValidatorUtil.rejectIfEmptyOrWhitespace(section.getSectionName()))
		{
		errors.rejectValue("sectionName",ErrorConstants.TS_2011);
		return;
		}
		if(ValidatorUtil.rejectIfNotAlphaNumericSpace(section.getSectionName())){
			errors.rejectValue("sectionName", ErrorConstants.TS_2017);
			return;
		}
	}
	
}