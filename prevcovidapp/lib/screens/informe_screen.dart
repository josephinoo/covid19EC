import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/checkbox_widget.dart';
import 'dart:convert';
import '../providers/user.dart';
import '../providers/auth.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class InformeScreen extends StatefulWidget {
  static const routeName = "/informe-screen";
  @override
  _InformeScreenState createState() => _InformeScreenState();
}

class _InformeScreenState extends State<InformeScreen> {
  final controllerGrados = TextEditingController();
  final controllerLatXMin = TextEditingController();
  @override
  void dispose() {
    controllerLatXMin.dispose();
    controllerGrados.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final widgetTos = CheckboxWidget("Tos");
    final widgetDificultad = CheckboxWidget("Dificultad para respirar");
    final widgetDolor = CheckboxWidget("Dolor de garganta");
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        width: mq.size.width,
        height: mq.size.height,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.redAccent),
                  ),
                ),
                margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                width: mq.size.width * 0.8,
                height: mq.size.height * 0.07,
                child: Text(
                  "Informe Diario",
                  style: TextStyle(fontSize: 25),
                  textAlign: TextAlign.center,
                ),
              ),
              _buildText("Temperatura", "Grados Centigrados", mq.size,
                  controllerGrados),
              SizedBox(height: 10),
              _buildText("Ritmo Cardiaco", "Latidos por minuto", mq.size,
                  controllerLatXMin),
              SizedBox(height: 15),
              Text(
                "Sintomas: ",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              widgetTos,
              SizedBox(height: 10),
              widgetDificultad,
              SizedBox(height: 10),
              widgetDolor,
              SizedBox(height: 10),
              Container(
                width: mq.size.width*0.4,
                child: FlatButton(
                  color: Colors.blue,
                  onPressed: () {
                    if (controllerLatXMin.text.isEmpty ||
                        controllerLatXMin.text.isEmpty) {
                      showDialog<Null>(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: Text(
                            "DATOS",
                            textAlign: TextAlign.center,
                          ),
                          content: Text(
                            "No ha completado todos los Campos",
                            textAlign: TextAlign.center,
                          ),
                          actions: <Widget>[
                            FlatButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                },
                                child: Text("Okay"))
                          ],
                        ),
                      );
                    } else {
                      _sendData(
                        _getData(
                          widgetTos.data,
                          widgetDificultad.data,
                          widgetDolor.data,
                        ),
                      );
                      Navigator.of(context).pop();
                      Fluttertoast.showToast(
                        msg: "Envio Exitoso",
                        toastLength: Toast.LENGTH_SHORT,
                      );
                    }
                  },
                  child: Text(
                    "Enviar",
                    style: TextStyle(fontSize: 18,color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String _getData(
    Map<String, dynamic> m1,
    Map<String, dynamic> m2,
    Map<String, dynamic> m3,
  ) {
    return json.encode({
      'fechaDiag': DateTime.now().toIso8601String(),
      'temperatura': controllerGrados.text,
      'ritmoCardiaco': controllerLatXMin.text,
      'hasTos': m1['hasTos'],
      'estado': m1['estado'],
      'hasDificultad': m2['hasDificultad para respirar'],
      'estado': m2['estado'],
      'hasDolor': m3['hasDolor de garganta'],
      'estado': m3['estado'],
    });
  }

  Future<void> _sendData(String data) async {
    final user = Provider.of<User>(context, listen: false);
    final auth = Provider.of<Auth>(context, listen: false);
    final id = user.localId;
    final authToken = auth.token;
    final url =
        'https://covid19app-2cf50.firebaseio.com/diagnostico/$id.json?auth=$authToken';
    try {
      final request = await http.post(url, body: data);
      if (request.statusCode >= 400) {
        showDialog<Null>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text(
              "Algo a Ocurrido",
              textAlign: TextAlign.center,
            ),
            content: Text(
              "Intentelo en unos minutos despues",
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Text("Okay"))
            ],
          ),
        );
      }
    } catch (error) {
      showDialog<Null>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(
            "Algo a Ocurrido",
            textAlign: TextAlign.center,
          ),
          content: Text(
            error.toString(),
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Text("Okay"))
          ],
        ),
      );
    }
  }

  Widget _buildText(
      String texto, String label, Size size, TextEditingController controller) {
    return Container(
      width: size.width * 0.85,
      height: size.height * 0.1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(
            texto + " :",
            style: TextStyle(fontSize: 18),
          ),
          Container(
            width: size.width * 0.4,
            height: size.height * 0.1,
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: label,
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red))),
            ),
          ),
        ],
      ),
    );
  }
}
