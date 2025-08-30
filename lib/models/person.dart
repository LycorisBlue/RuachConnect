class Person {
  final String id;
  final String firstName;
  final String lastName;
  final String gender;
  final DateTime? birthDate;
  final String phone;
  final String commune;
  final String quartier;
  final String profession;
  final String maritalStatus;
  final bool isFirstVisit;
  final String howKnownChurch;
  final String prayerRequest;
  final String status;
  final String? assignedMentorId;
  final DateTime createdAt;

  Person({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.gender,
    this.birthDate,
    required this.phone,
    required this.commune,
    required this.quartier,
    required this.profession,
    required this.maritalStatus,
    required this.isFirstVisit,
    required this.howKnownChurch,
    required this.prayerRequest,
    required this.status,
    this.assignedMentorId,
    required this.createdAt,
  });

  String get fullName => '$firstName $lastName';

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      gender: json['gender'],
      birthDate: json['birthDate'] != null ? DateTime.parse(json['birthDate']) : null,
      phone: json['phone'],
      commune: json['commune'],
      quartier: json['quartier'],
      profession: json['profession'],
      maritalStatus: json['maritalStatus'],
      isFirstVisit: json['isFirstVisit'],
      howKnownChurch: json['howKnownChurch'],
      prayerRequest: json['prayerRequest'],
      status: json['status'],
      assignedMentorId: json['assignedMentorId'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'gender': gender,
      'birthDate': birthDate?.toIso8601String(),
      'phone': phone,
      'commune': commune,
      'quartier': quartier,
      'profession': profession,
      'maritalStatus': maritalStatus,
      'isFirstVisit': isFirstVisit,
      'howKnownChurch': howKnownChurch,
      'prayerRequest': prayerRequest,
      'status': status,
      'assignedMentorId': assignedMentorId,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}