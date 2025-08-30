import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
import '../presentation/screens/new_person_screen.dart';
import '../presentation/screens/newcomers_list_screen.dart';
import '../presentation/screens/assign_mentor_screen.dart';
import '../presentation/screens/user_profile_screen.dart';
import '../presentation/screens/stats_screen.dart';
import '../utils/user_role_helper.dart';

class HomeController {
  final WidgetRef ref;

  HomeController(this.ref);

  void logout() {
    ref.read(authProvider.notifier).state = null;
  }

  void goToNewPerson(BuildContext context) {
    final user = ref.read(authProvider);
    if (user == null || !UserRole.canAddNewcomer(user.type)) {
      _showPermissionDenied(context, 'Vous n\'êtes pas autorisé à enregistrer des nouveaux');
      return;
    }
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const NewPersonScreen()),
    );
  }

  void goToNewcomersList(BuildContext context) {
    final user = ref.read(authProvider);
    if (user == null || !UserRole.canViewAllNewcomers(user.type)) {
      _showPermissionDenied(context, 'Vous n\'êtes pas autorisé à voir tous les nouveaux');
      return;
    }
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const NewcomersListScreen()),
    );
  }

  void goToStats(BuildContext context) {
    final user = ref.read(authProvider);
    if (user == null || !UserRole.canViewStats(user.type)) {
      _showPermissionDenied(context, 'Vous n\'êtes pas autorisé à voir les statistiques');
      return;
    }
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const StatsScreen()),
    );
  }

  void goToAssignMentor(BuildContext context) {
    final user = ref.read(authProvider);
    if (user == null || !UserRole.canAssignMentor(user.type)) {
      _showPermissionDenied(context, 'Vous n\'êtes pas autorisé à assigner des encadreurs');
      return;
    }
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const AssignMentorScreen()),
    );
  }

  void goToMyAssignments(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Mes assignations - À implémenter')),
    );
  }

  void goToProfile(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const UserProfileScreen()),
    );
  }

  void _showPermissionDenied(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}