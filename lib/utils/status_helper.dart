import 'package:flutter/material.dart';
import 'styles.dart';
import '../common/constants/app_constants.dart';

class StatusHelper {
  static const List<String> allStatuses = [
    AppConstants.statusNew,
    AppConstants.statusToVisit,
    AppConstants.statusInFollow,
    AppConstants.statusIntegrated,
    AppConstants.statusReorient,
    AppConstants.statusAbsent,
  ];

  static String getStatusLabel(String status) {
    switch (status) {
      case AppConstants.statusNew:
        return 'Nouveau';
      case AppConstants.statusToVisit:
        return 'À visiter';
      case AppConstants.statusInFollow:
        return 'En suivi';
      case AppConstants.statusIntegrated:
        return 'Intégré(e)';
      case AppConstants.statusReorient:
        return 'À réorienter';
      case AppConstants.statusAbsent:
        return 'Absent(e) prolongé(e)';
      default:
        return 'Inconnu';
    }
  }

  static Color getStatusColor(String status) {
    switch (status) {
      case AppConstants.statusNew:
        return AppColors.secondary;
      case AppConstants.statusToVisit:
        return AppColors.warning;
      case AppConstants.statusInFollow:
        return AppColors.primary;
      case AppConstants.statusIntegrated:
        return AppColors.success;
      case AppConstants.statusReorient:
        return AppColors.danger;
      case AppConstants.statusAbsent:
        return AppColors.accent;
      default:
        return AppColors.accent;
    }
  }

  static List<DropdownMenuItem<String>> getStatusDropdownItems() {
    return allStatuses.map((status) {
      return DropdownMenuItem<String>(
        value: status,
        child: Row(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: getStatusColor(status),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(getStatusLabel(status)),
          ],
        ),
      );
    }).toList();
  }

  static String getNextStatus(String currentStatus) {
    switch (currentStatus) {
      case AppConstants.statusToVisit:
        return AppConstants.statusInFollow;
      case AppConstants.statusInFollow:
        return AppConstants.statusIntegrated;
      default:
        return currentStatus;
    }
  }
}