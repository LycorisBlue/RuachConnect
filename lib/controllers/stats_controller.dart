import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
import '../providers/newcomers_provider.dart';
import '../providers/mentors_provider.dart';
import '../services/stats_service.dart';
import '../utils/user_role_helper.dart';
import '../utils/styles.dart';

class StatsController {
  final WidgetRef ref;

  StatsController(this.ref);

  bool canViewStats() {
    final user = ref.read(authProvider);
    return user != null && UserRole.canViewStats(user.type);
  }

  StatsData getStats() {
    if (!canViewStats()) {
      throw Exception('Permission refusée pour voir les statistiques');
    }

    final newcomers = ref.read(newcomersProvider);
    final mentors = ref.read(mentorsProvider);
    
    return StatsService.calculateStats(newcomers, mentors);
  }

  String getTimePeriodLabel(String period) {
    switch (period) {
      case 'week':
        return 'Cette semaine';
      case 'month':
        return 'Ce mois';
      case 'quarter':
        return 'Ce trimestre';
      case 'year':
        return 'Cette année';
      default:
        return 'Total';
    }
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'NOUVEAU':
        return AppColors.secondary;
      case 'A_VISITER':
        return AppColors.warning;
      case 'EN_SUIVI':
        return AppColors.primary;
      case 'INTEGRE':
        return AppColors.success;
      case 'A_REORIENTER':
        return AppColors.danger;
      case 'ABSENT_PROLONGE':
        return AppColors.accent;
      default:
        return AppColors.accent;
    }
  }

  List<MapEntry<String, int>> getSortedStatusDistribution(Map<String, int> distribution) {
    final entries = distribution.entries.toList();
    entries.sort((a, b) => b.value.compareTo(a.value));
    return entries;
  }

  List<MapEntry<String, int>> getSortedCommuneDistribution(Map<String, int> distribution) {
    final entries = distribution.entries.toList();
    entries.sort((a, b) => b.value.compareTo(a.value));
    return entries.take(10).toList(); // Top 10 communes
  }

  String getIntegrationMessage(double rate) {
    if (rate >= 80) {
      return 'Excellent taux d\'intégration !';
    } else if (rate >= 60) {
      return 'Bon taux d\'intégration';
    } else if (rate >= 40) {
      return 'Taux d\'intégration moyen';
    } else if (rate >= 20) {
      return 'Taux d\'intégration faible';
    } else {
      return 'Besoin d\'améliorer l\'intégration';
    }
  }

  void showPermissionDenied(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Vous n\'êtes pas autorisé à voir les statistiques'),
        backgroundColor: AppColors.danger,
        duration: Duration(seconds: 3),
      ),
    );
  }
}