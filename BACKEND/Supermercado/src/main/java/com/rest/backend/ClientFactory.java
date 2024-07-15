package com.rest.backend;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class ClientFactory {

    @Autowired
    private SoapServiceClient soapServiceClient;

    @Autowired
    private RestServiceClient restServiceClient;

    public ServiceClient getClient(String url) {
        if (url.contains("?wsdl")) {
            return soapServiceClient;
        } else {
            return restServiceClient;
        }
    }
}
