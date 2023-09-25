import 'package:flutter/material.dart';

class AddTransactionProvider extends ChangeNotifier {
  bool _isSecure = true;

  bool get isSecure => _isSecure;

  void changeSecureText() {
    _isSecure = !_isSecure;
    notifyListeners();
  }
  
  // bool _secureText = true;

  // bool get secureText => _secureText;

  // void toggleSecureText() {
  //   _secureText = !_secureText;
  //   notifyListeners();
  // }
}
