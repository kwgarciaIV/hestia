import 'package:flutter/material.dart';
import 'package:hestia/Screens/HomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Screens/LoginPage.dart';

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
      debugShowCheckedModeBanner: false,
      initialRoute: initScreen == 0 || initScreen == null ? 'login' : 'home',
      routes: {
        'home': (context) => HomePage(),
        'login': (context) => LoginPage(),
      },
    );
  }
}
