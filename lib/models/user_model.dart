class User {
  final String firstName;
  final String lastName;
  final String email;
  final String avatar;

  User({required this.firstName, required this.lastName, required this.email, required this.avatar});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      avatar: json['avatar'],
    );
  }
}