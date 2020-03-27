import 'dart:io';
import 'package:flutter/material.dart';
import 'package:prevcovidapp/providers/auth.dart';
import 'package:prevcovidapp/screens/signup_screen.dart';
import 'package:provider/provider.dart';

enum AuthMode {
  Signup,
  Login,
}

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth-screen';
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
          width: mq.size.width,
          height: mq.size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: mq.size.height * 0.25,
                width: mq.size.width * 0.85,
                child: Image.asset(
                    "assets/images/Salud_ec_gob.png"), //aun hay que terminarlo
              ),
              AuthCard()
            ],
          ),
        ),
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  var _authMode = AuthMode.Login;
  Map<String, String> _authdata = {'email': '', 'password': ''};
  var _isLoading = false;
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: EdgeInsets.all(15),
        height: _authMode == AuthMode.Login ? deviceSize.height * 0.4 : null,
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                    labelText: "E-mail", icon: Icon(Icons.mail)),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value.isEmpty || !value.contains('@')) {
                    return 'Invalid email!';
                  }
                },
                onSaved: (value) {
                  _authdata['email'] = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Password', icon: Icon(Icons.lock)),
                obscureText: true,
                controller: _passwordController,
                validator: (value) {
                  if (value.isEmpty || value.length < 5) {
                    return 'Password is too short!';
                  }
                },
                onSaved: (value) {
                  _authdata['password'] = value;
                },
              ),
              FlatButton(
                onPressed: _submit,
                child: Text("LOGIN"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('An error Occurred'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Okay")),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authMode == AuthMode.Login) {
        // Log user in
        await Provider.of<Auth>(context, listen: false).signin(
          _authdata['email'],
          _authdata['password'],
        );
        print("object");
      }
    } on HttpException catch (error) {
      var errrorMessage = 'Authentication failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errrorMessage = 'This email address is already in use';
      } else if (error.toString().contains("INVALID_EMAIL")) {
        errrorMessage = 'This is not a valid email address';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errrorMessage = 'This password is too weak';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errrorMessage = 'Could not find a user with that email';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errrorMessage = 'Invalid password';
      }
      _showErrorDialog(errrorMessage);
    } catch (error) {
      const errorMessage = 'Could Not authenticate you, please try again later';
    }

    setState(() {
      _isLoading = false;
    });
  }
}
