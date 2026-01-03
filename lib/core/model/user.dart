class User {
  final String id;
  final String name;
  final String name2;
  final String lastName;
  final String lastName2;
  final String email;
  final String password;

  User({
    required this.id,
    required this.name,
    this.name2 = '',
    required this.lastName,
    this.lastName2 = '',
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'name2': name2,
      'lastName': lastName,
      'lastName2': lastName2,
      'email': email,
      'password': password,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      name2: json['name2'] ?? '',
      lastName: json['lastName'],
      lastName2: json['lastName2'] ?? '',
      email: json['email'],
      password: json['password'],
    );
  }
}
