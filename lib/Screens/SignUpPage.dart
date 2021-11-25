import 'package:flutter/material.dart';
import 'package:hestia/Screens/HomePage.dart';
import '../constants.dart';
import 'package:page_transition/page_transition.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  final username = new TextEditingController();
  final password = new TextEditingController();
  final passwordConfirmation = new TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainDarkGreen,
      //resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
                  hintText: 'Confirm Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: CircleAvatar(
                      child: FaIcon(
                        //im so sorry T.T di ko sure kung maganda to pero eto lang talaga available rawr
                        FontAwesomeIcons.key,
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
                padding: EdgeInsets.symmetric(horizontal: 132, vertical: 17),
                textStyle: TextStyle(fontSize: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // <-- Radius
                ),
              ),
              child: Text(
                'Sign Up',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kVeryDarkGreen,
                  fontFamily: 'Montserrat-Bold',
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(
              height: 40,
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
