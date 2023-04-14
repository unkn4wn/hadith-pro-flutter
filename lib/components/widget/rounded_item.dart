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
    return SizedBox(
      height: size,
      width: size,
      child: Card(
        color: itemColor,
        elevation: 2,
        child: Center(
          child: Text(
            shortName,
            style: const TextStyle(
              fontSize: 22,
            ),
          ),
        ),
      ),
    );
  }
}
