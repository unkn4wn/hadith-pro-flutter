import 'package:flutter/material.dart';

class RoundedItem extends StatelessWidget {
  final Color textColor;
  final Color itemColor;
  final String shortName;
  final double size;
  const RoundedItem(
      {Key? key,
      required this.textColor,
      required this.itemColor,
      required this.shortName,
      required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: itemColor),
      height: size,
      width: size,
      child: Center(
        child: Text(
          shortName,
          style: TextStyle(
            fontSize: 22,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
