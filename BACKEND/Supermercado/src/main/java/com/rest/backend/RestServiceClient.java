package com.rest.backend;

import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;
import org.springframework.http.ResponseEntity;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.beans.factory.annotation.Autowired;

@Component
public class RestServiceClient implements ServiceClient {

    private final RestTemplate restTemplate;

    @Autowired
    public RestServiceClient(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }

    @Override
    public String getConfiguracion(String token, String url) {
    	url = url + "configuracion";
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "Bearer " + token);
        headers.setContentType(org.springframework.http.MediaType.APPLICATION_JSON);

        HttpEntity<String> entity = new HttpEntity<>(headers);

        ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.POST, entity, String.class);
        return response.getBody();
    }

	@Override
	public String getProductos(String token, String url) {
    	url = url + "productos";
		HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "Bearer " + token);
        headers.setContentType(org.springframework.http.MediaType.APPLICATION_JSON);

        HttpEntity<String> entity = new HttpEntity<>(headers);

        ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.POST, entity, String.class);
        return response.getBody();
	}

	@Override
	public String getPedido(String token, String url, String json) {
    	url = url + "pedido";
		HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "Bearer " + token);
        headers.setContentType(org.springframework.http.MediaType.APPLICATION_JSON);

        // Ejemplo de cómo enviar un cuerpo JSON en la solicitud
        String requestBody = json; // Ejemplo, asegúrate de ajustar según tus necesidades
        HttpEntity<String> entity = new HttpEntity<>(requestBody, headers);

        ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.POST, entity, String.class);
        return response.getBody();
	}

	@Override
	public String getRanking(String token, String url) {
    	url = url + "ranking";
		HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "Bearer " + token);
        headers.setContentType(org.springframework.http.MediaType.APPLICATION_JSON);

        HttpEntity<String> entity = new HttpEntity<>(headers);

        ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.POST, entity, String.class);
        return response.getBody();
	}

	
	
	@Override
	public String cancelarPedido(String token, String url, String json) {
		url = url + "cancelar_pedido";
		HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "Bearer " + token);
        headers.setContentType(org.springframework.http.MediaType.APPLICATION_JSON);

        // Ejemplo de cómo enviar un cuerpo JSON en la solicitud
        String requestBody = json; // Ejemplo, asegúrate de ajustar según tus necesidades
        HttpEntity<String> entity = new HttpEntity<>(requestBody, headers);

        ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.POST, entity, String.class);
        return response.getBody();
	}

	@Override
	public String evaluarPedido(String token, String url, String json) {
		url = url + "evaluar_pedido";
		HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "Bearer " + token);
        headers.setContentType(org.springframework.http.MediaType.APPLICATION_JSON);

        // Ejemplo de cómo enviar un cuerpo JSON en la solicitud
        String requestBody = json; // Ejemplo, asegúrate de ajustar según tus necesidades
        HttpEntity<String> entity = new HttpEntity<>(requestBody, headers);

        ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.POST, entity, String.class);
        return response.getBody();
	}


	
	
	@Override
	public String getPedidos(String token, String url) {
    	url = url + "pedidos";
		HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "Bearer " + token);
        headers.setContentType(org.springframework.http.MediaType.APPLICATION_JSON);

        HttpEntity<String> entity = new HttpEntity<>(headers);

        ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.POST, entity, String.class);
        return response.getBody();
	}
	
	
	@Override
	public String insertPedidos(String token, String url, String json) {
		url = url + "insertar_pedido";
		HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "Bearer " + token);
        headers.setContentType(org.springframework.http.MediaType.APPLICATION_JSON);

        // Ejemplo de cómo enviar un cuerpo JSON en la solicitud
        String requestBody = json; // Ejemplo, asegúrate de ajustar según tus necesidades
        HttpEntity<String> entity = new HttpEntity<>(requestBody, headers);

        ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.POST, entity, String.class);
        return response.getBody();
	}
	



}
