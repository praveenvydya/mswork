package com.vydya.theschool.jaxb;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import javax.xml.bind.Unmarshaller;

import com.vydya.theschool.common.dto.MenuData;
 
public class JAXBLeftMenuExample {
	public static void main(String[] args) {
 
		//ObjecttoXml();
		XmlToObject();
 
	}

	private static void XmlToObject() {
		 try {
			 
				File file = new File("C:/xmls/leftMenu.xml");
				
				JAXBContext jaxbContext = JAXBContext.newInstance(MenuData.class);
		 
				Unmarshaller jaxbUnmarshaller = jaxbContext.createUnmarshaller();
				MenuData menuData = (MenuData) jaxbUnmarshaller.unmarshal(file);
				System.out.println(menuData.toString());
		 
			  } catch (JAXBException e) {
				e.printStackTrace();
			  }
		
	}

	private static List<MenuData> getMenuList() {
		List<MenuData> mdList = new ArrayList<MenuData>();
		MenuData md1 = new MenuData();
		md1.setMenuId(1);
		md1.setName("home");
		md1.setPath("/home");
	//	md1.setTitle("Home");
		md1.setSubMenu(null);
		mdList.add(md1);
		
		MenuData sbmd1 = new MenuData();
		sbmd1.setMenuId(301);
		sbmd1.setName("preschool");
		sbmd1.setPath("/preschool");
		//sbmd1.setTitle("Preschool");
		sbmd1.setSubMenu(null);

		List<MenuData> snmdList1 = new ArrayList<MenuData>();
		snmdList1.add(sbmd1);
		
		MenuData md2 = new MenuData();
		md2.setMenuId(3);
		md2.setName("academics");
		md2.setPath("/academics");
		//md2.setTitle("academics");
		md2.setSubMenu(snmdList1);
		
		mdList.add(md2);
		return mdList;
	}

	private static void ObjecttoXml() {
		 List<MenuData> menuList = getMenuList();
		 MenuData menuData = new MenuData();
		menuData.setName("mainmenu");
		menuData.setPath(null);
		//menuData.setTitle("Main Menu");
		menuData.setSubMenu(menuList);
		 
		  try {
	 
			File file = new File("C:/xmls/leftMenu.xml");
			JAXBContext jaxbContext = JAXBContext.newInstance(MenuData.class);
			Marshaller jaxbMarshaller = jaxbContext.createMarshaller();
	 
			// output pretty printed
			jaxbMarshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
	 
			jaxbMarshaller.marshal(menuData, file);
			jaxbMarshaller.marshal(menuData, System.out);
	 
		      } catch (JAXBException e) {
			e.printStackTrace();
		      }
		
	}
}
