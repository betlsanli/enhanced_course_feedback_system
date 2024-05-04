class Profile{
  Profile({
    required this.user_id,
    required this.name,
    required this.role,
  });

  final String user_id;
  final String name;
  final String role;

  Profile.fromMap(Map<String, dynamic> map)
        : user_id = map['user_id'],
        name = map['name'],
        role = map['role'];
}