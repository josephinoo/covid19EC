import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class User with ChangeNotifier{

  String _ci;
  String _localId;
  String _lugarContagio;
  String _sexo;
  String _peso;
  String _altura;
  String _tlfn;
  String _tlfnEmergencia;
 
 final mapa;
 User(this.mapa);
  
  Future<void> obtenerDatos() async{
    //print(mapa as Map<String,String>);
    if ((mapa as Map<String,String>).isEmpty) return;
    final id=(mapa as Map<String,String>)['userId'];
    print(id);
    final authToken=(mapa as Map<String,String>)['token'];
    final url="https://covid19app-2cf50.firebaseio.com/users/$id.json?auth=$authToken";
    final response= await http.get(url);
    final datos= json.decode(response.body) as Map<String,dynamic>;
    print( datos['telefono'].runtimeType);
    if (datos==null) return;


  }





}