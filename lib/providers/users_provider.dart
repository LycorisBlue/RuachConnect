import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';
import '../common/constants/app_constants.dart';

final usersProvider = Provider<List<User>>((ref) {
  return [
    User(
      id: '1',
      name: 'Jean Administrateur',
      email: 'admin@ruach.org',
      type: AppConstants.userTypeCAN,
    ),
    User(
      id: '2',
      name: 'Marie Accueil',
      email: 'accueil@ruach.org',
      type: AppConstants.userTypeAccueil,
    ),
    User(
      id: '3',
      name: 'Paul Encadreur',
      email: 'encadreur@ruach.org',
      type: AppConstants.userTypeEncadreur,
    ),
    User(
      id: '4',
      name: 'Sophie Pasteur',
      email: 'pasteur@ruach.org',
      type: AppConstants.userTypePasteur,
    ),
  ];
});

final testCredentialsProvider = Provider<Map<String, String>>((ref) {
  return {
    'admin@ruach.org': 'admin123',
    'accueil@ruach.org': 'accueil123',
    'encadreur@ruach.org': 'encadreur123',
    'pasteur@ruach.org': 'pasteur123',
  };
});