import 'dart:math';

import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartcoin/pages/ads.dart';
import 'package:text_scroll/text_scroll.dart';
import 'package:url_launcher/url_launcher.dart';

import '../methods/alerts.dart';
import '../methods/all_user_data.dart';
import '../methods/auth_methods.dart';
import '../provider/provider.dart';

class Mine extends StatefulWidget {
  const Mine({super.key});

  @override
  State<Mine> createState() => _MineState();
}

class _MineState extends State<Mine> with TickerProviderStateMixin {


  //circle animation
  late final AnimationController _controller;
  bool isMining = true, loading = true;
  late int earnPerTap, balance, currentLevel, currentTime, maxTime, earned;
  String levelText = '-|-', coinsToLevelUp = '-|-';

  late ConfettiController confettiController;

  RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  String Function(Match) mathAFunction = (Match match) => '${match[1]},';

  // We can detect the location of the cart by this  GlobalKey<CartIconKey>
  GlobalKey<CartIconKey> cartKey = GlobalKey<CartIconKey>();
  late Function(GlobalKey) runAddToCartAnimation;

  var _cartQuantityItems = 0;

  @override
  void initState() {
    // TODO: implement initState
    _controller =   AnimationController(vsync: this)
      ..repeat(period: const Duration(seconds: 1));

    //confetti
    confettiController = ConfettiController(
      duration: const Duration(milliseconds: 500),
    );

    updateNumberValues();
    super.initState();
  }
  startAnimation(){
    _controller
      ..stop()
      ..reset()
      ..repeat(period: const Duration(seconds: 1));

  }

  @override
  void dispose() {
    confettiController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AddToCartAnimation(
      cartKey: cartKey,
      height: 30,
      width: 30,
      opacity: 0.85,
      dragAnimation: const DragToCartAnimationOptions(
        rotation: true,
      ),
      jumpAnimation: const JumpAnimationOptions(),
      createAddToCartAnimation: (runAddToCartAnimation) {
        // You can run the animation by addToCartAnimationMethod, just pass trough the the global key of  the image as parameter
        this.runAddToCartAnimation = runAddToCartAnimation;
      },
      child: Scaffold(
        backgroundColor: loading ? Colors.black : Colors.transparent,
        body: loading
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
            child: Column(
              children: [
                const SizedBox(height: 30,),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 10),
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Text('Earn per tap', style: TextStyle(fontSize: 12, color: Colors.blue),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/coin.png', height: 25, width: 25,),
                                Text('+${earnPerTap.toString().replaceAllMapped(reg, mathAFunction)}')
                              ],
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade900,
                            borderRadius: BorderRadius.all(Radius.circular(15))
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 10),
                        padding: EdgeInsets.all(10),
                        child: Column(

                          children: [
                            Text('Coins to level up', style: TextStyle(fontSize: 12, color: Colors.red),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/coin.png', height: 25, width: 25,),
                                Text('${coinsToLevelUp}')
                              ],
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade900,
                            borderRadius: BorderRadius.all(Radius.circular(15))
                        ),
                      ),
                    ),
                    const SizedBox(width: 5,),
                    IconButton(
                        onPressed: (){
                          showRechargeBottomSheet();
                        },
                        icon: Icon(Icons.battery_charging_full, color: Colors.green, size: 30,)),
                    const SizedBox(width: 15,),

                  ],
                ),
                //infos (earn per tap...

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/coin.png', height: 80, width: 80,),
                    Flexible(
                      child: TextScroll(
                        '${balance.toString().replaceAllMapped(reg, mathAFunction)}',
                        mode: TextScrollMode.bouncing,
                        velocity: Velocity(pixelsPerSecond: Offset(50, 0)),
                        delayBefore: Duration(milliseconds: 500),
                        numberOfReps: 5,
                        pauseBetween: Duration(milliseconds: 50),
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40, color: Colors.white),
                        selectable: true,
                      ),
                    )

                  ],
                ),
                const SizedBox(height: 10,),
                //level
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Text('$levelText', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(text: 'Level ', style: TextStyle(color: Colors.grey)),
                              TextSpan(text: '$currentLevel', style: TextStyle(color: Colors.white)),
                              TextSpan(text: '/', style: TextStyle(color: Colors.white)),
                              TextSpan(text: '6', style: TextStyle(color: Colors.white)),
                            ]
                          )),
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: LinearProgressBar(
                    maxSteps: 15,
                    currentStep: currentLevel,
                    progressType: LinearProgressBar.progressTypeLinear,
                    // dotsSpacing: EdgeInsets.all(10),
                    // dotsActiveSize: 20,
                    minHeight: 20,
                    backgroundColor: Colors.white,
                    progressColor: Colors.lightBlue,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.lightBlue,
                    borderRadius: BorderRadius.all(Radius.circular(55))
                  ),
                ),
                Expanded(
                    child: CustomPaint(
                      painter: isMining ? SpritePainter(_controller) : null,
                      child: InkWell(
                        onLongPress: (){
                          addCoins(true);
                        },
                        onTap: () async {
                          if(isMining){
                            addCoins(false);
                          }
                        },
                        child: !isMining ?  Text('Recharge Energy!', textAlign: TextAlign.center,
                          style: TextStyle( fontSize: 30, color: !isMining ? Colors.yellow : Colors.redAccent, fontWeight: FontWeight.bold),)
                            :AppListItem(

                          onClick: listClick,
                        ),
                      ),
                    )),
                //TODO
                Container(
                  margin: EdgeInsets.all(10),
                  child: LinearProgressBar(
                    maxSteps: maxTime,
                    currentStep: currentTime,
                    progressType: LinearProgressBar.progressTypeLinear,
                    // dotsSpacing: EdgeInsets.all(10),
                    // dotsActiveSize: 20,
                    dotsActiveSize: 49,
                    minHeight: 5,
                    backgroundColor: Colors.grey,
                    progressColor: Colors.yellow,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //minng live
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          //if it is low
                          currentTime == 0
                          ? Icon(CupertinoIcons.battery_0, size: 25, color: Colors.red,)
                          : currentTime < maxTime/2 //if it is half or fully charged
                              ? Icon(CupertinoIcons.battery_25, size: 25, color: Colors.yellow,)
                              : Icon(CupertinoIcons.battery_charging, size: 25, color: Colors.green,),
                          RichText(
                              text: TextSpan(
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                                  children: [
                                   // TextSpan(text: 'Level ', style: TextStyle(color: Colors.grey)),
                                    TextSpan(text: '${currentTime.toString().replaceAllMapped(reg, mathAFunction)}'),
                                    TextSpan(text: ' /'),
                                    TextSpan(text: '${maxTime.toString().replaceAllMapped(reg, mathAFunction)}'),
                                  ]
                              ))
                        ],
                      ),
                    ),
                    //claim stuffs
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.all(5),
                            child:  Row(
                              children: [

                               AddToCartIcon(

                                  key: cartKey,
                                  icon:     Image.asset('assets/coin.png', height: 25, width: 25,),
                                 badgeOptions: const BadgeOptions(
                                    active: false,
                                    backgroundColor: Colors.red,
                                  ),
                                ),
                                Text('${earned.toString().replaceAllMapped(reg, mathAFunction)}',
                                    style: TextStyle(fontSize: 20, color: Colors.green, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                          InkWell(
                              onTap: () async {
                                if(earned > 0){
                                  confettiController.play();
                                  showSpackSnackBar('You earned +${earned.toString().replaceAllMapped(reg, mathAFunction)}!',  context, Colors.green, Icons.done);

                                  final coin_amount = balance + earned * 1;
                                  await AuthMethods().updateUserCoin(coin_amount);

                                  earned = 0;
                                  UserData().setEarned(0);

                                  updateNumberValues();

                                }

                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                  child: Text('Claim'),
                                decoration: BoxDecoration(
                                    color: earned > 0 ? Colors.green : Colors.grey,
                                    borderRadius: BorderRadius.all(Radius.circular(10))
                                ),
                              )),
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade900,
                        borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                    )
                  ],
                )

              ],
            ),
          ),

        ),

      ),
    );
  }

  Future<void> updateNumberValues() async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final userid =  prefs.getString('username') ?? '';
    final perTap =  prefs.getInt('earnPerTap') ?? 1;
    final currenttimeShared =  prefs.getInt('currentTime') ?? 500;
    final maxtimeShared =  prefs.getInt('maxTime') ?? 500;
    final earnedShared =  prefs.getInt('earned') ?? 0;

    var userSnap = await FirebaseFirestore.instance.collection('user')
        .doc(userid)
        .get();

    //update number values
    balance = userSnap.data()!['coins'] * 1;
    //per tap
    earnPerTap = perTap * 1;

    //to level up
    if(balance < 10000){
      coinsToLevelUp = '10K';
      levelText = 'Apprentice';
      currentLevel = 1;

    }else if(balance < 100000){
      coinsToLevelUp = '100K';
      levelText = 'Worker';
      currentLevel = 2;
    }else if(balance < 1000000){
      coinsToLevelUp = '1M';
      levelText = 'Manager';
      currentLevel = 3;
    }else if(balance < 10000000){
      coinsToLevelUp = '10M';
      levelText = 'Co-Founder';
      currentLevel = 4;
    }else if(balance < 100000000){
      coinsToLevelUp = '100M';
      levelText = 'Boss';
      currentLevel = 5;
    }else if(balance < 1000000000){
      coinsToLevelUp = '1B';
      levelText = 'CEO';
      currentLevel = 6;
    }else{
      coinsToLevelUp = '10B';
      levelText = 'god';
      currentLevel = 6;

    }

    currentTime = currenttimeShared * 1;
    maxTime = maxtimeShared * 1;
    earned = earnedShared * 1;
    if(currentTime == 0){
        isMining = false;
    }

    setState(() {

      loading = false;
    });
  }

  void showRechargeBottomSheet() {

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

                      const Icon(Icons.flash_on, size: 100, color: Colors.orange,).animate().flipH(delay: 400.milliseconds),
                      //title
                      const Padding(
                        padding: EdgeInsets.only(top: 20.0, bottom: 10),
                        child: Text(
                            "Full energy",
                            textScaleFactor: 2,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white,
                                fontWeight: FontWeight.bold, fontSize: 18)),
                      ),

                      const Padding(
                        padding: EdgeInsets.only(bottom: 20.0, top: 10, left: 20, right: 20),
                        child: Text(
                            "Recharge your energy to the maximum and do another round of mining",

                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white,
                                fontSize: 18)),
                      ),
                      //price
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Image.asset('assets/coin.png', height: 40, width: 40,),
                          Text(
                            Provider.of<SpackProvider>(context, listen: false).isRechargedForFree
                            ? 'Visit sponsored website'
                                : 'Free',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
                        ],
                      ),
                      InkWell(
                        onTap: () async {

                          UserData().setcurrentTime(maxTime);
                          if( !Provider.of<SpackProvider>(context, listen: false).isRechargedForFree
                          ){
                            Provider.of<SpackProvider>(context, listen: false).toggleRecharged(true);
                          }else{
                            try{
                              String url = 'https://curlsbatter.com/fzgm6d3w?key=b7d97f1b334c50c1407bdbffa8810d44';
                              await launchUrl(Uri.parse(url));
                            }catch(e){

                            }
                          }

                          updateNumberValues();
                          setState(() {
                            isMining = true;
                          });
                          Navigator.pop(context);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                          padding: EdgeInsets.all(25),
                          width: double.infinity,
                          decoration:BoxDecoration(
                            // border: Border.all(color: Colors.green),
                            borderRadius: BorderRadius.all(
                                Radius.circular(30.0,)
                            ),
                            color: Colors.lightBlue,),
                          child: Text('Go ahead',
                            textScaleFactor: 1.5, style: TextStyle(fontWeight: FontWeight.bold),),
                        ),
                      ),


                    ],
                  ),
                ),
              ),
            );
          }
      );

  }

  void listClick(GlobalKey widgetKey) async {
    addCoins(false);
    await runAddToCartAnimation(widgetKey);
    await cartKey.currentState!
        .runCartAnimation((++_cartQuantityItems).toString());

  }

  Future<void> addCoins(bool longPress) async {
    // if(!kIsWeb){
    //   Navigator.push(context, MaterialPageRoute(builder: (context) =>
    //       Ads()
    //   ));
    // }

    if(currentTime == 0){

      setState(() {
        isMining = false;
      });
      if(longPress) {
        showRechargeBottomSheet();
      }
    }else{
      setState(() {
        currentTime --;
        earned += earnPerTap;
        UserData().setEarned(earned);

      });

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt('currentTime', currentTime);
    }
  }
}


class AppListItem extends StatelessWidget {
  final GlobalKey widgetKey = GlobalKey();
  final void Function(GlobalKey) onClick;

  AppListItem({super.key, required this.onClick,});
  @override
  Widget build(BuildContext context) {
    //  Container is mandatory. It can hold images or whatever you want
    Container mandatoryContainer = Container(
      key: widgetKey,
      width:60,
      height: 60,
      color: Colors.transparent,
      child: Image.asset(
        "assets/coin.png",
        width: 40,
        height: 40,
      ),
    );

    return InkWell(
      onTap: () => onClick(widgetKey),
      child: Stack(children: [
        Center(child: mandatoryContainer),
        Center(child: Image.asset('assets/coin.png', height: 300, width: 300,).animate().scale())
      ]),
    );
  }
}

class SpritePainter extends CustomPainter{
  final Animation<double> _animation;

  SpritePainter(this._animation) : super(repaint: _animation);

  void circle(Canvas canvas, Rect rect, double value){
    double opacity = (1.0 - (value / 4.0)).clamp(0.0, 1.0);
    Color color = Color.fromRGBO(40, 150, 600, opacity);

    double size = rect.width/2;
    double area = size * size;
    double radius = sqrt(area * value / 4);

    final Paint paint = Paint()..color = color;
    canvas.drawCircle(rect.center, radius, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    Rect rect = Rect.fromLTRB(0.0, 0.0, size.width, size.height);

    for(int wave = 3; wave >= 0; wave --){
      circle(canvas, rect, wave +_animation.value);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
