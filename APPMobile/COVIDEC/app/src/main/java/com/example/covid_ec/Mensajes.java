package com.example.covid_ec;

import androidx.appcompat.app.AppCompatActivity;

import android.graphics.Color;
import android.os.Bundle;
import android.widget.LinearLayout;
import android.widget.TextView;

import java.util.ArrayList;

public class Mensajes extends AppCompatActivity {
    Usuario user;
    TextView nombreTV;
    LinearLayout linear;
    ArrayList<Recomendacion> lista;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_mensajes);
        user = (Usuario) getIntent().getSerializableExtra("user");
        nombreTV = (TextView) findViewById(R.id.usernameid);
        nombreTV.setText(user.getUsername());
        linear = (LinearLayout) findViewById(R.id.linearlayout);

       lista = (ArrayList<Recomendacion>) getIntent().getSerializableExtra("mapa");
        System.out.println(lista);
        cargarRecomendacion();
    }

    public ArrayList<Recomendacion> cargarRecomendacion(){
        /*
         * Acceder a la base de datos y cargar todas las recetas existentes en el objeto Recomendacion
         * Anadirlas al ArrayList
         * */
        ArrayList<Recomendacion> recomendaciones = lista;
        /*
         * RECOMENDACIONES DE PRUEBA
         * */
       // recomendaciones.add(new Recomendacion("Lian Alava","22/05/2020","Tome mucha agua"));
       // recomendaciones.add(new Recomendacion("Gustavo Behr","01/06/2020","Ya fue"));


        for (Recomendacion receta: recomendaciones){
            TextView tv = new TextView(linear.getContext());
            String texto = "Dia: "+receta.getFecha()+"  |    Medico: "+receta.getNombreDoctor()+"\nRecomendacion: "+receta.getMensaje()+"\n";
            tv.setText(texto);
            tv.setTextColor(Color.BLACK);
            tv.setTextSize(17);
            tv.setBackgroundResource(R.drawable.rectangulo);
            tv.setPadding(35,32,16,0);


            linear.addView(tv);

        }
        return  recomendaciones;
    }

    private void getInfo(){

    }
}
