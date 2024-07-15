package com.rest.services;

import com.google.gson.Gson;
import com.rest.beans.CredencialesBean;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.stereotype.Service;

@Service
public class CredencialesService {

    private final NamedParameterJdbcTemplate namedParameterJdbcTemplate;
    private final Gson gson;

    @Autowired
    public CredencialesService(NamedParameterJdbcTemplate namedParameterJdbcTemplate) {
        this.namedParameterJdbcTemplate = namedParameterJdbcTemplate;
        this.gson = new Gson();  // Inicializa Gson
    }

    public CredencialesBean obtenerCredenciales(String idProveedor) {

        String sql = "EXEC OBTENER_CREDENCIALES :json";
        SqlParameterSource namedParameters = new MapSqlParameterSource()
                .addValue("json",idProveedor );

        return namedParameterJdbcTemplate.queryForObject(sql, namedParameters, (rs, rowNum) -> {
            String credencialesJson = rs.getString("credenciales");
            // Parsear el JSON a un objeto Credenciales usando Gson
            return gson.fromJson(credencialesJson, CredencialesBean.class);
        });
    }
}
