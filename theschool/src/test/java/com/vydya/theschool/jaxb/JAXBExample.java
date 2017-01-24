package com.vydya.theschool.jaxb;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import javax.xml.bind.Unmarshaller;
 
public class JAXBExample {
	public static void main(String[] args) {
 
		//ObjecttoXml();
		XmlToObject();
 
	}

	private static void XmlToObject() {
		 try {
			 
				File file = new File("C:/xmls/customer.xml");
				
				JAXBContext jaxbContext = JAXBContext.newInstance(Company.class);
		 
				Unmarshaller jaxbUnmarshaller = jaxbContext.createUnmarshaller();
				Company company = (Company) jaxbUnmarshaller.unmarshal(file);
				System.out.println(company);
		 
			  } catch (JAXBException e) {
				e.printStackTrace();
			  }
		
	}

	private static List<Customer> getCustomerList() {
		List<Customer> cList = new ArrayList<Customer>();
		for(int i=0;i<5;i++){
			
			 Customer customer = new Customer();
			  customer.setId(1);
			  customer.setName("praveen"+i);
			  customer.setAge(20+i);
			  cList.add(customer);
		}
		return cList;
	}

	private static void ObjecttoXml() {
		 List<Customer> custList = getCustomerList();
		Company company = new Company();
		company.setCompanyName("Vydya Ltd");
		company.setCustomers(custList);
		 
		  try {
	 
			File file = new File("C:/xmls/customer.xml");
			JAXBContext jaxbContext = JAXBContext.newInstance(Company.class);
			Marshaller jaxbMarshaller = jaxbContext.createMarshaller();
	 
			// output pretty printed
			jaxbMarshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
	 
			jaxbMarshaller.marshal(company, file);
			jaxbMarshaller.marshal(company, System.out);
	 
		      } catch (JAXBException e) {
			e.printStackTrace();
		      }
		
	}
}
