import 'package:flutter/material.dart';
import 'package:smartcoin/fragments/frens.dart';
import 'package:smartcoin/fragments/mine.dart';
import 'package:smartcoin/fragments/task.dart';
import 'package:animated_background/animated_background.dart';
import 'package:webviewx/webviewx.dart';

import '../fragments/updates.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomefragmentstate();
}

class _MyHomefragmentstate extends State<MyHomePage> with TickerProviderStateMixin  {

  late TabController tab_controller;
  Color color = Colors.transparent;

  dynamic controller;
  bool isLoading = true, failedToLoad = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body:  Stack(
          children: [
            AnimatedBackground(
              vsync: this,
              behaviour: RandomParticleBehaviour(
                  options: ParticleOptions(
                      spawnMaxSpeed: 100,
                      spawnMinSpeed: 50,
                      baseColor: Colors.grey
                  )
              ),
              child: TabBarView(
                controller: tab_controller,

                children:  [
                  Mine(),
                  Task(),
                  Updates(),
                  Frens(),
                ],
              ),
            ),

            //ads
            
          ],
        ),

        bottomNavigationBar: Container(
          color: color,
          child: TabBar(
            indicatorColor: Colors.yellow,
            //padding: EdgeInsets.all(10),
            controller: tab_controller,
            labelColor: Colors.lightBlue,
            unselectedLabelColor: Colors.grey,

            tabs: [
//home starts
              Tab(
                icon: Icon(Icons.touch_app),
                text: 'Mine',
                // child: const Text('Home', style: TextStyle(fontSize: 9)),
              ),

//frens
              Tab(
                text: 'Tasks',
                icon: Badge(

                    child:Icon(Icons.task_alt) ),
                // child: const Text('Profile', style: TextStyle(fontSize: 9),),
              ),

              Tab(
                text: 'Updates',
                icon: Badge(

                    child:Icon(Icons.notifications_active) ),
                // child: const Text('Profile', style: TextStyle(fontSize: 9),),
              ),
//market starts
              Tab(
                icon: Icon(Icons.people_outline_rounded),
                text: 'Frens',
                // child: const Text('Home', style: TextStyle(fontSize: 9)),
              ),

            ],
          ),
        )
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    tab_controller = TabController(length: 4, vsync: this);
    tab_controller.addListener(_tabChanged);
    super.initState();
  }

  void _tabChanged() {
    if(tab_controller.index == 3){
      color = Colors.grey.shade900;
    }else{

      color = Colors.transparent;
    }
    setState(() {

    });
  }

}