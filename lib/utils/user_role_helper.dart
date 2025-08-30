import 'package:flutter/material.dart';
import '../common/constants/app_constants.dart';
import 'styles.dart';

class UserRole {
  static bool canAddNewcomer(String userType) {
    return [
      AppConstants.userTypeCAN,
      AppConstants.userTypeAccueil,
      AppConstants.userTypePasteur,
    ].contains(userType);
  }

  static bool canAssignMentor(String userType) {
    return [
      AppConstants.userTypeCAN,
      AppConstants.userTypePasteur,
    ].contains(userType);
  }

  static bool canViewAllNewcomers(String userType) {
    return [
      AppConstants.userTypeCAN,
      AppConstants.userTypePasteur,
    ].contains(userType);
  }

  static bool canViewStats(String userType) {
    return [
      AppConstants.userTypeCAN,
      AppConstants.userTypePasteur,
    ].contains(userType);
  }

  static bool canManageUsers(String userType) {
    return userType == AppConstants.userTypePasteur;
  }

  static bool canEditPersonStatus(String userType) {
    return [
      AppConstants.userTypeCAN,
      AppConstants.userTypeEncadreur,
      AppConstants.userTypePasteur,
    ].contains(userType);
  }

  static bool canViewOwnAssignments(String userType) {
    return userType == AppConstants.userTypeEncadreur;
  }

  static String getRoleLabel(String userType) {
    switch (userType) {
      case AppConstants.userTypeCAN:
        return 'Comité Accueil Nouveaux';
      case AppConstants.userTypeAccueil:
        return 'Accueil Général';
      case AppConstants.userTypeEncadreur:
        return 'Encadreur';
      case AppConstants.userTypePasteur:
        return 'Pasteur';
      default:
        return userType;
    }
  }

  static Color getRoleColor(String userType) {
    switch (userType) {
      case AppConstants.userTypeCAN:
        return AppColors.primary;
      case AppConstants.userTypeAccueil:
        return AppColors.secondary;
      case AppConstants.userTypeEncadreur:
        return AppColors.success;
      case AppConstants.userTypePasteur:
        return AppColors.warning;
      default:
        return AppColors.accent;
    }
  }

  static IconData getRoleIcon(String userType) {
    switch (userType) {
      case AppConstants.userTypeCAN:
        return Icons.group;
      case AppConstants.userTypeAccueil:
        return Icons.waving_hand;
      case AppConstants.userTypeEncadreur:
        return Icons.person;
      case AppConstants.userTypePasteur:
        return Icons.church;
      default:
        return Icons.account_circle;
    }
  }

  static List<String> getAvailableActions(String userType) {
    List<String> actions = [];
    
    if (canAddNewcomer(userType)) actions.add('Enregistrer nouveaux');
    if (canViewAllNewcomers(userType)) actions.add('Voir tous les nouveaux');
    if (canAssignMentor(userType)) actions.add('Assigner encadreurs');
    if (canViewStats(userType)) actions.add('Voir statistiques');
    if (canManageUsers(userType)) actions.add('Gérer utilisateurs');
    if (canViewOwnAssignments(userType)) actions.add('Mes assignations');

    return actions;
  }
}