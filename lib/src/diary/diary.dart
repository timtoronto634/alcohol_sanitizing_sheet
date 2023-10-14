class Diary {
  final int? id;
  final String content;
  final DateTime date;

  Diary({this.id, required this.content, required this.date});

  // Convert a Diary object into a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'date': date.toIso8601String(),
    };
  }

  // Create a Diary object from a map
  static Diary fromMap(Map<String, dynamic> map) {
    return Diary(
      id: map['id'],
      content: map['content'],
      date: DateTime.parse(map['date']),
    );
  }
}
