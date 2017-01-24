package com.vydya.theschool.web.captcha;

import java.awt.image.BufferedImage;
import java.io.Serializable;

import com.octo.captcha.image.ImageCaptcha;

/*
 * @author Sridhar
 * Created on August 25, 2012
 * This file will be used for calling Captcha Image code
*/

/**
 * The Class WUGimpy.
 */
public class DefaultImageCaptcha extends ImageCaptcha implements Serializable {
	
	/** The Constant serialVersionUID. */
	private static final long	serialVersionUID	= -7431149895972865218L;
	
	/** The response. */
	private String response;
	
	/**
	 * Instantiates a new wU gimpy.
	 *
	 * @param question the question
	 * @param challenge the challenge
	 * @param response the response
	 */
	public DefaultImageCaptcha(String question, BufferedImage challenge, String response) {
		super(question, challenge);
		this.response = response;
	}

	/* (non-Javadoc)
	 * @see com.octo.captcha.Captcha#validateResponse(java.lang.Object)
	 */
	public final Boolean validateResponse(Object response) {
		return null == response || !(response instanceof String) ? Boolean.FALSE
				: validateResponse((String) response);
	}

	/**
	 * Validate response.
	 *
	 * @param response the response
	 * @return the boolean
	 */
	private final Boolean validateResponse(String response) {
		return Boolean.valueOf(response.equals(this.response));
	}

	/**
	 * Gets the captcha text.
	 *
	 * @return the captcha text
	 */
	public final String getCaptchaText() {
		return response;
	}


}