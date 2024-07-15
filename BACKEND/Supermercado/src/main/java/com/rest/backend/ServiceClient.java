package com.rest.backend;


public interface ServiceClient {
    String getConfiguracion(String token, String url);
    String getProductos(String token, String url);
	String getPedido(String token, String url, String json);
	String getRanking(String token, String url);
	String cancelarPedido(String token, String url, String json);
	String evaluarPedido(String token, String url, String json);
	String getPedidos(String token, String url);
	String insertPedidos(String token, String url, String json);
}
