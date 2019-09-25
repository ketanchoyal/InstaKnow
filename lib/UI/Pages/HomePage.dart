import 'dart:math';
import 'package:after_layout/after_layout.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:instaknown/UI/Pages/PrivateAccount.dart';
import 'package:instaknown/UI/Pages/PublicAccount.dart';
import 'package:instaknown/UI/Resources/Constants.dart' as R;
import 'package:instaknown/UI/Resources/my_flutter_app_icons.dart';
import 'package:instaknown/UI/Widgets/EmojiContainer.dart';
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
        MediaQuery.of(context).size.height * .075 -
        130;

    buttonExpandedWidth = MediaQuery.of(context).size.width * 0.9 -
        MediaQuery.of(context).size.width * 0.40;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: <Widget>[
            _buildBacgroundEmoji(context),
            _buildInstructions(context),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.105 +
                  5 * privateButtonExpansionPercentage -
                  60 * pubilcButtonExpansionPercentage,
              left: MediaQuery.of(context).size.width * .05 / 2,
              child: _buttonPrivate(),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.105 +
                  5 * pubilcButtonExpansionPercentage -
                  60 * privateButtonExpansionPercentage,
              right: MediaQuery.of(context).size.width * .05 / 2,
              child: _buttonPublic(),
            ),
            FloatingAppbar(
              fontSize: 23,
              title: 'Insta Know',
            )
          ],
        ),
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
        child: privateButtonExpansionPercentage == 1
            ? PrivateAccount()
            : Center(
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
        child: pubilcButtonExpansionPercentage == 1
            ? new PublicAccount()
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
                  EmojiContainer(
                      icon: EmojiIcon.emo_angry, color: Colors.black),
                  EmojiContainer(
                      icon: EmojiIcon.emo_happy, color: Colors.lightGreen),
                  EmojiContainer(
                      icon: EmojiIcon.emo_laugh, color: Colors.purple),
                  EmojiContainer(
                      icon: EmojiIcon.emo_unhappy, color: Colors.red),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  EmojiContainer(
                      icon: EmojiIcon.emo_wink2, color: Colors.amberAccent),
                  EmojiContainer(icon: EmojiIcon.emo_grin, color: Colors.green),
                  EmojiContainer(
                      icon: EmojiIcon.emo_displeased, color: Colors.redAccent),
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
      right: -MediaQuery.of(context).size.width * 0.35 +
          (MediaQuery.of(context).size.width * 0.25) *
              pubilcButtonExpansionPercentage,
      bottom: -MediaQuery.of(context).size.height * 0.16 +
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
