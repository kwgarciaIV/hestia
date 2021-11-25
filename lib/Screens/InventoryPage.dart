import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hestia/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({Key? key}) : super(key: key);

  @override
  _InventoryPageState createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 640),
      builder: () => Scaffold(
        backgroundColor: kOffWhite,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                    width: MediaQuery.of(context).size.width,
                    padding: new EdgeInsets.fromLTRB(30, 60, 0, 25),
                    decoration: BoxDecoration(
                      color: kMainDarkGreen,
                    ),
                    //constraints: BoxConstraints.expand(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Food Inventory',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: kGold,
                                fontSize: 32.0,
                                fontFamily: 'Poppins-Bold',
                              ),
                            ),
                            SizedBox(height: 2.0),
                            Text(
                              'Track your food items here',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                                fontFamily: 'Poppins-Regular',
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              margin: EdgeInsets.only(right: 30),
                              child: FloatingActionButton(
                                //to be replaced by an icon
                                child: Text('+',
                                    style: TextStyle(
                                      color: kMainDarkGreen,
                                      fontSize: 40,
                                    )),
                                backgroundColor: Colors.white,
                                onPressed: () {},
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
                Container(
                  padding: new EdgeInsets.fromLTRB(30, 20, 30, 30),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: new EdgeInsets.symmetric(
                            vertical: 12, horizontal: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        margin: EdgeInsets.only(bottom: 10),
                        child: Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(left: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Text(
                                        'Item Title',
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
                              Row(
                                children: <Widget>[
                                  Container(
                                      height: 50,
                                      width: 2,
                                      color: kGrayHeading),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 5),
                                    child: Column(
                                      children: [
                                        Text(
                                          '00',
                                          style: TextStyle(
                                            color: kVeryDarkGreen,
                                            fontSize: 40.0,
                                            fontFamily: 'Montserrat-Bold',
                                          ),
                                        ),
                                        Text(
                                          'Quantity',
                                          style: TextStyle(
                                            color: kGrayHeading,
                                            fontSize: 12.0,
                                            fontFamily: 'Montserrat-SemiBold',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    Icons.more_vert,
                                    size: 30,
                                    color: Color(0xFF959595),
                                  ),
                                ],
                              )
                            ],
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
        bottomNavigationBar: Container(
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
                          'Add to Calendar',
                          style: TextStyle(
                            color: kMainDarkGreen,
                            fontFamily: 'Montserrat-Bold',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
