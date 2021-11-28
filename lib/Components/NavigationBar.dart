import 'package:flutter/material.dart';
import 'package:hestia/constants.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Screens/HomePage.dart';
import '../Screens/InventoryPage.dart';

enum PageSelection { home, budget, inventory, about, settings }

class NavigationBar extends StatefulWidget {
  NavigationBar({this.selectedPage});
  PageSelection? selectedPage;

  @override
  _NavigationBarState createState() =>
      _NavigationBarState(selectedPage: selectedPage);
}

class _NavigationBarState extends State<NavigationBar> {
  _NavigationBarState({this.selectedPage});
  PageSelection? selectedPage;
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
                        setState(() {
                          selectedPage = PageSelection.inventory;
                        });
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
                SizedBox(height: 20.0),
                //Inventory

                Row(
                  children: [
                    Container(
                      width: 8.0,
                      height: 50.0,
                      color: selectedPage == PageSelection.budget
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
                          selectedPage = PageSelection.budget;
                        });
                      },
                      child: Text(
                        'Budget',
                        textAlign: TextAlign.left,
                        style: selectedPage == PageSelection.budget
                            ? kNavBarTextStylePressed
                            : kNavBarTextStyle,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
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
                        setState(() {
                          selectedPage = PageSelection.about;
                        });
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
              ],
            ),
          ),
/*          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Text(
              '© 2021 Tessera',
              style: TextStyle(
                color: Color(0xFF798A89),
                fontFamily: 'Montserrat-Regular',
                fontSize: 20.0,
              ),
            ),
          ),*/
        ],
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Text(
          '© 2021 Tessera',
          textAlign: TextAlign.right,
          style: TextStyle(
            color: Color(0xFF798A89),
            fontFamily: 'Montserrat-Regular',
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }
}
