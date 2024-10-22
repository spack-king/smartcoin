import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../methods/alerts.dart';
import '../methods/auth_methods.dart';

class Frens extends StatefulWidget {
  const Frens({super.key});

  @override
  State<Frens> createState() => _FrensState();
}

class _FrensState extends State<Frens> with TickerProviderStateMixin {

  late ConfettiController confettiController;
  bool loading = true;
  int frenlistCount = 0;
  late List<dynamic> frenList = <dynamic>[];
  String frenCode = '';
  bool giftAvailable = false;
  late SharedPreferences prefs;

  int pref_FRIENDLENGTH = 0;
  int earned = 0;

  late int balance;
  late String userid;

  late String username;
  late int userBalance;

  RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  String Function(Match) mathAFunction = (Match match) => '${match[1]},';

  @override
  void initState() {
    getUserCoin();

    //confetti
    confettiController = ConfettiController(
      duration: const Duration(milliseconds: 500),
    );
    super.initState();
  }

  getUserCoin() async {
    setState(() {
      loading= true;
    });

    prefs = await SharedPreferences.getInstance();
    userid =  prefs.getString('username') ?? 'userid';
    pref_FRIENDLENGTH =  prefs.getInt('frens') ?? 0;

    var userSnap = await FirebaseFirestore.instance.collection('user')
        .doc(userid)
        .get();

    frenlistCount = userSnap.data()!['frens'].length;
    frenCode = userSnap.data()!['username'];
    balance = userSnap.data()!['coins'] * 1;

    frenList = userSnap.data()!['frens'];
    print('$userid frens');

    if(frenList.length > pref_FRIENDLENGTH){
      giftAvailable = true;
      earned = 5000 * frenlistCount;
    }else{
      giftAvailable = false;
    }


    setState(() {
      loading = false;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose

    confettiController.dispose();
    super.dispose();
  }
// TODO
//   Share.share('',
//   subject: 'Invite frens');
  @override
  Widget build(BuildContext context) {
    return loading ? Center(
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
        : ConfettiWidget(
      confettiController: confettiController,
      particleDrag: 0.05,
      emissionFrequency: 0.02,
      numberOfParticles: 50,
      gravity: 0.05,
      // shouldLoop: true,
      blastDirectionality: BlastDirectionality.explosive,
      colors: const [
        Colors.green,
        Colors.blue,
        Colors.pink,
        Colors.orange,
        Colors.purple,
        Colors.white,
        Colors.lightGreenAccent,
      ],
      child: SafeArea(
          child:
          Column(
            children: [
              const SizedBox(height: 10,),

              Expanded(
                child: frens(),
              ),

            ],
          )),
    );
  }

  frens() {
    return Column(
      children: [
        const SizedBox(height: 20,),
        loading
            ? CircularProgressIndicator()
            : Text('$frenlistCount', style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Frens ', style: TextStyle(fontSize: 30,),),
            Icon(CupertinoIcons.person_3_fill)
          ],
        ),
        const SizedBox(height: 20,),
        Expanded(
            child: frenlistCount == 0
                ? Center(child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  //margin: EdgeInsets.all(20),
                  child: Flexible(
                    child: RichText(
                      textAlign: TextAlign.center,
                      textScaleFactor: 2,
                      text: const TextSpan(
                          style: TextStyle(fontWeight: FontWeight.bold),
                        children: [
                          TextSpan(text: 'Invite ', style: TextStyle(color: Colors.white)),
                          TextSpan(text: 'more frens', style: TextStyle(color: Colors.white)),
                          TextSpan(text: ' to earn 5,000 coins times the number of frens!',  style: TextStyle(color: Colors.lightBlue),),
                        ]
                      ),
                    ),
                  ),
                ),
              ],
            ))
                :
            loading
                ? Center(child: CircularProgressIndicator(),)
                : ListView.builder(
                itemCount: frenlistCount,
                itemBuilder: (contxet, index){

                  return Container(
                    margin: EdgeInsets.only(left: 20),
                    child: ListTile(
                        leading: Icon(CupertinoIcons.person_alt_circle_fill),
                      title: FutureBuilder(
                        builder: (c,s){
                          if(s.hasError){
                            return  LoadingAnimationWidget.dotsTriangle(
                                color: Colors.blue, size: 20);
                          }else {
                            return s.data == null
                                ?LoadingAnimationWidget.dotsTriangle(
                                color: Colors.blue, size: 20)
                            :Text(s.data as String,
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),);
                          }
                        },
                        future:  getRefName('${frenList[index]}'),
                      ),
                      subtitle: FutureBuilder(
                        builder: (c,s){
                          if(s.hasError){
                            return  LoadingAnimationWidget.dotsTriangle(
                                color: Colors.blue, size: 20);
                          }else{

                            return Row(
                              children: [
                                Image.asset('assets/coin.png', height: 20, width: 20,),
                                s.data == null
                                    ?LoadingAnimationWidget.newtonCradle(
                                    color: Colors.blue, size: 40)
                                    :
                                Text(
                                  '${s.data.toString().replaceAllMapped(reg, mathAFunction)}',
                                  style: TextStyle(fontSize: 16,),)
                              ],
                            );
                          }
                        },
                        future:  getRefCoin('${frenList[index]}'),
                      ),


                    ),
                  );
                }
            )
        ),
        //update mining rate
        Container(
          margin: EdgeInsets.only(top: 10),
          padding: EdgeInsets.all(20),

          decoration:BoxDecoration(
            // border: Border.all(color: Colors.green),
            borderRadius: BorderRadius.only(

              topLeft: Radius.circular(40.0,),
              topRight: Radius.circular(40.0,),
            ),
            color: Colors.grey.shade900,),
          child: Column(
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Image.asset('assets/coin.png', height: 40, width: 40,),
                  Text(
                    '${earned.toString().replaceAllMapped(reg, mathAFunction)}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
                ],
              ),
              RichText(
                textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                    children: [
                      TextSpan(text: 'Click on the '),
                      TextSpan(text: 'copy code ',  style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace'),),
                      TextSpan(text: 'to copy your link.'),
                      TextSpan(text: ' Your Referral code is: '),
                      TextSpan(text: '$userid', style: TextStyle(color: Colors.yellow, fontSize: 14)),
                    ]
                  )
              ),
              Row(
                children: [
                  Expanded(
                    child: Opacity(
                      opacity: giftAvailable ? 1 : 0.5,
                      child: InkWell(
                        onTap: () async {
                          if(giftAvailable){
                            confettiController.play();
                            await prefs.setInt('frens', frenList.length);

                            final coin_amount = balance + earned * 1;
                            await AuthMethods().updateUserCoin(coin_amount);

                            showSpackSnackBar('You earned ${earned.toString().replaceAllMapped(reg, mathAFunction)} coins!', context, Colors.green, CupertinoIcons.gift);
                            setState(() {

                            });
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 20, bottom: 20, right: 10),
                          width: double.infinity,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          decoration:const ShapeDecoration(shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(25),)
                          ),
                              color: Colors.lightBlue
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Claim reward', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                              Icon(CupertinoIcons.gift)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration:const ShapeDecoration(shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25),),
                    ),
                    color: Colors.white),
                    child: IconButton(
                        onPressed: (){
                          String toCopy = 'https://t.me/Thesmartcoin_bot Use the referral code \'$frenCode\' for bonuses!';
                          Clipboard.setData( ClipboardData(text: toCopy));

                          showSpackSnackBar('Copied!', context, Colors.green, Icons.copy);

                        },
                        icon:  Icon(Icons.copy_all, color: Colors.black, size: 30,)),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<String> getRefName(String usernameAsIndex) async {
    var userSnap = await FirebaseFirestore.instance.collection('user')
        .doc(usernameAsIndex)
        .get();
    return userSnap.data()!['username'];
  }
  Future<int> getRefCoin(String usernameAsIndex) async {
    var userSnap = await FirebaseFirestore.instance.collection('user')
        .doc(usernameAsIndex)
        .get();
    return userSnap.data()!['coins'];
  }

}
