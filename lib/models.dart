import 'package:flutter/material.dart';

class LoaderProvider extends ChangeNotifier {
  bool _isLoading = false;

  void startLoading() {
    _isLoading = true;

    ////Call whenever there is some schange in any field of change notifier.
    notifyListeners();
  }

  void stopLoading() {
    _isLoading = false;
    //Call whenever there is some change in any field of change notifier.
    notifyListeners();
  }

  bool get isLoading => _isLoading;
}

class ColorDataProvider extends ChangeNotifier {
  Color? prim, sec, text;
  bool isDarkMode = false;

  void makeDarkMode() {
    prim = Colors.blueGrey[900];
    sec = Colors.grey[900];
    text = Colors.white;
    isDarkMode = true;
    //Call whenever there is some schange in any field of change notifier.
    notifyListeners();
  }

  void makeLightMode() {
    prim = Colors.teal;
    sec = Colors.white;
    text = Colors.black;
    isDarkMode = false;
    //Call whenever there is some change in any field of change notifier.
    notifyListeners();
  }

  Color? get primary => prim;
  Color? get secondary => sec;
  Color? get textColor => text;
}

class UserData extends ChangeNotifier {
  String? _email, _name, _edu, _intern, _dob;

  void updateUserData(
      String? email, String? name, String? edu, String? intern, String? dob) {
    _email = email;
    _name = name;
    _edu = edu;
    _intern = intern;
    _dob = dob;
    //Call whenever there is some change in any field of change notifier.
    notifyListeners();
  }

  String? get email => _email;
  String? get name => _name;
  String? get edu => _edu;
  String? get intern => _intern;
  String? get dob => _dob;
}
