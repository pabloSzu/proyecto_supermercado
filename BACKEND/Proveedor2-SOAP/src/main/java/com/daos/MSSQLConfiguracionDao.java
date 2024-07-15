package com.daos;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;


import ar.edu.ubp.das.db.Dao;

/*
 * public class MSSQLConfiguracionDao extends Dao< 1, 2, 3 >
 * 1- La respuesta que van a tener los metodos
 * 2- Parametros que recibe
 * 3- Lo que devuelve cada metodo
 * 
 * 
 * 
 * 
 * */



public class MSSQLConfiguracionDao extends Dao<String, String, String>{

	@Override
	public String delete(String arg0) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String insert(String arg0) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String make(ResultSet result) throws SQLException {
		 return result.getString("Configuracion");
	}

	@Override
	public List<String> select(String arg0) throws SQLException {
		this.connect();
		this.setProcedure("OBTENER_CONFIGURACION");
		return this.executeQuery();
	}

	@Override
	public String update(String arg0) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean valid(String arg0) throws SQLException {
		// TODO Auto-generated method stub
		return false;
	}

	
	

	

}
