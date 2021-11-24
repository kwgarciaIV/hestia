import 'package:flutter/material.dart';
import 'package:hestia/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 640),
      builder: () => Scaffold(
        backgroundColor: kOffWhite,
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: kMainDarkGreen,
                ),
                //constraints: BoxConstraints.expand(),
                child: Column(
                  children: [
                    SizedBox(height: 40.0),
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
                        fontSize: 13.0,
                        fontFamily: 'Poppins-Regular',
                      ),
                    ),
                    SizedBox(height: 50.0),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'November 24, ',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontFamily: 'Poppins-Bold',
                            ),
                          ),
                          Text(
                            'Wed',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontFamily: 'Poppins-Regular',
                            ),
                          ),
                        ],
                      ),
                      Card(
                        //----------------------------- edit to Dismissible
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Text(
                                  '7:00',
                                  style: TextStyle(
                                    color: kVeryDarkGreen,
                                    fontSize: 24.0,
                                    fontFamily: 'Montserrat-Regular',
                                  ),
                                ),
                                Text(
                                  'AM',
                                  style: TextStyle(
                                    color: kGrayTextField,
                                    fontSize: 24.0,
                                    fontFamily: 'Montserrat-Regular',
                                  ),
                                ),
                              ],
                            ),
                            VerticalDivider(
                              //---------------- line not showing
                              color: Colors.black,
                              thickness: 2,
                              indent: 10,
                              endIndent: 0,
                              width: 20,
                            ),
                            Column(
                              children: [
                                Text(
                                  'Lorem Ipsum',
                                  style: TextStyle(
                                    color: kVeryDarkGreen,
                                    fontSize: 25.0,
                                    fontFamily: 'Poppins-Bold',
                                  ),
                                ),
                                Text(
                                  'button',
                                  style: TextStyle(
                                    color: kGrayTextField,
                                    fontSize: 24.0,
                                    fontFamily: 'Poppins-Regular',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
