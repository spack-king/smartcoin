import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartcoin/methods/alerts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../methods/auth_methods.dart';
import '../pages/choose_crypto_page.dart';
import '../provider/provider.dart';

class Task extends StatefulWidget {
  const Task({super.key});

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  late SharedPreferences prefs;

  RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  String Function(Match) mathAFunction = (Match match) => '${match[1]},';

  bool loading = true;
  var balance, maxTime, earnPerTap;
  late ConfettiController confettiController;
  late bool exchangeAdded ;
  late bool cryptoAdded;
  late String userid;

  @override
 void initState()  {
    getSharedPref();
    //confetti
    confettiController = ConfettiController(
      duration: const Duration(milliseconds: 500),
    );
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    confettiController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child:
        loading
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
            :ConfettiWidget(
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
              child: Container(
          margin: EdgeInsets.all(20),
          child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //boosters
                  const Text('Boosters', textScaleFactor: 2, style: TextStyle(fontWeight: FontWeight.bold),),
                  //enery
                  ListTile(
                    onTap: (){

                     var energyLimitAmount =  prefs.getInt('energyLimitAmount') ?? 1000;
                      showRechargeBottomSheet(
                          Title: 'Increase energy',
                          Message: 'Increase Energy Limit by 500',
                          CoinAmount: '$energyLimitAmount',
                          buttonText: 'Buy',
                          icon: Icons.flash_on,
                        function: () async {
                            if(energyLimitAmount > balance){
                              showSpackSnackBar('Insufficient funds', context, Colors.red, Icons.monetization_on);
                            }else{

                              prefs.setInt('maxTime', maxTime + 500);
                              prefs.setInt('energyLimitAmount', energyLimitAmount + energyLimitAmount);
                              final coin_amount = balance - energyLimitAmount * 1;
                              await AuthMethods().updateUserCoin(coin_amount);
                              showSpackSnackBar('New energy level updated!', context, Colors.green, Icons.flash_on);
                            }

                        },
                        function2: (){

                          prefs.setInt('maxTime', maxTime + 500);
                          showSpackSnackBar('New energy level updated!', context, Colors.green, CupertinoIcons.battery_charging);
                        },
                          );
                    },
                    leading: Icon(Icons.flash_on, size: 40,),
                    title: const Text('Increase Energy'),
                    subtitle: const Text('Increase Energy Limit'),
                  ),
                  //increase per tap
                  ListTile(
                    onTap: (){
                      var perTapAmount =  prefs.getInt('earnPerTapAmount') ?? 1000;
                      var perTap =  prefs.getInt('earnPerTap') ?? 1000;
                      showRechargeBottomSheet(
                        Title: 'Increase Tap',
                        Message: 'Increase your Earn Per Tap by 1',
                        CoinAmount: '$perTapAmount',
                        buttonText: 'Buy',
                        icon: Icons.touch_app,
                        function: () async {
                          if(perTapAmount > balance){
                            showSpackSnackBar('Insufficient funds', context, Colors.red, Icons.monetization_on);
                          }else{

                            prefs.setInt('earnPerTap', earnPerTap + 1);
                            prefs.setInt('earnPerTapAmount', perTapAmount + perTapAmount);
                            final coin_amount = balance - perTapAmount * 1;
                            await AuthMethods().updateUserCoin(coin_amount);
                            showSpackSnackBar('Earn Per Tap increased!', context, Colors.green, CupertinoIcons.rocket);
                          }

                        },
                        function2: (){

                          prefs.setInt('earnPerTap', earnPerTap + 1);
                          showSpackSnackBar('Earn Per Tap increased!', context, Colors.green, CupertinoIcons.rocket);
                        },
                      );
                    },
                    leading: Icon(Icons.touch_app, size: 40, ),
                    title: const Text('Increase Tap'),
                    subtitle: const Text('Increase Earn Per Tap'),
                  ),

                  //special
                  const SizedBox(height: 20,),
                  const Text('Daily Task', textScaleFactor: 2,style: TextStyle(fontWeight: FontWeight.bold),),
                  //increase per tap
                  ListTile(
                    enabled: false,
                    onTap: (){

                    },
                    leading: Icon(Icons.rocket_launch, size: 40, ),
                    title: const Text('Launch the rocket'),
                    subtitle: const Text('Coming soon!'),
                  ),

                  //tasks
                  const SizedBox(height: 20,),
                  const Text('Tasks', textScaleFactor: 2,style: TextStyle(fontWeight: FontWeight.bold),),
                  //increase per tap
                  ListTile(
                    enabled: !Provider.of<SpackProvider>(context, listen: false).isSessionEarned,
                    onTap: (){
                      bool sessionClaimed = Provider.of<SpackProvider>(context, listen: false).isSessionEarned;

                      showRechargeBottomSheet(
                        Title: 'Regular Reward',
                        Message: 'Earn rewards on every login session',
                        CoinAmount: '+10000',
                        buttonText: sessionClaimed ? 'Come back later' : 'Claim',
                        icon: Icons.calendar_month_sharp,
                        function: () async {
                          if(sessionClaimed){
                            return;
                          }else{
                            confettiController.play();
                            Provider.of<SpackProvider>(context, listen: false).toggleSessionEarned(true);
                            final coin_amount = balance + 10000 * 1;
                            await AuthMethods().updateUserCoin(coin_amount);
                            showSpackSnackBar('+10,000 claimed!', context, Colors.green, Icons.celebration);

                          }
                        },
                        function2: (){

                        },
                      );
                    },
                    leading: Icon(Icons.calendar_month_sharp, size: 40,),
                    title: const Text('Regular Reward'),
                    subtitle: Row(
                      children: [
                        Image.asset('assets/coin.png', height: 20, width: 20,),
                        Text(
                          '+10,000',
                          style: TextStyle(fontSize: 16,),)
                      ],
                    ),
                  ),
                  Container(color: Colors.grey, height: 1,),
                  //Exchange
                  ListTile(
                    enabled: !exchangeAdded,
                    onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>
                          ChooseCryptoPage(title: 'exchange',)
                        )).then((value) async {
                          confettiController.play();
                          final coin_amount = balance + 100000 * 1;
                          await AuthMethods().updateUserCoin(coin_amount);
                          showSpackSnackBar('+100,000 claimed!', context, Colors.green, Icons.celebration);
                          setState(() {
                            exchangeAdded = true;
                          });

                        }

                        );
                    },
                    leading: Icon(Icons.currency_exchange, size: 40,),
                    title: const Text('Choose your Exchange'),
                    subtitle: Row(
                      children: [
                        Image.asset('assets/coin.png', height: 20, width: 20,),
                        Text(
                          '+100,000',
                          style: TextStyle(fontSize: 16,),)
                      ],
                    ),
                  ),
                  //crypto
                  ListTile(
                    enabled: !cryptoAdded,
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>
                          ChooseCryptoPage(title: 'crypto',)
                      )).then((value) async {
                        confettiController.play();
                        final coin_amount = balance + 50000 * 1;
                        await AuthMethods().updateUserCoin(coin_amount);
                        showSpackSnackBar('+50,000 claimed!', context, Colors.green, Icons.celebration);
                        setState(() {
                          cryptoAdded = true;
                        });
                      }

                      );
                    },
                    leading: Icon(CupertinoIcons.bitcoin, size: 40, ),
                    title: const Text('Select Preferred Crypto Currency'),
                    subtitle: Row(
                      children: [
                        Image.asset('assets/coin.png', height: 20, width: 20,),
                        Text(
                          '+50,000',
                          style: TextStyle(fontSize: 16,),)
                      ],
                    ),
                  ),
                  //share
                  ListTile(
                    enabled: !(prefs.getBool('shared') ?? false),
                    onTap: (){
                      Share.share('Join the new Generation Earning App on Telegram https://t.me/Thesmartcoin_bot use the referral code \'$userid\' ' ,
                          subject: 'Smart Coin');
                      prefs.setBool('shared', true).then((value) async {

                        final coin_amount = balance + 10000 * 1;
                        await AuthMethods().updateUserCoin(coin_amount);
                        confettiController.play();
                        showSpackSnackBar('+10,000 claimed!', context, Colors.green, Icons.celebration);
                        setState(() {

                        });
                      });

                    },
                    leading: Icon(Icons.link, size: 40, ),
                    title: const Text('Share your link'),
                    subtitle: Row(
                      children: [
                        Image.asset('assets/coin.png', height: 20, width: 20,),
                        Text(
                          '+10,000',
                          style: TextStyle(fontSize: 16,),)
                      ],
                    ),
                  ),
                  //telegram
                  ListTile(
                    enabled: !(prefs.getBool('jointTelegram') ?? false),
                    onTap: (){
                      launchUrl(Uri.parse('https://t.me/notcoin'));
                      prefs.setBool('jointTelegram', true).then((value) async {

                        final coin_amount = balance + 1000000 * 1;
                        await AuthMethods().updateUserCoin(coin_amount);
                        confettiController.play();
                        showSpackSnackBar('+1,000,000 claimed!', context, Colors.green, Icons.celebration);
                        setState(() {

                        });
                      });

                    },
                    leading: Icon(Icons.telegram, size: 40, color: Colors.lightBlue,),
                    title: const Text('Join Notcoin Telegram Community'),
                    subtitle: Row(
                      children: [
                        Image.asset('assets/coin.png', height: 20, width: 20,),
                        Text(
                          '+1,000,000',
                          style: TextStyle(fontSize: 16,),)
                      ],
                    ),
                  ),
                  //sponsored
                  ListTile(
                    enabled: !(prefs.getBool('visitedWebPage') ?? false),
                    onTap: (){

                      launchUrl(Uri.parse('https://curlsbatter.com/fzgm6d3w?key=b7d97f1b334c50c1407bdbffa8810d44'));
                      prefs.setBool('visitedWebPage', true).then((value) async {

                        final coin_amount = balance + 500000 * 1;
                        await AuthMethods().updateUserCoin(coin_amount);
                        confettiController.play();
                        showSpackSnackBar('+500,000 claimed!', context, Colors.green, Icons.celebration);
                        setState(() {

                        });
                      });
                    },
                    leading: Icon(CupertinoIcons.globe, size: 40, ),
                    title: const Text('Visit Sponsors page'),
                    subtitle: Row(
                      children: [
                        Image.asset('assets/coin.png', height: 20, width: 20,),
                        Text(
                          '+500,000',
                          style: TextStyle(fontSize: 16,),)
                      ],
                    ),
                  ),
                ],
              ),
          ),
        ),
            ),
      ),
    );
  }

 void showRechargeBottomSheet(
      {required String Title,
        required String Message, required String CoinAmount, required String buttonText,
        required IconData icon, required void Function()  function,required  void Function() function2,
      }) {

    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (builder){
          return Container(
            decoration:BoxDecoration(

              // border: Border.all(color: Colors.green),
              borderRadius: BorderRadius.only(

                topLeft: Radius.circular(40.0,),
                topRight: Radius.circular(40.0,),
              ),
              color: Colors.lightBlue,),
            child: Container(
              margin: EdgeInsets.only(top: 10),
              decoration:BoxDecoration(
                // border: Border.all(color: Colors.green),
                borderRadius: BorderRadius.only(

                  topLeft: Radius.circular(40.0,),
                  topRight: Radius.circular(40.0,),
                ),
                color: Colors.grey.shade900,),
              child:  SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 10, top: 10),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.cancel),

                        ),
                      ),
                    ),

                    Icon(icon, size: 100, color: Colors.green,).animate().flipH(delay: 400.milliseconds),
                    //title
                    Padding(
                      padding: EdgeInsets.only(top: 20.0, bottom: 10),
                      child: Text(
                          Title,
                          textScaleFactor: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white,
                              fontWeight: FontWeight.bold, fontSize: 18)),
                    ),

                    Padding(
                      padding: EdgeInsets.only(bottom: 20.0, top: 10, left: 20, right: 20),
                      child: Text(
                          Message,

                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white,
                              fontSize: 18)),
                    ),
                    //price
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Image.asset('assets/coin.png', height: 40, width: 40,),
                        Text(CoinAmount.toString().replaceAllMapped(reg, mathAFunction),
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () async {
                              //run function1
                              function();
                              Navigator.pop(context);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(left: 20, right: 5, bottom: 20),
                              padding: EdgeInsets.all(15),
                              width: double.infinity,
                              decoration:BoxDecoration(
                                // border: Border.all(color: Colors.green),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(30.0,)
                                ),
                                color: buttonText == 'Buy'
                                    ?Colors.grey
                                    :Colors.lightBlue,),
                              child: Text(buttonText,
                                textScaleFactor: 1,),
                            ),
                          ),
                        ),
                        buttonText == 'Buy'
                        ?InkWell(
                          onTap: () async {
                            String url = 'https://curlsbatter.com/fzgm6d3w?key=b7d97f1b334c50c1407bdbffa8810d44';
                            await launchUrl(Uri.parse(url));
                            //run function2

                            function2();
                            Navigator.pop(context);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(left: 5, right: 20, bottom: 20),
                            padding: EdgeInsets.all(15),
                            decoration:BoxDecoration(
                              // border: Border.all(color: Colors.green),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(30.0,)
                              ),
                              color: Colors.lightBlue,),
                            child: Text('Visit Sponsored page',
                              textScaleFactor: 1,),
                          ),
                        )
                        : Container(),
                      ],
                    ),


                  ],
                ),
              ),
            ),
          );
        }
    );

  }

  Future<void> getSharedPref() async {

    prefs = await SharedPreferences.getInstance();

     userid =  prefs.getString('username') ?? '';
    final perTap =  prefs.getInt('earnPerTap') ?? 1;
    final maxtimeShared =  prefs.getInt('maxTime') ?? 500;

    var exchangeAdded_pref = prefs.getString('exchange') ?? '';
    var cryptoAdded_pref = prefs.getString('crypto') ?? '';
    exchangeAdded = exchangeAdded_pref != '';
    cryptoAdded   = cryptoAdded_pref != '';

    var userSnap = await FirebaseFirestore.instance.collection('user')
        .doc(userid)
        .get();

    //update number values
    balance = userSnap.data()!['coins'] * 1;
    //per tap
    earnPerTap = perTap * 1;
    //max time
    maxTime = maxtimeShared * 1;

    setState(() {

      loading = false;
    });
  }
}
