import 'package:flutter/material.dart';
import 'package:hestia/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'AddTaskPopUp.dart';

class BottomAction extends StatefulWidget {
  const BottomAction({Key? key}) : super(key: key);

  @override
  _BottomActionState createState() => _BottomActionState();
}

class _BottomActionState extends State<BottomAction> {
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
                  showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    context: context,
                    builder: (BuildContext context) {
                      return AddTaskPopUp();
                    },
                  );
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
              child: CircleAvatar(
                child: FaIcon(
                  FontAwesomeIcons.home,
                  color: kOffWhite,
                ), // Icon widget changed with FaIcon
                radius: 60.0,
                backgroundColor: kMainDarkGreen,
              ),
            ),
            Expanded(
              flex: 2,
              child: CircleAvatar(
                child: FaIcon(
                  FontAwesomeIcons.calendarWeek,
                  color: kOffWhite,
                ), // Icon widget changed with FaIcon
                radius: 60.0,
                backgroundColor: kMainDarkGreen,
              ),
            ),
            Expanded(
              flex: 2,
              child: CircleAvatar(
                child: FaIcon(
                  FontAwesomeIcons.boxOpen,
                  color: kOffWhite,
                ), // Icon widget changed with FaIcon
                radius: 60.0,
                backgroundColor: kMainDarkGreen,
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
