import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'utils/styles.dart';
import 'common/constants/app_constants.dart';
import 'providers/auth_provider.dart';
import 'presentation/screens/login_screen.dart';
import 'presentation/screens/home_screen.dart';

void main() {
  runApp(const ProviderScope(child: RuachConnectApp()));
}

class RuachConnectApp extends StatelessWidget {
  const RuachConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(AppConstants.designWidth, AppConstants.designHeight),
      minTextAdapt: true,
      child: MaterialApp(
        title: AppConstants.appName,
        theme: AppTheme.theme,
        home: const AuthWrapper(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggedIn = ref.watch(isLoggedInProvider);
    
    return isLoggedIn ? const HomeScreen() : const LoginScreen();
  }
}

