/*
 * @author Sridhar
 * Created on August 25, 2012
 * For generating captcha image
*/
package com.vydya.theschool.web.captcha;

import java.awt.Color;
import java.awt.Font;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.lang.reflect.Field;
import java.security.SecureRandom;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Locale;
import java.util.Random;
import java.util.StringTokenizer;

import javax.imageio.ImageIO;

import org.apache.log4j.Logger;

import com.octo.captcha.CaptchaException;
import com.octo.captcha.CaptchaQuestionHelper;
import com.octo.captcha.component.image.backgroundgenerator.BackgroundGenerator;
import com.octo.captcha.component.image.backgroundgenerator.GradientBackgroundGenerator;
import com.octo.captcha.component.image.fontgenerator.FontGenerator;
import com.octo.captcha.component.image.fontgenerator.RandomFontGenerator;
import com.octo.captcha.component.image.textpaster.NonLinearTextPaster;
import com.octo.captcha.component.image.textpaster.TextPaster;
import com.octo.captcha.component.image.wordtoimage.ComposedWordToImage;
import com.octo.captcha.component.image.wordtoimage.WordToImage;
import com.octo.captcha.component.word.wordgenerator.RandomWordGenerator;
import com.octo.captcha.component.word.wordgenerator.WordGenerator;
import com.octo.captcha.image.gimpy.Gimpy;

public class CaptchaImage 
{
	private static Logger logger = Logger.getLogger(CaptchaImage.class.getName());
	/* This piece of code/main method is not removed to make this file a 
	 * standalone whenever needed 
	 */
	public static void main(String[] args)
	{
				//generateCaptcha();
	}
	public  void generateCaptcha()
	{
		try
		{
			
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd_HH-mm-ss");
		FileOutputStream fileO = new FileOutputStream(new File("D:/CaptchaImageTest" + fmt.format(cal.getTime()) + ".jpg"));
		String capText = getText();
		writeCaptchaImage(fileO, capText);
		fileO.flush();
		fileO.close();
		fileO = null;
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	
	private String captchaText;
	public String getCaptchaText() {
		return captchaText;
	}
	public  void  setCaptchaText(String captchaText) {
		this.captchaText = captchaText;
	}
	private static WordGenerator wordGenerator;
	private static Random myRandom;
	
	public byte[] createJPEG() throws Exception
	{
		ByteArrayOutputStream imageOut = new ByteArrayOutputStream();
		String capText = getText();
		writeCaptchaImage(imageOut, capText);
		return imageOut.toByteArray();
	}
	private   void writeCaptchaImage(OutputStream o, String capText) throws IOException
	{
		createImage(o, capText);
		o.flush();
	}
	
	private  void createImage(OutputStream stream, String text) throws IOException
	{
        BufferedImage image = null;
        try {
        	
        	wordGenerator = new RandomWordGenerator(CaptchaConstants.SIMPLE_CAPTCHA_TEXTPRODUCER_CHARR);
        	
        	FontGenerator fontGenerator =
    			new RandomFontGenerator(
    					new Integer( 16),
    					new Integer(16),
    					getFonts());
        	BackgroundGenerator backgroundGenerator =
    			new GradientBackgroundGenerator(
    					new Integer(120), 
    					new Integer(35),
    					getColor(CaptchaConstants.SIMPLE_CAPTCHA_BCKGRND_CLR_FRM, Color.WHITE),
    					getColor(CaptchaConstants.SIMPLE_CAPTCHA_BCKGRND_CLR_T, Color.LIGHT_GRAY));

    		//int captchaLength = getIntegerFromString(CaptchaConstants.SIMPLE_CAPTCHA_TEXTPRODUCER_CHARRL);
    		TextPaster textPaster =
    			new NonLinearTextPaster(
    					new Integer( 6 ), 
    					new Integer( 6 ),
    					getColor(CaptchaConstants.SIMPLE_CAPTCHA_TEXTPRODUCER_FONTC, Color.BLACK) );
    		
    		
        	WordToImage wordToImage = new ComposedWordToImage(fontGenerator, backgroundGenerator, textPaster );
        	myRandom = new SecureRandom();
           // image = wordToImage.getImage(createText(wordToImage));
        	setCaptchaText(text);
        	image = wordToImage.getImage(text);
        String BUNDLE_QUESTION_KEY = (Gimpy.class).getName();
        DefaultImageCaptcha imageCaptcha = 
        	new DefaultImageCaptcha(CaptchaQuestionHelper.getQuestion(Locale.getDefault(), BUNDLE_QUESTION_KEY), image, text);
		
        BufferedImage bi = imageCaptcha.getImageChallenge();

        ImageIO.write(bi, "jpeg", stream);
        } catch(Throwable e) {
            throw new CaptchaException(e);
        }
	}
	
	public static String getText()
	{
		Random generator = new Random();
		int capLength = 6;
		char[] captchars = new char[] { 'a', 'b', 'c', 'd', 'e', '2', '3', '4', '5', '6', '7', '8', 'g', 'f', 'y', 'n', 'm', 'n', 'p', 'w', 'x',
				
				 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U','V','W','X','Y','Z'};
		int car = captchars.length - 1;

		String capText = "";
		for (int i = 0; i < capLength; i++)
		{
			capText += captchars[generator.nextInt(car) + 1];
		}
		
		return capText;

	}
	
	private static Font[] getFonts()
	{
		 Font[] defaultFonts = new Font[] { new Font("Arial", Font.BOLD, 40), new Font("Courier", Font.BOLD, 40) };
		

		String fontArr = CaptchaConstants.SIMPLE_CAPTCHA_TEXTPRODUCER_FONTA;
		if(fontArr == null)
			return defaultFonts;
		int fontsize = getIntegerFromString(CaptchaConstants.SIMPLE_CAPTCHA_TEXTPRODUCER_FONTS);
		if(fontsize < 8)
			fontsize = 40;
		int fontstyle = getIntegerFromString(CaptchaConstants.SIMPLE_CAPTCHA_TEXTPRODUCER_FONTT);
		Font[] fonts = null;
		try
		{

			StringTokenizer tokeniz = new StringTokenizer(fontArr, ",");
			fonts = new Font[tokeniz.countTokens()];
			int cnt = 0;
			while(tokeniz.hasMoreElements())
			{
				String fontStr = tokeniz.nextToken();
				Font itf = new Font(fontStr, fontstyle, fontsize);
				fonts[cnt] = itf;
				cnt++;
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}

		if(fonts == null)
		{
			return defaultFonts;
		}
		else
		{
			return fonts;
		}

	}
	
	private static int getIntegerFromString(String val)
	{
		int ret = 0;
		
		if(val == null || val.equals(""))
			return ret;

		try
		{
			ret = Integer.parseInt(val);
		}
		catch(Exception e)
		{
			logger.debug("Error while converting the integer from string");
		}
		return ret;
	}
	
	private static Color getColor(String color, Color defaultc)
	{

		Color retCol = null;

		
		try
		{
		
			if(color != null && !color.equals(""))
			{
				if(color.indexOf(",") > 0)
				{
					retCol = createColor(color);
				}
				else
				{
					Field field = Class.forName("java.awt.Color").getField(color);
					retCol = (Color)field.get(null);
				}

			}
		}
		catch(Exception e)
		{
			logger.debug("Error while getting the color");
		}

		if(retCol == null && defaultc == null)
		{
			retCol = Color.black;
		}
		else if(retCol == null)
		{
			retCol = defaultc;
		}

		return retCol;

	}
	private static Color createColor(String rgbalpha)
	{

		Color c = null;
		try
		{

			StringTokenizer tok = new StringTokenizer(rgbalpha, ",");
			if(tok.countTokens() < 3)
			{
				return null;
			}
			int r = Integer.parseInt((String)tok.nextElement());
			int g = Integer.parseInt((String)tok.nextElement());
			int b = Integer.parseInt((String)tok.nextElement());

			if(tok.countTokens() == 1)
			{
				int a = Integer.parseInt((String)tok.nextElement());
				c = new Color(r, g, b, a);
			}
			else
			{
				c = new Color(r, g, b);
			}

		}
		catch(Exception e)
		{
			logger.debug("Error while creating the color");
		}

		return c;

	}
	
	private String createText(WordToImage wordToImage)
	{
        //Integer wordLength = getRandomLength(wordToImage);
        String word = wordGenerator.getWord(6);
		setCaptchaText(word);
        return word;
	}

	
  

}
	
	
