import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../database/hadith_database.dart';
import '../../models/hadith.dart';
import '../../widgets/roundedItem.dart';

class Hadiths extends StatefulWidget {
  final int? booknumber;
  final int? chapternumber;

  @override
  State<Hadiths> createState() => _HadithsState();

  const Hadiths(
      {Key? key, required this.booknumber, required this.chapternumber})
      : super(key: key);
}

class _HadithsState extends State<Hadiths> {
  List<Hadith> _hadithList = [];

  @override
  void initState() {
    super.initState();
    _initHadithList();
  }

  Future<void> _initHadithList() async {
    final hadithList = await HadithDatabase.instance
        .getHadithList(widget.booknumber, widget.chapternumber);

    setState(() {
      _hadithList = hadithList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        elevation: 0,
        title: Text("Chapter ${widget.chapternumber}"),
      ),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 0,
              color: Theme.of(context).colorScheme.secondary,
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              child: ListTile(
                leading: RoundedItem(
                  shortName: "${widget.chapternumber}/1",
                  textColor: Theme.of(context).colorScheme.onPrimary,
                  itemColor: Theme.of(context).colorScheme.primary,
                ),
                title: const Text("CHAPTER 1: Revelation"),
                subtitle: const Text("by Unknown"),
              ),
            ),
            Expanded(
              child: ListView.builder(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemCount: _hadithList.length,
                itemBuilder: (BuildContext context, int index) {
                  return _buildHadithCard(_hadithList[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHadithCard(Hadith hadith) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surface,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RoundedItem(
              shortName: hadith.reference_hadith.toString(),
              textColor: Theme.of(context).colorScheme.onSurfaceVariant,
              itemColor: Theme.of(context).colorScheme.surfaceVariant,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              hadith.text_ara.toString(),
              softWrap: true,
              maxLines: null,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 17,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              hadith.text_eng.toString(),
              softWrap: true,
              maxLines: null,
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.start,
              style: GoogleFonts.notoKufiArabic(
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  height: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Divider(
              color: Colors.black,
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
