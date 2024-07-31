package com.ws;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.jws.WebResult;
import javax.jws.WebService;
import javax.naming.AuthenticationException;
import org.apache.cxf.interceptor.Fault;

import ar.edu.ubp.das.db.Dao;
import ar.edu.ubp.das.db.DaoFactory;

@WebService(targetNamespace = "http://ws/", portName = "ConfiguracionesWSPort", serviceName = "ConfiguracionesWSService")
public class ConfiguracionesWS {

    private void validarToken(String token) throws AuthenticationException, SQLException {
        try (Dao<String, String, String> dao = DaoFactory.getDao("Autorizacion", "com")) {
            if (!dao.valid(token)) {
                throw new AuthenticationException("Token no válido " + token);
            }
        }
    }

    @WebMethod(operationName = "getConfiguracion", action = "urn:GetConfiguracion")
    @WebResult(name = "return")
    public  List<String> getConfiguracion(@WebParam(name = "arg0") String token) {
        try {
            validarToken(token);
            try (Dao<String, String, String> daoConfiguracion = DaoFactory.getDao("Configuracion", "com")) {
                return daoConfiguracion.select(null);
            } catch (SQLException e) {
                throw new Fault(e);
            }
        } catch (AuthenticationException | SQLException e) {
            throw new Fault(e);
        }
    }



    @WebMethod(operationName = "getPedidos", action = "urn:GetPedidos")
    @WebResult(name = "return")
    public  List<String> getPedidos(@WebParam(name = "arg0") String token) {
        try {
            validarToken(token);
            try (Dao<String, String, String> dao = DaoFactory.getDao("Pedidos", "com")) {
                return dao.select(null);
            } catch (SQLException e) {
                throw new Fault(e);
            }
        } catch (AuthenticationException | SQLException e) {
            throw new Fault(e);
        }
    }
    
    
    
    
    
    @WebMethod(operationName = "getProductos", action = "urn:GetProductos")
    @WebResult(name = "return")
    public List<String> getProductos(@WebParam(name = "arg0") String token) {
        try {
            validarToken(token);
            try (Dao<String, String, String> daoProductos = DaoFactory.getDao("Productos", "com")) {
                return daoProductos.select(null);
            } catch (SQLException e) {
                throw new Fault(e);
            }
        } catch (AuthenticationException | SQLException e) {
            throw new Fault(e);
        }
    }

    @WebMethod(operationName = "getRanking", action = "urn:GetRanking")
    @WebResult(name = "return")
    public List<String> getRanking(@WebParam(name = "arg0") String token) {
        try {
            validarToken(token);
            try (Dao<String, String, String> daoRanking = DaoFactory.getDao("Ranking", "com")) {
                return daoRanking.select(null);
            } catch (SQLException e) {
                throw new Fault(e);
            }
        } catch (AuthenticationException | SQLException e) {
            throw new Fault(e);
        }
    }

    @WebMethod(operationName = "getPedido", action = "urn:GetPedido")
    @WebResult(name = "return")
    public List<String> getPedido(@WebParam(name = "arg0") String token, 
    							  @WebParam(name = "arg1") String json) {
        try {
            validarToken(token);
            try (Dao<String, String, String> daoProductos = DaoFactory.getDao("Pedido", "com")) {
                 return daoProductos.select(json);
            } catch (SQLException e) {
                throw new Fault(e);
            }
        } catch (AuthenticationException | SQLException e) {
            throw new Fault(e);
        }
    }

   
    @WebMethod(operationName = "cancelarPedido", action = "urn:CancelarPedido")
    @WebResult(name = "return")
    public  String cancelarPedido(@WebParam(name = "arg0") String token, 
    						      @WebParam(name = "arg1") String json) {
        try {
            validarToken(token);
            try (Dao<String, String, String> daoCancelarPedido = DaoFactory.getDao("PedidoCancelar", "com")) {
               return daoCancelarPedido.update(json);
            } catch (SQLException e) {
                throw new Fault(e);
            }
        } catch (AuthenticationException | SQLException e) {
            throw new Fault(e);
        }
    }

    @WebMethod(operationName = "evaluarPedido", action = "urn:EvaluarPedido")
    @WebResult(name = "return")
    public String evaluarPedido(@WebParam(name = "arg0") String token, 
    							@WebParam(name = "arg1") String json) {
        try {
            validarToken(token);
            try (Dao<String, String, String> daoEvaluarPedido = DaoFactory.getDao("PedidoEvaluar", "com")) {
                return daoEvaluarPedido.update(json);
            } catch (SQLException e) {
                throw new Fault(e);
            }
        } catch (AuthenticationException | SQLException e) {
            throw new Fault(e);
        }
    }
    


    @WebMethod(operationName = "insertPedidos", action = "urn:InsertPedidos")
    @WebResult(name = "return")
    public List<String> insertPedidos(@WebParam(name = "arg0") String token, @WebParam(name = "arg1") String json) {
        try {
            validarToken(token);
            try (Dao<String, String, String> daoInsertarPedido = DaoFactory.getDao("DetallePedido", "com")) {
                String insertResult = daoInsertarPedido.insert(json);
                if ("OK".equals(insertResult)) {
                    return daoInsertarPedido.select(null);
                } else {
                    List<String> errorResult = new ArrayList<>();
                    errorResult.add("Error: No se pudo insertar el pedido.");
                    return errorResult;
                }
            } catch (SQLException e) {
                List<String> errorResult = new ArrayList<>();
                errorResult.add("Error: " + e.getMessage());
                return errorResult;
            }
        } catch (AuthenticationException | SQLException e) {
            List<String> errorResult = new ArrayList<>();
            errorResult.add("Error: " + e.getMessage());
            return errorResult;
        }
    }
    



}
