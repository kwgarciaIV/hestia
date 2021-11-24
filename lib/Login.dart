import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:page_transition/page_transition.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  final username = new TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kVeryDarkGreen,
      //resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 70,
            ),
            Container(
              child: Image.asset(
                "images/Hestia Logo.png",
                width: 275,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(40, 0, 40, 15),
              child: TextField(
                controller: username,
                autofocus: false,
                textAlignVertical: TextAlignVertical.center,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Montserrat-SemiBold',
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                  hintText: 'Username',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),

                  //To be changed, di ako marunong mag lagay ng icons T.T Padding on the left must be added~
                  //Tsaka umiilaw siya di ko alam bakit, paskong pasko na siguro.
                  prefixIcon: Icon(Icons.email),
                  hintStyle: TextStyle(
                    color: Colors.white70,
                    fontFamily: 'Montserrat-SemiBold',
                    fontSize: 16,
                  ),
                  filled: true,
                  fillColor: Color(0xFF57706F),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                /*  Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.fade,
                    child: CustomScreen(name: yourName.text),
                    duration: Duration(milliseconds: 500),
                    reverseDuration: Duration(milliseconds: 500),
                  ),
                );*/
              },
              style: ElevatedButton.styleFrom(
                primary: kGold,
                padding: EdgeInsets.symmetric(horizontal: 130, vertical: 17),
                textStyle: TextStyle(fontSize: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // <-- Radius
                ),
              ),
              child: Text(
                'Proceed',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kVeryDarkGreen,
                  fontFamily: 'Montserrat-Bold',
                  fontSize: 16,
                ),
              ),
            ),
            /*  Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: RichText(
                text: new TextSpan(
                  children: <TextSpan>[
                    new TextSpan(text: 'Don\'t have an account?'),
                    new TextSpan(text: 'Sign up!'),
                  ],
                ),
              ),
            ),*/
            SizedBox(
              height: 100,
            ),
            Text(
              '© 2021 Tessera. All rights reserved.',
              style: TextStyle(
                fontFamily: 'Montserrat-Regular',
                fontSize: 14,
                color: kGrayButton,
              ),
            )
          ],
        ),
      ),
    );
  }
}
