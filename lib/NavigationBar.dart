import 'package:flutter/material.dart';
import 'package:hestia/constants.dart';

class NavigationBar extends StatefulWidget {
  const NavigationBar({Key? key}) : super(key: key);

  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainDarkGreen,
      body: Column(
        children: <Widget>[
          Text(
            'Poppins',
            style: TextStyle(
                fontFamily: 'Poppins-Bold',
                fontSize: 30,
                fontStyle: FontStyle.italic),
          ),
          Text(
            'Montserrat',
            style:
            TextStyle(fontFamily: 'Montserrat-Regular', fontSize: 30),
          ),
          Text(
            'Comfortaa',
            style: TextStyle(fontFamily: 'Comfortaa-Regular', fontSize: 30),
          ),
        ],
      ),
    );
  }
}
