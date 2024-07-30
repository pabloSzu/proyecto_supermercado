package com.rest.controllers;

import com.rest.services.PedidosAutomaticosService;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.JsonNode;
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
import com.rest.services.CredencialesService;


@RestController
@RequestMapping("/super")
public class SupermercadoController {

    @Autowired
    private ClientFactory clientFactory;

    @Autowired
    private CredencialesService credencialesService;
   
    @Autowired
    private SupermercadoRepository repository;
    
    
    private final PedidosAutomaticosService PedidosAutomaticosService;
    
    @Autowired
    public SupermercadoController(PedidosAutomaticosService PedidosAutomaticosService) {
        this.PedidosAutomaticosService = PedidosAutomaticosService;
    }

    

    //========================================================================OBTENGO LA URL Y EL TOKEN SEGUN EL id_proveedor
    @PostMapping("/configuracion")
    public String getConfiguracion(@RequestBody String json) {
    	/*    json		{"id_proveedor":"1"	}    */
        CredencialesBean credenciales = credencialesService.obtenerCredenciales(json);
        
        String url = credenciales.getNombre_url();
        String token = credenciales.getToken();

        ServiceClient client = clientFactory.getClient(url);
        return client.getConfiguracion(token, url);
    }
    //========================================================================OBTENGO LA URL Y EL TOKEN SEGUN EL id_proveedor
    
    

    //========================================================================CONSULTO AL PROVEEDOR SUS PRODUCTOS
    @PostMapping("/productos")
    public String getProductos(@RequestBody String json) {
    	/*    json		{"id_proveedor":"1"	}    */
        CredencialesBean credenciales = credencialesService.obtenerCredenciales(json);
        
        String url = credenciales.getNombre_url();
        String token = credenciales.getToken();

        ServiceClient client = clientFactory.getClient(url);
        return client.getProductos(token, url);
    }
    //========================================================================CONSULTO AL PROVEEDOR SUS PRODUCTOS
    
    

    //========================================================================CONSULTO AL PROVEEDOR UN PEDIDO 
    @PostMapping("/pedido")
    public String getPedido(@RequestBody String json) {
    	/*    json		{"id_proveedor":"1"	, "codigo_seguimiento":"ABCD123456"}    */
        CredencialesBean credenciales = credencialesService.obtenerCredenciales(json);
        
        String url = credenciales.getNombre_url();
        String token = credenciales.getToken();

        ServiceClient client = clientFactory.getClient(url);
        return client.getPedido(token, url, json);
    }
    //========================================================================CONSULTO AL PROVEEDOR UN PEDIDO 
    
    

    
    //========================================================================CANCELAR PEDIDO
    @PostMapping("/cancelar_pedido")
    public ResponseEntity<String> cancelPedido(@RequestBody String json) {
        /* json {"id_proveedor":"1", "codigo_seguimiento":"ABCD123456"} */

        CredencialesBean credenciales = credencialesService.obtenerCredenciales(json);
        String url = credenciales.getNombre_url();
        String token = credenciales.getToken();
        ServiceClient client = clientFactory.getClient(url);

        try {
            client.cancelarPedido(token, url, json);
            try {
                String jsonConfig = repository.cancelarPedidoSuper(json);
                return new ResponseEntity<>(jsonConfig, HttpStatus.OK);
            } catch (Exception e) {
                System.out.println("Exception in repository call: " + e.getMessage());
                return new ResponseEntity<>("Error cancelando pedido en el repositorio: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
            }
        }  catch (Exception e) {
            System.out.println("Exception in client call: " + e.getMessage());
            return new ResponseEntity<>("No se puede cancelar: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
  //========================================================================CANCELAR PEDIDO



    
    

    
    //========================================================================EVALUAR PEDIDO
    @PostMapping("/evaluar_pedido")
    public ResponseEntity<String> evaluarPedido(@RequestBody String json) {
        /* json {"id_proveedor":"1", "codigo_seguimiento":"ABCD123456", "valor":"Muy Malo"} */

        CredencialesBean credenciales = credencialesService.obtenerCredenciales(json);
        String url = credenciales.getNombre_url();
        String token = credenciales.getToken();
        ServiceClient client = clientFactory.getClient(url);

        try {
            client.evaluarPedido(token, url, json);
            try {
                String jsonConfig = repository.evaluarPedido(json);
                return new ResponseEntity<>(jsonConfig, HttpStatus.OK);
            } catch (Exception e) {
                System.out.println("Exception in repository call: " + e.getMessage());
                return new ResponseEntity<>("Error evaluando pedido en el repositorio: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
            }
        }  catch (Exception e) {
            System.out.println("Exception in client call: " + e.getMessage());
            return new ResponseEntity<>("No se puede evaluar: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
  //========================================================================EVALUAR PEDIDO


    

    //========================================================================OBTENGO RANKING/PONDERACION PROPIA
      @PostMapping(
    	      path="/ranking_ponderado",
    	      consumes = {MediaType.APPLICATION_JSON_VALUE},
    	      produces = MediaType.APPLICATION_JSON_VALUE
    	    )
    public ResponseEntity<String> getRankingPonderado(@RequestBody JsonNode Json) {
    	try {
            String jsonConfig = repository.getRankingPonderado(Json);
            return new ResponseEntity<>(jsonConfig, HttpStatus.OK);
        } catch (Exception e) {
            System.out.println("Exception: " + e.getMessage());
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
      //========================================================================OBTENGO RANKING/PONDERACION PROPIA


      

      //========================================================================OBTENGO PRODUCTOS POR PROVEEDOR PROPIA
        @PostMapping(
      	      path="/productos_proveedor",
      	      consumes = {MediaType.APPLICATION_JSON_VALUE},
      	      produces = MediaType.APPLICATION_JSON_VALUE
      	    )
      public ResponseEntity<String> getProductosProveedor(@RequestBody JsonNode Json) {
      	try {
              String jsonConfig = repository.getProductosProveedor(Json);
              return new ResponseEntity<>(jsonConfig, HttpStatus.OK);
          } catch (Exception e) {
              System.out.println("Exception: " + e.getMessage());
              return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
          }
      }
        //========================================================================OBTENGO PRODUCTOS POR PROVEEDOR PROPIA


        

        //========================================================================OBTENGO PEDIDOS POR PROVEEDOR PROPIA
          @PostMapping(
        	      path="/pedido_proveedor",
        	      consumes = {MediaType.APPLICATION_JSON_VALUE},
        	      produces = MediaType.APPLICATION_JSON_VALUE
        	    )
        public ResponseEntity<String> getPedidoProveedor(@RequestBody JsonNode Json) {
        	try {
                String jsonConfig = repository.getPedidoProveedor(Json);
                return new ResponseEntity<>(jsonConfig, HttpStatus.OK);
            } catch (Exception e) {
                System.out.println("Exception: " + e.getMessage());
                return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
            }
        }
          //========================================================================OBTENGO PEDIDOS POR PROVEEDOR PROPIA


          

          //========================================================================UPDATE DE PONDERACION A UN VALOR DEL RANKING DEL PROVEEDOR PROPIA
            @PostMapping(
          	      path="/update_ponderacion",
          	      consumes = {MediaType.APPLICATION_JSON_VALUE},
          	      produces = MediaType.APPLICATION_JSON_VALUE
          	    )
          public ResponseEntity<String> updatePonderacion(@RequestBody JsonNode Json) {
          	try {
                  String jsonConfig = repository.updatePonderacion(Json);
                  return new ResponseEntity<>(jsonConfig, HttpStatus.OK);
              } catch (Exception e) {
                  System.out.println("Exception: " + e.getMessage());
                  return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
              }
          }
            //========================================================================UPDATE DE PONDERACION A UN VALOR DEL RANKING DEL PROVEEDOR


        

        //========================================================================OBTENGO ESTADISTICA DE PROVEEDOR PROPIA
          @PostMapping(
        	      path="/estadistica_proveedor",
        	      consumes = {MediaType.APPLICATION_JSON_VALUE},
        	      produces = MediaType.APPLICATION_JSON_VALUE
        	    )
        public ResponseEntity<String> getEstadisticaProveedor(@RequestBody JsonNode Json) {
        	try {
                String jsonConfig = repository.getEstadisticaProveedor(Json);
                return new ResponseEntity<>(jsonConfig, HttpStatus.OK);
            } catch (Exception e) {
                System.out.println("Exception: " + e.getMessage());
                return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
            }
        }
          //========================================================================OBTENGO ESTADISTICA DE PROVEEDOR PROPIA
    
    




    

    //========================================================================OBTENGO RANKING DEL PROVEEDOR
    @PostMapping("/ranking")
    public String getRanking(@RequestBody String json) {
    	/*    json		{"id_proveedor":"1"	}    */
        CredencialesBean credenciales = credencialesService.obtenerCredenciales(json);
        
        String url = credenciales.getNombre_url();
        String token = credenciales.getToken();

        ServiceClient client = clientFactory.getClient(url);
        return client.getRanking(token, url);
    }
    //========================================================================OBTENGO RANKING DEL PROVEEDOR
    
    


  //========================================================================OBTENGO LOGIN PROPIO
    @PostMapping(
    	      path="/login",
    	      consumes = {MediaType.APPLICATION_JSON_VALUE},
    	      produces = MediaType.APPLICATION_JSON_VALUE
    	    )
    public ResponseEntity<String> getUsuario(@RequestBody JsonNode usuarioJson) {
    	try {
            String jsonConfig = repository.getUsuario(usuarioJson);
            return new ResponseEntity<>(jsonConfig, HttpStatus.OK);
        } catch (Exception e) {
            System.out.println("Exception: " + e.getMessage());
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
  //========================================================================OBTENGO LOGIN PROPIO
    



    //========================================================================OBTENGO LISTADO DE PEDIDOS PROPIO
    @PostMapping(
    	      path="/pedidos",
    	      produces = MediaType.APPLICATION_JSON_VALUE
    	    )
    public ResponseEntity<String> getPedidos() {
    	try {
            String jsonConfig = repository.getPedidos();
            return new ResponseEntity<>(jsonConfig, HttpStatus.OK);
        } catch (Exception e) {
            System.out.println("Exception: " + e.getMessage());
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
  //========================================================================OBTENGO LISTADO DE PEDIDOS PROPIO
    



    //========================================================================OBTENGO LISTADO DE PROVEEDORES PROPIO
    @PostMapping(
    	      path="/proveedores",
      	      produces = MediaType.APPLICATION_JSON_VALUE
    	    )
    public ResponseEntity<String> getProveedores() {
    	try {
            String jsonConfig = repository.getProveedores();
            return new ResponseEntity<>(jsonConfig, HttpStatus.OK);
        } catch (Exception e) {
            System.out.println("Exception: " + e.getMessage());
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
  //========================================================================OBTENGO LISTADO DE PROVEEDORES PROPIO
    



    //========================================================================ALTA/BAJA PROVEEDOR PROPIO (habilitado=0/1)
    @PostMapping(
  	      path="/altabaja_proveedor",
  	      consumes = {MediaType.APPLICATION_JSON_VALUE},
  	      produces = MediaType.APPLICATION_JSON_VALUE
  	    )
  public ResponseEntity<String> altabajaProveedor(@RequestBody String Json) {
  	try {
          String jsonConfig = repository.altabajaProveedor(Json);
          return new ResponseEntity<>(jsonConfig, HttpStatus.OK);
      } catch (Exception e) {
          System.out.println("Exception: " + e.getMessage());
          return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
      }
  }
  //========================================================================ALTA/BAJA PROVEEDOR PROPIO (habilitado=0/1)
    



    //========================================================================OBTENGO DETALLE DEL PEDIDO PROPIO
    @PostMapping(
  	      path="/"
  	      		+ "detalle_pedido",
  	      consumes = {MediaType.APPLICATION_JSON_VALUE},
  	      produces = MediaType.APPLICATION_JSON_VALUE
  	    )
  public ResponseEntity<String> getDetallePedido(@RequestBody String Json) {
  	try {
          String jsonConfig = repository.getDetallePedido(Json);
          return new ResponseEntity<>(jsonConfig, HttpStatus.OK);
      } catch (Exception e) {
          System.out.println("Exception: " + e.getMessage());
          return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
      }
  }
  //========================================================================OBTENGO DETALLE DEL PEDIDO PROPIO
    



    //========================================================================OBTENGO LISTADO DE PRODUCTOS PROPIO -JOIN CON LOS DEL PROVEEDOR
    @PostMapping(
  	      path="/productos_join",
  	      consumes = {MediaType.APPLICATION_JSON_VALUE},
  	      produces = MediaType.APPLICATION_JSON_VALUE
  	    )
  public ResponseEntity<String> getProductosJoin(@RequestBody String Json) {
  	try {
          String jsonConfig = repository.getProductosJoin(Json);
          return new ResponseEntity<>(jsonConfig, HttpStatus.OK);
      } catch (Exception e) {
          System.out.println("Exception: " + e.getMessage());
          return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
      }
  }
  //========================================================================OBTENGO LISTADO DE PRODUCTOS PROPIO -JOIN CON LOS DEL PROVEEDOR
    



    //========================================================================INSERTO DATOS DEL PROVEEDOR PROPIO
    @PostMapping(
  	      path="/insertar_datos_proveedor",
  	      consumes = {MediaType.APPLICATION_JSON_VALUE},
  	      produces = MediaType.APPLICATION_JSON_VALUE
  	    )
  public ResponseEntity<String> insertDatosProveedor(@RequestBody String Json) {
  	try {
          String jsonConfig = repository.insertDatosProveedor(Json);
          return new ResponseEntity<>(jsonConfig, HttpStatus.OK);
      } catch (Exception e) {
          System.out.println("Exception: " + e.getMessage());
          return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
      }
  }
  //========================================================================INSERTO DATOS DEL PROVEEDOR PROPIO



    
    

    
    //========================================================================OBTENGO DATOS ALTA PROVEEDOR
    @PostMapping("/datos_proveedor")
    public ResponseEntity<String> obtengoDatos(@RequestBody String json) {
        Gson gson = new Gson();
        CredencialesBean credenciales = gson.fromJson(json, CredencialesBean.class);
        String url = credenciales.getNombre_url();
        String token = credenciales.getToken();
        ServiceClient client = clientFactory.getClient(url);

        Map<String, Object> combinedResponse = new HashMap<>();

        try {
            String configuracion = client.getConfiguracion(token, url);
            String ranking = client.getRanking(token, url);
            String productos = client.getProductos(token, url);

            // Deserializar los JSON internos antes de incluirlos en la respuesta combinada
            JsonElement configuracionJson = gson.fromJson(configuracion, JsonElement.class);
            JsonElement rankingJson = gson.fromJson(ranking, JsonElement.class);
            JsonElement productosJson = gson.fromJson(productos, JsonElement.class);

            combinedResponse.put("configuracion", configuracionJson);
            combinedResponse.put("ranking", rankingJson);
            combinedResponse.put("productos", productosJson);

            return ResponseEntity.ok(gson.toJson(combinedResponse));
        } catch (Exception e) {
            JsonObject errorResponse = new JsonObject();
            errorResponse.addProperty("error", e.getMessage());
            return ResponseEntity.status(500).body(gson.toJson(errorResponse));
        }
    }
  //========================================================================OBTENGO DATOS ALTA  PROVEEDOR
    
    

    
    
    
    
    
//================================================================================================================================================
//================================================================================================================================================
    //========================================================================REALIZAR PEDIDOS AUTOMATICOS - LLAMA A -> PedidosAutomaticosService
    @PostMapping("/realizar_pedidos")
    public ResponseEntity<String> realizarPedidos() {
        return PedidosAutomaticosService.realizarPedidos();
    }
    //========================================================================REALIZAR PEDIDOS AUTOMATICOS - LLAMA A -> PedidosAutomaticosService
//================================================================================================================================================
//================================================================================================================================================
    
        
    
        
    
    
     
    
    
    
 }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    