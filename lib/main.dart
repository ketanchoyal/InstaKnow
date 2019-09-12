import 'package:flutter/material.dart';
import 'package:instaknown/UI/Pages/HomePage.dart';
import 'package:instaknown/UI/Pages/SplashScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      routes: {
        HomePage.id: (context) => HomePage(),
        SplashScreen.id: (context) => SplashScreen(),
      },
      // initialRoute: SplashScreen.id,
      home: SplashScreen(),
    );
  }
}
