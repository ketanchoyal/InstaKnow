import 'dart:math';

import 'package:after_layout/after_layout.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:instaknown/UI/Pages/login_page.dart';
import 'package:instaknown/UI/Resources/Constants.dart' as R;
import 'package:instaknown/UI/Resources/my_flutter_app_icons.dart';
import 'package:instaknown/UI/Widgets/FloatingAppbar.dart';

class HomePage extends StatefulWidget {
  static const id = 'HomePage';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AfterLayoutMixin<HomePage>, TickerProviderStateMixin {
  CurvedAnimation curve;

  var buttonExpandedHeight = 0.0;
  var buttonExpandedWidth = 0.0;

  //*Private Button Animation Code
  AnimationController animationControllerPrivateButton;
  var privateButtonOffset = 0.0;
  get privateButtonExpansionPercentage => max(
        0.0,
        min(
          1.0,
          privateButtonOffset / buttonExpandedHeight,
        ),
      );
  bool isPrivateButtonExpanded = false;
  Animation<double> animationPrivateButton;

  void onPrivateButtonVerticalDragUpdate(details) {
    privateButtonOffset -= details.delta.dy;
    if (privateButtonOffset > buttonExpandedHeight) {
      privateButtonOffset = buttonExpandedHeight;
    } else if (privateButtonOffset < 0) {
      privateButtonOffset = 0;
    }
    print(privateButtonExpansionPercentage);
    setState(() {});
  }

  void animatePrivateButton(bool open) {
    if (isPublicButtonExpanded) {
      animatePubilcButton(!isPublicButtonExpanded);
    }

    animationControllerPrivateButton = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    curve = CurvedAnimation(
        parent: animationControllerPrivateButton, curve: Curves.ease);
    animationPrivateButton = Tween(
            begin: privateButtonOffset, end: open ? buttonExpandedHeight : 0.0)
        .animate(curve)
          ..addListener(() {
            setState(() {
              privateButtonOffset = animationPrivateButton.value;
            });
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              isPrivateButtonExpanded = open;
            }
          });
    animationControllerPrivateButton.forward();
  }

  //*Public Button Animation Code
  AnimationController animationControllerPubilcButton;
  var pubilcButtonOffset = 0.0;
  get pubilcButtonExpansionPercentage => max(
        0.0,
        min(
          1.0,
          pubilcButtonOffset / buttonExpandedHeight,
        ),
      );
  bool isPublicButtonExpanded = false;
  Animation<double> animationPubilcButton;

  void onPubilcButtonVerticalDragUpdate(details) {
    pubilcButtonOffset -= details.delta.dy;
    if (pubilcButtonOffset > buttonExpandedHeight) {
      pubilcButtonOffset = buttonExpandedHeight;
    } else if (pubilcButtonOffset < 0) {
      pubilcButtonOffset = 0;
    }
    setState(() {});
  }

  void animatePubilcButton(bool open) {
    if (isPrivateButtonExpanded) {
      animatePrivateButton(!isPrivateButtonExpanded);
    }

    animationControllerPubilcButton = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    curve = CurvedAnimation(
        parent: animationControllerPubilcButton, curve: Curves.ease);
    animationPubilcButton =
        Tween(begin: pubilcButtonOffset, end: open ? buttonExpandedHeight : 0.0)
            .animate(curve)
              ..addListener(() {
                setState(() {
                  pubilcButtonOffset = animationPubilcButton.value;
                });
              })
              ..addStatusListener((status) {
                if (status == AnimationStatus.completed) {
                  isPublicButtonExpanded = open;
                }
              });
    animationControllerPubilcButton.forward();
  }

  @override
  Widget build(BuildContext context) {
    buttonExpandedHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).size.height * .075 -
        210;

    buttonExpandedWidth = MediaQuery.of(context).size.width * 0.9 -
        MediaQuery.of(context).size.width * 0.40;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: <Widget>[
            _buildBacgroundEmoji(context),
            _buildInstructions(context),
            Positioned(
              bottom: 90 +
                  10 * privateButtonExpansionPercentage -
                  60 * pubilcButtonExpansionPercentage,
              left: MediaQuery.of(context).size.width * .05 / 2,
              child: _buttonPrivate(),
            ),
            Positioned(
              bottom: 90 +
                  10 * pubilcButtonExpansionPercentage -
                  60 * privateButtonExpansionPercentage,
              right: MediaQuery.of(context).size.width * .05 / 2,
              child: _buttonPublic(),
            ),
            FloatingAppbar(
              fontSize: 23,
              title: 'Sentiment Analyzer',
            )
          ],
        ),
      ),
    );
  }

  _buildInstructions(BuildContext context) {
    return Positioned(
      top: 60,
      left: 10,
      right: 10,
      bottom: MediaQuery.of(context).size.height * .075 + 100,
      child: AnimatedOpacity(
        opacity: 1 - pubilcButtonExpansionPercentage,
        duration: Duration(milliseconds: 200),
        child: Container(
          child: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 80,
                    width: 80,
                    // color: Colors.red,
                    child: FlareActor(
                      'assets/instagram.flr',
                      shouldClip: false,
                      snapToEnd: true,
                      sizeFromArtboard: true,
                      alignment: Alignment.center,
                      fit: BoxFit.contain,
                      animation: "Animations",
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Enter Instagram username for sentimental analysis of the user..',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: R.avenirFontFamily,
                        fontSize: 16,
                      ),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _buildEmojiContainer(EmojiIcon.emo_angry, Colors.black),
                  _buildEmojiContainer(EmojiIcon.emo_happy, Colors.lightGreen),
                  _buildEmojiContainer(EmojiIcon.emo_laugh, Colors.purple),
                  _buildEmojiContainer(EmojiIcon.emo_unhappy, Colors.red),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildEmojiContainer(
                      EmojiIcon.emo_wink2, Colors.yellowAccent),
                  _buildEmojiContainer(EmojiIcon.emo_grin, Colors.green),
                  _buildEmojiContainer(
                      EmojiIcon.emo_displeased, Colors.redAccent),
                ],
              ),
              Container(
                height: 150,
                width: 150,
                // color: Colors.red,
                child: FlareActor(
                  'assets/cloud.flr',
                  shouldClip: false,
                  snapToEnd: true,
                  sizeFromArtboard: true,
                  alignment: Alignment.center,
                  fit: BoxFit.contain,
                  animation: "Animations",
                ),
              ),
              Text(
                'Depending on the number of posts it may take a while to analyse your captions..',
                maxLines: 3,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: R.avenirFontFamily,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildBacgroundEmoji(BuildContext context) {
    return Positioned(
      right: -145 +
          (MediaQuery.of(context).size.width * 0.25) *
              pubilcButtonExpansionPercentage,
      bottom: -150 +
          (MediaQuery.of(context).size.height * 0.4) *
              pubilcButtonExpansionPercentage,
      child: Opacity(
        opacity: 0.2,
        child: Container(
          height: MediaQuery.of(context).size.width * 1.2,
          width: MediaQuery.of(context).size.width * 1.2,
          // color: Colors.red,
          child: FlareActor(
            'assets/emoji2_white_slow.flr',
            shouldClip: false,
            snapToEnd: true,
            sizeFromArtboard: true,
            alignment: Alignment.center,
            fit: BoxFit.contain,
            animation: "Animations",
          ),
        ),
      ),
    );
  }

  _buildEmojiContainer(IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Icon(icon),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(50),
        // border: Border.all(c)
      ),
    );
  }

  _buttonPrivate() {
    return GestureDetector(
      onTap: () {
        if (!isPrivateButtonExpanded)
          animatePrivateButton(!isPrivateButtonExpanded);
      },
      onPanDown: (_) => animationControllerPrivateButton?.stop(),
      onVerticalDragUpdate: onPrivateButtonVerticalDragUpdate,
      onVerticalDragEnd: (_) {
        _dispatchPrivateButtonOffset();
      },
      onVerticalDragCancel: () {
        _dispatchPrivateButtonOffset();
      },
      child: Container(
        width: MediaQuery.of(context).size.width * .45 +
            buttonExpandedWidth * privateButtonExpansionPercentage +
            buttonExpandedWidth * pubilcButtonExpansionPercentage,
        height: MediaQuery.of(context).size.height * .075 +
            buttonExpandedHeight * privateButtonExpansionPercentage -
            MediaQuery.of(context).size.height *
                .01 *
                pubilcButtonExpansionPercentage,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(0),
            ),
            border: Border.all(color: Colors.white, width: 1)),
        child: Center(
          child: Text(
            "Private",
            style: TextStyle(
              fontFamily: R.avenirFontFamily,
              fontWeight: FontWeight.w800,
              fontSize: 18,
              color: Colors.grey[900],
            ),
          ),
        ),
      ),
    );
  }

  _buttonPublic() {
    return GestureDetector(
      onTap: () {
        if (!isPublicButtonExpanded)
          animatePubilcButton(!isPublicButtonExpanded);
      },
      onPanDown: (_) => animationControllerPubilcButton?.stop(),
      onVerticalDragUpdate: onPubilcButtonVerticalDragUpdate,
      onVerticalDragEnd: (_) {
        _dispatchPublicButtonOffset();
      },
      onVerticalDragCancel: () {
        _dispatchPublicButtonOffset();
      },
      child: Container(
        width: MediaQuery.of(context).size.width * .45 +
            buttonExpandedWidth * pubilcButtonExpansionPercentage +
            buttonExpandedWidth * privateButtonExpansionPercentage,
        height: MediaQuery.of(context).size.height * .075 +
            buttonExpandedHeight * pubilcButtonExpansionPercentage -
            MediaQuery.of(context).size.height *
                .01 *
                privateButtonExpansionPercentage,
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(
              Radius.circular(0),
            ),
            border: Border.all(color: Colors.white, width: 1)),
        child: isPublicButtonExpanded
            ? Container(
                child: Stack(
                  children: <Widget>[
                    // Username input
                    Positioned(
                      top: 0,
                      right: 0,
                      left: 0,
                      child: Container(
                        // color: Colors.red,
                        padding: EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              // height: 50,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  "Public Account......",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontFamily: R.avenirFontFamily,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            TextField(
                              style: TextStyle(
                                fontSize: 22.0,
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                prefixIcon: Icon(
                                  IconData(0xe8e9, fontFamily: 'Feather'),
                                  color: Colors.white,
                                  size: 30,
                                ),
                                hintText: "Username",
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 32.0,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    15.0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white10,
                                    width: 32.0,
                                  ),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: MediaQuery.of(context).size.height * .055,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(0),
                                  ),
                                  border: Border.all(
                                      color: Colors.white, width: 1)),
                              child: Center(
                                child: Text(
                                  "Analyse",
                                  style: TextStyle(
                                    fontFamily: R.avenirFontFamily,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 18,
                                    color: Colors.grey[900],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Center(
                child: Text(
                  "Public",
                  style: TextStyle(
                    fontFamily: R.avenirFontFamily,
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  }

  void _dispatchPrivateButtonOffset() {
    if (!isPrivateButtonExpanded) {
      if (privateButtonExpansionPercentage < 0.3) {
        animatePrivateButton(false);
      } else {
        animatePrivateButton(true);
      }
    } else {
      if (privateButtonExpansionPercentage > 0.6) {
        animatePrivateButton(true);
      } else {
        animatePrivateButton(false);
      }
    }
  }

  void _dispatchPublicButtonOffset() {
    if (!isPublicButtonExpanded) {
      if (pubilcButtonExpansionPercentage < 0.3) {
        animatePubilcButton(false);
      } else {
        animatePubilcButton(true);
      }
    } else {
      if (pubilcButtonExpansionPercentage > 0.6) {
        animatePubilcButton(true);
      } else {
        animatePubilcButton(false);
      }
    }
  }
}
