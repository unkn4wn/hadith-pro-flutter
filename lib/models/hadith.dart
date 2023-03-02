class Hadith {
  final int? id;
  final int? booknumber;
  final double? hadithnumber;
  final double? arabicnumber;
  final String? text_ara;
  final String? text_ben;
  final String? text_eng;
  final String? text_ind;
  final String? text_tur;
  final String? text_urd;
  final int? reference_book;
  final int? reference_hadith;

  Hadith({
    required this.id,
    required this.booknumber,
    required this.hadithnumber,
    required this.arabicnumber,
    required this.text_ara,
    required this.text_ben,
    required this.text_eng,
    required this.text_ind,
    required this.text_tur,
    required this.text_urd,
    required this.reference_book,
    required this.reference_hadith,
  });

  factory Hadith.fromMap(Map<String, dynamic> map) {
    return Hadith(
      id: map['_id'],
      booknumber: map['booknumber'],
      hadithnumber: map['hadithnumber'],
      arabicnumber: map['arabicnumber'],
      text_ara: map['text_ara'],
      text_ben: map['text_ben'],
      text_eng: map['text_eng'],
      text_ind: map['text_ind'],
      text_tur: map['text_tur'],
      text_urd: map['text_urd'],
      reference_book: map['reference_book'],
      reference_hadith: map['reference_hadith'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'booknumber': booknumber,
      'hadithnumber': hadithnumber,
      'arabicnumber': arabicnumber,
      'text_ara': text_ara,
      'text_ben': text_ben,
      'text_eng': text_eng,
      'text_ind': text_ind,
      'text_tur': text_tur,
      'text_urd': text_urd,
      'reference_book': reference_book,
      'reference_hadith': reference_hadith,
    };
  }
}
