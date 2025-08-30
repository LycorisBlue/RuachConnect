import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/styles.dart';
import '../../controllers/home_controller.dart';
import '../../providers/auth_provider.dart';
import '../../common/constants/app_constants.dart';
import '../../utils/user_role_helper.dart';
import '../../widgets/common/role_badge.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider);
    final controller = HomeController(ref);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppConstants.appName),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => controller.logout(),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(ResponsiveHelper.screenPadding.left),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bonjour ${user?.name ?? 'Utilisateur'}',
                        style: AppTextStyles.h1,
                      ),
                      SizedBox(height: 4.h),
                      if (user != null) RoleBadge(userType: user.type),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Text(
              'Que souhaitez-vous faire aujourd\'hui ?',
              style: AppTextStyles.body,
            ),
            SizedBox(height: 32.h),
            
            Expanded(
              child: GridView.count(
                crossAxisCount: ResponsiveHelper.crossAxisCount,
                crossAxisSpacing: 16.w,
                mainAxisSpacing: 16.h,
                childAspectRatio: 1.2,
                children: _buildMenuItems(user, controller, context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildMenuItems(user, HomeController controller, BuildContext context) {
    if (user == null) return [];
    
    List<Widget> items = [];

    if (UserRole.canAddNewcomer(user.type)) {
      items.add(_MenuCard(
        title: 'Nouveau Visiteur',
        subtitle: 'Enregistrer un nouveau',
        icon: Icons.person_add,
        color: AppColors.primary,
        onTap: () => controller.goToNewPerson(context),
      ));
    }

    if (UserRole.canViewAllNewcomers(user.type)) {
      items.add(_MenuCard(
        title: 'Liste Nouveaux',
        subtitle: 'Voir tous les nouveaux',
        icon: Icons.people,
        color: AppColors.secondary,
        onTap: () => controller.goToNewcomersList(context),
      ));
    }

    if (UserRole.canAssignMentor(user.type)) {
      items.add(_MenuCard(
        title: 'Attribution',
        subtitle: 'Assigner encadreurs',
        icon: Icons.assignment_ind,
        color: AppColors.success,
        onTap: () => controller.goToAssignMentor(context),
      ));
    }

    if (UserRole.canViewStats(user.type)) {
      items.add(_MenuCard(
        title: 'Statistiques',
        subtitle: 'Voir les rapports',
        icon: Icons.bar_chart,
        color: AppColors.accent,
        onTap: () => controller.goToStats(context),
      ));
    }

    if (UserRole.canViewOwnAssignments(user.type)) {
      items.add(_MenuCard(
        title: 'Mes Assignations',
        subtitle: 'Mes personnes à suivre',
        icon: Icons.assignment_ind,
        color: AppColors.warning,
        onTap: () => controller.goToMyAssignments(context),
      ));
    }

    items.add(_MenuCard(
      title: 'Mon Profil',
      subtitle: 'Gérer mon compte',
      icon: Icons.account_circle,
      color: AppColors.accent,
      onTap: () => controller.goToProfile(context),
    ));

    return items;
  }
}

class _MenuCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _MenuCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  size: 32.sp,
                  color: color,
                ),
              ),
              
              SizedBox(height: 12.h),
              
              Text(
                title,
                style: AppTextStyles.h2.copyWith(fontSize: 16.sp),
                textAlign: TextAlign.center,
              ),
              
              SizedBox(height: 4.h),
              
              Text(
                subtitle,
                style: AppTextStyles.caption,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}