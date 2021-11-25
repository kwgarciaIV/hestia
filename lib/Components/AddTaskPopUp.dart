import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hestia/constants.dart';

class AddTaskPopUp extends StatefulWidget {
  const AddTaskPopUp({Key? key}) : super(key: key);

  @override
  _AddTaskPopUpState createState() => _AddTaskPopUpState();
}

const kLabelInputField = TextStyle(
    fontFamily: 'Montserrat-SemiBold',
    fontSize: 15.0,
    color: Color(0xFF57706F));
const kHintTextStyle = TextStyle(
    fontSize: 15,
    color: kGrayButton,
    fontStyle: FontStyle.italic,
    fontFamily: 'Montserrat-Medium');
const kInputTextStyle = TextStyle(
    color: Colors.black, fontSize: 15.0, fontFamily: 'Montserrat-SemiBold');

class _AddTaskPopUpState extends State<AddTaskPopUp> {
  String dropDownValue = '';
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kOffWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 20.0),
          Center(
              child: Text(
            'Add Task',
            style: TextStyle(
              fontFamily: 'Montserrat-Bold',
              fontSize: 20.0,
              color: kVeryDarkGreen,
            ),
          )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5.0),
            child: Text(
              'Task Title',
              style: kLabelInputField,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                filled: true,
                fillColor: kGrayTextField,
                hintText: 'Enter Task Title',
                hintStyle: kHintTextStyle,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5.0),
            child: Text(
              'Task Description',
              style: kLabelInputField,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                filled: true,
                fillColor: kGrayTextField,
                hintText: 'Enter Task Description',
                hintStyle: kHintTextStyle,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5.0),
            child: Text(
              'Task Category',
              style: kLabelInputField,
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
          //   child: TextField(
          //     decoration: InputDecoration(
          //       border: InputBorder.none,
          //       filled: true,
          //       fillColor: kGrayTextField,
          //       hintText: 'Enter Task Category',
          //       hintStyle: kHintTextStyle,
          //     ),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
            child: DropdownButton(
              //buttonstyle: ButtonStyle(),
              hint: dropDownValue == ''
                  ? Text('Choose Task Category')
                  : Text(
                      dropDownValue,
                      style: dropDownValue == ''
                          ? kHintTextStyle
                          : kInputTextStyle,
                    ),
              isExpanded: true,
              focusColor: Colors.white,
              iconSize: 30.0,
              style: dropDownValue == '' ? kHintTextStyle : kInputTextStyle,
              items: [
                'Chores',
                'Cleaning',
                'Cooking',
                'Meeting',
                'Event',
                'Appointment',
                'Miscellaneous'
              ].map(
                (val) {
                  return DropdownMenuItem<String>(
                    value: val,
                    child: Text(val),
                  );
                },
              ).toList(),
              onChanged: (val) {
                setState(
                  () {
                    dropDownValue = val.toString();
                  },
                );
              },
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                //"Back" Button
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context, AddTaskPopUp());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: kGrayButton,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 40.0),
                      child: Text(
                        'Back',
                        style: TextStyle(
                            fontFamily: 'Montserrat-SemiBold',
                            fontSize: 15.0,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),

                //"Add Task" Button
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      color: kMainDarkGreen,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 40.0),
                      child: Text(
                        'Add Task',
                        style: TextStyle(
                            fontFamily: 'Montserrat-SemiBold',
                            fontSize: 15.0,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
