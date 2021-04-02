import 'package:intl/intl.dart';

class Note {
  int? id, date;
  String? content, title;

  setDate() {
    DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyyMMdd');
    final String formatted = formatter.format(now);
    date = int.parse(formatted);
  }

  Note();

  Note.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    date = map['date'];
    title = map['title'];
    content = map['content'];
  }

  toMap() {
    return <String, dynamic>{
      'id': id,
      'date': date,
      'title': title,
      'content': content,
    };
  }
}
