import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:instaknown/Core/ViewModel/BaseModel.dart';
import 'package:instaknown/Core/ViewModel/HomePageViewModel.dart';
import 'package:instaknown/Core/models/Result.dart';
import 'package:instaknown/UI/Pages/BaseView.dart';
import 'package:instaknown/UI/Pages/PieChartPage.dart';
import 'package:instaknown/UI/Resources/my_flutter_app_icons.dart';
import 'package:instaknown/UI/Widgets/EmojiContainer.dart';
import 'package:instaknown/UI/Resources/Constants.dart' as R;
import 'package:instaknown/UI/Widgets/UserCard.dart';

class PrivateAccount extends StatefulWidget {
  PrivateAccount({
    Key key,
  }) : super(key: key);

  @override
  _PrivateAccountState createState() => _PrivateAccountState();
}

class _PrivateAccountState extends State<PrivateAccount> {
  final GlobalKey stickyKeyUsenameContainer = GlobalKey();
  final GlobalKey stickyKeyChartContainer = GlobalKey();

  _findHeight(GlobalKey<State<StatefulWidget>> stickyKey) {
    final keyContext = stickyKey.currentContext;
    if (keyContext != null) {
      // widget is visible
      final box = keyContext.findRenderObject() as RenderBox;
      return box.size.height;
    }
  }

  bool isUserFound = true;

  TextEditingController username;
  TextEditingController password;
  TextEditingController user;

  Result result;

  @override
  void initState() {
    super.initState();
    username = TextEditingController();
    user = TextEditingController();
    password = TextEditingController();
  }

  onAnlaysePressed(HomePageViewModel model) async {
    if (username.text.trim().length > 0 &&
        password.text.trim().length > 0 &&
        user.text.trim().length > 0) {
      Result result = await model.getSentimentsPrivate(
        username: username.text,
        password: password.text,
        user: user.text,
      );
      if (result.type == 'Success') {
        isUserFound = true;
        this.result = result;
      } else {
        isUserFound = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<HomePageViewModel>(
        onModelReady: (model) => model,
        builder: (context, model, snapshot) {
          return Container(
            color: Colors.white10,
            child: model.state == ViewState.Busy
                ? Center(
                    child: Container(
                      height: MediaQuery.of(context).size.width * 0.7,
                      width: MediaQuery.of(context).size.width * 0.7,
                      // color: Colors.red,
                      child: FlareActor(
                        'assets/loadingCloud.flr',
                        shouldClip: false,
                        snapToEnd: true,
                        sizeFromArtboard: true,
                        alignment: Alignment.center,
                        fit: BoxFit.contain,
                        animation: "Animations",
                      ),
                    ),
                  )
                : Stack(
                    children: <Widget>[
                      // Username input
                      Positioned(
                        top: 0,
                        right: 0,
                        left: 0,
                        child: Container(
                          key: stickyKeyUsenameContainer,
                          color: Colors.redAccent,
                          padding: EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                // height: 50,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        "Private Account......",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontFamily: R.avenirFontFamily,
                                          fontWeight: FontWeight.w800,
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            result = null;
                                          });
                                        },
                                        child: Container(
                                          height: 25,
                                          width: 50,
                                          child: Icon(Icons.restore),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              result != null
                                  ? UserCard(
                                      url: result.picture,
                                      username: result.name,
                                    )
                                  : Container(),
                              result != null
                                  ? Container()
                                  : TextField(
                                      controller: username,
                                      style: TextStyle(
                                        fontSize: 22.0,
                                        color: Colors.white,
                                        fontFamily: R.avenirFontFamily,
                                      ),
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(
                                            20.0, 15.0, 20.0, 15.0),
                                        prefixIcon: Icon(
                                          IconData(0xe8e9,
                                              fontFamily: 'Feather'),
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                        hintText: "Your Username",
                                        hintStyle: TextStyle(
                                          fontSize: 18,
                                          fontFamily: R.avenirFontFamily,
                                        ),
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
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                      ),
                                    ),
                              result != null
                                  ? Container()
                                  : SizedBox(
                                      height: 10,
                                    ),
                              result != null
                                  ? Container()
                                  : TextField(
                                      controller: password,
                                      style: TextStyle(
                                        fontSize: 22.0,
                                        color: Colors.white,
                                      ),
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(
                                            20.0, 15.0, 20.0, 15.0),
                                        prefixIcon: Icon(
                                          IconData(0xe887,
                                              fontFamily: 'Feather'),
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                        hintText: "Your Password",
                                        hintStyle: TextStyle(
                                          fontSize: 18,
                                          fontFamily: R.avenirFontFamily,
                                        ),
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
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                      ),
                                    ),
                              result != null
                                  ? Container()
                                  : SizedBox(
                                      height: 10,
                                    ),
                              isUserFound
                                  ? Container()
                                  : Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8, right: 8, bottom: 8),
                                      child: Text(
                                        "Username doesn't exists or this user is Private...",
                                        textAlign: TextAlign.start,
                                        maxLines: 3,
                                        style: TextStyle(
                                          fontFamily: R.avenirFontFamily,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                              result != null
                                  ? Container()
                                  : TextField(
                                      controller: user,
                                      style: TextStyle(
                                        fontSize: 22.0,
                                        color: Colors.white,
                                        fontFamily: R.avenirFontFamily,
                                      ),
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(
                                            20.0, 15.0, 20.0, 15.0),
                                        prefixIcon: Icon(
                                          IconData(0xe8e9,
                                              fontFamily: 'Feather'),
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                        hintText: "User to analyse sentiments",
                                        hintStyle: TextStyle(
                                          fontSize: 18,
                                          fontFamily: R.avenirFontFamily,
                                        ),
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
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                      ),
                                    ),
                              result != null
                                  ? Container()
                                  : SizedBox(
                                      height: 10,
                                    ),
                              result != null
                                  ? Container()
                                  : InkWell(
                                      onTap: () async {
                                        await onAnlaysePressed(model);
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .055,
                                        decoration: BoxDecoration(
                                            color: Colors.transparent,
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
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ),
                      result == null
                          ? Container()
                          : Positioned(
                              left: 0,
                              right: 0,
                              key: stickyKeyChartContainer,
                              top:
                                  _findHeight(stickyKeyUsenameContainer) ?? 180,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Expanded(
                                          child: Column(
                                            children: <Widget>[
                                              GaugeChart(
                                                animate: false,
                                                isPrivate: true,
                                                color: Colors.black,
                                                percentage:
                                                    result.value.negative,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  EmojiContainer(
                                                      icon: EmojiIcon.emo_angry,
                                                      color: Colors.black),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    'Negative',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily:
                                                          R.avenirFontFamily,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: <Widget>[
                                              GaugeChart(
                                                animate: false,
                                                color: Colors.purple,
                                                isPrivate: true,
                                                percentage:
                                                    result.value.positive,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  EmojiContainer(
                                                      icon: EmojiIcon.emo_laugh,
                                                      color: Colors.purple),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    'Positive',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily:
                                                          R.avenirFontFamily,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        GaugeChart(
                                          animate: false,
                                          color: Colors.lightGreen,
                                          percentage: result.value.neutral,
                                          isPrivate: true,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            EmojiContainer(
                                                icon: EmojiIcon.emo_happy,
                                                color: Colors.lightGreen),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              'Neutral',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: R.avenirFontFamily,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w900,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    ],
                  ),
          );
        });
  }
}
