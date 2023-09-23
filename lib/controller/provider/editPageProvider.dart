// import 'package:flutter/material.dart';

// class EditPageProvider extends ChangeNotifier{
  

// }




import 'package:flutter/foundation.dart';

class EditPageProvider extends ChangeNotifier {
  double _amount = 0.0;
  bool _secureText = true;

  double get amount => _amount;
  bool get secureText => _secureText;

  void setAmount(double value) {
    _amount = value;
    notifyListeners();
  }

  void toggleSecureText() {
    _secureText = !_secureText;
    notifyListeners();
  }
}







































