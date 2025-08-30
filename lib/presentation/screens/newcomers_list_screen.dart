import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/lists/person_card.dart';
import '../../providers/newcomers_provider.dart';
import '../../providers/auth_provider.dart';
import '../../utils/styles.dart';
import '../../utils/user_role_helper.dart';
import 'new_person_screen.dart';
import 'person_detail_screen.dart';

class NewcomersListScreen extends ConsumerWidget {
  const NewcomersListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newcomers = ref.watch(newcomersProvider);
    final user = ref.watch(authProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header moderne similaire aux autres écrans
            Container(
              padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 0),
              decoration: BoxDecoration(
                color: AppColors.background,
                border: Border(bottom: BorderSide(color: AppColors.divider.withValues(alpha: 0.3), width: 1)),
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
                                'Liste des visiteurs',
                                style: TextStyle(fontSize: 14.sp, color: AppColors.accent, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            '${newcomers.length} visiteur${newcomers.length > 1 ? 's' : ''}',
                            style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w700, color: AppColors.onSurface),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Filtrer/rechercher
                            },
                            child: Container(
                              padding: EdgeInsets.all(8.w),
                              decoration: BoxDecoration(color: AppColors.background, shape: BoxShape.circle),
                              child: Icon(Icons.search_outlined, color: AppColors.accent, size: 20.w),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: Container(
                              padding: EdgeInsets.all(8.w),
                              decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.1), shape: BoxShape.circle),
                              child: Icon(Icons.arrow_back, color: AppColors.primary, size: 20.w),
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

            // Contenu principal
            Expanded(
              child: newcomers.isEmpty
                  ? _buildEmptyState(context, user)
                  : SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        children: [
                          SizedBox(height: 20.h),
                          
                          // Liste des visiteurs
                          ...newcomers.map((person) => Padding(
                            padding: EdgeInsets.only(bottom: 12.h),
                            child: PersonCard(
                              person: person,
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => PersonDetailScreen(person: person),
                                  ),
                                );
                              },
                            ),
                          )),
                          
                          SizedBox(height: 100.h), // Espace pour le FAB
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: UserRole.canAddNewcomer(user?.type ?? '')
          ? FloatingActionButton.extended(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const NewPersonScreen(),
                  ),
                );
              },
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

  Widget _buildEmptyState(BuildContext context, user) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120.w,
              height: 120.h,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.05),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.people_outline,
                size: 60.w,
                color: AppColors.primary,
              ),
            ),
            
            SizedBox(height: 24.h),
            
            Text(
              'Aucun visiteur enregistré',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.onSurface,
              ),
            ),
            
            SizedBox(height: 8.h),
            
            Text(
              'Commencez par enregistrer votre premier visiteur pour bâtir votre communauté',
              style: TextStyle(
                fontSize: 16.sp,
                color: AppColors.accent,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            
            SizedBox(height: 32.h),
            
            if (UserRole.canAddNewcomer(user?.type ?? ''))
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const NewPersonScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                ),
                icon: Icon(Icons.person_add, size: 20.w),
                label: Text(
                  'Enregistrer un visiteur',
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                ),
              ),
          ],
        ),
      ),
    );
  }

}