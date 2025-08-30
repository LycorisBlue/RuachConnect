import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../providers/auth_provider.dart';
import '../../utils/styles.dart';
import '../../utils/user_role_helper.dart';
import '../../widgets/common/role_badge.dart';

class UserProfileScreen extends ConsumerWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider);

    if (user == null) {
      return const Scaffold(body: Center(child: Text('Utilisateur non connecté')));
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header moderne
            Container(
              padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 0),
              decoration: BoxDecoration(
                color: AppColors.background,
                border: Border(bottom: BorderSide(color: AppColors.divider.withOpacity(0.3), width: 1)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 8.w,
                                height: 8.w,
                                decoration: BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                'Mon profil',
                                style: TextStyle(fontSize: 14.sp, color: AppColors.accent, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            user.name,
                            style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w700, color: AppColors.onSurface),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Text(
                          'Retour',
                          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: AppColors.primary),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    SizedBox(height: 20.h),

                    // Avatar et informations de base
                    _buildProfileHeader(user),

                    SizedBox(height: 24.h),

                    // Informations utilisateur
                    _buildSection('Informations utilisateur', Icons.person_outline, [
                      _buildInfoRow('Nom complet', user.name),
                      _buildInfoRow('Email', user.email),
                      _buildInfoRow('Type de compte', UserRole.getRoleLabel(user.type)),
                      _buildInfoRow('Statut', user.isActive ? 'Actif' : 'Inactif'),
                    ]),

                    SizedBox(height: 20.h),

                    // Permissions
                    _buildPermissionsSection(user),

                    SizedBox(height: 32.h),

                    // Section déconnexion
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(color: AppColors.divider.withOpacity(0.3), width: 1),
                      ),
                      child: Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              ref.read(authProvider.notifier).state = null;
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.danger,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              minimumSize: Size(double.infinity, 48.h),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.logout, size: 20.sp),
                                SizedBox(width: 8.w),
                                Text('Se déconnecter'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 32.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(user) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.02),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.primary.withOpacity(0.1), width: 1.5),
      ),
      child: Row(
        children: [
          Container(
            width: 64.w,
            height: 64.h,
            decoration: BoxDecoration(color: UserRole.getRoleColor(user.type), shape: BoxShape.circle),
            child: Center(
              child: Icon(UserRole.getRoleIcon(user.type), color: Colors.white, size: 28.sp),
            ),
          ),

          SizedBox(width: 16.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700, color: AppColors.onSurface),
                ),
                SizedBox(height: 4.h),
                Text(
                  user.email,
                  style: TextStyle(fontSize: 14.sp, color: AppColors.accent, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 8.h),
                RoleBadge(userType: user.type),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, IconData icon, List<Widget> children) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.divider.withOpacity(0.3), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 4.w,
                height: 18.h,
                decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(2.r)),
              ),
              SizedBox(width: 12.w),
              Text(
                title,
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700, color: AppColors.onSurface),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          ...children.map(
            (child) => Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: child,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPermissionsSection(user) {
    final actions = UserRole.getAvailableActions(user.type);

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.divider.withOpacity(0.3), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 4.w,
                height: 18.h,
                decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(2.r)),
              ),
              SizedBox(width: 12.w),
              Text(
                'Autorisations',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700, color: AppColors.onSurface),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          ...actions.map((action) {
            return Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: Row(
                children: [
                  Container(
                    width: 6.w,
                    height: 6.w,
                    decoration: BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      action,
                      style: TextStyle(fontSize: 14.sp, color: AppColors.onSurface, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120.w,
          child: Text(
            label,
            style: TextStyle(fontSize: 14.sp, color: AppColors.accent, fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 14.sp, color: AppColors.onSurface, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
