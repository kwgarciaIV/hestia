import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hestia/constants.dart';

class AddInventoryPopUp extends StatefulWidget {
  const AddInventoryPopUp({Key? key}) : super(key: key);

  @override
  _AddInventoryPopUpState createState() => _AddInventoryPopUpState();
}

class _AddInventoryPopUpState extends State<AddInventoryPopUp> {
  String dropDownValue1 = '';
  String dropDownValue2 = '';
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
            'Add Item',
            style: TextStyle(
              fontFamily: 'Montserrat-Bold',
              fontSize: 20.0,
              color: kVeryDarkGreen,
            ),
          )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5.0),
            child: Text(
              'Item Name',
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
                hintText: 'Enter Item',
                hintStyle: kHintTextStyle,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5.0),
            child: Text(
              'Item Quantity',
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
                hintText: 'Enter Initial Item Quantity',
                hintStyle: kHintTextStyle,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5.0),
            child: Text(
              'Unit of Measure',
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
          Container(
            color: Colors.white,
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
              child: DropdownButton(
                //buttonstyle: ButtonStyle(),
                hint: dropDownValue1 == ''
                    ? Text('Choose Unit of Measure')
                    : Text(
                        dropDownValue1,
                        style: dropDownValue1 == ''
                            ? kHintTextStyle
                            : kInputTextStyle,
                      ),
                isExpanded: true,
                focusColor: Colors.white,
                iconSize: 30.0,
                style: dropDownValue1 == '' ? kHintTextStyle : kInputTextStyle,
                items: [
                  'Pieces',
                  'Box',
                  'Pack',
                  'Grams (g)',
                  'Kilograms (kg)',
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
                      dropDownValue1 = val.toString();
                    },
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5.0),
            child: Text(
              'Category',
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
          Container(
            color: Colors.white,
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
              child: DropdownButton(
                //buttonstyle: ButtonStyle(),
                hint: dropDownValue2 == ''
                    ? Text('Choose Item Category')
                    : Text(
                        dropDownValue2,
                        style: dropDownValue2 == ''
                            ? kHintTextStyle
                            : kInputTextStyle,
                      ),
                isExpanded: true,
                focusColor: Colors.white,
                iconSize: 30.0,
                style: dropDownValue2 == '' ? kHintTextStyle : kInputTextStyle,
                items: [
                  'Beverages',
                  'Bread & Pastry',
                  'Breakfast & Cereal',
                  'Canned Goods & Soups',
                  'Condiments',
                  'Snacks & Candy',
                  'Dairy',
                  'Fruits & Vegetables',
                  'Pasta',
                  'Frozen Meat & Seafood',
                  'Miscellaneous',
                  'Paper Products',
                  'Cleaning Supplies',
                  'Health',
                  'Pet Care',
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
                      dropDownValue2 = val.toString();
                    },
                  );
                },
              ),
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
                    Navigator.pop(context, AddInventoryPopUp());
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
