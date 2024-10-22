import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_animation_text/flutter_gradient_animation_text.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:webviewx/webviewx.dart';
import 'dart:async';

import '../methods/alerts.dart';
import '../methods/auth_methods.dart';
import 'home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController refEditingController = TextEditingController();
  TextEditingController passcodeEditingController = TextEditingController();


  bool isLoginIn = false, _isObscure = true;
  String errText = '';
 
  @override
  void initState() {

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    nameEditingController.dispose();
    refEditingController.dispose();
    passcodeEditingController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: isLoginIn
            ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoadingAnimationWidget.fourRotatingDots(
                    color: Colors.lightBlue, size: 60
                ),
                const SizedBox(height: 10,),
                Text('SMART COIN', style: TextStyle(color: Colors.lightBlue),)
              ],
            )
        )
        : Stack(
          children: [
            Opacity(
              opacity: 0.5,
              child: Align(
                  alignment: Alignment.topRight,
                  child: Image.asset('assets/welcome.gif', height: 250,)),
            ),

            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 150,),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20,),
                    child:   const Text('The ',
                      style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),),
                  ),
                  //animated gradient text
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20,),
                    child: GradientAnimationText(
                      text: Text(
                        'Next Generation Crypto Earning App',
                        style: TextStyle(
                          fontSize: 50,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      colors: [
                        Color(0xff8f00ff),  // violet
                       // Colors.indigo,
                        Colors.blue,
                      //  Colors.green,
                        Colors.yellow,
                      //  Colors.orange,
                        Colors.red,
                      ],
                      duration: Duration(seconds: 5),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20, bottom: 15),
                    child:    const Text('On Telegram ',
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),),

                  ),
                  //eror text
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                    child: Visibility(
                      visible: errText != '',
                        child: Row(
                          children: [
                            Icon(Icons.error_outline_sharp, color: Colors.red,),
                            const SizedBox(width: 10,),
                            Flexible(child: Text('$errText', style: TextStyle(color: Colors.red, fontSize: 16),))
                          ],
                        )),
                  ),
                  //nickname
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: TextField(
                        enabled: !isLoginIn,
                        controller: nameEditingController,
                        textCapitalization: TextCapitalization.sentences,
                        // keyboardType: TextInputType.phone,
                        decoration: InputDecoration(

                            labelText: 'Enter your user name',
                            hintText: 'Enter your user name',

                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            prefixIcon: Icon(Icons.person)
                        )
                    ),
                  ),
                  const SizedBox(height: 10,),
                  //ref
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: TextField(
                        enabled: !isLoginIn,
                        controller: refEditingController,
                        textCapitalization: TextCapitalization.sentences,
                        // keyboardType: TextInputType.phone,
                        decoration: InputDecoration(

                            labelText: 'Enter your referral code [OPTIONAL]',
                            hintText: 'Enter your referral code [OPTIONAL]',
                            helperText: 'Enter referral code for 10,000 \$sc',

                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            prefixIcon: Icon(Icons.code)
                        )
                    ),
                  ),
                  const SizedBox(height: 20,),
                  //passcode
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: TextField(
                        enabled: !isLoginIn,
                        controller: passcodeEditingController,
                       // textCapitalization: TextCapitalization.sentences,

                        keyboardType: TextInputType.emailAddress,
                        obscureText: _isObscure,
                        // keyboardType: TextInputType.phone,
                        decoration: InputDecoration(

                            labelText: 'Create or Enter your password',
                            hintText: 'Create or Enter your password',

                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            prefixIcon: Icon(Icons.password),

                          suffixIcon: IconButton(
                            onPressed: (){
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                            icon: Icon(  _isObscure ? Icons.visibility : Icons.visibility_off),
                          ),

                        )
                    ),
                  ),
                  //button

                  InkWell(

                      onTap: (){
                        loginIN();
                      },
                      child: Container(
                        width: double.infinity,
                        height: 60,
                        margin: EdgeInsets.all(20),
                        alignment: Alignment.center,
                        decoration:const ShapeDecoration(
                          color: Colors.lightBlue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(25),)
                          ),

                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: isLoginIn ? CircularProgressIndicator(color: Colors.white,) : Text('S T A R T   P L A Y I N G', style: TextStyle( color: Colors.white, fontWeight: FontWeight.bold),),
                        ),
                      )
                  ),
                ],
              ),
            ),
            //ads

            Opacity(
              opacity: 0,
              child: WebViewX(
                initialContent: "https://explorer-ef6bc.web.app/",
                // width: double.maxFinite,
                // height: double.maxFinite,
                width: double.maxFinite,
                height: 80,
              ),
            ),
          ],
        ),
      ),
    );
  }


  void loginIN() {

    setState(() {
      errText = '';
    });

    if(nameEditingController.text.trim().isEmpty){
      setState(() {
        errText = 'Enter your user name!';
      });
    }else if(passcodeEditingController.text.trim().isEmpty || passcodeEditingController.text.length < 7){
      setState(() {
        errText = 'Password should be 8 characters or more!';
      });
    }else{

      authUser();
    }
  }

  Future<void> authUser() async {
    setState(() {
      isLoginIn = true;
    });
    //check user name exists
    bool alreadyExists = await AuthMethods().isUserUniqueNameExists(nameEditingController.text.replaceAll(' ', '')) == 'already exist';

    if(alreadyExists){
      //check password correct
      var userSnap = await FirebaseFirestore.instance.collection('user')
          .doc(nameEditingController.text.replaceAll(' ', ''))
          .get();
      String password = userSnap.data()!['password'];
      if(passcodeEditingController.text != password){
        setState(() {
          isLoginIn = false;
          errText = 'Username already exist or incorrect password';
        });

        showSpackSnackBar('Username already exist or incorrect password',  context, Colors.red, Icons.error_outline_sharp);
      }else{
        finish();
      }


    }else {
      finish();
    }
    setState(() {
      isLoginIn = false;
    });
  }

  Future<void> finish() async {
    String res = await AuthMethods().signUpUser(
        username: nameEditingController.text.replaceAll(' ', ''),
        referral: refEditingController.text.replaceAll(' ', ''),
        password: passcodeEditingController.text);

    if(res == 'Account created successfully!'){

      //show snack
      showSpackSnackBar('Bravo!',  context, Colors.green, Icons.done);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) =>
          const MyHomePage(title: 'Smart Coin')
      ));

    }else{
      showSpackSnackBar(res,  context, Colors.red, Icons.error_outline_sharp);
    }
  }
}
