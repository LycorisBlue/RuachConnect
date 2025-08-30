import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';

final authProvider = StateProvider<User?>((ref) => null);

final isLoggedInProvider = Provider<bool>((ref) {
  final user = ref.watch(authProvider);
  return user != null;
});