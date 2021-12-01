import 'package:flutter/material.dart';
import 'package:hestia/Weather/loading_screen.dart';
import 'package:hestia/constants.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => SafeArea(
        child: IntroductionScreen(
          pages: [
            PageViewModel(
              title: 'Task Management',
              body:
                  'Track your upcoming tasks, and never miss any schedule.', //medj sabaw tings, pwede pa to change
              image: buildImage(
                  'images/Hestia Logo.png'), //change to task vector image
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Inventory Management',
              body:
                  'Track your inventory stocks, avoid last minute shopping.', //medj sabaw tings, pwede pa to change
              image: buildImage(
                  'images/Hestia Logo.png'), //change to inventory vector image
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Budget Management',
              body:
                  'Track your spending, and never worry on your budget.', //medj sabaw tings, pwede pa to change
              image: buildImage(
                  'images/Hestia Logo.png'), //change to budget vector image
              decoration: getPageDecoration(),
            )
          ],
          done: Text('Done', style: kOnBoardButtons),
          onDone: () => goToHome(context),
          showSkipButton: true,
          skip: Text('Skip', style: kOnBoardButtons),
          onSkip: () => goToHome(context),
          next: Icon(Icons.arrow_forward),
          dotsDecorator: getDotDecoration(),
          onChange: (index) => print('Page $index selected'),
          globalBackgroundColor: kVeryDarkGreen,
          animationDuration: 500,
          skipFlex: 0,
          nextFlex: 0,
          // showNextButton: false,
          // isProgress: false,
          // isProgressTap: false,
          // freeze: true,
        ),
      );

  DotsDecorator getDotDecoration() => DotsDecorator(
        color: kGold,
        activeColor: kMainDarkGreen,
        size: Size(10, 10),
        activeSize: Size(20, 10),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      );

  void goToHome(context) => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => LoadingScreen()),
      );

  Widget buildImage(String path) =>
      Center(child: Image.asset(path, width: 350));

  PageDecoration getPageDecoration() => PageDecoration(
        titleTextStyle: kOBtitle,
        bodyTextStyle: kOBbody,
        descriptionPadding: EdgeInsets.all(16).copyWith(bottom: 0),
        imagePadding: EdgeInsets.all(24),
        pageColor: Colors.white,
      );
}
