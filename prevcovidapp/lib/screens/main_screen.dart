import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user.dart';
class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userInfo=Provider.of<User>(context);
    userInfo.obtenerDatos();
    return Scaffold(
      body: Center(child: Text("HOLIIIII!!!!!"),),
    );
  }
}