import 'package:flutter/material.dart';
import 'package:prevcovidapp/providers/auth.dart';
import 'package:prevcovidapp/screens/signup_screen.dart';
import './screens/auth_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: AuthScreen(),
        routes: {
          SignUpScreen.routeName:(ctx)=>SignUpScreen(),
        },
      ),
    );
  }
}
