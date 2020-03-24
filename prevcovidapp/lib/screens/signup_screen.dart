import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName='/signup-screen';
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, String> _authData = {
    'firstName': '',
    'lastName': '',
    'age': '',
    'ci': '',
    'email': '',
    'emergencyPhone': '',
  };
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(25),
        width: mq.size.width,
        height: mq.size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(labelText: 'First Name'),
                      onSaved: (value) {
                        _authData['firstName'] = value;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Last Name'),
                      onSaved: (value) {
                        _authData['lastName'] = value;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Age'),
                      onSaved: (value) {
                        _authData['age'] = value;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'C.I.'),
                      onSaved: (value) {
                        _authData['ci'] = value;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'email'),
                      onSaved: (value) {
                        _authData['email'] = value;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Emergency Phone'),
                      onSaved: (value) {
                        _authData['emergencyPhone'] = value;
                      },
                    ),
                  ],
                ),
              ),
            ),
            FlatButton(
              onPressed: () {},
              child: Text("SIGN UP"),
            ),
          ],
        ),
      ),
    );
  }
}
