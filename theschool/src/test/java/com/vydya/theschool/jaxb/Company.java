package com.vydya.theschool.jaxb;

import java.util.List;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlElementWrapper;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class Company {

	
	private String companyName;
	
	
	private List<Customer> customers;
	
	
	public String getCompanyName() {
		return companyName;
	}
	
	@XmlElement
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	public List<Customer> getCustomers() {
		return customers;
	}
	
	@XmlElementWrapper(name="customers")
	@XmlElement(name="customer", required=true)
	public void setCustomers(List<Customer> customers) {
		this.customers = customers;
	}
	
	
	
}
