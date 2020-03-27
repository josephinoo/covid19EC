package com.example.covid_ec;

import androidx.annotation.IntegerRes;
import androidx.appcompat.app.AppCompatActivity;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.CheckBox;
import android.widget.SeekBar;
import android.widget.TextView;
import android.widget.Toast;

import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;

import java.util.Hashtable;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;
import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;

public class RegisterActivity extends AppCompatActivity {
    Hashtable<Integer, String> estado = new Hashtable<Integer, String>();
    Hashtable<Integer, Integer> estadoToDB = new Hashtable<Integer, Integer>();

    Usuario user;
    SeekBar intensidad, dificultadrespirar, dolor;
    TextView tvintensidad, tvdificultad, tvdolor;
    String infos;
    TextView nombreTV;
    TextView tptemperatura, tpritmocardiaco;
    CheckBox cbtos, cbdificultadRespirar, cbdolorGarganta;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_register);

        user = (Usuario) getIntent().getSerializableExtra("user");
        nombreTV = (TextView) findViewById(R.id.usernameid);
        nombreTV.setText(user.getUsername());


        intensidad = (SeekBar) findViewById(R.id.intensidadtosid);
        dificultadrespirar = (SeekBar) findViewById(R.id.dificultadid);
        dolor = (SeekBar) findViewById(R.id.dolorid);

        tvintensidad = (TextView) findViewById(R.id.TVtosid);
        tvdificultad = (TextView) findViewById(R.id.TVdificultadid);
        tvdolor = (TextView) findViewById(R.id.TVdolorid);

        estado.put(0, "Peor que ayer");
        estado.put(1, "Igual que ayer");
        estado.put(2, "Mejor que ayer");

        estadoToDB.put(0, -1);
        estadoToDB.put(1, 0);
        estadoToDB.put(2, 10);


        tptemperatura = (TextView) findViewById(R.id.temperaturaid);
        tpritmocardiaco = (TextView) findViewById(R.id.ritmoid);

        cbtos = (CheckBox) findViewById(R.id.toscheckid);
        cbdificultadRespirar = (CheckBox) findViewById(R.id.dificultadcheckid);
        cbdolorGarganta = (CheckBox) findViewById(R.id.dolorcheckid);

        tvintensidad.setText(estado.get(intensidad.getProgress()));
        tvdificultad.setText(estado.get(dificultadrespirar.getProgress()));
        tvdolor.setText(estado.get(dolor.getProgress()));


        intensidad.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
            @Override
            public void onProgressChanged(SeekBar seekBar, int i, boolean b) {
                tvintensidad.setText(estado.get(i));
            }

            @Override
            public void onStartTrackingTouch(SeekBar seekBar) {

            }

            @Override
            public void onStopTrackingTouch(SeekBar seekBar) {

            }
        });

        dificultadrespirar.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
            @Override
            public void onProgressChanged(SeekBar seekBar, int i, boolean b) {
                tvdificultad.setText(estado.get(i));
            }

            @Override
            public void onStartTrackingTouch(SeekBar seekBar) {

            }

            @Override
            public void onStopTrackingTouch(SeekBar seekBar) {

            }
        });

        dolor.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
            @Override
            public void onProgressChanged(SeekBar seekBar, int i, boolean b) {
                tvdolor.setText(estado.get(i));
            }

            @Override
            public void onStartTrackingTouch(SeekBar seekBar) {

            }

            @Override
            public void onStopTrackingTouch(SeekBar seekBar) {

            }
        });


    }

    public void enviar(View v) {
        if (envioDataBase(this)) {
            Intent i = new Intent(this, MainHomeActivity.class);
            i.putExtra("user", user);
            Toast toast2 = Toast.makeText(getApplicationContext(), "Conexión Exitosa", Toast.LENGTH_SHORT);
            toast2.show();
            startActivity(i);

        } else {
            Toast toast1 = Toast.makeText(getApplicationContext(), "Conexión Fallida", Toast.LENGTH_LONG);
            toast1.show();
        }


    }

    public boolean envioDataBase(final Context ctx) {
        float temp = Float.parseFloat(tptemperatura.getText().toString());
        int ritmocardiaco = Integer.parseInt(tpritmocardiaco.getText().toString());
        boolean tos;
        int estadoTos;
        boolean dolorGarganta;
        int estadoDolorGarganta;
        boolean dificultadRespirar;
        int estadoDificultadRespirar;


        if (cbtos.isChecked()) {
            tos = true;
            estadoTos = intensidad.getProgress() - 1;
        } else {
            tos = false;
            estadoTos = 0;
        }

        if (cbdolorGarganta.isChecked()) {
            dolorGarganta = true;
            estadoDolorGarganta = dolor.getProgress() - 1;
        } else {
            dolorGarganta = false;
            estadoDolorGarganta = 0;
        }
        if (cbdificultadRespirar.isChecked()) {
            dificultadRespirar = true;
            estadoDificultadRespirar = dificultadrespirar.getProgress() - 1;
        } else {
            dificultadRespirar = false;
            estadoDificultadRespirar = 0;
        }


        /*
         * Envio a la base de datos
         * El return devolvera si se realizo la conexion
         * */
        sendPost(ctx,tptemperatura.getText().toString(),tpritmocardiaco.getText().toString(),tos,estadoTos,dificultadRespirar,estadoDificultadRespirar,dolorGarganta,estadoDolorGarganta);

        return true;
    }

    public void sendPost(final Context ctx,String temperatura, String ritmoCardiaco, boolean hasTos, int estadoTos, boolean hasDi,int estadoDi,boolean hasDolor, int estadoDolor) {
        JsonObject json = new JsonObject();
        json.addProperty("cedula",user.getUsername());
        json.addProperty("temperatura",temperatura);
        json.addProperty("ritmoCardiaco",ritmoCardiaco);
        json.addProperty("hasTos",String.valueOf(hasTos));
        json.addProperty("hasDi",String.valueOf(hasDi));
        json.addProperty("hasDolor",String.valueOf(hasDolor));
        json.addProperty("estadoTos",estado.get(estadoTos));
        json.addProperty("estadoDi",estado.get(estadoDi));
        json.addProperty("estadoDolor",estado.get(estadoDolor));

        Retrofit retrofit = new Retrofit.Builder()
                .baseUrl("https://covid19ec-2d508.firebaseio.com/")
                .addConverterFactory(GsonConverterFactory.create(new GsonBuilder().create()))
                .build();

        InformacionPacienteApi infoApi = retrofit.create(InformacionPacienteApi.class);

        Call<JsonObject> call = infoApi.createPost(json);
        call.enqueue(new Callback<JsonObject>() {
            @Override
            public void onResponse(Call<JsonObject> call, Response<JsonObject> response) {
                Toast.makeText(ctx, "La operacion se realizo con exito", Toast.LENGTH_SHORT).show();
            }

            @Override
            public void onFailure(Call<JsonObject> call, Throwable t) {
                Toast.makeText(ctx, "La operacion no pudo realizarse", Toast.LENGTH_SHORT).show();
            }
        });

    }


}