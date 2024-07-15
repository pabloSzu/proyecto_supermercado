package com.rest.backend;

import org.apache.cxf.jaxws.JaxWsProxyFactoryBean;
import org.springframework.stereotype.Component;

@Component
public class SoapServiceClient implements ServiceClient {
    private SoapServiceClientImplementacion soapServiceClientImplementacion;

    public SoapServiceClient() {
        // Constructor por defecto
    }

    public void setServiceUrl(String serviceUrl) {
        JaxWsProxyFactoryBean factory = new JaxWsProxyFactoryBean();
        factory.setServiceClass(SoapServiceClientImplementacion.class);
        factory.setAddress(serviceUrl);
        this.soapServiceClientImplementacion = (SoapServiceClientImplementacion) factory.create();
    }

    @Override
    public String getConfiguracion(String token, String url) {
        setServiceUrl(url);
        if (this.soapServiceClientImplementacion == null) {
            throw new IllegalStateException("SOAP client not initialized with URL");
        }
        return soapServiceClientImplementacion.getConfiguracion(token);
    }

	@Override
	public String getProductos(String token, String url) {
		setServiceUrl(url);
    if (this.soapServiceClientImplementacion == null) {
        throw new IllegalStateException("SOAP client not initialized with URL");
    }
    return soapServiceClientImplementacion.getProductos(token);
	}

	@Override
	public String getPedido(String token, String url, String json) {
		setServiceUrl(url);
	    if (this.soapServiceClientImplementacion == null) {
	        throw new IllegalStateException("SOAP client not initialized with URL");
	    }
	    return soapServiceClientImplementacion.getPedido(token, json);
	}

	@Override
	public String getRanking(String token, String url) {
		setServiceUrl(url);
	    if (this.soapServiceClientImplementacion == null) {
	        throw new IllegalStateException("SOAP client not initialized with URL");
	    }
	    return soapServiceClientImplementacion.getRanking(token);
	}

	@Override
	public String cancelarPedido(String token, String url, String json) {
		setServiceUrl(url);
	    if (this.soapServiceClientImplementacion == null) {
	        throw new IllegalStateException("SOAP client not initialized with URL");
	    }
	    return soapServiceClientImplementacion.cancelarPedido(token, json);
	}

	@Override
	public String evaluarPedido(String token, String url, String json) {
		setServiceUrl(url);
	    if (this.soapServiceClientImplementacion == null) {
	        throw new IllegalStateException("SOAP client not initialized with URL");
	    }
	    return soapServiceClientImplementacion.evaluarPedido(token, json);
	}

	@Override
	public String getPedidos(String token, String url) {
		setServiceUrl(url);
	    if (this.soapServiceClientImplementacion == null) {
	        throw new IllegalStateException("SOAP client not initialized with URL");
	    }
	    return soapServiceClientImplementacion.getPedidos(token);
	}


	@Override
	public String insertPedidos(String token, String url, String json) {
		setServiceUrl(url);
	    if (this.soapServiceClientImplementacion == null) {
	        throw new IllegalStateException("SOAP client not initialized with URL");
	    }
	    return soapServiceClientImplementacion.insertPedidos(token, json);
	}
	
}
