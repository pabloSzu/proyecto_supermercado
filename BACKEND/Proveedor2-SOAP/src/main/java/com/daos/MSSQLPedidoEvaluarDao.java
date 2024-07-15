package com.daos;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import ar.edu.ubp.das.db.Dao;

public class MSSQLPedidoEvaluarDao extends Dao<String, String, String> {

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
	public String make(ResultSet arg0) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<String> select(String arg0) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String update(String json) throws SQLException {

		try {
			this.connect();
			this.setProcedure("EVALUAR_PEDIDO(?)");
			this.setParameter(1, json);
			this.executeUpdateQuery();
			JsonObject jsonObject = JsonParser.parseString(json).getAsJsonObject();
	        String codigoSeguimiento = jsonObject.get("codigo_seguimiento").getAsString();
	        String evaluacion = jsonObject.get("evaluacion").getAsString();
	        return String.format("[{\"codigo_seguimiento\":\"%s\", \"evaluacion\":\"%s\"}]", codigoSeguimiento, evaluacion);
		}
		finally {
			this.close();
		}
	}

	@Override
	public boolean valid(String arg0) throws SQLException {
		// TODO Auto-generated method stub
		return false;
	}



}
