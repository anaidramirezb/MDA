/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.mda;

import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Heckutoru
 */
@Entity
@Table(name = "details")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Details.findAll", query = "SELECT d FROM Details d")
    , @NamedQuery(name = "Details.findByLineNumber", query = "SELECT d FROM Details d WHERE d.lineNumber = :lineNumber")
    , @NamedQuery(name = "Details.findByRoute", query = "SELECT d FROM Details d WHERE d.route = :route")
    , @NamedQuery(name = "Details.findBySchedul", query = "SELECT d FROM Details d WHERE d.schedul = :schedul")})
public class Details implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Column(name = "line_number")
    private Integer lineNumber;
    @Column(name = "route")
    private String route;
    @Column(name = "schedul")
    private String schedul;
    @Column(name = "schedul_back")
    private String schedul_back;

    public Details() {
    }

    public Details(Integer lineNumber) {
        this.lineNumber = lineNumber;
    }

    public Integer getLineNumber() {
        return lineNumber;
    }

    public void setLineNumber(Integer lineNumber) {
        this.lineNumber = lineNumber;
    }

    public String getRoute() {
        return route;
    }

    public void setRoute(String route) {
        this.route = route;
    }

    public String getSchedul() {
        return schedul;
    }

    public void setSchedul(String schedul) {
        this.schedul = schedul;
    }

    public String getSchedul_back() {
        return schedul_back;
    }

    public void setSchedul_back(String schedul_back) {
        this.schedul_back = schedul_back;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (lineNumber != null ? lineNumber.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Details)) {
            return false;
        }
        Details other = (Details) object;
        if ((this.lineNumber == null && other.lineNumber != null) || (this.lineNumber != null && !this.lineNumber.equals(other.lineNumber))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.mycompany.mda.Details[ lineNumber=" + lineNumber + " ]";
    }

}
