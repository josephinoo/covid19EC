package com.example.covid_ec;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.view.View;
import android.widget.EditText;
import android.widget.Toast;

public class MainActivity extends AppCompatActivity {

    EditText username,password;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        this.username = (EditText)findViewById(R.id.usernameid);
        this.password = (EditText)findViewById(R.id.passwordid);

    }

    public void iniciarSesion(View view) {

        /*
        * Objeto Usuario
        */
        Usuario user = new Usuario(username.getText().toString());

        if (validandoSesion(user.getUsername(),password.getText().toString())){
            /*
            * Aqui se hace la peticion al server de los datos del usuario
            * correspondiente.
            * Se setean los valores del Objeto user (Usuario) nombres, apellidos, telfn, etc
            * */

            Intent i = new Intent(this, MainHomeActivity.class );
            i.putExtra("user", user);
            Toast toast1 = Toast.makeText(getApplicationContext(),"Conexión Exitosa",Toast.LENGTH_SHORT);
            toast1.show();
            startActivity(i);
        }
        else{
            Toast toast = Toast.makeText(getApplicationContext(),"Fallo de conexión",Toast.LENGTH_LONG);
            toast.show();
        }



    }

    public boolean validandoSesion(String user,String pass){
        /*
        * Chicos aqui va la validacion en el servidor con los parámetros user y pass
        * */
        return true;
    }

    public void openGoogle(View v){
        Uri uri = Uri.parse("https://www.who.int/es/emergencies/diseases/novel-coronavirus-2019");
        Intent intent = new Intent(Intent.ACTION_VIEW, uri);
        startActivity(intent);
    }

    public void openTwitter(View v){
        Uri uri = Uri.parse("https://twitter.com/Salud_Ec");
        Intent intent = new Intent(Intent.ACTION_VIEW, uri);
        startActivity(intent);
    }

    public void openFacebook(View v){
        Uri uri = Uri.parse("https://m.facebook.com/SaludEcuador/");
        Intent intent = new Intent(Intent.ACTION_VIEW, uri);
        startActivity(intent);
    }
}
