import 'package:cloud_firestore/cloud_firestore.dart';

class User{
  final String username;
  final String password;
  final String status;
  final DateTime timestamp;
  final List frens;
  final int coins;

  const User({
    required this.username,
    required this.password,
    required this.status,
    required this.timestamp,
    required this.frens,
    required this.coins,
  });

  Map<String, dynamic> toJson() => {
    "username": username,
    "password": password,
    "status": status,
    "timestamp": timestamp,
    "frens": frens,
    "coins": coins,
  };
  static User fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
        username: snapshot['username'],
        password: snapshot['password'],
        status: snapshot['status'],
        timestamp: snapshot['timestamp'],
        frens: snapshot['frens'],
        coins: snapshot['coins'],);
  }
}
