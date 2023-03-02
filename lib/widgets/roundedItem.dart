import 'package:flutter/material.dart';

class RoundedItem extends StatelessWidget {
  final color;
  final String shortName;
  const RoundedItem({Key? key, this.color, required this.shortName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
          height: 50,
          width: 50,
          color: color,
          child: Center(
            child: Text(
              shortName,
              style: TextStyle(fontSize: 22, color: Colors.white),
            ),
          )),
    );
  }
}
