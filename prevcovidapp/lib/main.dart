import 'package:flutter/material.dart';
import 'package:prevcovidapp/providers/auth.dart';
import 'package:prevcovidapp/providers/user.dart';
import 'package:prevcovidapp/screens/main_screen.dart';
import 'package:prevcovidapp/screens/signup_screen.dart';
import './screens/auth_screen.dart';
import 'package:provider/provider.dart';
import './screens/informe_screen.dart';
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
        ChangeNotifierProxyProvider<Auth, User>(
          create: (_) => null,
          update: (_, auth, user) => User(auth.isAuth ? {'userId':auth.userId,'token':auth.token} : Map<String,String>()),
        )
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, chil) => MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: auth.isAuth
              ? MainScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapchot) =>
                      authResultSnapchot.connectionState ==
                              ConnectionState.waiting
                          ? Scaffold(
                              body: Center(
                                child: Text("Loading......"),
                              ),
                            )
                          : AuthScreen()),
          routes: {
            SignUpScreen.routeName: (ctx) => SignUpScreen(),
            InformeScreen.routeName:(ctx)=>InformeScreen(),
          },
        ),
      ),
    );
  }
}
