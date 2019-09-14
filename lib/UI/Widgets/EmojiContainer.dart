import 'package:flutter/material.dart';

class EmojiContainer extends StatelessWidget {
  EmojiContainer({
    this.icon,
    this.color,
  });
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
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
}
