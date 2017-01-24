package com.vydya.theschool.web;

import java.sql.Connection;
import java.sql.SQLException;

import com.vydya.theschool.web.localstatic.StaticData;

public class TestJdbcSQL {

	/**
	 * @param args
	 * @throws SQLException 
	 */
	public static void main(String[] args) throws SQLException {
		// TODO Auto-generated method stub
			//JDBCMySQLConnection clc = new JDBCMySQLConnection();
		//	Connection con  =clc.getConnection();
		//	System.out.println(con.getMetaData());
			
		StaticData d = new StaticData();
		d.setStaticPath("/afda");
			
			
	}

}
