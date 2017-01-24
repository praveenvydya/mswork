package com.vydya.theschool.web.utils;

import java.io.BufferedOutputStream;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.sql.Blob;
import java.sql.SQLException;

import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;

import com.vydya.theschool.common.constants.ErrorConstants;
import com.vydya.theschool.common.constants.TSConstants;
import com.vydya.theschool.common.dto.CmsFile;
import com.vydya.theschool.common.exceptions.ServiceException;
import com.vydya.theschool.services.spring.common.SchoolAdminProperties;

public class SchoolFilesHelper {
	
	//@Autowired
	//private CMSFilesUtilityService cmsFilesUtilityService;
	
	@Autowired
	private SchoolAdminProperties schoolProperties;
	
	public String uploadFile(byte[] content){
		return "";
	}

	private final static Logger logger = Logger.getLogger(SchoolFilesHelper.class.getName());
	//private static final int DEFAULT_BUFFER_SIZE = 1048576;
	
	/**
	 * This method is used to download file with respective id and type
	 * 
	 * @param id , type,response
	 * @return 
	 */
	public void downloadFile(Integer id, HttpServletResponse response,String type) throws ServiceException, IOException {

		CmsFile content = null;
		/*try {
			//content = cmsFilesUtilityService.getFileById(id,type);
		} catch (ServiceException exp) {
			
			throw exp;
		}*/
		String filename = content.getFileName();
		Integer fileid = content.getFileId();
		if(null == filename){
			filename = content.getName()+".xsl";
		}
		
			
				if(filename.endsWith(".xls") || filename.endsWith(".csv")) {
					OutputStream out = null;
					InputStream input = null;
					try {
						response.setContentType("application/vnd.ms-excel");
						response.setHeader("Content-Disposition", "filename="+filename);
						out = response.getOutputStream();
						HSSFWorkbook wb = new HSSFWorkbook(new ByteArrayInputStream(content.getFileContent().getBytes()));
						wb.write(out);
		
					} catch (Exception e) {
						logger.error("Unable to retrive file content: filename="+filename+", fileid="+fileid, e);
						throw new IOException("Unable to retrive file content: filename="+filename+", fileid="+fileid+". " + e);
					} finally {
						if(input!=null) input.close();
						if(out!=null) out.close();
					}
				} else if (filename.endsWith(".jpeg") || filename.endsWith(".gif")||filename.endsWith(".jpg")){
					PrintWriter writer = null;
					InputStream sImage = null;
					BufferedOutputStream out = new BufferedOutputStream( response.getOutputStream() );
					try {
						
						byte[] imageBytes = content.getImageContent();
						response.setContentType("image/jpeg");
						response.setHeader("Content-Type", "image/jpeg");
						response.setHeader("Content-Disposition","attachment;filename=\""+filename+"\"");
						sImage = new ByteArrayInputStream(imageBytes);
						//THIS IS WORKING 
						/*byte[] bytearray = new byte[1048576];
						int size=0;
						while((size=sImage.read(bytearray))!= -1 ){
						response.getOutputStream().
						write(bytearray,0,size);
						}*/
						
						//THIS IS ALSO WORKING
						/* byte by[] = new byte[ 32768 ];
					      int index = sImage.read( by, 0, 32768 );
					      while ( index != -1 )
					      {
					        out.write( by, 0, index );
					        index = sImage.read( by, 0, 32768 );
					      }
					      out.flush();*/
					      
					      byte[] buffer = new byte[1048576];
					      int length;
					      while ((length = sImage.read(buffer)) > 0) {
					          out.write(buffer, 0, length);
					      }

						
					} catch (Exception e) {
						logger.error("Unable to retrive file content: filename="+filename+", fileid="+fileid, e);
						throw new IOException("Unable to retrive file content: filename="+filename+", fileid="+fileid+". " + e);
					} finally {
						if(writer!=null) writer.close();
						if(sImage!=null) sImage.close();
						if(out!=null) out.close();
					}
				}
				else {
					PrintWriter writer = null;
					InputStream input = null;
				
					try {
						response.setContentType("text/plain");
						response.setHeader("Expires", "0");					
						response.setHeader("Content-Type", "text/plain");
						response.setHeader("Content-Disposition","attachment;filename=\""+filename+"\"");
						writer = response.getWriter();
										
						writer.write(content.getFileContent());
											
						
					} catch (Exception e) {
						logger.error("Unable to retrive file content: filename="+filename+", fileid="+fileid, e);
						throw new IOException("Unable to retrive file content: filename="+filename+", fileid="+fileid+". " + e);
					} finally {
						if(writer!=null) writer.close();
						if(input!=null) input.close();
					}
				}
	}
	
	/**
	 * This method is used to validate filename and size which is being uploaded
	 * and returns empty if success and returns respective error code if any error occurs
	 * @param fileName , fileSize
	 * @return string
	 */
	public String isValidFile(String fileName, long fileSize)throws ServiceException{
        
		try{
		if(schoolProperties.getMaxFileUploadSize() != null) {	
        if(fileSize> Integer.parseInt(schoolProperties.getMaxFileUploadSize())){
              return ErrorConstants.TS_9040;
         }
		}
        if(null != fileName){
        String fileFormats  = schoolProperties.getFileUploadFormats();
        String formats[] = fileFormats.split(",");
        for(String format : formats){
              if(fileName.endsWith(format)){
                    return TSConstants.EMPTY;
                    }
              }
        }
        return ErrorConstants.TS_9041;
		}
		 catch (Exception exp) {
				
				throw new  ServiceException(ErrorConstants.TS_9047,  exp.getMessage());
			}
  }
	/*public List<ReferenceData> IsValidServerStatus(List<ReferenceData> cmsStatusList)
	{        
        
        if(null != cmsStatusList){        	
        String cmsServerStatus  = schoolProperties.getCmsServerStatus();
        if(cmsServerStatus != null && !cmsServerStatus.equals("T"))
        {
        	List<ReferenceData> updatedCmsStatusList = new ArrayList<ReferenceData>();
        	for(ReferenceData cmsStatus : cmsStatusList)
			{
				if(!"prod".equalsIgnoreCase(cmsStatus.getDescription())){
					updatedCmsStatusList.add(cmsStatus);
				}
			}
        	return updatedCmsStatusList;
        	
        }      
        
        }
        return cmsStatusList;
	}*/
	
	private byte[] toByteArray(Blob fromImageBlob) {
	    ByteArrayOutputStream baos = new ByteArrayOutputStream();
	    try {
	      return toByteArrayImpl(fromImageBlob, baos);
	    } catch (Exception e) {
	    }
	    return null;
	  }



	private byte[] toByteArrayImpl(Blob fromImageBlob, 
	      ByteArrayOutputStream baos) throws SQLException, IOException {
	    byte buf[] = new byte[4000];
	    int dataSize;
	    InputStream is = fromImageBlob.getBinaryStream(); 

	    try {
	      while((dataSize = is.read(buf)) != -1) {
	        baos.write(buf, 0, dataSize);
	      }    
	    } finally {
	      if(is != null) {
	        is.close();
	      }
	    }
	    return baos.toByteArray();
	  }
}
