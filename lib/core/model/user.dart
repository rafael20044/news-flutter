class User {
  String id;
  String name;
  String name2;
  String lastName;
  String lastName2;
  String email;
  String password;
  String country;

  User({
    this.id = '',
    required this.name,
    this.name2 = '',
    required this.lastName,
    this.lastName2 = '',
    required this.email,
    required this.password,
    required this.country,
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
      'country': country,
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
      country: json['country'],
    );
  }
}
