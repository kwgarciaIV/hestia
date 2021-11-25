import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hestia/Components/BottomActions.dart';
import 'package:hestia/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import '../Components/NavigationBar.dart';

//Klee Comments
//No NavBar button
//Cards not dismissive, still not a component
//Bottom NavBar no functionality
//Username still not passed

enum SelectedTab { add, home, weekly, inventory }

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var selectedTab = SelectedTab.home;

  void handleIndexChanged(int i) {
    setState(() {
      selectedTab = SelectedTab.values[i];
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 640),
      builder: () => Scaffold(
        backgroundColor: kOffWhite,
        appBar: AppBar(
          backgroundColor: kMainDarkGreen,
          shadowColor: Colors.transparent,
          leading: IconButton(
            icon:
                Image.asset('images/navigation_button_white.png', height: 20.0),
            onPressed: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.leftToRight,
                  child: NavigationBar(selectedPage: PageSelection.home),
                ),
              );
            },
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: new EdgeInsets.fromLTRB(30, 30, 0, 25),
                  decoration: BoxDecoration(
                    color: kMainDarkGreen,
                  ),
                  //constraints: BoxConstraints.expand(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Roomie!',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: kGold,
                          fontSize: 32.0,
                          fontFamily: 'Poppins-Bold',
                        ),
                      ),
                      SizedBox(height: 2.0),
                      Text(
                        'How are you feeling today?',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontFamily: 'Poppins-Regular',
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: new EdgeInsets.fromLTRB(30, 20, 30, 30),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: RichText(
                          text: new TextSpan(
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Poppins-Regular',
                              color: kMainDarkGreen,
                            ),
                            children: <TextSpan>[
                              new TextSpan(
                                text: 'November 24, ',
                                style: TextStyle(
                                  fontFamily: 'Poppins-Bold',
                                ),
                              ),
                              new TextSpan(
                                text: 'Wednesday',
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: new EdgeInsets.symmetric(
                            vertical: 12, horizontal: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        margin: EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 5, right: 13),
                              child: Column(
                                children: [
                                  Text(
                                    '7:00',
                                    style: TextStyle(
                                      color: kVeryDarkGreen,
                                      fontSize: 20.0,
                                      fontFamily: 'Montserrat-Bold',
                                    ),
                                  ),
                                  Text(
                                    'AM',
                                    style: TextStyle(
                                      color: kGrayHeading,
                                      fontSize: 18.0,
                                      fontFamily: 'Montserrat-SemiBold',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                                height: 50, width: 2, color: kGrayHeading),
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Text(
                                      'Lorem Ipsum',
                                      style: TextStyle(
                                        color: kVeryDarkGreen,
                                        fontSize: 25.0,
                                        fontFamily: 'Poppins-Bold',
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 30),
                                    color: kGrayButton,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: new EdgeInsets.symmetric(
                            vertical: 12, horizontal: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        margin: EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 5, right: 13),
                              child: Column(
                                children: [
                                  Text(
                                    '7:00',
                                    style: TextStyle(
                                      color: kVeryDarkGreen,
                                      fontSize: 20.0,
                                      fontFamily: 'Montserrat-Bold',
                                    ),
                                  ),
                                  Text(
                                    'AM',
                                    style: TextStyle(
                                      color: kGrayHeading,
                                      fontSize: 18.0,
                                      fontFamily: 'Montserrat-SemiBold',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                                height: 50, width: 2, color: kGrayHeading),
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Text(
                                      'Lorem Ipsum',
                                      style: TextStyle(
                                        color: kVeryDarkGreen,
                                        fontSize: 25.0,
                                        fontFamily: 'Poppins-Bold',
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 30),
                                    color: kGrayButton,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: new EdgeInsets.symmetric(
                            vertical: 12, horizontal: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        margin: EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 5, right: 13),
                              child: Column(
                                children: [
                                  Text(
                                    '7:00',
                                    style: TextStyle(
                                      color: kVeryDarkGreen,
                                      fontSize: 20.0,
                                      fontFamily: 'Montserrat-Bold',
                                    ),
                                  ),
                                  Text(
                                    'AM',
                                    style: TextStyle(
                                      color: kGrayHeading,
                                      fontSize: 18.0,
                                      fontFamily: 'Montserrat-SemiBold',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                                height: 50, width: 2, color: kGrayHeading),
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Text(
                                      'Lorem Ipsum',
                                      style: TextStyle(
                                        color: kVeryDarkGreen,
                                        fontSize: 25.0,
                                        fontFamily: 'Poppins-Bold',
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 30),
                                    color: kGrayButton,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: new EdgeInsets.symmetric(
                            vertical: 12, horizontal: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        margin: EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 5, right: 13),
                              child: Column(
                                children: [
                                  Text(
                                    '7:00',
                                    style: TextStyle(
                                      color: kVeryDarkGreen,
                                      fontSize: 20.0,
                                      fontFamily: 'Montserrat-Bold',
                                    ),
                                  ),
                                  Text(
                                    'AM',
                                    style: TextStyle(
                                      color: kGrayHeading,
                                      fontSize: 18.0,
                                      fontFamily: 'Montserrat-SemiBold',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                                height: 50, width: 2, color: kGrayHeading),
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Text(
                                      'Lorem Ipsum',
                                      style: TextStyle(
                                        color: kVeryDarkGreen,
                                        fontSize: 25.0,
                                        fontFamily: 'Poppins-Bold',
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 30),
                                    color: kGrayButton,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: new EdgeInsets.symmetric(
                            vertical: 12, horizontal: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        margin: EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 5, right: 13),
                              child: Column(
                                children: [
                                  Text(
                                    '7:00',
                                    style: TextStyle(
                                      color: kVeryDarkGreen,
                                      fontSize: 20.0,
                                      fontFamily: 'Montserrat-Bold',
                                    ),
                                  ),
                                  Text(
                                    'AM',
                                    style: TextStyle(
                                      color: kGrayHeading,
                                      fontSize: 18.0,
                                      fontFamily: 'Montserrat-SemiBold',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                                height: 50, width: 2, color: kGrayHeading),
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Text(
                                      'Lorem Ipsum',
                                      style: TextStyle(
                                        color: kVeryDarkGreen,
                                        fontSize: 25.0,
                                        fontFamily: 'Poppins-Bold',
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 30),
                                    color: kGrayButton,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: new EdgeInsets.symmetric(
                            vertical: 12, horizontal: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        margin: EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 5, right: 13),
                              child: Column(
                                children: [
                                  Text(
                                    '7:00',
                                    style: TextStyle(
                                      color: kVeryDarkGreen,
                                      fontSize: 20.0,
                                      fontFamily: 'Montserrat-Bold',
                                    ),
                                  ),
                                  Text(
                                    'AM',
                                    style: TextStyle(
                                      color: kGrayHeading,
                                      fontSize: 18.0,
                                      fontFamily: 'Montserrat-SemiBold',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                                height: 50, width: 2, color: kGrayHeading),
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Text(
                                      'Lorem Ipsum',
                                      style: TextStyle(
                                        color: kVeryDarkGreen,
                                        fontSize: 25.0,
                                        fontFamily: 'Poppins-Bold',
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 30),
                                    color: kGrayButton,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: RichText(
                          text: TextSpan(
                            text: 'See Full Schedule',
                            style: TextStyle(
                              color: kVeryDarkGreen,
                              fontFamily: 'Montserrat-SemiBold',
                              fontSize: 14,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAction(),
      ),
    );
  }
}
