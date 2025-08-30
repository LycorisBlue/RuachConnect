import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/styles.dart';
import '../../utils/status_helper.dart';
import '../../models/person.dart';

class PersonCard extends StatelessWidget {
  final Person person;
  final VoidCallback? onTap;

  const PersonCard({
    super.key,
    required this.person,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.divider.withValues(alpha: 0.3), width: 1),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.02),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Avatar avec initiale
            Container(
              width: 56.w,
              height: 56.h,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Center(
                child: Text(
                  person.firstName[0].toUpperCase(),
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            SizedBox(width: 16.w),

            // Informations visiteur
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          person.fullName,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.onSurface,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: StatusHelper.getStatusColor(person.status),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Text(
                          StatusHelper.getStatusLabel(person.status),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: 6.h),
                  
                  Row(
                    children: [
                      Icon(Icons.phone_outlined, color: AppColors.accent, size: 14.w),
                      SizedBox(width: 6.w),
                      Text(
                        person.phone,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.accent,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: 4.h),
                  
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined, color: AppColors.accent, size: 14.w),
                      SizedBox(width: 6.w),
                      Expanded(
                        child: Text(
                          '${person.commune}${person.quartier != 'Non renseigné' ? ' • ${person.quartier}' : ''}',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.accent,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: 8.h),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Première visite badge
                      if (person.isFirstVisit)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.secondary, width: 1),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            'Première visite',
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.secondary,
                            ),
                          ),
                        ),
                      
                      // Date d'ajout
                      Text(
                        _formatDate(person.createdAt),
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColors.accent,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(width: 12.w),

            // Flèche de navigation
            Icon(
              Icons.arrow_forward_ios,
              color: AppColors.accent,
              size: 16.w,
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final cardDate = DateTime(date.year, date.month, date.day);
    
    if (cardDate == today) {
      return 'Aujourd\'hui';
    } else if (cardDate == today.subtract(const Duration(days: 1))) {
      return 'Hier';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}