
package com.ws.jaxws;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;

/**
 * This class was generated by Apache CXF 3.5.6
 * Mon Jul 08 12:50:31 ART 2024
 * Generated source version: 3.5.6
 */

@XmlRootElement(name = "getPedidoResponse", namespace = "http://ws/")
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "getPedidoResponse", namespace = "http://ws/")

public class GetPedidoResponse {

    @XmlElement(name = "return")
    private java.util.List<java.lang.String> _return;

    public java.util.List<java.lang.String> getReturn() {
        return this._return;
    }

    public void setReturn(java.util.List<java.lang.String> new_return)  {
        this._return = new_return;
    }

}

