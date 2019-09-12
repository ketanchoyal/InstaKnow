import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:instaknown/UI/Pages/HomePage.dart';
import 'package:instaknown/UI/Resources/Constants.dart' as R;

class SplashScreen extends StatefulWidget {
  static const id = 'SplashScreen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _goToHomepage(BuildContext context) async {
    await Future.delayed(Duration(seconds: 5));
    Navigator.pushNamedAndRemoveUntil(context, HomePage.id, (r) => false);
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
    WidgetsBinding.instance.addPostFrameCallback((_) => _goToHomepage(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black,
                  Colors.black45,
                  Colors.white,
                  // Color(
                  //   0xff6a60ee,
                  // ),
                  // Color(
                  //   0xff56edff,
                  // ),
                ],
                stops: [0, 0.5, 1],
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 400,
              width: 400,
              // color: Colors.red,
              child: FlareActor(
                'assets/emoji1.flr',
                shouldClip: false,
                snapToEnd: true,
                sizeFromArtboard: true,
                alignment: Alignment.center,
                fit: BoxFit.contain,
                animation: "Animations",
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 100.0 + MediaQuery.of(context).size.height / 2,
            child: Text(
              'InstaKnow',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 60,
                fontFamily: R.instagramFontFamily,
                color: Colors.white,
                letterSpacing: 3,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
