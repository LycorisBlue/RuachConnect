class User {
  final String id;
  final String name;
  final String email;
  final String type;
  final bool isActive;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.type,
    this.isActive = true,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      type: json['type'],
      isActive: json['isActive'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'type': type,
      'isActive': isActive,
    };
  }
}