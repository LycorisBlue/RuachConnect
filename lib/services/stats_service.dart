import '../models/person.dart';
import '../models/mentor.dart';
import '../common/constants/app_constants.dart';

class StatsData {
  final int totalNewcomers;
  final int newThisWeek;
  final int newThisMonth;
  final Map<String, int> statusDistribution;
  final Map<String, int> communeDistribution;
  final Map<String, int> mentorAssignments;
  final double integrationRate;

  StatsData({
    required this.totalNewcomers,
    required this.newThisWeek,
    required this.newThisMonth,
    required this.statusDistribution,
    required this.communeDistribution,
    required this.mentorAssignments,
    required this.integrationRate,
  });
}

class StatsService {
  static StatsData calculateStats(List<Person> newcomers, List<Mentor> mentors) {
    final now = DateTime.now();
    final weekAgo = now.subtract(const Duration(days: 7));
    final monthAgo = now.subtract(const Duration(days: 30));

    final newThisWeek = newcomers.where((p) => p.createdAt.isAfter(weekAgo)).length;
    final newThisMonth = newcomers.where((p) => p.createdAt.isAfter(monthAgo)).length;

    final statusDistribution = _calculateStatusDistribution(newcomers);
    final communeDistribution = _calculateCommuneDistribution(newcomers);
    final mentorAssignments = _calculateMentorAssignments(newcomers, mentors);
    
    final integrationRate = _calculateIntegrationRate(newcomers);

    return StatsData(
      totalNewcomers: newcomers.length,
      newThisWeek: newThisWeek,
      newThisMonth: newThisMonth,
      statusDistribution: statusDistribution,
      communeDistribution: communeDistribution,
      mentorAssignments: mentorAssignments,
      integrationRate: integrationRate,
    );
  }

  static Map<String, int> _calculateStatusDistribution(List<Person> newcomers) {
    final distribution = <String, int>{};
    
    for (final person in newcomers) {
      distribution[person.status] = (distribution[person.status] ?? 0) + 1;
    }

    return distribution;
  }

  static Map<String, int> _calculateCommuneDistribution(List<Person> newcomers) {
    final distribution = <String, int>{};
    
    for (final person in newcomers) {
      distribution[person.commune] = (distribution[person.commune] ?? 0) + 1;
    }

    return distribution;
  }

  static Map<String, int> _calculateMentorAssignments(List<Person> newcomers, List<Mentor> mentors) {
    final assignments = <String, int>{};
    
    for (final mentor in mentors) {
      final count = newcomers.where((p) => p.assignedMentorId == mentor.id).length;
      if (count > 0) {
        assignments[mentor.name] = count;
      }
    }

    return assignments;
  }

  static double _calculateIntegrationRate(List<Person> newcomers) {
    if (newcomers.isEmpty) return 0.0;
    
    final integrated = newcomers.where((p) => 
      p.status == AppConstants.statusIntegrated
    ).length;
    
    return (integrated / newcomers.length) * 100;
  }

  static String getStatusLabel(String status) {
    switch (status) {
      case AppConstants.statusNew:
        return 'Nouveaux';
      case AppConstants.statusToVisit:
        return 'À visiter';
      case AppConstants.statusInFollow:
        return 'En suivi';
      case AppConstants.statusIntegrated:
        return 'Intégrés';
      case AppConstants.statusReorient:
        return 'À réorienter';
      case AppConstants.statusAbsent:
        return 'Absents';
      default:
        return status;
    }
  }
}