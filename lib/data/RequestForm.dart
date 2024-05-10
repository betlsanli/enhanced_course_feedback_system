class RequestForm {
  final String code;
  final String name;
  final String topic;
  final String date;

  RequestForm({
    required this.code,
    required this.name,
    required this.topic,
    required this.date,
  });

  factory RequestForm.fromMap(Map<String, dynamic> map) {
    return RequestForm(
      code: map['course_code'],
      name: map['name'],
      topic: map['topic'],
      date: map['date'],
    );
  }
}
