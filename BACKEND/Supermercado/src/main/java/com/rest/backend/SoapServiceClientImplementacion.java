package com.rest.backend;

import javax.jws.WebMethod;
import javax.jws.WebService;

@WebService(targetNamespace = "http://ws/")
public interface SoapServiceClientImplementacion {
	
	
    @WebMethod(operationName = "getConfiguracion", action = "urn:GetConfiguracion")
    String getConfiguracion(String token);

    
    @WebMethod(operationName = "getProductos", action = "urn:GetProductos")
    String getProductos(String token);
    
    
    @WebMethod(operationName = "getPedido", action = "urn:GetPedido")
    String getPedido(String token, String json);


	 @WebMethod(operationName = "getRanking", action = "urn:GetRanking")
   String getRanking(String token);
	 
	 
	 @WebMethod(operationName = "cancelarPedido", action = "urn:CancelarPedido")
	    String cancelarPedido(String token, String json);
	 
	 
	 @WebMethod(operationName = "evaluarPedido", action = "urn:EvaluarPedido")
	    String evaluarPedido(String token, String json);
	 
	 
	 @WebMethod(operationName = "getPedidos", action = "urn:GetPedidos")
	    String getPedidos(String token);

	    
    @WebMethod(operationName = "insertPedidos", action = "urn:InsertPedidos")
    String insertPedidos(String token, String json);

}

