package com.rest.beans;

public class CredencialesBean {
	private String nombre_url;
    private String token;

    public CredencialesBean(String nombre_url, String token) {
        this.nombre_url = nombre_url;
        this.token = token;
    }

    public String getNombre_url() {
        return nombre_url;
    }

    public String getToken() {
        return token;
    }
}
