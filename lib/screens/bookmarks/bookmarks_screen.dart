import 'package:flutter/material.dart';

class BookmarksScreen extends StatelessWidget {
  const BookmarksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookmark'),
      ),
      body: Center(
        child: Text(
          "Bookmarks",
          style: TextStyle(fontSize: 50),
        ),
      ),
    );
  }
}
