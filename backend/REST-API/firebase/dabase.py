from firebase import firebase

firebase=firebase.FirebaseApplication("https://covid19ec-2d508.firebaseio.com/",None)
data={

    "nombre":"Joseph Avila",

    "genero":"Masculino",
    "edad":"20",
    "cedula" : "0959300799",
    "direccion":"Jaime Roldos",
    "numeroContacto":"09919498919",
    "email":"prueba@gmail.com"

    
}
result=firebase.post("pacientes",data)

     var ctx =document.getElementById("MyChart").getContext("2d");
     var MyChart=new Chart(ctx,{
     type:"line",
    data:[20, 10]
    
    });