import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/user.dart';
class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;
  Timer _authTimer;
  bool get isAuth {
    return _token != null;
  }
  String get userId{
    return _userId;
  }
  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }
///El metdoo se encarga de loggear al usuario
  Future<void> signin(String email, String password) async {
   const url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyBgTP44uTT3ILzjRG-yknW_LHXUeUjZ6Hg';
    
    try {
      print("object");
      final response = await http.post(
        url,
        body: {
          'email': email,
          'password': password,
          'returnSecureToken': 'true',
        },
      );
      // print(email);
      // print(password);
      // print(response.statusCode);
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        
        throw Exception(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
      _autoLogout();
      notifyListeners();

      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'userId': _userId,
        'exiryDate': _expiryDate.toIso8601String(),
      });
      prefs.setString("userData", userData);
      //print(userData+"    SignIn");
    } catch (error) {
      print(error);
      throw error;
    }
  }
/// El metodo siguiente se encarga de limiar los valores del login y notificar a las pantallas que la utilicen que ya el usuario esta desloggeandose

  Future<void> logout() async {
    _token = null;
    _expiryDate = null;
    _userId = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
/// El metodo siguiente es utilizado de temporizador para conocer el tiepo de vida del token

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }

 /// El metodo se encarga de autologgearse en el caso de que el tiempo de expiracion del token no haya pasado

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
  // print(prefs.get("userData")+"   tryAutoLogin");
    if (!prefs.containsKey("userData")) {
      return false;
    }
       // print(" valor de verdad");

    final extractedUserData = json.decode(prefs.getString("userData"));
    final expiryDate = DateTime.parse(extractedUserData["exiryDate"]);
   // print(expiryDate.isBefore(DateTime.now()));
    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = extractedUserData['token'];
    _userId = extractedUserData['userId'];
    _expiryDate=expiryDate;
    notifyListeners();
    _autoLogout();//timer
    return true;
  }
}
