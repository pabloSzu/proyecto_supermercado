
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

@XmlRootElement(name = "insertPedidos", namespace = "http://ws/")
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "insertPedidos", namespace = "http://ws/", propOrder = {"arg0", "arg1"})

public class InsertPedidos {

    @XmlElement(name = "arg0")
    private java.lang.String arg0;
    @XmlElement(name = "arg1")
    private java.lang.String arg1;

    public java.lang.String getArg0() {
        return this.arg0;
    }

    public void setArg0(java.lang.String newArg0)  {
        this.arg0 = newArg0;
    }

    public java.lang.String getArg1() {
        return this.arg1;
    }

    public void setArg1(java.lang.String newArg1)  {
        this.arg1 = newArg1;
    }

}

