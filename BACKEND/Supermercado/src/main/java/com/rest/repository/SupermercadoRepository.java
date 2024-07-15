package com.rest.repository;


import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.stereotype.Repository;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;

@Repository
public class SupermercadoRepository {
	 @Autowired
	    private JdbcTemplate jdbcTpl;	 
	 

	 
	 
	 
	 
	 
	 
	 

	 
	 

		@SuppressWarnings("unchecked")
	    public String getUsuario(JsonNode usuarioJson) {
			try {
				// Convert the JsonNode to a JSON string
				String jsonString = usuarioJson.toString();
		        SimpleJdbcCall jdbcCall = new SimpleJdbcCall(jdbcTpl);

				// Add the JSON string to the SqlParameterSource
				SqlParameterSource in = new MapSqlParameterSource()
					.addValue("json", jsonString);
	
				// Configure the SimpleJdbcCall
				Map<String, Object> out = jdbcCall.withProcedureName("USUARIO_LOGIN")
					.withSchemaName("dbo")
					.execute(in);
				List<Map<String, Object>> resultSet = (List<Map<String, Object>>) out.get("#result-set-1");

				// Obtener el resultado devuelto por el procedimiento almacenado
				if (resultSet != null && !resultSet.isEmpty()) {
					Map<String, Object> firstRow = resultSet.get(0);
					return (String) firstRow.get("Pedido");
				} else {
					throw new RuntimeException("No existen esos datos.");
				}
			} catch (Exception e) {
				throw new RuntimeException("Error ejecutando el procedimiento almacenado", e);
			}
}
		 
		 
		 

		 
		@SuppressWarnings("unchecked")
	    public String getPedidos() {
			try {
		        SimpleJdbcCall jdbcCall = new SimpleJdbcCall(jdbcTpl);

				// Add the JSON string to the SqlParameterSource
				SqlParameterSource in = new MapSqlParameterSource();
	
				// Configure the SimpleJdbcCall
				Map<String, Object> out = jdbcCall.withProcedureName("OBTENER_PEDIDOS")
					.withSchemaName("dbo")
					.execute(in);
				List<Map<String, Object>> resultSet = (List<Map<String, Object>>) out.get("#result-set-1");

				// Obtener el resultado devuelto por el procedimiento almacenado
				if (resultSet != null && !resultSet.isEmpty()) {
					Map<String, Object> firstRow = resultSet.get(0);
					return (String) firstRow.get("Pedidos");
				} else {
					throw new RuntimeException("No existen esos datos.");
				}
			} catch (Exception e) {
				throw new RuntimeException("Error ejecutando el procedimiento almacenado", e);
			}
}

		 
		 
		 

		 
		@SuppressWarnings("unchecked")
	    public String getProveedores() {
			try {
		        SimpleJdbcCall jdbcCall = new SimpleJdbcCall(jdbcTpl);

				// Add the JSON string to the SqlParameterSource
				SqlParameterSource in = new MapSqlParameterSource();
	
				// Configure the SimpleJdbcCall
				Map<String, Object> out = jdbcCall.withProcedureName("OBTENER_PROVEEDORES")
					.withSchemaName("dbo")
					.execute(in);
				List<Map<String, Object>> resultSet = (List<Map<String, Object>>) out.get("#result-set-1");

				// Obtener el resultado devuelto por el procedimiento almacenado
				if (resultSet != null && !resultSet.isEmpty()) {
					Map<String, Object> firstRow = resultSet.get(0);
					return (String) firstRow.get("Proveedores");
				} else {
					throw new RuntimeException("No existen esos datos.");
				}
			} catch (Exception e) {
				throw new RuntimeException("Error ejecutando el procedimiento almacenado", e);
			}
}


		 
		 
		 
		 

		 
		 
		 

		 
		@SuppressWarnings("unchecked")
	    public String getProveedoresSinPreciosActualizados() {
			try {
		        SimpleJdbcCall jdbcCall = new SimpleJdbcCall(jdbcTpl);

				// Add the JSON string to the SqlParameterSource
				SqlParameterSource in = new MapSqlParameterSource();
	
				// Configure the SimpleJdbcCall
				Map<String, Object> out = jdbcCall.withProcedureName("OBTENER_PROVEEDORES_PARA_ACTUALIZAR_PRECIOS")
					.withSchemaName("dbo")
					.execute(in);
				List<Map<String, Object>> resultSet = (List<Map<String, Object>>) out.get("#result-set-1");

				// Obtener el resultado devuelto por el procedimiento almacenado
				if (resultSet != null && !resultSet.isEmpty()) {
					Map<String, Object> firstRow = resultSet.get(0);
					return (String) firstRow.get("ProveedoresSinPreciosActualizados");
				} else {
					throw new RuntimeException("No existen esos datos.");
				}
			} catch (Exception e) {
				throw new RuntimeException("Error ejecutando el procedimiento almacenado", e);
			}
}


		 
		 
		 
		 
		 
		 
		 
		 

		 
		 
		 

		 
		@SuppressWarnings("unchecked")
	    public String getRankingPonderado(JsonNode Json) {
			try {
				// Convert the JsonNode to a JSON string
				String jsonString = Json.toString();
		        SimpleJdbcCall jdbcCall = new SimpleJdbcCall(jdbcTpl);

				// Add the JSON string to the SqlParameterSource
				SqlParameterSource in = new MapSqlParameterSource()
					.addValue("json", jsonString);
	
				// Configure the SimpleJdbcCall
				Map<String, Object> out = jdbcCall.withProcedureName("OBTENER_RANKING_PONDERACION")
					.withSchemaName("dbo")
					.execute(in);
				List<Map<String, Object>> resultSet = (List<Map<String, Object>>) out.get("#result-set-1");

				// Obtener el resultado devuelto por el procedimiento almacenado
				if (resultSet != null && !resultSet.isEmpty()) {
					Map<String, Object> firstRow = resultSet.get(0);
					return (String) firstRow.get("Ranking");
				} else {
					throw new RuntimeException("No existen esos datos.");
				}
			} catch (Exception e) {
				throw new RuntimeException("Error ejecutando el procedimiento almacenado", e);
			}
 }

		 
		 
		 
		 
		 
		 
		 
		 

		 
		 
		 

		 
		@SuppressWarnings("unchecked")
	    public String getProductosProveedor(JsonNode Json) {
			try {
				// Convert the JsonNode to a JSON string
				String jsonString = Json.toString();
		        SimpleJdbcCall jdbcCall = new SimpleJdbcCall(jdbcTpl);

				// Add the JSON string to the SqlParameterSource
				SqlParameterSource in = new MapSqlParameterSource()
					.addValue("json", jsonString);
	
				// Configure the SimpleJdbcCall
				Map<String, Object> out = jdbcCall.withProcedureName("OBTENER_PRODUCTOS_PROVEEDOR")
					.withSchemaName("dbo")
					.execute(in);
				List<Map<String, Object>> resultSet = (List<Map<String, Object>>) out.get("#result-set-1");

				// Obtener el resultado devuelto por el procedimiento almacenado
				if (resultSet != null && !resultSet.isEmpty()) {
					Map<String, Object> firstRow = resultSet.get(0);
					return (String) firstRow.get("Productos");
				} else {
					throw new RuntimeException("No existen esos datos.");
				}
			} catch (Exception e) {
				throw new RuntimeException("Error ejecutando el procedimiento almacenado", e);
			}
 }

		 
		 
		 
		 
		 
		 
		 
		 
		@SuppressWarnings("unchecked")
	    public String getPedidoProveedor(JsonNode Json) {
			try {
				// Convert the JsonNode to a JSON string
				String jsonString = Json.toString();
		        SimpleJdbcCall jdbcCall = new SimpleJdbcCall(jdbcTpl);

				// Add the JSON string to the SqlParameterSource
				SqlParameterSource in = new MapSqlParameterSource()
					.addValue("json", jsonString);
	
				// Configure the SimpleJdbcCall
				Map<String, Object> out = jdbcCall.withProcedureName("OBTENER_PEDIDOS_PROVEEDOR")
					.withSchemaName("dbo")
					.execute(in);
				List<Map<String, Object>> resultSet = (List<Map<String, Object>>) out.get("#result-set-1");

				// Obtener el resultado devuelto por el procedimiento almacenado
				if (resultSet != null && !resultSet.isEmpty()) {
					Map<String, Object> firstRow = resultSet.get(0);
					return (String) firstRow.get("Pedidos");
				} else {
					throw new RuntimeException("No existen esos datos.");
				}
			} catch (Exception e) {
				throw new RuntimeException("Error ejecutando el procedimiento almacenado", e);
			}
 }

		 
		 
		 
		 
		 
		 
		 
		 
		@SuppressWarnings("unchecked")
	    public String getEstadisticaProveedor(JsonNode Json) {
			try {
				// Convert the JsonNode to a JSON string
				String jsonString = Json.toString();
		        SimpleJdbcCall jdbcCall = new SimpleJdbcCall(jdbcTpl);

				// Add the JSON string to the SqlParameterSource
				SqlParameterSource in = new MapSqlParameterSource()
					.addValue("json", jsonString);
	
				// Configure the SimpleJdbcCall
				Map<String, Object> out = jdbcCall.withProcedureName("OBTENER_ESTADISTICA_PROVEEDOR")
					.withSchemaName("dbo")
					.execute(in);
				List<Map<String, Object>> resultSet = (List<Map<String, Object>>) out.get("#result-set-1");

				// Obtener el resultado devuelto por el procedimiento almacenado
				if (resultSet != null && !resultSet.isEmpty()) {
					Map<String, Object> firstRow = resultSet.get(0);
					return (String) firstRow.get("Estadistica");
				} else {
					throw new RuntimeException("No existen esos datos.");
				}
			} catch (Exception e) {
				throw new RuntimeException("Error ejecutando el procedimiento almacenado", e);
			}
 }
		 
		 
		 
		 
		 
		 
		 
		 
		@SuppressWarnings("unchecked")
	    public String updatePonderacion(JsonNode Json) {
			try {
				// Convert the JsonNode to a JSON string
				String jsonString = Json.toString();
		        SimpleJdbcCall jdbcCall = new SimpleJdbcCall(jdbcTpl);

				// Add the JSON string to the SqlParameterSource
				SqlParameterSource in = new MapSqlParameterSource()
					.addValue("json", jsonString);
	
				// Configure the SimpleJdbcCall
				Map<String, Object> out = jdbcCall.withProcedureName("UPDATE_PONDERACION")
					.withSchemaName("dbo")
					.execute(in);
				List<Map<String, Object>> resultSet = (List<Map<String, Object>>) out.get("#result-set-1");

				// Obtener el resultado devuelto por el procedimiento almacenado
				if (resultSet != null && !resultSet.isEmpty()) {
					Map<String, Object> firstRow = resultSet.get(0);
					return (String) firstRow.get("Ponderacion");
				} else {
					throw new RuntimeException("No existen esos datos.");
				}
			} catch (Exception e) {
				throw new RuntimeException("Error ejecutando el procedimiento almacenado", e);
			}
}
 
 
	 
	 
	 
	 
	 
	 
	 
	 


		@SuppressWarnings("unchecked")
	    public String cancelarPedidoSuper(String pedidoJson) {
			try {
				// Convert the JsonNode to a JSON string
				String jsonString = pedidoJson.toString();
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
	    public String evaluarPedido(String pedidoJson) {
			try {
				// Convert the JsonNode to a JSON string
				String jsonString = pedidoJson.toString();
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
				throw new RuntimeException("Error ejecutando el proce", e);
			}
    }

		
		
		
		
		
		
		
		
		

		 

		@SuppressWarnings("unchecked")
	    public String altabajaProveedor(String Json) {
			try {
		        SimpleJdbcCall jdbcCall = new SimpleJdbcCall(jdbcTpl);

				// Add the JSON string to the SqlParameterSource
				SqlParameterSource in = new MapSqlParameterSource()
					.addValue("json", Json);
	
				// Configure the SimpleJdbcCall
				Map<String, Object> out = jdbcCall.withProcedureName("BAJA_ALTA_PROVEEDOR")
					.withSchemaName("dbo")
					.execute(in);
				List<Map<String, Object>> resultSet = (List<Map<String, Object>>) out.get("#result-set-1");

				// Obtener el resultado devuelto por el procedimiento almacenado
				if (resultSet != null && !resultSet.isEmpty()) {
					Map<String, Object> firstRow = resultSet.get(0);
					return (String) firstRow.get("Proveedor");
				} else {
					throw new RuntimeException("No existen esos datos.");
				}
			} catch (Exception e) {
				throw new RuntimeException("Error ejecutando el procedimiento almacenado", e);
			}
}

		
		
		
		
		
		
		
		
		

		 

		@SuppressWarnings("unchecked")
	    public String getDetallePedido(String Json) {
			try {
		        SimpleJdbcCall jdbcCall = new SimpleJdbcCall(jdbcTpl);

				// Add the JSON string to the SqlParameterSource
				SqlParameterSource in = new MapSqlParameterSource()
					.addValue("json", Json);
	
				// Configure the SimpleJdbcCall
				Map<String, Object> out = jdbcCall.withProcedureName("OBTENER_DETALLE_PEDIDO")
					.withSchemaName("dbo")
					.execute(in);
				List<Map<String, Object>> resultSet = (List<Map<String, Object>>) out.get("#result-set-1");

				// Obtener el resultado devuelto por el procedimiento almacenado
				if (resultSet != null && !resultSet.isEmpty()) {
					Map<String, Object> firstRow = resultSet.get(0);
					return (String) firstRow.get("detalle_pedido");
				} else {
					throw new RuntimeException("No existen esos datos.");
				}
			} catch (Exception e) {
				throw new RuntimeException("Error ejecutando el procedimiento almacenado", e);
			}
}
		 
		
		 
		 

			
		@SuppressWarnings("unchecked")
	    public String getProductosJoin(String Json) {
			try {
		        SimpleJdbcCall jdbcCall = new SimpleJdbcCall(jdbcTpl);

				// Add the JSON string to the SqlParameterSource
				SqlParameterSource in = new MapSqlParameterSource()
					.addValue("json", Json);
	
				// Configure the SimpleJdbcCall
				Map<String, Object> out = jdbcCall.withProcedureName("OBTENER_PRODUCTOS_JOIN")
					.withSchemaName("dbo")
					.execute(in);
				List<Map<String, Object>> resultSet = (List<Map<String, Object>>) out.get("#result-set-1");

				// Obtener el resultado devuelto por el procedimiento almacenado
				if (resultSet != null && !resultSet.isEmpty()) {
					Map<String, Object> firstRow = resultSet.get(0);
					return (String) firstRow.get("Productos");
				} else {
					throw new RuntimeException("No existen esos datos.");
				}
			} catch (Exception e) {
				throw new RuntimeException("Error ejecutando el procedimiento almacenado", e);
			}
}
		 
		
		 
		 




		@SuppressWarnings("unchecked")
	    public String insertDatosProveedor(String Json) {
			try {
		        SimpleJdbcCall jdbcCall = new SimpleJdbcCall(jdbcTpl);

				// Add the JSON string to the SqlParameterSource
				SqlParameterSource in = new MapSqlParameterSource()
					.addValue("json", Json);
	
				// Configure the SimpleJdbcCall
				Map<String, Object> out = jdbcCall.withProcedureName("INSERTAR_DATOS_PROVEEDOR")
					.withSchemaName("dbo")
					.execute(in);
				List<Map<String, Object>> resultSet = (List<Map<String, Object>>) out.get("#result-set-1");

				// Obtener el resultado devuelto por el procedimiento almacenado
				if (resultSet != null && !resultSet.isEmpty()) {
					Map<String, Object> firstRow = resultSet.get(0);
					return (String) firstRow.get("configuracion");
				} else {
					throw new RuntimeException("No existen esos datos.");
				}
			} catch (Exception e) {
				throw new RuntimeException("Error ejecutando el procedimiento almacenado", e);
			}
}
		 
		
		 
		 



		public String actualizarPedidos(String Json) {
		    try {
		        SimpleJdbcCall jdbcCall = new SimpleJdbcCall(jdbcTpl);
		        jdbcCall.withProcedureName("ActualizarPedidosDesdeJson")
		                .withSchemaName("dbo");
		        SqlParameterSource in = new MapSqlParameterSource()
		                .addValue("json", Json);
		        jdbcCall.execute(in);
		        return "OK";
		    } catch (Exception e) {
		        throw new RuntimeException("Error ejecutando el procedimiento almacenado", e);
		    }
		}

		public String actualizarProductosPrecio(String Json) {
		    try {
		        SimpleJdbcCall jdbcCall = new SimpleJdbcCall(jdbcTpl);
		        jdbcCall.withProcedureName("ActualizarProductosProveedorDesdeJson")
		                .withSchemaName("dbo");
		        SqlParameterSource in = new MapSqlParameterSource()
		                .addValue("json", Json);
		        jdbcCall.execute(in);
		        return "OK";
		    } catch (Exception e) {
		        throw new RuntimeException("Error ejecutando el procedimiento almacenado", e);
		    }
		}

		

		public String realizarPedidos() {
			try {
		        SimpleJdbcCall jdbcCall = new SimpleJdbcCall(jdbcTpl);

				// Add the JSON string to the SqlParameterSource
				SqlParameterSource in = new MapSqlParameterSource();
	
				// Configure the SimpleJdbcCall
				Map<String, Object> out = jdbcCall.withProcedureName("SeleccionarMejorProveedorPorProducto")
					.withSchemaName("dbo")
					.execute(in);
				List<Map<String, Object>> resultSet = (List<Map<String, Object>>) out.get("#result-set-1");

				// Obtener el resultado devuelto por el procedimiento almacenado
				if (resultSet != null && !resultSet.isEmpty()) {
					Map<String, Object> firstRow = resultSet.get(0);
					return (String) firstRow.get("resultado");
				} else {
					throw new RuntimeException("No existen esos datos.");
				}
			} catch (Exception e) {
				throw new RuntimeException("Error ejecutando el procedimiento almacenado", e);
			}
		}
		
		
		

		public String guardarNuevoPedido(String Json) {
		    try {
		        SimpleJdbcCall jdbcCall = new SimpleJdbcCall(jdbcTpl);
		        jdbcCall.withProcedureName("INSERTAR_PEDIDO_DETALLES")
		                .withSchemaName("dbo");
		        SqlParameterSource in = new MapSqlParameterSource()
		                .addValue("json", Json);
		        jdbcCall.execute(in);
		        return "OK";
		    } catch (Exception e) {
		        throw new RuntimeException("Error ejecutando el procedimiento almacenado", e);
		    }
		}
	 
	
}