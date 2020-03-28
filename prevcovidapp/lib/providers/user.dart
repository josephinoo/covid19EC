import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class User with ChangeNotifier {
  String _ci;
  String _localId;
  String _lugarContagio;
  String _sexo;
  String _altura;
  String _tlfn;
  String _tlfnEmergencia;
  String _nombre;
  DateTime _fechaContagio;
  final mapa;
  User(this.mapa);

  Future<void> obtenerDatos() async {
    //print(mapa as Map<String,String>);
    if ((mapa as Map<String, String>).isEmpty) return;
    final id = (mapa as Map<String, String>)['userId'];
    final authToken = (mapa as Map<String, String>)['token'];
    final url =
        "https://covid19app-2cf50.firebaseio.com/users/$id.json?auth=$authToken";
    final response = await http.get(url);
    final datos = json.decode(response.body) as Map<String, dynamic>;
    if (datos == null) return;
    _altura = datos['altura'];
    _ci = datos['cedula'];
    _localId = id;
    _lugarContagio = datos['lugarContagio'];
    _sexo = datos['sexo'];
    _tlfn = datos['telefono'];
    _nombre=datos['nombre'];

    _tlfnEmergencia = datos['telefonoEmergencia'];
    _fechaContagio = DateTime.parse(datos['fechaContagio']);
    print(datos);
  }

  bool isEmpty() {
    return _ci == null &&
        _fechaContagio == null &&
        _localId == null &&
        _lugarContagio == null &&
        _sexo == null &&
        _tlfn == null &&
        _tlfnEmergencia == null&&
        _altura==null&&_nombre==null;
      
  }
  String get nombre{
    return _nombre;
  }
}
