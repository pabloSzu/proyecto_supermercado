
package com.ws.jaxws;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;

/**
 * This class was generated by Apache CXF 3.5.6
 * Tue Jul 30 21:58:49 ART 2024
 * Generated source version: 3.5.6
 */

@XmlRootElement(name = "getProductosResponse", namespace = "http://ws/")
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "getProductosResponse", namespace = "http://ws/")

public class GetProductosResponse {

    @XmlElement(name = "return")
    private java.util.List<java.lang.String> _return;

    public java.util.List<java.lang.String> getReturn() {
        return this._return;
    }

    public void setReturn(java.util.List<java.lang.String> new_return)  {
        this._return = new_return;
    }

}

