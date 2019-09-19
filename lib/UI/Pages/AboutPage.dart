import 'package:flutter/material.dart';
import 'package:instaknown/Core/Services/UrlHelper.dart';
import 'package:instaknown/UI/Widgets/FloatingAppbar.dart';
import 'package:instaknown/UI/Resources/Constants.dart' as R;
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  static const id = 'About Us';
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  bool editUrl = false;
  TextEditingController url;

  UrlHelper _urlHelper = UrlHelper();

  saveButtonPressed() async {
    if (url.text.length > 0) {
      await _urlHelper.setNewUrl(url.text);
      setState(() {
        editUrl = !editUrl;
      });
    }
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
    url = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          editUrl = !editUrl;
          setState(() {});
        },
        child: Icon(Icons.edit),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 60,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    editUrl
                        ? Column(
                            children: <Widget>[
                              TextField(
                                controller: url,
                                style: TextStyle(
                                  fontSize: 22.0,
                                  color: Colors.white,
                                ),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.fromLTRB(
                                      20.0, 15.0, 20.0, 15.0),
                                  prefixIcon: Icon(
                                    Icons.link,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  hintText: "New Url  http://....",
                                  hintStyle: TextStyle(
                                    fontSize: 18,
                                    fontFamily: R.avenirFontFamily,
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                        width: 32.0,
                                      ),
                                      borderRadius: BorderRadius.zero),
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
                              InkWell(
                                onTap: () async {
                                  await saveButtonPressed();
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.height,
                                  height:
                                      MediaQuery.of(context).size.height * .050,
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(0),
                                      ),
                                      border: Border.all(
                                          color: Colors.white, width: 1)),
                                  child: Center(
                                    child: Text(
                                      "Save",
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
                          )
                        : Container(),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                      child: Text(
                        "App Developed By:",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: R.avenirFontFamily,
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        _launchURL('https://github.com/ketanchoyal');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Icon(
                              LineIcons.github_square,
                              size: 50,
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Text(
                              "@ketanchoyal (Ketan Choyal)",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontFamily: R.avenirFontFamily,
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _launchURL('https://github.com/namas191297');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Icon(
                              LineIcons.github_square,
                              size: 50,
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Text(
                              "@namas191297 (Namas Bhandari)",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontFamily: R.avenirFontFamily,
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            FloatingAppbar(
              title: 'About Us',
              backButton: true,
              fontSize: 20,
            )
          ],
        ),
      ),
    );
  }
}
