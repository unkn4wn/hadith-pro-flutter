class Reference {
  final int book;
  final int hadith;

  Reference({required this.book, required this.hadith});

  factory Reference.fromJson(Map<String, dynamic> json) {
    return Reference(
      book: json['book'],
      hadith: json['hadith'],
    );
  }
}
