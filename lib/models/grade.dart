class Grade {
  final String name;
  final String grade;

  Grade({required this.name, required this.grade});

  factory Grade.fromJson(Map<String, dynamic> json) {
    return Grade(
      name: json['name'],
      grade: json['grade'],
    );
  }
}
