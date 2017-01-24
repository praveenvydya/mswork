package com.vydya.theschool.test;
/*

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.transaction.TransactionConfiguration;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.vydya.theschool.dataaccess.api.common.ContentDAO;

@TransactionConfiguration(defaultRollback=false)
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:mvc-dispatcher-servlet.xml"})
public class TestProperty 
{
	
	@Autowired
	protected ContentDAO coDAO;
	
	
	
	@Transactional(propagation=Propagation.REQUIRED)
	@Test
	public void  getAllContents(){
		
		 try
	        {
			// Notifications entity = nDAO.getById(21);
			 List<Object[]> entityList = coDAO.getAllContents();

			 	for(Object[] c:entityList){
			 		
			 		
			 		System.out.println(" "+c[5]);
			 	}
				
			 
	        }catch (Exception e)
			{
				e.printStackTrace();
			
				fail(e.getMessage());
			}
		
	}
	
}

*/