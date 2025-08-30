class Mentor {
  final String id;
  final String name;
  final String type;
  final String phone;
  final bool isActive;

  Mentor({
    required this.id,
    required this.name,
    required this.type,
    required this.phone,
    this.isActive = true,
  });

  factory Mentor.fromJson(Map<String, dynamic> json) {
    return Mentor(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      phone: json['phone'],
      isActive: json['isActive'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'phone': phone,
      'isActive': isActive,
    };
  }
}