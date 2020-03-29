import 'package:flutter/material.dart';
import 'package:prevcovidapp/screens/informacion_screen.dart';
import 'package:prevcovidapp/screens/informe_screen.dart';
import 'package:provider/provider.dart';
import '../providers/user.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var _isLoading = true;
  @override
  Widget build(BuildContext context) {
    final userInfo = Provider.of<User>(context, listen: false);

    final mq = MediaQuery.of(context);
    return Scaffold(
      body: FutureBuilder(
        future: userInfo.obtenerDatos(),
        builder: (ctx, snapshot) {
          if (userInfo.isEmpty()) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Container(
              width: mq.size.width,
              height: mq.size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.redAccent),
                      ),
                    ),
                    margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                    width: mq.size.width * 0.8,
                    height: mq.size.height * 0.1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Hola " + userInfo.nombre,style: TextStyle(fontSize: 25),),
                        IconButton(icon: Icon(Icons.mail), onPressed: () {})
                      ],
                    ),
                  ),
                  Container(
                    child: Image.asset(
                      "assets/images/logo.png",
                      fit: BoxFit.contain,
                    ),
                    width: mq.size.width * 0.65,
                    height: mq.size.height * 0.3,
                  ),
                  _builtButtons("Informacion Personal", mq.size, () {
                    Navigator.of(context)
                        .pushNamed(InformacionPersonalScreen.routeName);
                  }),
                  _builtButtons("Informe de datos diarios", mq.size, () {
                    Navigator.of(context).pushNamed(InformeScreen.routeName);
                  }),
                  _builtButtons("Evolucion de los sintomas", mq.size, () {}),
                  Container(
                    width: mq.size.width * 0.6,
                    height: mq.size.height * 0.05,
                    child: Image.asset(
                      "assets/images/Salud_ec_gob.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _builtButtons(String texto, Size s, Function function) {
    return Container(
      width: s.width * 0.8,
      child: FlatButton(
        color: Colors.blue,
        onPressed: function,
        child: Text(texto,style: TextStyle(color: Colors.white,fontSize: 18),),
      ),
    );
  }
}
