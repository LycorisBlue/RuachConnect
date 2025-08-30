class FollowUp {
  final String id;
  final String personId;
  final String mentorId;
  final String mentorName;
  final String type;
  final String notes;
  final DateTime date;

  FollowUp({
    required this.id,
    required this.personId,
    required this.mentorId,
    required this.mentorName,
    required this.type,
    required this.notes,
    required this.date,
  });

  factory FollowUp.fromJson(Map<String, dynamic> json) {
    return FollowUp(
      id: json['id'],
      personId: json['personId'],
      mentorId: json['mentorId'],
      mentorName: json['mentorName'],
      type: json['type'],
      notes: json['notes'],
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'personId': personId,
      'mentorId': mentorId,
      'mentorName': mentorName,
      'type': type,
      'notes': notes,
      'date': date.toIso8601String(),
    };
  }
}

class FollowUpType {
  static const String visite = 'VISITE';
  static const String appel = 'APPEL';
  static const String priere = 'PRIERE';

  static List<String> get all => [visite, appel, priere];

  static String getLabel(String type) {
    switch (type) {
      case visite:
        return 'Visite';
      case appel:
        return 'Appel';
      case priere:
        return 'Prière';
      default:
        return type;
    }
  }
}