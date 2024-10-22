import 'package:flutter/material.dart';

class SpackProvider extends ChangeNotifier{
  late bool _isRechargedForFree;
  bool get isRechargedForFree => _isRechargedForFree;

  //session claimed
  late bool _isSessionEarned;
  bool get isSessionEarned => _isSessionEarned;

  SpackProvider(){
    _isSessionEarned = false;
    _isRechargedForFree = false;
  }

  set isSessionEarned(bool value){
    _isSessionEarned = value;
    notifyListeners();
  }
  void toggleSessionEarned(bool value){
    _isSessionEarned = value;
    notifyListeners();
  }

  set isRechargedForFree(bool value){
    _isRechargedForFree = value;
    notifyListeners();
  }
  void toggleRecharged(bool value){
    _isRechargedForFree = value;
    notifyListeners();
  }

}