import 'package:flutter/material.dart';
import 'package:hadithpro/widgets/hadithtext.dart';

import '../../models/hadith.dart';
import '../../widgets/roundedItem.dart';
import 'books.dart';

class Hadiths extends StatefulWidget {
  final int bookname;
  final int chapternumber;

  @override
  State<Hadiths> createState() => _HadithsState();

  Hadiths({Key? key, required this.bookname, required this.chapternumber})
      : super(key: key);
}

class _HadithsState extends State<Hadiths> {
  late Future<HadithsList> _hadithsList;
  late Future<HadithsList> _hadithsListArabic;

  @override
  void initState() {
    super.initState();
    _hadithsListArabic = loadJson('assets/json/' "ara-" +
        Home().fileNamesList[widget.bookname] +
        ".min.json");
    _hadithsList = loadJson('assets/json/' "eng-" +
        Home().fileNamesList[widget.bookname] +
        ".min.json");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        appBar: AppBar(
          elevation: 0,
          title: Text(Home().longNamesList[widget.bookname]),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        body: FutureBuilder<List<HadithsList>>(
            future: Future.wait([_hadithsList, _hadithsListArabic]),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final hadithsOfSection =
                    snapshot.data![0].hadiths.where((hadith) {
                  return hadith.reference.book == widget.chapternumber;
                }).toList();
                final hadithsOfSectionArabic = snapshot.data![1].hadiths
                    .where((hadith) =>
                        hadith.reference.book == widget.chapternumber)
                    .toList();
                return Container(
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
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        child: ListTile(
                          leading: RoundedItem(
                            shortName: "${widget.chapternumber}/1",
                            textColor: Theme.of(context).colorScheme.onPrimary,
                            itemColor: Theme.of(context).colorScheme.primary,
                          ),
                          title: Text("Chapter ${widget.chapternumber}"),
                          subtitle: const Text("by Unknown"),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: hadithsOfSection.length,
                          itemBuilder: (BuildContext context, int index) {
                            return _buildHadithCard(
                                hadithsOfSectionArabic[index],
                                hadithsOfSection[index]);
                          },
                        ),
                      ),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              } else {
                return Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                    child: const ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                        ),
                        child: Center(
                          child: CircularProgressIndicator(),
                        )));
              }
            }));
  }

  Widget _buildHadithCard(Hadith hadithArabic, Hadith hadith) {
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
              shortName: hadith.reference.hadith.toString(),
              textColor: Theme.of(context).colorScheme.onSurfaceVariant,
              itemColor: Theme.of(context).colorScheme.surfaceVariant,
            ),
            const SizedBox(
              height: 8,
            ),
            HadithText(
              hadithText: hadithArabic,
              TextDirection: TextDirection.rtl,
              fontFamily: 'Uthman',
              FontWeight: FontWeight.normal,
            ),
            const SizedBox(height: 8),
            HadithText(
              hadithText: hadith,
              TextDirection: TextDirection.ltr,
              fontFamily: 'Uthman',
              FontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 4),
            Divider(
              color: Colors.black,
              height: 0,
            ),
            _buildExpandable(context, hadith),
            Divider(
              color: Colors.black,
              height: 0,
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Expanded(
                  child: Text("Reference"),
                ),
                const VerticalDivider(width: 1.0),
                Expanded(
                  child: Text(
                      "${Home().longNamesList[widget.bookname]} ${hadith.arabicNumber}"),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Expanded(
                  child: Text("In-book reference"),
                ),
                const VerticalDivider(width: 1.0),
                Expanded(
                  child: Text(
                      "Book ${hadith.reference.book}, Hadith ${hadith.reference.hadith}"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpandable(BuildContext context, Hadith hadith) {
    return Container(
      child: ExpansionTile(
          title: Text("Grades"),
          tilePadding: EdgeInsets.zero,
          children: List.generate(hadith.grades.length, (index) {
            return Card(
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                trailing: Text(hadith.grades[index].grade),
                tileColor: hadith.grades[index].grade.contains("Sahih") ||
                        hadith.grades[index].grade.contains("Hassan")
                    ? Colors.green
                    : Colors.red,
                visualDensity: VisualDensity(vertical: -4),
                title: Text(hadith.grades[index].name),
              ),
            );
          })),
    );
  }
}
