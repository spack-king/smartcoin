import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartcoin/pages/login.dart';
import 'package:smartcoin/provider/provider.dart';
import 'firebase_options.dart';
import 'pages/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String username = prefs.getString('username') ?? '';

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
     ChangeNotifierProvider(
         create: (context) => SpackProvider(),
          child:
           MyApp(username: username)
          
  ) );
}

class MyApp extends StatelessWidget {
  final username;
  const MyApp({super.key, this.username,});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Coin',
      theme: ThemeData(
          colorScheme: ColorScheme.dark(
            background: Colors.black,
            primary: Colors.blue,
            secondary: Colors.grey.shade800,
            inversePrimary: Colors.grey.shade300,
          )
      ),
        home: username != ''
            ? const MyHomePage(title: 'Smart Coin')
            : const  LoginPage()//const Ads()
    );
  }
}
