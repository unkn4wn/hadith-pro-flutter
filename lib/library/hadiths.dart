import 'package:flutter/material.dart';

class Hadiths extends StatelessWidget {
  final int? booknumber;
  final int? chapternumber;

  const Hadiths(
      {Key? key, required this.booknumber, required this.chapternumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chapter " + chapternumber.toString()),
      ),
    );
  }
}
