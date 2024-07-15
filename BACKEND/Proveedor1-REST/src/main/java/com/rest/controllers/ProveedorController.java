package com.rest.controllers;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.JsonNode;
import com.rest.repositories.ProveedorRepository;

@RestController
@RequestMapping(
  path="/proveedor",
  produces={MediaType.APPLICATION_JSON_VALUE}
)
public class ProveedorController {
    @Autowired
    ProveedorRepository repository;

	
    @PostMapping(
            path = "/configuracion",
            produces = MediaType.APPLICATION_JSON_VALUE
        )
        public ResponseEntity<String> getConfiguracion() {
            try {
                String jsonConfig = repository.getConfiguracion();
                return new ResponseEntity<>(jsonConfig, HttpStatus.OK);
            } catch (SecurityException e) {
                System.out.println("SecurityException: " + e.getMessage());
                return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
            }
        }
	 
    @PostMapping(
    	      path="/productos",
    	      produces = MediaType.APPLICATION_JSON_VALUE
    	    )
    public ResponseEntity<String> getProductos() {
        try {
            String jsonConfig = repository.getProductos();
            return new ResponseEntity<>(jsonConfig, HttpStatus.OK);
        } catch (SecurityException e) {
            System.out.println("SecurityException: " + e.getMessage());
            return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
        }
    }

    
    
    @PostMapping(
        path = "/pedido",
        produces = {MediaType.APPLICATION_JSON_VALUE},
        consumes = {MediaType.APPLICATION_JSON_VALUE}
    )
    public ResponseEntity<String> getPedido(@RequestBody JsonNode pedidoJson) {
        try {
            String jsonConfig = repository.getPedido(pedidoJson);
            return new ResponseEntity<>(jsonConfig, HttpStatus.OK);
        } catch (SecurityException e) {
            System.out.println("SecurityException: " + e.getMessage());
            return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
        } catch (Exception e) {
            System.out.println("Exception: " + e.getMessage());
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    


  

    

    @PostMapping(
        path = "/cancelar_pedido",
        produces = {MediaType.APPLICATION_JSON_VALUE},
        consumes = {MediaType.APPLICATION_JSON_VALUE}
    )
    public ResponseEntity<String> cancelarPedido(@RequestBody String pedidoJson) {
        try {
            String jsonConfig = repository.cancelarPedido(pedidoJson);
            return new ResponseEntity<>(jsonConfig, HttpStatus.OK);
        } catch (SecurityException e) {
            System.out.println("SecurityException: " + e.getMessage());
            return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
        } catch (Exception e) {
            System.out.println("Exception: " + e.getMessage());
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    


  

    @PostMapping(
        path = "/evaluar_pedido",
        produces = {MediaType.APPLICATION_JSON_VALUE},
        consumes = {MediaType.APPLICATION_JSON_VALUE}
    )
    public ResponseEntity<String> evaluarPedido(@RequestBody String pedidoJson) {
        try {
            String jsonConfig = repository.evaluarPedido(pedidoJson);
            return new ResponseEntity<>(jsonConfig, HttpStatus.OK);
        } catch (SecurityException e) {
            System.out.println("SecurityException: " + e.getMessage());
            return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
        } catch (Exception e) {
            System.out.println("Exception: " + e.getMessage());
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    


  

    @PostMapping(
    	      path="/ranking",
    	      produces = MediaType.APPLICATION_JSON_VALUE
    	    )
    public ResponseEntity<String> getRanking() {
        try {
            String jsonConfig = repository.getRanking();
            return new ResponseEntity<>(jsonConfig, HttpStatus.OK);
        } catch (SecurityException e) {
            System.out.println("SecurityException: " + e.getMessage());
            return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
        }
    }
    


    

    @PostMapping(
    	      path="/pedidos",
    	      produces = MediaType.APPLICATION_JSON_VALUE
    	    )
    public ResponseEntity<String> getPedidos() {
        try {
            String jsonConfig = repository.getPedidos();
            return new ResponseEntity<>(jsonConfig, HttpStatus.OK);
        } catch (SecurityException e) {
            System.out.println("SecurityException: " + e.getMessage());
            return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
        }
    }

    


    


    

    @PostMapping(
        path = "/insertar_pedido",
        produces = {MediaType.APPLICATION_JSON_VALUE},
        consumes = {MediaType.APPLICATION_JSON_VALUE}
    )
    public ResponseEntity<String> insertarPedido(@RequestBody String pedidoJson) {
        try {
            String jsonConfig = repository.insertarPedido(pedidoJson);
            return new ResponseEntity<>(jsonConfig, HttpStatus.OK);
        } catch (SecurityException e) {
            System.out.println("SecurityException: " + e.getMessage());
            return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
        } catch (Exception e) {
            System.out.println("Exception: " + e.getMessage());
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    
    
    
}
