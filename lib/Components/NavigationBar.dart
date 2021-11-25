import 'package:flutter/material.dart';
import 'package:hestia/constants.dart';
//import 'package:sizer/sizer.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Screens/HomePage.dart';
import '../Screens/InventoryPage.dart';

class NavigationBar extends StatefulWidget {
  const NavigationBar({Key? key}) : super(key: key);

  @override
  _NavigationBarState createState() => _NavigationBarState();
}

const kNavBarTextStyle = TextStyle(
  color: kOffWhite,
  fontSize: 20.0,
  fontFamily: 'Montserrat-Regular',
);

const kNavBarTextStylePressed = TextStyle(
  color: kOffWhite,
  fontSize: 20.0,
  fontFamily: 'Montserrat-Bold',
);

enum PageSelection { home, calendar, inventory, about, settings }

class _NavigationBarState extends State<NavigationBar> {
  PageSelection selectedPage = PageSelection.home;
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(360, 690),
        orientation: Orientation.portrait);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: IconButton(
          icon: Image.asset('images/navigation_button_white.png', height: 20.0),
          onPressed: () {
            Navigator.pop(
              context,
              PageTransition(
                type: PageTransitionType.rightToLeft,
                child: NavigationBar(),
              ),
            );
          },
        ),
      ),
      backgroundColor: kMainDarkGreen,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 5.0, 0, 5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //Hestia Text
                Row(
                  children: [
                    SizedBox(
                      width: 30.0,
                    ),
                    Text(
                      'Hestia',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: 'Comfortaa-Regular',
                        fontSize: 40.0,
                        color: kGold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                //Home
                Row(
                  children: [
                    Container(
                      width: 8.0,
                      height: 50.0,
                      color: selectedPage == PageSelection.home
                          ? kGold
                          : kMainDarkGreen,
                      child: Text(''),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedPage = PageSelection.home;
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: HomePage(),
                            ),
                          );
                        });
                      },
                      child: Text(
                        'Home',
                        textAlign: TextAlign.left,
                        style: selectedPage == PageSelection.home
                            ? kNavBarTextStylePressed
                            : kNavBarTextStyle,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                //Calendar
                Row(
                  children: [
                    Container(
                      width: 8.0,
                      height: 50.0,
                      color: selectedPage == PageSelection.calendar
                          ? kGold
                          : kMainDarkGreen,
                      child: Text(''),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedPage = PageSelection.calendar;
                        });
                      },
                      child: Text(
                        'Calendar',
                        textAlign: TextAlign.left,
                        style: selectedPage == PageSelection.calendar
                            ? kNavBarTextStylePressed
                            : kNavBarTextStyle,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                //Inventory
                Row(
                  children: [
                    Container(
                      width: 8.0,
                      height: 50.0,
                      color: selectedPage == PageSelection.inventory
                          ? kGold
                          : kMainDarkGreen,
                      child: Text(''),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        selectedPage = PageSelection.inventory;
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: InventoryPage(),
                          ),
                        );
                      },
                      child: Text(
                        'Inventory',
                        textAlign: TextAlign.left,
                        style: selectedPage == PageSelection.inventory
                            ? kNavBarTextStylePressed
                            : kNavBarTextStyle,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 120.0),
                //About Us
                Row(
                  children: [
                    Container(
                      width: 8.0,
                      height: 50.0,
                      color: selectedPage == PageSelection.about
                          ? kGold
                          : kMainDarkGreen,
                      child: Text(''),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        selectedPage = PageSelection.about;
                      },
                      child: Text(
                        'About Us',
                        textAlign: TextAlign.left,
                        style: selectedPage == PageSelection.about
                            ? kNavBarTextStylePressed
                            : kNavBarTextStyle,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                //Settings
                Row(
                  children: [
                    Container(
                      width: 8.0,
                      height: 50.0,
                      color: selectedPage == PageSelection.settings
                          ? kGold
                          : kMainDarkGreen,
                      child: Text(''),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedPage = PageSelection.settings;
                        });
                      },
                      child: Text(
                        'Settings',
                        textAlign: TextAlign.left,
                        style: selectedPage == PageSelection.settings
                            ? kNavBarTextStylePressed
                            : kNavBarTextStyle,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                //Log out
                Row(
                  children: <Widget>[
                    SizedBox(width: 22.0),
                    Icon(
                      Icons.logout_rounded,
                      color: kOffWhite,
                    ),
                    Text(
                      'Log-out',
                      textAlign: TextAlign.left,
                      style: kNavBarTextStyle,
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                // Positioned(
                //   right: 10.0,
                //   child: Text(
                //     '© 2021 Tessera',
                //     style: TextStyle(
                //       color: Color(0xFF798A89),
                //       fontFamily: 'Montserrat-Regular',
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Text(
              '© 2021 Tessera',
              style: TextStyle(
                color: Color(0xFF798A89),
                fontFamily: 'Montserrat-Regular',
                fontSize: 20.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
