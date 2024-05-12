import 'package:intl/intl.dart';

class RequestForm {
  final String code;
  final String name;
  final String topic;
  final String date;
  final String? summary;

  RequestForm({
    required this.code,
    required this.name,
    required this.topic,
    required this.date,
    required this.summary,
  });

  factory RequestForm.fromMap(Map<String, dynamic> map, String courseName) {
    final dateFormat = DateFormat('yyyy-MM-dd'); // Original format of the date string
    final parsedDate = dateFormat.parse(map['date']); // Parse the date string
    final formattedDate = DateFormat('dd/MM/yyyy').format(parsedDate); // Format the parsed date as dd/MM/yyyy
    return RequestForm(
      code: map['course_code'],
      name: courseName,
      topic: map['topic'],
      date: formattedDate,
      summary : map['feedback_summary'],
    );
  }
}


//IDK IF NECESSARY
//CHECK HERE!!
  factory RequestForm.fromJson(Map<String, dynamic> json) {
    return RequestForm(
      code: json['code'],
      name: json['name'],
      topic: json['topic'],
      date: json['date'],
      summary: json['summary'],
    );
  }
}
