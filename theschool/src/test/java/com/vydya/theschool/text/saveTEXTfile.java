package com.vydya.theschool.text;

import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.Writer;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.io.FileUtils;

public class saveTEXTfile {

	 public static void main(String [] args) throws Exception
	   { 
		Long ln=	System.currentTimeMillis();
		// saveSample();
		 //saveSample2();
		 saveSample3();
	//	readTextFile();
		//readImageFromTextFile();
		 System.out.println("Done!!");
		 System.out.println(System.currentTimeMillis()-ln);
	   }


	private static void saveSample() throws IOException {

		//File file = new File("C:/xmls/leftMenu.xml");
		String fileName = "C:/Temp/text/sample.txt";
		Writer out = new BufferedWriter(new OutputStreamWriter(
			    new FileOutputStream(fileName), "UTF-8"));
			try {
			    out.write("Hi sample text");
			} finally {
			    out.close();
			}
	}

	private static void saveSample2() throws IOException {

		File file = new File("C:/Temp/text/sample2.txt");
		 file.setWritable(false);
		//File f = new File("output.txt"); 
		FileUtils.writeStringToFile(file, "hello hi sample2", "UTF-8");
	}
	
	
	private static void saveSample3() throws Exception {

		//File file = new File("C:/xmls/leftMenu.xml");
		String shanghai = "\u4E0A\u6D77";  
		byte[] out = UnicodeUtil.convert(shanghai.getBytes("UTF-16"), "UTF-8"); //Shanghai in Chinese  
		FileOutputStream fos = new FileOutputStream("C:/Temp/text/sample3.txt");  
		fos.write(out);  
		fos.close();
	}
	
	private static void readTextFile(){
		BufferedReader br = null;
		try {
			String sCurrentLine;
			StringBuffer bf = new StringBuffer();
			br = new BufferedReader(new FileReader("C:/Temp/text/sample3.txt"));
			while ((sCurrentLine = br.readLine()) != null) {
				//System.out.println(sCurrentLine);
				bf.append(sCurrentLine);
			}
			
			/*FileOutputStream writer = new FileOutputStream("file.txt");
			
			writer.write((new String()).getbytes());
			writer.close();*/
			
			File file = new File("C:/Temp/text/sampleHtml3.html");
			
			file.setWritable(true);
			FileUtils.writeStringToFile(file, bf.toString(), "UTF-8");
			file.setWritable(false);
			
			//System.out.println(bl);
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				if (br != null)br.close();
			} catch (IOException ex) {
				ex.printStackTrace();
			}
		}
	}
	
	private static void readImageFromTextFile(){
		BufferedReader br = null;
		try {
			String sCurrentLine;
			StringBuffer bf = new StringBuffer();
			br = new BufferedReader(new FileReader("C:/Temp/text/image2.txt"));
			while ((sCurrentLine = br.readLine()) != null) {
				//System.out.println(sCurrentLine);
				bf.append(sCurrentLine);
			}
			String path = "C:/Temp/text/image2.jpeg";
			String strImage = bf.toString();
			
			String ne = strImage.substring(strImage.indexOf("base64,")+7);
			
			byte[] bytes =  Base64.decodeBase64(ne);
			save(path, bytes);
			
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				if (br != null)br.close();
			} catch (IOException ex) {
				ex.printStackTrace();
			}
		}
	}
	
	private static void save(String path, byte[] bytes) throws IOException{
		OutputStream out = null; 

		String folder = path.substring(0, path.lastIndexOf("/"));
		
		File f = new File(folder);
		if(!f.exists()){
			f.mkdirs();
		}
		try {
		     out = new BufferedOutputStream(new FileOutputStream(path));
		    out.write(bytes);
		
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
		    if (out != null) out.close();
		}
	}

}