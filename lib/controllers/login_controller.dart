import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';
import '../providers/auth_provider.dart';
import '../providers/users_provider.dart';

class LoginController {
  final WidgetRef ref;

  LoginController(this.ref);

  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    
    final users = ref.read(usersProvider);
    final credentials = ref.read(testCredentialsProvider);
    
    if (credentials[email] == password) {
      final user = users.firstWhere((u) => u.email == email);
      ref.read(authProvider.notifier).state = user;
      return true;
    }
    
    return false;
  }

  void logout() {
    ref.read(authProvider.notifier).state = null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email requis';
    }
    if (!value.contains('@')) {
      return 'Email invalide';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mot de passe requis';
    }
    if (value.length < 6) {
      return 'Minimum 6 caractères';
    }
    return null;
  }
}