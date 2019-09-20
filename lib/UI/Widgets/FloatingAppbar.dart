import 'package:flutter/material.dart';
import 'package:instaknown/UI/Pages/AboutPage.dart';
import 'package:instaknown/UI/Resources/Constants.dart' as R;

class FloatingAppbar extends StatelessWidget {
  FloatingAppbar({
    this.title,
    this.fontSize = 16,
    this.backButton = false,
  });

  final String title;
  final double fontSize;
  final bool backButton;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 5,
      right: 5,
      child: SafeArea(
        child: Row(
          children: <Widget>[
            backButton
                ? Hero(
                    tag: 'backkk',
                    child: Card(
                      child: Container(
                        height: 50,
                        width: 50,
                        child: RawMaterialButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(),
            Expanded(
              child: Card(
                child: Container(
                  height: 50,
                  child: Center(
                    child: Text(
                      title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: TextStyle(
                        fontFamily: R.amaranthFontFamily,
                        fontWeight: FontWeight.w600,
                        fontSize: fontSize,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            backButton
                ? Container()
                : Hero(
                    tag: 'backkk',
                    child: Card(
                      child: Container(
                        height: 50,
                        width: 50,
                        child: RawMaterialButton(
                          onPressed: () {
                            Navigator.pushNamed(context, AboutPage.id,
                                arguments: (r) => false);
                          },
                          child: Icon(
                            Icons.info,
                          ),
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
