import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/common/role_badge.dart';
import '../../utils/styles.dart';
import '../../utils/user_role_helper.dart';

class UserProfileScreen extends ConsumerWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider);

    if (user == null) {
      return const Scaffold(
        body: Center(child: Text('Utilisateur non connecté')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mon Profil'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildUserInfoCard(user),
            SizedBox(height: 16.h),
            _buildPermissionsCard(user),
            SizedBox(height: 16.h),
            _buildActionsCard(context, ref),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfoCard(user) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: UserRole.getRoleColor(user.type),
                  radius: 30.r,
                  child: Icon(
                    UserRole.getRoleIcon(user.type),
                    color: Colors.white,
                    size: 28.sp,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user.name, style: AppTextStyles.h1),
                      SizedBox(height: 4.h),
                      Text(user.email, style: AppTextStyles.caption),
                      SizedBox(height: 8.h),
                      RoleBadge(userType: user.type),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPermissionsCard(user) {
    final actions = UserRole.getAvailableActions(user.type);

    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Autorisations', style: AppTextStyles.h2),
            SizedBox(height: 12.h),
            ...actions.map((action) {
              return Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: AppColors.success,
                      size: 16.sp,
                    ),
                    SizedBox(width: 8.w),
                    Text(action, style: AppTextStyles.body),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildActionsCard(BuildContext context, WidgetRef ref) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Actions', style: AppTextStyles.h2),
            SizedBox(height: 12.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  ref.read(authProvider.notifier).state = null;
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.logout),
                label: const Text('Se déconnecter'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.danger,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}