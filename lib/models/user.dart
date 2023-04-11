class User {

  int? id;
  final String name;
  final String email;
  String? password;
  final int role_id;
  String? status;
  String? photo;

  User({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.role_id,
    this.status,
    this.photo
  });

  factory User.fromObject(Map json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      role_id: json['role_id'],
      status: json['status'],
      photo: json['photo']
    );
  }
}