import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
