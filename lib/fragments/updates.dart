import 'package:flutter/material.dart';

class Updates extends StatefulWidget {
  const Updates({super.key});

  @override
  State<Updates> createState() => _UpdatesState();
}

class _UpdatesState extends State<Updates> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notifications_off_outlined, size: 200,),
          const SizedBox(height: 10,),
          Padding(
            padding: EdgeInsets.all(10),
              child: Text('Well-well-well no new update for now fren, check back later!', textAlign: TextAlign.center, textScaleFactor: 2,))
        ],
      ),
    );
  }
}
