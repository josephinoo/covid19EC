package com.example.covid_ec;

import java.io.Serializable;

public class Recomendacion implements Serializable {
    String nombreDoctor;
    String fecha; // No le puse el objeto date para mas simplicidad
    String mensaje;

    public Recomendacion(String nombreDoctor,String fecha,String mensaje){
        this.nombreDoctor = nombreDoctor;
        this.fecha = fecha;
        this.mensaje= mensaje;
    }

    public String getNombreDoctor() {
        return nombreDoctor;
    }

    public String getFecha() {
        return fecha;
    }

    public String getMensaje() {
        return mensaje;
    }

    public void setNombreDoctor(String nombreDoctor) {
        this.nombreDoctor = nombreDoctor;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public void setMensaje(String mensaje) {
        this.mensaje = mensaje;
    }

    @Override
    public String toString() {
        return "Recomendacion{" +
                "nombreDoctor='" + nombreDoctor + '\'' +
                ", fecha='" + fecha + '\'' +
                ", mensaje='" + mensaje + '\'' +
                '}';
    }
}
