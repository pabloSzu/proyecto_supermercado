package com.daos;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import ar.edu.ubp.das.db.Dao;

public class MSSQLDetallePedidoDao extends Dao<String, String, String> {

    @Override
    public String delete(String arg0) throws SQLException {
        // No implementado
        return null;
    }

    @Override
    public String insert(String json) throws SQLException {

		try {
			this.connect();
			this.setProcedure("INSERTAR_DETALLE(?)");
			this.setParameter(1, json);
			this.executeUpdateQuery();
	        return String.format("OK");
		}
		finally {
			this.close();
		}
    }


    @Override
    public List<String> select(String arg0) throws SQLException { 
		this.connect();
		this.setProcedure("OBTENER_DETALLES_ULTIMO_PEDIDO");
		return this.executeQuery();
    }

    @Override
    public String update(String json) throws SQLException {
        // No implementado
        return null;
    }

    @Override
    public boolean valid(String arg0) throws SQLException {
        // No implementado
        return false;
    }

	@Override
	public String make(ResultSet result) throws SQLException {
		 return result.getString("Resultado");
	}

}
