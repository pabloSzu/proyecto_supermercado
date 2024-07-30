package com.rest.services;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.PostMapping;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonSyntaxException;
import com.google.gson.reflect.TypeToken;
import com.rest.backend.ClientFactory;
import com.rest.backend.ServiceClient;
import com.rest.beans.CredencialesBean;
import com.rest.beans.ProveedorBean;
import com.rest.repository.SupermercadoRepository;


@Service
public class PedidosAutomaticosService {

    @Autowired
    private ClientFactory clientFactory;

    @Autowired
    private SupermercadoRepository repository;

    @Autowired
    private CredencialesService credencialesService;
    
    

    public ResponseEntity<String> getProveedores() {
    	try {
            String jsonConfig = repository.getProveedores();
            return new ResponseEntity<>(jsonConfig, HttpStatus.OK);
        } catch (Exception e) {
            System.out.println("Exception: " + e.getMessage());
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    
    

    public ResponseEntity<String> getProveedoresSinPreciosActualizados() {
    	try {
            String jsonConfig = repository.getProveedoresSinPreciosActualizados();
            return new ResponseEntity<>(jsonConfig, HttpStatus.OK);
        } catch (Exception e) {
            System.out.println("Exception: " + e.getMessage());
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    
    

    /////////////////////////////////////////////////////////////////////////////////Consulto a todos los proveedores los pedidos realizados
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    public ResponseEntity<String> actualizarPedidos() {
        Gson gson = new Gson();
        try {
            ResponseEntity<String> proveedoresResponse = getProveedores();
            String proveedoresJson = proveedoresResponse.getBody();

            List<ProveedorBean> proveedores = gson.fromJson(proveedoresJson, new TypeToken<List<ProveedorBean>>() {}.getType());

            if (proveedoresJson == null || proveedoresJson.isEmpty()) {
                JsonObject errorResponse = new JsonObject();
                errorResponse.addProperty("error", "La respuesta de proveedores está vacía.");
                return ResponseEntity.status(HttpStatus.NO_CONTENT).body(gson.toJson(errorResponse));
            }

            List<JsonObject> combinedResponse = new ArrayList<>();

            for (ProveedorBean proveedor : proveedores) {
                String url = proveedor.getNombre_url();
                String token = proveedor.getToken();

                ServiceClient client = clientFactory.getClient(url);
                String pedidosJson = client.getPedidos(token, url);
                JsonArray pedidosArray = gson.fromJson(pedidosJson, JsonArray.class);

                for (JsonElement pedidoElement : pedidosArray) {
                    JsonObject pedidoObject = pedidoElement.getAsJsonObject();
                    pedidoObject.addProperty("id_proveedor", proveedor.getId_proveedor());
                    combinedResponse.add(pedidoObject);
                }
            }

            System.out.println("JSON pedidos-proveedor: " + gson.toJson(combinedResponse));

            ResponseEntity<String> response = updatePedidos(gson.toJson(combinedResponse));

            return response;

        } catch (JsonSyntaxException e) {
            JsonObject errorResponse = new JsonObject();
            errorResponse.addProperty("error", "Error en el formato del JSON: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(gson.toJson(errorResponse));
        } catch (Exception e) {
            JsonObject errorResponse = new JsonObject();
            errorResponse.addProperty("error", e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(gson.toJson(errorResponse));
        }
    }

    
  //Hago el Update en nuestra base
    public ResponseEntity<String> updatePedidos(String Json) {
        try {
            String jsonConfig = repository.actualizarPedidos(Json);
            return new ResponseEntity<>(jsonConfig, HttpStatus.OK);
        } catch (Exception e) {
            System.out.println("Excepción en actualizarPedidos: " + e.getMessage());
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    /////////////////////////////////////////////////////////////////////////////////Consulto a todos los proveedores los productos y sus precios
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    public ResponseEntity<String> actualizarProductos() {
        Gson gson = new Gson();
        try {
            ResponseEntity<String> proveedoresResponse = getProveedoresSinPreciosActualizados();
            String proveedoresJson = proveedoresResponse.getBody();

            if (proveedoresJson == null || proveedoresJson.isEmpty()) {
                JsonObject errorResponse = new JsonObject();
                errorResponse.addProperty("error", "La respuesta de proveedores está vacía.");
                return ResponseEntity.status(HttpStatus.NO_CONTENT).body(gson.toJson(errorResponse));
            }

            List<ProveedorBean> proveedores = gson.fromJson(proveedoresJson, new TypeToken<List<ProveedorBean>>() {}.getType());
           System.out.println("JSON PROVEEDORES: " + proveedoresJson);

            List<JsonObject> combinedResponse = new ArrayList<>();

            for (ProveedorBean proveedor : proveedores) {
                String url = proveedor.getNombre_url();
                String token = proveedor.getToken();

                ServiceClient client = clientFactory.getClient(url);
                String productosJson = client.getProductos(token, url);
                JsonArray productosArray = gson.fromJson(productosJson, JsonArray.class);

                for (JsonElement productoElement : productosArray) {
                    JsonObject productoObject = productoElement.getAsJsonObject();
                    productoObject.addProperty("id_proveedor", proveedor.getId_proveedor());
                    combinedResponse.add(productoObject);
                }
            }

            System.out.println("JSON productos-proveedor: " + gson.toJson(combinedResponse));

            ResponseEntity<String> response = updateProductosPrecio(gson.toJson(combinedResponse));

            return response;
        } catch (JsonSyntaxException e) {
            JsonObject errorResponse = new JsonObject();
            errorResponse.addProperty("error", "Error en el formato del JSON: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(gson.toJson(errorResponse));
        } catch (Exception e) {
            JsonObject errorResponse = new JsonObject();
            errorResponse.addProperty("error", e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(gson.toJson(errorResponse));
        }
    }
    
    
//Hago el Update en nuestra base
    public ResponseEntity<String> updateProductosPrecio(String Json) {
        try {
            String jsonConfig = repository.actualizarProductosPrecio(Json);
            return new ResponseEntity<>(jsonConfig, HttpStatus.OK);
        } catch (Exception e) {
            System.out.println("Excepción en actualizarProductosPrecio: " + e.getMessage());
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    
    
    
    
    
    

    //////////////////////////////////////////////////////////////////////////////////REALIZO PEDIDOS AUTOMATICAMENTE
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    public ResponseEntity<String> realizarPedidos() {
        // Actualizo los estados de los pedidos y los precios de los productos
        actualizarPedidos();
        actualizarProductos();

        try {
            // Obtener el JSON de todos los productos a pedir, sus cantidades, y a qué proveedor realizarlo
            String jsonResponse = repository.realizarPedidos();

            if (jsonResponse == null) {
                return new ResponseEntity<>("Todos los productos tienen stock. No se realizaron pedidos nuevos", HttpStatus.OK);
            }

            Gson gson = new Gson();

            // Convertir el JSON a una lista de mapas
            List<Map<String, Object>> pedidos = gson.fromJson(jsonResponse, new TypeToken<List<Map<String, Object>>>() {}.getType());

            // Agrupar pedidos por id_proveedor
            Map<Integer, List<Map<String, Object>>> pedidosPorProveedor = pedidos.stream()
                    .collect(Collectors.groupingBy(pedido -> {
                        Number idProveedor = (Number) pedido.get("id_proveedor");
                        return idProveedor.intValue();
                    }));

            // Iterar sobre cada grupo de pedidos por proveedor
            for (Map.Entry<Integer, List<Map<String, Object>>> entry : pedidosPorProveedor.entrySet()) {
                Integer idProveedor = entry.getKey();
                List<Map<String, Object>> pedidosProveedor = entry.getValue();

                // Mostrar id_proveedor
                String jsonProveedor = gson.toJson(Map.of("id_proveedor", idProveedor));
                System.out.println("MOSTRAR\n" + jsonProveedor);

                // Mostrar pedidos agrupados por proveedor
                String jsonPedidos = gson.toJson(pedidosProveedor.stream()
                        .map(p -> Map.of(
                                "codigo_barra", p.get("codigo_barra"),
                                "cantidad", ((Number) p.get("cantidad")).intValue()
                        ))
                        .collect(Collectors.toList()));
                System.out.println("LUEGO MOSTRAR\n" + jsonPedidos);

                // Obtener credenciales y realizar el pedido
                CredencialesBean credenciales = credencialesService.obtenerCredenciales(jsonProveedor);
                String url = credenciales.getNombre_url();
                String token = credenciales.getToken();
                ServiceClient client = clientFactory.getClient(url);

                // Realizar el pedido y obtener la respuesta
                String respuestaInsercionPedidosProveedores = client.insertPedidos(token, url, jsonPedidos);

                System.out.println("AAAAAAAAAAAAAAAAAAAAAA" + respuestaInsercionPedidosProveedores);
                
                
                // Parsear la respuesta a una lista de mapas
                List<Map<String, Object>> respuestaList = gson.fromJson(respuestaInsercionPedidosProveedores, new TypeToken<List<Map<String, Object>>>() {}.getType());

                // Iterar sobre la lista de respuestas para agregar id_proveedor a cada Pedido
                respuestaList.forEach(respuesta -> {
                    Map<String, Object> pedido = (Map<String, Object>) respuesta.get("Pedido");
                    // Convertir los valores numéricos a enteros
                    pedido.put("id_pedido", ((Number) pedido.get("id_pedido")).intValue());
                    pedido.put("total", ((Number) pedido.get("total")).intValue());

                    // Convertir los detalles a enteros
                    List<Map<String, Object>> detalles = (List<Map<String, Object>>) respuesta.get("Detalles");
                    detalles.forEach(detalle -> {
                        detalle.put("cantidad", ((Number) detalle.get("cantidad")).intValue());
                        detalle.put("precio_unitario", ((Number) detalle.get("precio_unitario")).intValue());
                    });

                    // Agregar id_proveedor al objeto Pedido
                    pedido.put("id_proveedor", idProveedor);
                });

                // Convertir nuevamente la lista de respuestas a JSON
                String jsonConIdProveedor = gson.toJson(respuestaList);

                System.out.println("holaaa\n" + jsonConIdProveedor);
                try {
                    // Guardar el nuevo pedido
                    jsonResponse = repository.guardarNuevoPedido(jsonConIdProveedor);
                    System.out.println("HOLAAAA\n" + jsonConIdProveedor);
                } catch (Exception e) {
                    System.out.println("Error en insertarPedidos en nuestra base: " + e.getMessage());
                    e.printStackTrace(); // Imprimir la traza completa de la excepción
                }

            }

            //return new ResponseEntity<>("TODO BIEN", HttpStatus.OK);
            return  controlarPedidos();
            
        } catch (Exception e) {
            System.out.println("Error en insertarPedidos en los proveedores: " + e.getMessage());
            e.printStackTrace(); // Imprimir la traza completa de la excepción

            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    
    
    
    
    
    
    

    
    
    
    
    
    
    public ResponseEntity<String> controlarPedidos() {
        Gson gson = new Gson();
        try {
            // Obtener proveedores desde la API
            ResponseEntity<String> proveedoresResponse = getProveedores();
            String proveedoresJson = proveedoresResponse.getBody();

            if (proveedoresJson == null || proveedoresJson.isEmpty()) {
                JsonObject errorResponse = new JsonObject();
                errorResponse.addProperty("error", "La respuesta de proveedores está vacía.");
                return ResponseEntity.status(HttpStatus.NO_CONTENT).body(gson.toJson(errorResponse));
            }

            List<ProveedorBean> proveedores = gson.fromJson(proveedoresJson, new TypeToken<List<ProveedorBean>>() {}.getType());

            List<JsonObject> combinedResponse = new ArrayList<>();

            // Obtener y combinar pedidos del cliente
            for (ProveedorBean proveedor : proveedores) {
                String url = proveedor.getNombre_url();
                String token = proveedor.getToken();

                ServiceClient client = clientFactory.getClient(url);
                String pedidosJson = client.getPedidos(token, url);
                JsonArray pedidosArray = gson.fromJson(pedidosJson, JsonArray.class);

                for (JsonElement pedidoElement : pedidosArray) {
                    JsonObject pedidoObject = pedidoElement.getAsJsonObject();
                    pedidoObject.addProperty("id_proveedor", proveedor.getId_proveedor());
                    combinedResponse.add(pedidoObject);
                }
            }

            // Obtener las cantidades de pedidos propios desde la base de datos
            String jsonObtenerCantidadPedidosPorProveedor = repository.getObtenerCantidadPedidosPorProveedor();
            List<JsonObject> pedidosPropios = gson.fromJson(jsonObtenerCantidadPedidosPorProveedor, new TypeToken<List<JsonObject>>() {}.getType());

            // Contar pedidos del cliente por proveedor
            Map<Integer, Long> pedidosClientePorProveedor = combinedResponse.stream()
                    .collect(Collectors.groupingBy(p -> p.get("id_proveedor").getAsInt(), Collectors.counting()));

            // Comparar las cantidades y generar el mensaje en caso de discrepancias
            StringBuilder mensaje = new StringBuilder();
            boolean hayDiscrepancias = false;

            for (JsonObject pedidoPropio : pedidosPropios) {
                int idProveedor = pedidoPropio.get("id_proveedor").getAsInt();
                long cantidadPropia = pedidoPropio.get("cantidad_pedidos").getAsLong();
                long cantidadCliente = pedidosClientePorProveedor.getOrDefault(idProveedor, 0L);

                if (cantidadCliente != cantidadPropia) {
                    hayDiscrepancias = true;
                    ProveedorBean proveedor = proveedores.stream()
                            .filter(p -> p.getId_proveedor() == idProveedor)
                            .findFirst().orElse(null);
                    if (proveedor != null) {
                        mensaje.append("LLAMAR AL PROVEEDOR ")
                                .append(proveedor.getNombre())
                                .append(" - Se han generado pedidos incorrectos\n");
                    }
                }
            }

            if (hayDiscrepancias) {
                return new ResponseEntity<>(mensaje.toString(), HttpStatus.OK);
            } else {
                return new ResponseEntity<>(" PEDIDOS GENERADOS. No hay discrepancias en los pedidos.", HttpStatus.OK);
            }

        } catch (JsonSyntaxException e) {
            JsonObject errorResponse = new JsonObject();
            errorResponse.addProperty("error", "Error en el formato del JSON: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(gson.toJson(errorResponse));
        } catch (Exception e) {
            JsonObject errorResponse = new JsonObject();
            errorResponse.addProperty("error", e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(gson.toJson(errorResponse));
        }
    }

    
        
        
    }