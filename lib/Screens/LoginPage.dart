import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hestia/Screens/HomePage.dart';
import 'package:hestia/Screens/SignUpPage.dart';
import '../constants.dart';
import 'package:page_transition/page_transition.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  final username = new TextEditingController();
  final password = new TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainDarkGreen,
      //resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Container(
              child: Image.asset(
                "images/Hestia Logo.png",
                width: 275,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(40, 0, 40, 10),
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
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: CircleAvatar(
                      child: FaIcon(
                        FontAwesomeIcons.userCircle,
                        color: kOffWhite,
                      ), // Icon widget changed with FaIcon
                      radius: 20.0,
                      backgroundColor: Color(0xFF57706F),
                    ),
                  ),
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
            Container(
              padding: EdgeInsets.fromLTRB(40, 0, 40, 10),
              child: TextField(
                controller: password,
                autofocus: false,
                textAlignVertical: TextAlignVertical.center,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Montserrat-SemiBold',
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                  hintText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: CircleAvatar(
                      child: FaIcon(
                        //im so sorry T.T di ko sure kung maganda to pero eto lang talaga available rawr
                        FontAwesomeIcons.lock,
                        color: kOffWhite,
                      ), // Icon widget changed with FaIcon
                      radius: 20.0,
                      backgroundColor: Color(0xFF57706F),
                    ),
                  ),
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
            //replace for responsiveness
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.fade,
                    child: HomePage(),
                    duration: Duration(milliseconds: 500),
                    reverseDuration: Duration(milliseconds: 500),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: kGold,
                padding: EdgeInsets.symmetric(horizontal: 140, vertical: 17),
                textStyle: TextStyle(fontSize: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // <-- Radius
                ),
              ),
              child: Text(
                'Log in',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kVeryDarkGreen,
                  fontFamily: 'Montserrat-Bold',
                  fontSize: 16,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Don\'t have an account? ',
                      style: TextStyle(
                        fontFamily: 'Montserrat-SemiBold',
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: 'Sign up!',
                      style: TextStyle(
                        fontFamily: 'Montserrat-Bold',
                        fontSize: 14,
                        color: kGold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.fade,
                              child: SignUpPage(),
                              duration: Duration(milliseconds: 500),
                              reverseDuration: Duration(milliseconds: 500),
                            ),
                          );
                        },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 70,
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
