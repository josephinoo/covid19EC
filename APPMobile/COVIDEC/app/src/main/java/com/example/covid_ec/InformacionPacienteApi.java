package com.example.covid_ec;
import com.google.gson.JsonObject;
import retrofit2.Call;
import retrofit2.http.Body;
import retrofit2.http.GET;
import retrofit2.http.POST;

public interface InformacionPacienteApi {
    @GET("recetas.json")
    Call<JsonObject> getPosts();

    @POST("diganostico.json")
    Call<JsonObject> createPost(@Body JsonObject post);

}
