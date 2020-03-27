package com.example.covid_ec;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.TextView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;
import com.google.gson.internal.LinkedTreeMap;
import com.google.gson.reflect.TypeToken;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;
import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;

public class MainHomeActivity extends AppCompatActivity {
    Usuario user;
    TextView nombreTV;
    private JsonObject j;
    Map<String, Object> retMap;
    ArrayList<Recomendacion> recomendaciones1=new ArrayList<>();
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main_home);
        user = (Usuario) getIntent().getSerializableExtra("user");
        nombreTV = (TextView) findViewById(R.id.usernameid);
        nombreTV.setText(user.getUsername());
    }

    public void cambiarInfoPersonal(View v) {
        Intent i = new Intent(this, HomeActivity.class);
        i.putExtra("user", user);
        startActivity(i);
    }

    public void registrarSintomas(View v) {
        Intent i = new Intent(this, RegisterActivity.class);
        i.putExtra("user", user);
        startActivity(i);
    }

    public void estadisticas(View view) {
        Intent i = new Intent(this, activity_stadistics.class);
        startActivity(i);
    }


    public void obtenerMensajes() {
        Retrofit retrofit = new Retrofit.Builder()
                .baseUrl("https://covid19ec-2d508.firebaseio.com/")
                .addConverterFactory(GsonConverterFactory.create(new GsonBuilder().create()))
                .build();

        InformacionPacienteApi infoApi = retrofit.create(InformacionPacienteApi.class);
        Call<JsonObject> call = infoApi.getPosts();

        call.enqueue(new Callback<JsonObject>() {
            @Override
            public void onResponse(Call<JsonObject> call, Response<JsonObject> response) {
                j = response.body();
                retMap = new Gson().fromJson(
                        j, new TypeToken<HashMap<String, Object>>() {
                        }.getType()
                );
                // System.out.println(j.get("-M3NeF-OMugt8b0U8UjU"));
                cargarRecomendaciones();
            }

            @Override
            public void onFailure(Call<JsonObject> call, Throwable t) {
                System.out.println(t.getMessage());
            }
        });


    }

    public void mostrarMensajes(View view) {
        obtenerMensajes();
        Intent i = new Intent(this, Mensajes.class);
        startActivity(i);
    }
    public void verRecomendaciones (View v){
        System.out.println(recomendaciones1+"dddddddddddddddddddddd");
        obtenerMensajes();

        final Intent i = new Intent(this, Mensajes.class);
        i.putExtra("user", user);
        new Thread(new Runnable() {
            public void run()
            {
                while (recomendaciones1.isEmpty()){

                }
                i.putExtra("mapa",recomendaciones1);
                startActivity(i);

            }
        }).start();


    }
    private void cargarRecomendaciones(){
        Map<String,ArrayList<Recomendacion>> mapa=new TreeMap<>();
        for(Map.Entry<String, Object> m : retMap.entrySet()){
            LinkedTreeMap o=(LinkedTreeMap) m.getValue();
            Map<String,String> minimapa2=new TreeMap<>();
            for (Object o1 : o.entrySet()) {
                String s=o1.toString();
                String[]oe=s.split("=");
                minimapa2.put(oe[0],oe[1]);

            }
            String id=minimapa2.get("id");
            if(!mapa.containsKey(id)){
                mapa.put(id,new ArrayList());
                mapa.get(id).add(new Recomendacion(minimapa2.get("doctor"),minimapa2.get("fecha"),minimapa2.get("recetas")));
            }else {
                mapa.get(id).add(new Recomendacion(minimapa2.get("doctor"),minimapa2.get("fecha"),minimapa2.get("recetas")));

            }

        }
        recomendaciones1=mapa.get(user.getUsername());
    }


}
