package com.vydya.theschool.web.utils;

import java.io.BufferedWriter;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;

import com.vydya.theschool.common.constants.ErrorConstants;
import com.vydya.theschool.common.exceptions.ServiceException;
import com.vydya.theschool.common.pagination.Exportable;
import com.vydya.theschool.common.pagination.PageNavigation;
import com.vydya.theschool.common.pagination.Pagination;
import com.vydya.theschool.services.spring.common.SchoolAdminProperties;
import com.vydya.theschool.web.validator.ValidatorUtil;

public final class DataExportWebUtil {

	private static final Logger logger = Logger.getLogger(DataExportWebUtil.class.getName());
	
	@Autowired
	private SchoolAdminProperties properties;
	
	public boolean isExportRequest(Pagination pageForm)
	{
		if (ValidatorUtil.rejectIfEmptyOrWhitespace(pageForm.getExportOption()))
		{
			return false;
		}
		return true;
	}
	
	
	public boolean isExportCurrentPage(Pagination pageForm)
	{
		if (pageForm.getExportOption() != null && "page".equals(pageForm.getExportOption())) 
		{			
			return true;			
		}
		return false;
	}
	

	/*@SuppressWarnings("unchecked")
	public List<?>  genarateExportData(Pagination pageForm,PaginationService paginationService,HttpServletResponse  response) throws ServiceException 
	{
		logger.debug("genarateExportData method invoked");		
		List<Exportable> entityList = null;
		if(isExportCurrentPage(pageForm))
		{
			PageNavigation pageNavigation = new PageNavigation(properties.getPageSize(),properties.getMaxIndices());
			pageNavigation.setTotalRows(pageForm.getTotalRows());
			pageNavigation.setCurrentPage(pageForm.getPageNo());
			int dbCurrentPageIndex = pageNavigation.getCurrentPage()-1;
			entityList = (List<Exportable>) paginationService.getEntitiesByCriteria(pageForm, dbCurrentPageIndex,pageNavigation.getPageSize());
		}
		else
		{
			entityList = (List<Exportable>) paginationService.getAllEntitiesByCriteria(pageForm);
		}
		exportToCSV(entityList,response);
		return entityList;
	}*/
	
	private void exportToCSV(List<Exportable> entityList,HttpServletResponse response) throws ServiceException 
	{
		BufferedWriter writer = null;
		try 
		{
			writer = new BufferedWriter(new OutputStreamWriter(response.getOutputStream(), "UTF-8"));			
			
			boolean isFirstRedord = true;
			for (Exportable dataRecord : entityList) 
			{
				if(isFirstRedord)
				{
					isFirstRedord =false;
					setResponseHeaderForDataExport(response,dataRecord.getReportName());
					writer.write(dataRecord.toFileHeader());
				}
				writer.write(dataRecord.toFileRecord());
				writer.newLine();
			}
			writer.flush();
			writer.close();
		}
		catch (UnsupportedEncodingException e) 
		{
			logger.error("UnsupportedEncodingException : while exporting data to file ",e);
			throw new ServiceException(ErrorConstants.TS_1004, e.getMessage());
		} catch (IOException e) 
		{
			logger.error("IOException : while exporting data to file ",e);
			throw new ServiceException(ErrorConstants.TS_1004, e.getMessage());
		}
		finally
		{
			if(null != writer){
				try 
				{
					writer.flush();
					writer.close();
				} catch (IOException e) {}
			}
		}
	}
	public  void setResponseHeaderForDataExport(HttpServletResponse response,String fileName)
	{
		response.setHeader("Pragma", "public");
		response.setHeader("Expires", "0");
		response.setHeader("Cache-Control","must-revalidate, post-check=0, pre-check=0");
		response.setHeader("Content-Type", "text/csv");
		response.setHeader("Content-Disposition","attachment;filename=\""+fileName+".csv\"");
	}
}