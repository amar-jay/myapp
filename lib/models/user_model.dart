class User {
  final String id;
  String name;
  final String email;
  bool isLoggedIn;

  User({required this.id, required this.name, required this.email, required this.isLoggedIn});

  // json to object
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      isLoggedIn: json['isLoggedIn'],
    );
  }

  // object to json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'isLoggedIn': isLoggedIn
    };
  }
}
