import 'package:shared_preferences/shared_preferences.dart';

class UserData{

  Future<void> updateAllData(
      {
        required String username,
    required String password,
  }) async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    await prefs.setString('password', password);
  }

  Future<void> setUsername(String username) async{

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
  }
  Future<void> setEarned(int earned) async{

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('earned', earned);
  }


  Future<void> setFullname(String fullname) async{

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('fullname', fullname);
  }
  Future<void> setcurrentTime(int currentTime) async{

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('currentTime', currentTime);
  }
}