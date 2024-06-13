class User {
  final String id;
  final String name;
  final String email;

  User({required this.id, required this.name, required this.email});

  // json to object
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }

  // object to json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }
}
