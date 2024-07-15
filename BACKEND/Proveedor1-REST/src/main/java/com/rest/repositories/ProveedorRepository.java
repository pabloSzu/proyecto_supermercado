package com.rest.repositories;


import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.stereotype.Repository;

import com.fasterxml.jackson.databind.JsonNode;

import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;

@Repository
public class ProveedorRepository {
	 @Autowired
	    private JdbcTemplate jdbcTpl;	 
	 

	 @SuppressWarnings("unchecked")
	 public String getConfiguracion() {
	        SimpleJdbcCall jdbcCall = new SimpleJdbcCall(jdbcTpl)
	            .withProcedureName("OBTENER_CONFIGURACION")
	            .withSchemaName("dbo");

	        SqlParameterSource in = new MapSqlParameterSource();
	        Map<String, Object> out = jdbcCall.execute(in);

	        // Obtener el resultado devuelto por el procedimiento almacenado
	        List<Map<String, Object>> resultSet = (List<Map<String, Object>>) out.get("#result-set-1");

	        // Asumiendo que el JSON está en la primera fila de la lista bajo la clave "Configuracion"
	        if (resultSet != null && !resultSet.isEmpty()) {
	            Map<String, Object> firstRow = resultSet.get(0);
	            return (String) firstRow.get("Configuracion");
	        } else {
	            throw new RuntimeException("No se devolvió la configuración.");
	        }
	    }
	    
	  
	 @SuppressWarnings("unchecked")
	    public String getProductos() {
		 SimpleJdbcCall jdbcCall = new SimpleJdbcCall(jdbcTpl)
		            .withProcedureName("OBTENER_PRODUCTOS")
		            .withSchemaName("dbo");

		        SqlParameterSource in = new MapSqlParameterSource();
		        Map<String, Object> out = jdbcCall.execute(in);

		        
			   // Obtener el resultado devuelto por el procedimiento almacenado
			   List<Map<String, Object>> resultSet = (List<Map<String, Object>>) out.get("#result-set-1");
   
			   // Asumiendo que el JSON está en la primera fila de la lista bajo la clave "Configuracion"
			   if (resultSet != null && !resultSet.isEmpty()) {
				   Map<String, Object> firstRow = resultSet.get(0);
				   return (String) firstRow.get("Productos");
			   } else {
				   throw new RuntimeException("No se devolvió los productos.");
			   }
	    }

	 
	 
	 

		@SuppressWarnings("unchecked")
	    public String getPedido(JsonNode pedidoJson) {
			try {
				// Convert the JsonNode to a JSON string
				String jsonString = pedidoJson.toString();
		        SimpleJdbcCall jdbcCall = new SimpleJdbcCall(jdbcTpl);

				// Add the JSON string to the SqlParameterSource
				SqlParameterSource in = new MapSqlParameterSource()
					.addValue("json", jsonString);
	
				// Configure the SimpleJdbcCall
				Map<String, Object> out = jdbcCall.withProcedureName("OBTENER_PEDIDO")
					.withSchemaName("dbo")
					.execute(in);
				List<Map<String, Object>> resultSet = (List<Map<String, Object>>) out.get("#result-set-1");

				// Obtener el resultado devuelto por el procedimiento almacenado
				if (resultSet != null && !resultSet.isEmpty()) {
					Map<String, Object> firstRow = resultSet.get(0);
					return (String) firstRow.get("Pedido");
				} else {
					throw new RuntimeException("No se devolvió el Pedido.");
				}
			} catch (Exception e) {
				throw new RuntimeException("Error ejecutando el procedimiento almacenado", e);
			}
 }

		
		

		 
		 
		 

		@SuppressWarnings("unchecked")
	    public String cancelarPedido(String jsonString) {
			try {
		        SimpleJdbcCall jdbcCall = new SimpleJdbcCall(jdbcTpl);

				// Add the JSON string to the SqlParameterSource
				SqlParameterSource in = new MapSqlParameterSource()
					.addValue("json", jsonString);
	
				// Configure the SimpleJdbcCall
				Map<String, Object> out = jdbcCall.withProcedureName("CANCELAR_PEDIDO")
					.withSchemaName("dbo")
					.execute(in);
				List<Map<String, Object>> resultSet = (List<Map<String, Object>>) out.get("#result-set-1");

				// Obtener el resultado devuelto por el procedimiento almacenado
				if (resultSet != null && !resultSet.isEmpty()) {
					Map<String, Object> firstRow = resultSet.get(0);
					return (String) firstRow.get("Pedido");
				} else {
					throw new RuntimeException("No se devolvió el Pedido.");
				}
			} catch (Exception e) {
				throw new RuntimeException("Error ejecutando el procedimiento almacenado", e);
			}
    }

	

		
		

		 
		 
		 

		@SuppressWarnings("unchecked")
	    public String evaluarPedido(String jsonString) {
			try {
		        SimpleJdbcCall jdbcCall = new SimpleJdbcCall(jdbcTpl);

				// Add the JSON string to the SqlParameterSource
				SqlParameterSource in = new MapSqlParameterSource()
					.addValue("json", jsonString);
	
				// Configure the SimpleJdbcCall
				Map<String, Object> out = jdbcCall.withProcedureName("EVALUAR_PEDIDO")
					.withSchemaName("dbo")
					.execute(in);
				List<Map<String, Object>> resultSet = (List<Map<String, Object>>) out.get("#result-set-1");

				// Obtener el resultado devuelto por el procedimiento almacenado
				if (resultSet != null && !resultSet.isEmpty()) {
					Map<String, Object> firstRow = resultSet.get(0);
					return (String) firstRow.get("Pedido");
				} else {
					throw new RuntimeException("No se devolvió el Pedido.");
				}
			} catch (Exception e) {
				throw new RuntimeException("Error ejecutando el procedimiento almacenado", e);
			}
    }

	
		

		 

		 @SuppressWarnings("unchecked")
		 public String getPedidos() {
		        SimpleJdbcCall jdbcCall = new SimpleJdbcCall(jdbcTpl)
		            .withProcedureName("OBTENER_PEDIDOS")
		            .withSchemaName("dbo");

		        SqlParameterSource in = new MapSqlParameterSource();
		        Map<String, Object> out = jdbcCall.execute(in);

		        // Obtener el resultado devuelto por el procedimiento almacenado
		        List<Map<String, Object>> resultSet = (List<Map<String, Object>>) out.get("#result-set-1");

		        // Asumiendo que el JSON está en la primera fila de la lista bajo la clave "Configuracion"
		        if (resultSet != null && !resultSet.isEmpty()) {
		            Map<String, Object> firstRow = resultSet.get(0);
		            return (String) firstRow.get("Pedidos");
		        } else {
		            throw new RuntimeException("No se devolvió la configuración.");
		        }
		    }
		
		
	
@SuppressWarnings("unchecked")
public String getRanking() {
 SimpleJdbcCall jdbcCall = new SimpleJdbcCall(jdbcTpl)
			.withProcedureName("OBTENER_RANKING")
			.withSchemaName("dbo");

		SqlParameterSource in = new MapSqlParameterSource();
		Map<String, Object> out = jdbcCall.execute(in);

		
	   // Obtener el resultado devuelto por el procedimiento almacenado
	   List<Map<String, Object>> resultSet = (List<Map<String, Object>>) out.get("#result-set-1");

	   // Asumiendo que el JSON está en la primera fila de la lista bajo la clave "Configuracion"
	   if (resultSet != null && !resultSet.isEmpty()) {
		   Map<String, Object> firstRow = resultSet.get(0);
		   return (String) firstRow.get("Ranking");
	   } else {
		   throw new RuntimeException("No se devolvió los productos.");
	   }
}




@SuppressWarnings("unchecked")
public String insertarPedido(String jsonString) {
	try {
		// Convert the JsonNode to a JSON string
        SimpleJdbcCall jdbcCall = new SimpleJdbcCall(jdbcTpl);

		// Add the JSON string to the SqlParameterSource
		SqlParameterSource in = new MapSqlParameterSource()
			.addValue("json", jsonString);

		// Configure the SimpleJdbcCall
		Map<String, Object> out = jdbcCall.withProcedureName("INSERTAR_DETALLE")
			.withSchemaName("dbo")
			.execute(in);
		List<Map<String, Object>> resultSet = (List<Map<String, Object>>) out.get("#result-set-1");

		// Obtener el resultado devuelto por el procedimiento almacenado
		if (resultSet != null && !resultSet.isEmpty()) {
			  SimpleJdbcCall jdbcCallpedido = new SimpleJdbcCall(jdbcTpl);
				// Add the JSON string to the SqlParameterSource
				SqlParameterSource inPedido = new MapSqlParameterSource();
				// Configure the SimpleJdbcCall
				Map<String, Object> outPedido = jdbcCallpedido.withProcedureName("OBTENER_DETALLES_ULTIMO_PEDIDO")
					.withSchemaName("dbo")
					.execute(inPedido);
				List<Map<String, Object>> resultSetPedido = (List<Map<String, Object>>) outPedido.get("#result-set-1");
			if (resultSetPedido != null && !resultSetPedido.isEmpty()) {
					Map<String, Object> firstRow = resultSetPedido.get(0);
					return (String) firstRow.get("Resultado");
				}
			else {
					throw new RuntimeException("No se insertó el Pedido.");
				}
		} else {
			throw new RuntimeException("No se devolvió el Pedido.");
		}
	} catch (Exception e) {
		throw new RuntimeException("Error ejecutando el procedimiento almacenado", e);
	}
}





 



}
