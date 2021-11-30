import 'package:flutter/material.dart';
import 'package:hestia/Screens/HomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Screens/LoginPage.dart';
import 'package:responsive_framework/responsive_framework.dart';

int? initScreen;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  initScreen = await preferences.getInt('initScreen');
  await preferences.setInt('initScreen', 1);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, widget) => ResponsiveWrapper.builder(
        BouncingScrollWrapper.builder(context, widget!),
        maxWidth: 1000,
        minWidth: 450,
        defaultScale: true,
        breakpoints: [
          ResponsiveBreakpoint.resize(450, name: MOBILE),
          ResponsiveBreakpoint.autoScale(800, name: MOBILE),
          ResponsiveBreakpoint.autoScale(800, name: TABLET),
          ResponsiveBreakpoint.autoScale(1000, name: TABLET),
        ],
        background: Container(
          color: Color(0xFFF5F5F5),
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: initScreen == 0 || initScreen == null ? 'login' : 'home',
      routes: {
        'home': (context) => HomePage(),
        'login': (context) => LoginPage(),
      },
    );
  }
}
