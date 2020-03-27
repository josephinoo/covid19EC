package com.example.covid_ec;
import java.io.Serializable;


public class Usuario implements Serializable {
    private String username,nombres,apellidos,sexo,lugar,fecha,peso,talla,telefono,telefonoContacto;



    public Usuario(String username){
        this.username = username;
    }


    public Usuario(String username, String nombres, String apellidos){
        this.username = username;
        this.nombres = nombres;
        this.apellidos = apellidos;
    }


    public String getUsername() {
        return username;
    }

    public String getNombres() {
        return nombres;
    }

    public String getApellidos() {
        return apellidos;
    }

    public String getSexo() {
        return sexo;
    }

    public String getLugar() {
        return lugar;
    }

    public String getFecha() {
        return fecha;
    }

    public String getPeso() {
        return peso;
    }

    public String getTalla() {
        return talla;
    }

    public String getTelefono() {
        return telefono;
    }

    public String getTelefonoContacto() {
        return telefonoContacto;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setNombres(String nombres) {
        this.nombres = nombres;
    }

    public void setApellidos(String apellidos) {
        this.apellidos = apellidos;
    }

    public String getNombre(){
        String[] div = this.nombres.split(" ");
        return div[0];
    }


    public void setSexo(String sexo) {
        this.sexo = sexo;
    }

    public void setLugar(String lugar) {
        this.lugar = lugar;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public void setPeso(String peso) {
        this.peso = peso;
    }

    public void setTalla(String talla) {
        this.talla = talla;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public void setTelefonoContacto(String telefonoContacto) {
        this.telefonoContacto = telefonoContacto;
    }
}
