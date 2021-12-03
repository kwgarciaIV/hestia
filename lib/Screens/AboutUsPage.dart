import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hestia/constants.dart';
import 'package:page_transition/page_transition.dart';
import 'package:hestia/Components/NavigationBar.dart';

enum SelectedTab { home, inventory, budget, about }

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  var selectedTab = SelectedTab.about;

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
          backgroundColor: kOffWhite,
          shadowColor: Colors.transparent,
          leading: IconButton(
            icon:
                Image.asset('images/navigation_button_green.png', height: 20.0),
            onPressed: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.leftToRight,
                  child: NavigationBar(selectedPage: PageSelection.about),
                ),
              );
            },
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'About us'.toUpperCase(),
                      style: TextStyle(
                        fontSize: 40,
                        fontFamily: 'Poppins-Bold',
                        color: kMainDarkGreen,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      'Our Story',
                      style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'Poppins-Bold',
                        color: kMainDarkGreen,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Center(
                      child: Text(
                        'Hestia is created by the developer group Tessera composed of four UST Computer Science students from the Philippines. The main purpose of the app is to provide a lifestyle assistant that is useful for homecare, thus including features for inventory tracking, budget tracking, and task management.',
                        textAlign: TextAlign.justify,
                        style: kAboutUs,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      'Our Team',
                      style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'Poppins-Bold',
                        color: kMainDarkGreen,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15, bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 3),
                          child: Text(
                            '-\t\tKyle Wilson A. Garcia IV.',
                            style: kAboutUs,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 3),
                          child: Text(
                            '-\t\tMonica S. Mendiola',
                            style: kAboutUs,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 3),
                          child: Text(
                            '-\t\tMaria Juliana S. Rolluqui',
                            style: kAboutUs,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 3),
                          child: Text(
                            '-\t\tMaxine Grace C. Uy',
                            style: kAboutUs,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 3),
                    child: Text(
                      'Contact Us',
                      style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'Poppins-Bold',
                        color: kMainDarkGreen,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 3),
                    child: Text(
                      '\tEmail: hutaolover12x2@gmail.com',
                      style: kAboutUs,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 3),
                    child: Text(
                      '\tNumber: 0917 861 1117',
                      style: kAboutUs,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
