import 'package:flutter/material.dart';
import 'package:instaknown/UI/Resources/Constants.dart' as R;

class UserCard extends StatelessWidget {
  const UserCard({
    Key key,
    this.url,
    this.username,
  }) : super(key: key);

  final String url;
  final String username;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.redAccent,
      elevation: 10,
      child: Container(
        padding: EdgeInsets.all(5),
        height: 120,
        // color: Colors.black,
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  // color: Colors.yellow,
                  image: DecorationImage(
                    image: NetworkImage(url)
                  ),
                  shape: BoxShape.circle),
            ),
            Expanded(
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      child: Text(
                        username ?? "User Name",
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: R.avenirFontFamily,
                          fontWeight: FontWeight.w800,
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}