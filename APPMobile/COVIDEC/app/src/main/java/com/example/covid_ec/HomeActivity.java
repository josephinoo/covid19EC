package com.example.covid_ec;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.graphics.Color;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;
import android.widget.ToggleButton;

import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;

import java.util.ArrayList;
import java.util.Hashtable;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;
import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;

public class HomeActivity extends AppCompatActivity {
    Usuario user;
    EditText lugar,fecha,peso,talla,telefono,telefonoContacto;
    TextView nombreTV;
    ToggleButton sexo;
    Button botonEditar;
    ListView listView1;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_home);

        this.sexo = (ToggleButton) findViewById(R.id.sexoid);
        this.lugar = (EditText)findViewById(R.id.lugarid);
        this.fecha = (EditText)findViewById(R.id.fechaid);
        this.peso = (EditText)findViewById(R.id.pesoid);
        this.talla = (EditText)findViewById(R.id.tallaid);
        this.telefono = (EditText)findViewById(R.id.telefonoid);
        this.telefonoContacto = (EditText)findViewById(R.id.telefonoContactoid);
//        this.listView1=(ListView) findViewById(R.id.listView);
        user = (Usuario) getIntent().getSerializableExtra("user");
        nombreTV = (TextView) findViewById(R.id.nombreTV);
        botonEditar = (Button) findViewById(R.id.editarbtnid);
        String nombreText="HOLA: "+user.getUsername();
        nombreTV.setText(nombreText);

        /*
        * Se deben settear todos los campos con los valores que se deben obtener de la DB        *
        * */

        String lugarDB="";String fechaDB="";String sexoDB="";String pesoDB="";String tallaDB="";String telefonoDB="";String contactoDB="";

        if (sexoDB.equals("FEMENINO")){
            sexo.setChecked(true);
        }
        else{
            sexo.setChecked(false);
        }
        lugar.setText(lugarDB);
        fecha.setText(fechaDB);
        peso.setText(pesoDB);
        talla.setText(tallaDB);
        telefono.setText(telefonoDB);
        telefonoContacto.setText(contactoDB);

        ArrayList<EditText> textos = new ArrayList<EditText>();
        textos.add(lugar);
        textos.add(fecha);
        textos.add(peso);
        textos.add(talla);
        textos.add(telefono);
        textos.add(telefonoContacto);

        for (EditText et : textos){
            et.setEnabled(false);
       }

    }


    public void cambiarColor(View v){

        if(sexo.isChecked()) {
            sexo.setBackgroundColor(Color.parseColor("#ff4e4e"));
        }
        else{
            sexo.setBackgroundColor(Color.parseColor("#19608d"));
        }
    }

    public void editarButton(View v){

        if (botonEditar.getText().toString().equals("EDITAR")){
            telefono.setEnabled(true);
            telefonoContacto.setEnabled(true);
            botonEditar.setText("GUARDAR");
        }
        else{
            /*
            * Se actualiza en la base de datos los nuevos valores ingresados de numeros telefonicos
            * */

            if (envioDeTelefonos()) {
                botonEditar.setText("EDITAR");
                Intent i = new Intent(this, MainHomeActivity.class);
                i.putExtra("user", user);
                Toast toast = Toast.makeText(getApplicationContext(),"Cambio Exitoso",Toast.LENGTH_SHORT);
                toast.show();
                startActivity(i);
            }
            else{
                Toast toast = Toast.makeText(getApplicationContext(),"Fallo de conexión",Toast.LENGTH_LONG);
                toast.show();
            }
        }


    }



    public boolean envioDeTelefonos(){

        /*
        *  Envio de telefonos a la nube
        *  Si es exitoso retorna true,
        *  Caso contrario false
        */
        return true;
    }





}
