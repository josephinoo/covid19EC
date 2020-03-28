import 'package:flutter/material.dart';
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

    print(userInfo);
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
                    margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                    width: mq.size.width * 0.8,
                    height: mq.size.height * 0.1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Hola " + userInfo.nombre),
                        IconButton(icon: Icon(Icons.mail), onPressed: () {})
                      ],
                    ),
                  ),
                  Container(
                    child: Image.asset(
                      "assets/images/logo.png",
                      fit: BoxFit.contain,
                    ),
                    width: mq.size.width*0.65,
                    height: mq.size.height*0.3,
                  ),
                  _builtButtons("Informacion Persona", mq.size),
                  _builtButtons("Informe de datos diarios", mq.size),
                  _builtButtons("Evolucion de los sintomas", mq.size),
                  

                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _builtButtons(String texto, Size s){

    return  InkWell(
      child: Container(
        alignment: Alignment.center,
      width: s.width*0.7,
      height: s.height*0.08,
        child: Text(texto),
      ),
    );
  }
}
