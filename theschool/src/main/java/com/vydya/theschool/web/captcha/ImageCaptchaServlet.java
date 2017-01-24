package com.vydya.theschool.web.captcha;

import org.apache.log4j.Logger;



/*
 * @author Sridhar
 * Created on August 25, 2012
*/
public class ImageCaptchaServlet extends CaptchaServlet {

	
	private static Logger log = Logger.getLogger(ImageCaptchaServlet.class.getName());
	
	private static final long serialVersionUID = 1L;

	protected String getType() {
		return "image";
	}

	protected String getContentType() {
		return "image/jpeg";
	}

	protected byte[] generate( CaptchaImage image ) throws Exception {
		log.debug("Calling generate in ImageCaptchaServlet");
		byte[] captcheaChallengeAsJpeg = null;
		captcheaChallengeAsJpeg = image.createJPEG();
		log.debug("captcheaChallengeAsJpeg" + captcheaChallengeAsJpeg.length);
		if (captcheaChallengeAsJpeg == null)
			throw new Exception("The CaptchaImage class did not return the image from createJPEG() method");
		else
			log.debug("captcheaChallengeAsJpeg success"); 
		return captcheaChallengeAsJpeg;
	}

}
