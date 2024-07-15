package com.rest.beans;

public class ProveedorBean {
    private int id_proveedor;
    private String nombre;
    private String nombre_url;
    private String token;

    // Getters y setters
    public int getId_proveedor() {
        return id_proveedor;
    }

    public void setId_proveedor(int id_proveedor) {
        this.id_proveedor = id_proveedor;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getNombre_url() {
        return nombre_url;
    }

    public void setNombre_url(String nombre_url) {
        this.nombre_url = nombre_url;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }


}
