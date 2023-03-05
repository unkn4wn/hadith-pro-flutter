import 'package:flutter/material.dart';

class RoundedItem extends StatelessWidget {
  final Color textColor;
  final Color itemColor;
  final String shortName;
  const RoundedItem(
      {Key? key,
      required this.textColor,
      required this.itemColor,
      required this.shortName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: itemColor),
      height: 50,
      width: 50,
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
