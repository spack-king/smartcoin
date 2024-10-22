import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartcoin/model/user.dart' as model;

import 'all_user_data.dart';

class AuthMethods{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //sign up user
  Future<String> signUpUser({
    required String username,
    required String referral,
    required String password,
  }) async {
    String res = "Fill in all the spaces!";
    try{
      if(await isUserUniqueNameExists(username) == 'Network failure!'){
        res = 'Network failure!';
      } else if(await isUserUniqueNameExists(username) == 'already exist'){
        UserData().updateAllData(
            username: username,
            password: password);
        res = 'Account created successfully!';
      }

      else{

        //register user

        model.User user =  model.User(
            username: username,
            timestamp: DateTime.now(),
            status: '',
            password: password,
          frens: [],
          coins: 0,);

        UserData().updateAllData(
            username: username,
            password: password);

        await _firestore.collection('user').doc(username).set(user.toJson());


        await _firestore.collection('UniqueUsernames').doc('unique').update({
          'userid': FieldValue.arrayUnion([username])
        });

        //check if referral code exists
        if(await isUserUniqueNameExists(referral) == 'already exist'){
          updateUpLiner(referral, username);
          //add to shared
          UserData().setEarned(10000);
        }

        res = 'Account created successfully!';

      }

      // await _firestore.collection('User').add(data);
    } catch(err){{
      switch(err.toString()){
        case '[firebase_auth/email-already-in-use] The email address is already in use by another account.':
          res = 'The email address already exist!';
          break;
        case '[firebase_auth/invalid-email] The email address is badly formatted.':
          res = 'Invalid email address!';
          break;
        default:
          res = 'Something went wrong somewhere!';
      }
    }

    }

    print(res);
    return res;
  }

  Future<String> isUserUniqueNameExists(String username) async {

    String exists = "Network failure!";
    try{
      DocumentSnapshot snap = await _firestore.collection('UniqueUsernames').doc('unique').get();
      List username_list = (snap.data()! as dynamic)['userid'];

      if(username_list.contains(username)){
        exists = 'already exist';

      }else{
        exists = 'not already exist';
      }
    }catch(e){
      exists = 'Access denied!';
    }

    return exists;
  }

  void updateUpLiner(String code, String downliner) {
    FirebaseFirestore.instance.collection("user").snapshots().listen((event) {

      event.docs.forEach((element) {
        if(element.data()['username'] == code){
          updateFren(element.data()['username'],downliner );
        }else{
          return;
        }
      });
    });

  }

  void updateFren(String upliner, String downliner) async {

    try{

      await _firestore.collection('user').doc(upliner).update({
          'frens': FieldValue.arrayUnion([downliner])
        });

    }catch(e){
      print(e.toString());
    }

  }

  Future<void> updateUserCoin(int coin_amount) async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final userid =  prefs.getString('username') ?? '';

    await _firestore.collection('user')
        .doc(userid).update({
      "coins": coin_amount
    });
  }
}