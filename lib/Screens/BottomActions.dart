import 'package:flutter/material.dart';
import 'package:hestia/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'AddTaskPopUp.dart';
import 'package:page_transition/page_transition.dart';
import 'package:hestia/Components/NavigationBar.dart';
import 'HomePage.dart';
import 'InventoryPage.dart';
import 'BudgetPage.dart';

//enum PageSelection1 { home, budget, inventory, about, settings }

class BottomAction extends StatefulWidget {
  const BottomAction({Key? key}) : super(key: key);

  @override
  _BottomActionState createState() => _BottomActionState();
}

class _BottomActionState extends State<BottomAction> {
  _BottomActionState({this.selectedPage});
  PageSelection? selectedPage;

  @override
  Widget build(BuildContext context) {
    //return _show
    return Container(
      margin: EdgeInsets.fromLTRB(30, 0, 30, 20),
      height: 60,
      decoration: BoxDecoration(
        color: kMainDarkGreen,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 6,
              child: GestureDetector(
                onTap: () {
                  print('Add task');
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: AddTaskPopUp(),
                    ),
                  );
                  /* showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    context: context,
                    builder: (BuildContext context) {
                      return AddTaskPopUp();
                    },
                  );*/
                },
                child: Container(
                  margin: EdgeInsets.only(left: 5, right: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        'Add Task',
                        style: TextStyle(
                          color: kMainDarkGreen,
                          fontFamily: 'Montserrat-Bold',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedPage = PageSelection.home;
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.bottomToTop,
                        child: HomePage(),
                      ),
                    );
                  });
                },
                child: CircleAvatar(
                  child: FaIcon(
                    FontAwesomeIcons.home,
                    color: kOffWhite,
                  ), // Icon widget changed with FaIcon
                  radius: 60.0,
                  backgroundColor: kMainDarkGreen,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedPage = PageSelection.home;
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.bottomToTop,
                        child: InventoryPage(),
                      ),
                    );
                  });
                },
                child: CircleAvatar(
                  child: FaIcon(
                    FontAwesomeIcons.boxOpen,
                    color: kOffWhite,
                  ), // Icon widget changed with FaIcon
                  radius: 60.0,
                  backgroundColor: kMainDarkGreen,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedPage = PageSelection.home;
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.bottomToTop,
                        //duration: Duration(milliseconds: 300),
                        child: BudgetPage(),
                      ),
                    );
                  });
                },
                child: CircleAvatar(
                  child: FaIcon(
                    FontAwesomeIcons.wallet,
                    color: kOffWhite,
                  ), // Icon widget changed with FaIcon
                  radius: 60.0,
                  backgroundColor: kMainDarkGreen,
                ),
              ),
            ),
          ],
        ),
      ),
    );
    //: Row();
  }

//   void _showBottomBar(bool value) {
//     setState(() {
//       _show = value;
//     });
//   }
}
