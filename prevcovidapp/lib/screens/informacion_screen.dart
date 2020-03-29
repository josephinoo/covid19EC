import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user.dart';
class InformacionPersonalScreen extends StatelessWidget {
  static const routeName = '/informacionScreen';
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final mq = MediaQuery.of(context);
    return Scaffold(
      body: Card(
        child: Container(
          width: mq.size.width,
          height: mq.size.height,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(20),
                  width: mq.size.width * 0.7,
                  height: mq.size.height * 0.3,
                  child: Image.asset(
                    'assets/images/quarantine.png',
                    fit: BoxFit.fill,
                  ),
                ),
                _buildListTitle("Nombre", user.nombre),
                Divider(indent: 5),
                _buildListTitle("Lugar de Contagio", user.lugarContagio),
                Divider(indent: 5),
                _buildListTitle(
                    "Fecha de Contagio", user.fechaContagio.toString()),
                Divider(indent: 5),
                _buildListTitle(" Altura", user.altura),
                Divider(indent: 5),
                _buildListTitle("Telefono", user.tlfn),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildListTitle(String title, String subtitle) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      contentPadding: EdgeInsets.only(left: 20, bottom: 5),
    );
  }
}
