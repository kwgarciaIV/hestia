import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:page_transition/page_transition.dart';
import '../Components/NavigationBar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kOffWhite,
      body: Column(
        children: <Widget>[
          FloatingActionButton(
            child: Text('test'),
            onPressed: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.leftToRight,
                  child: NavigationBar(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
