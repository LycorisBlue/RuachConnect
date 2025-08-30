import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/styles.dart';
import '../../controllers/home_controller.dart';
import '../../providers/auth_provider.dart';
import '../../providers/newcomers_provider.dart';
import '../../common/constants/app_constants.dart';
import '../../utils/user_role_helper.dart';
import '../../widgets/common/role_badge.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider);
    final newcomers = ref.watch(newcomersProvider);
    final controller = HomeController(ref);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header moderne avec indicateurs visuels
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
                                'Bonjour',
                                style: TextStyle(fontSize: 14.sp, color: AppColors.accent, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            user?.name ?? 'Utilisateur',
                            style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w700, color: AppColors.onSurface),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Navigation vers notifications
                            },
                            child: Container(
                              padding: EdgeInsets.all(8.w),
                              decoration: BoxDecoration(color: AppColors.background, shape: BoxShape.circle),
                              child: Stack(
                                children: [
                                  Icon(Icons.notifications_outlined, color: AppColors.accent, size: 20.w),
                                  Positioned(
                                    right: 0,
                                    top: 0,
                                    child: Container(
                                      width: 8.w,
                                      height: 8.w,
                                      decoration: BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          GestureDetector(
                            onTap: () => controller.goToProfile(context),
                            child: Container(
                              padding: EdgeInsets.all(8.w),
                              decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), shape: BoxShape.circle),
                              child: Icon(Icons.person, color: AppColors.primary, size: 20.w),
                            ),
                          ),
                        ],
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

                    // Bloc d'informations - Dernière personne ajoutée
                    if (newcomers.isNotEmpty) ...[
                      Container(
                        padding: EdgeInsets.all(20.w),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.02),
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(color: AppColors.primary.withOpacity(0.1), width: 1.5),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 4.w,
                                      height: 18.h,
                                      decoration: BoxDecoration(
                                        color: AppColors.primary,
                                        borderRadius: BorderRadius.circular(2.r),
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    Text(
                                      'Dernier visiteur ajouté',
                                      style: TextStyle(fontSize: 14.sp, color: AppColors.primary, fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                                  decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(16.r)),
                                  child: Text(
                                    'Nouveau',
                                    style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 12.h),

                            Row(
                              children: [
                                // Avatar avec initiale
                                Container(
                                  width: 48.w,
                                  height: 48.h,
                                  decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(12.r)),
                                  child: Center(
                                    child: Text(
                                      newcomers.first.firstName[0].toUpperCase(),
                                      style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: Colors.white),
                                    ),
                                  ),
                                ),

                                SizedBox(width: 16.w),

                                // Informations visiteur
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        newcomers.first.fullName,
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.onSurface,
                                        ),
                                      ),
                                      SizedBox(height: 2.h),
                                      Text(
                                        '${newcomers.first.phone} • ${newcomers.first.commune}',
                                        style: TextStyle(fontSize: 14.sp, color: AppColors.accent, fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(height: 4.h),
                                      Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                                            decoration: BoxDecoration(
                                              border: Border.all(color: AppColors.secondary, width: 1),
                                              borderRadius: BorderRadius.circular(8.r),
                                            ),
                                            child: Text(
                                              'À visiter',
                                              style: TextStyle(
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.w600,
                                                color: AppColors.secondary,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 6.w),
                                          Text(
                                            '${newcomers.first.isFirstVisit ? 'Première visite' : 'Déjà venu'}',
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              color: AppColors.primary,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24.h),
                    ],

                    // Actions rapides avec design moderne
                    Row(
                      children: [
                        Expanded(
                          child: _buildQuickAction(
                            'Nouveau',
                            'Enregistrer visiteur',
                            Icons.person_add,
                            AppColors.primary,
                            () => controller.goToNewPerson(context),
                            user,
                            () => UserRole.canAddNewcomer(user?.type ?? ''),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: _buildQuickAction(
                            'Liste',
                            'Des nouveaux',
                            Icons.people,
                            AppColors.secondary,
                            () => controller.goToNewcomersList(context),
                            user,
                            () => UserRole.canViewAllNewcomers(user?.type ?? ''),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 10.h),

                    Row(
                      children: [
                        Expanded(
                          child: _buildQuickAction(
                            'Attribution',
                            'D\'encadreurs',
                            Icons.assignment_ind,
                            AppColors.primary,
                            () => controller.goToAssignMentor(context),
                            user,
                            () => UserRole.canAssignMentor(user?.type ?? ''),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: _buildQuickAction(
                            'Statistiques',
                            'Voir les rapports',
                            Icons.bar_chart,
                            AppColors.secondary,
                            () => controller.goToStats(context),
                            user,
                            () => UserRole.canViewStats(user?.type ?? ''),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 20.h),

                    // Dernière activité
                    Container(
                      padding: EdgeInsets.all(18.w),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(color: AppColors.divider.withOpacity(0.3), width: 1),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 10.w,
                            height: 10.w,
                            decoration: BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                          ),

                          SizedBox(width: 14.w),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  newcomers.isNotEmpty ? newcomers.first.fullName : 'Aucun visiteur',
                                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700, color: AppColors.onSurface),
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  'Nouveau visiteur',
                                  style: TextStyle(fontSize: 14.sp, color: AppColors.accent, fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Aujourd\'hui',
                                style: TextStyle(fontSize: 12.sp, color: AppColors.accent, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(height: 3.h),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.primary, width: 1),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: Text(
                                  'Nouveau',
                                  style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w600, color: AppColors.primary),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 32.h),

                    // Citation inspirante
                    Text(
                      'Accueillir chaque âme avec amour et bienveillance',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.accent,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: 16.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: UserRole.canAddNewcomer(user?.type ?? '')
          ? FloatingActionButton.extended(
              onPressed: () => controller.goToNewPerson(context),
              backgroundColor: AppColors.primary,
              elevation: 4,
              icon: Icon(Icons.person_add, color: Colors.white, size: 20.w),
              label: Text(
                'Nouveau',
                style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w600),
              ),
            )
          : null,
    );
  }

  Widget _buildQuickAction(
    String title,
    String subtitle,
    IconData icon,
    Color color,
    VoidCallback? onTap,
    dynamic user,
    bool Function() hasPermission,
  ) {
    return GestureDetector(
      onTap: hasPermission() ? onTap : null,
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: hasPermission() ? AppColors.surface : AppColors.surface.withOpacity(0.5),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.divider.withOpacity(0.3), width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: hasPermission() ? color.withOpacity(0.08) : AppColors.accent.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(icon, color: hasPermission() ? color : AppColors.accent.withOpacity(0.5), size: 24.w),
            ),

            SizedBox(height: 12.h),

            Text(
              title,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: hasPermission() ? AppColors.onSurface : AppColors.accent.withOpacity(0.5),
              ),
            ),

            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12.sp,
                color: hasPermission() ? AppColors.accent : AppColors.accent.withOpacity(0.5),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
