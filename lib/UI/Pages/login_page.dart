import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:instaknown/UI/Resources/painter.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _opacityAnimation;
  Animation<double> _loginIconOpacity;
  Animation<double> _passwordIconOpacity;
  Animation<double> _loginButtonOpacity;

  final _firstInputController = TextEditingController();
  final _secondInputController = TextEditingController();
  final firstInputNode = FocusNode();
  final secondInputNode = FocusNode();

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 3000),
    );
    super.initState();

    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        curve: Interval(0.0, 1 / 6, curve: Curves.easeOut),
        parent: _animationController,
      ),
    );
    _loginIconOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        curve: Interval(1.5 / 4, 2 / 4, curve: Curves.easeOut),
        parent: _animationController,
      ),
    );
    _passwordIconOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        curve: Interval(2.5 / 4, 3 / 4, curve: Curves.easeOut),
        parent: _animationController,
      ),
    );
    _loginButtonOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        curve: Interval(3.2 / 4, 1, curve: Curves.easeOut),
        parent: _animationController,
      ),
    );
  }

  void _animateToUsername() async {
    await _animationController.animateTo(1 / 4);
    await _animationController.animateTo(2 / 4);
    FocusScope.of(context).requestFocus(firstInputNode);
  }

  void _animateToPassword() async {
    FocusScope.of(context).requestFocus(secondInputNode);
    await _animationController.animateTo(3 / 4);
  }

  void _animateToButton() async {
    FocusScope.of(context).requestFocus(new FocusNode());
    await _animationController.animateTo(4 / 4);
  }

  @override
  Widget build(BuildContext context) {
    final dimensions = MediaQuery.of(context).size;
    final paddingWidth = dimensions.width / 30;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          Opacity(
            opacity: .3,
            child: Container(
              width: dimensions.width,
              height: dimensions.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      "https://images.unsplash.com/photo-1511912886973-f5f8b49fb08b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80"),
                  fit: BoxFit.fitHeight,
                  colorFilter: ColorFilter.mode(
                    Colors.white,
                    BlendMode.color,
                  ),
                ),
              ),
            ),
          ),
          BackdropFilter(
            child: Container(
              height: dimensions.height,
              width: dimensions.width,
              color: Colors.transparent,
            ),
            filter: ImageFilter.blur(
              sigmaX: .0,
              sigmaY: .0,
            ),
          ),
          CustomPaint(
            painter: MyCustomPainter(_animationController, dimensions),
            size: Size(dimensions.width, dimensions.height),
          ),
          // Username input
          Container(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: (dimensions.height * 0.925 - 100) -
                      dimensions.height / 2 -
                      35,
                ),
                TextField(
                  onSubmitted: (_) => _animateToPassword(),
                  controller: _firstInputController,
                  focusNode: firstInputNode,
                  autocorrect: Platform.isIOS ? false : true,
                  enabled: false,
                  style: TextStyle(
                    fontSize: 22,
                    fontFamily: "Avenir",
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.none,
                  ),
                  cursorColor: Colors.white,
                  cursorWidth: 0.5,
                  strutStyle: StrutStyle.disabled,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: dimensions.width / 30 + 50),
                  ),
                ),
              ],
            ),
          ),
          // Password input
          Container(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height:
                      (dimensions.height * 0.925) - dimensions.height / 2 - 35,
                ),
                TextField(
                  onSubmitted: (_) => _animateToButton(),
                  controller: _secondInputController,
                  focusNode: secondInputNode,
                  autocorrect: Platform.isIOS ? false : true,
                  enabled: false,
                  obscureText: true,
                  style: TextStyle(
                    fontSize: 22,
                    fontFamily: "Avenir",
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.none,
                  ),
                  cursorColor: Colors.white,
                  cursorWidth: 0.5,
                  strutStyle: StrutStyle.disabled,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: dimensions.width / 30 + 50,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Username Icon
          AnimatedBuilder(
            animation: _loginIconOpacity,
            builder: (context, _) {
              return Positioned(
                top: (dimensions.height * 0.925 - 100) -
                    dimensions.height / 2 -
                    40,
                left: dimensions.width / 30 + 10,
                child: Opacity(
                  opacity: _loginIconOpacity.value,
                  child: Icon(
                    IconData(0xe8e9, fontFamily: 'Feather'),
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              );
            },
          ),
          // Password Icon
          AnimatedBuilder(
            animation: _passwordIconOpacity,
            builder: (context, _) {
              return Positioned(
                top: (dimensions.height * 0.925) - dimensions.height / 2 - 40,
                left: dimensions.width / 30 + 10,
                child: Opacity(
                  opacity: _passwordIconOpacity.value,
                  child: Icon(
                    IconData(0xe887, fontFamily: 'Feather'),
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              );
            },
          ),
          // Button
          AnimatedBuilder(
            animation: _loginButtonOpacity,
            builder: (context, _) {
              final size = MediaQuery.of(context).size;
              return Positioned(
                top: (size.height * 0.925 - 100) - size.height / 6 - 60,
                left: dimensions.width / 30,
                child: Opacity(
                  opacity: _loginButtonOpacity.value,
                  child: _button2(context),
                ),
              );
            },
          ),
          // Login/Sign up buttons
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, snapshot) {
              return Positioned(
                bottom: 100 * (1 - _animationController.value / 2),
                child: Opacity(
                  opacity: _opacityAnimation.value,
                  child: Row(
                    children: <Widget>[
                      SizedBox(width: paddingWidth),
                      _button('Login', context),
                      SizedBox(width: paddingWidth),
                      _button('Sign up', context),
                      SizedBox(width: paddingWidth),
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  _button2(BuildContext ctx) {
    return Container(
      width: MediaQuery.of(ctx).size.width * 28 / 30,
      child: FlatButton(
        onPressed: () => null,
        color: Colors.white,
        child: Container(
          width: MediaQuery.of(ctx).size.width * 28 / 30,
          height: 60,
          color: Colors.transparent,
          child: Center(
            child: Text(
              'Login',
              style: TextStyle(
                fontFamily: 'Avenir',
                fontWeight: FontWeight.w800,
                fontSize: 18,
                color: Colors.grey[900],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _button(String s, BuildContext ctx) {
    return GestureDetector(
      onTap: s == 'Login' ? () => _animateToUsername() : null,
      child: Container(
        width: MediaQuery.of(ctx).size.width * .45,
        height: MediaQuery.of(ctx).size.height * .075,
        color: s == 'Login' ? Colors.transparent : Colors.white,
        child: Center(
          child: Text(
            s,
            style: TextStyle(
              fontFamily: 'Avenir',
              fontWeight: FontWeight.w800,
              fontSize: 18,
              color: s == 'Login' ? Colors.white : Colors.grey[900],
            ),
          ),
        ),
      ),
    );
  }
}
