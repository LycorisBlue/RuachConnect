import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../models/follow_up.dart';
import '../../utils/styles.dart';

class InteractionCard extends StatelessWidget {
  final FollowUp followUp;

  const InteractionCard({super.key, required this.followUp});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 8.h),
      elevation: 1,
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: _getTypeColor().withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                _getTypeIcon(),
                color: _getTypeColor(),
                size: 20.sp,
              ),
            ),
            
            SizedBox(width: 12.w),
            
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        FollowUpType.getLabel(followUp.type),
                        style: AppTextStyles.h2.copyWith(fontSize: 16.sp),
                      ),
                      Text(
                        _formatDate(followUp.date),
                        style: AppTextStyles.caption,
                      ),
                    ],
                  ),
                  
                  SizedBox(height: 4.h),
                  
                  Text(
                    'Par ${followUp.mentorName}',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  
                  SizedBox(height: 8.h),
                  
                  Text(
                    followUp.notes,
                    style: AppTextStyles.body.copyWith(fontSize: 14.sp),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getTypeIcon() {
    switch (followUp.type) {
      case FollowUpType.visite:
        return Icons.home;
      case FollowUpType.appel:
        return Icons.phone;
      case FollowUpType.priere:
        return Icons.favorite;
      default:
        return Icons.note;
    }
  }

  Color _getTypeColor() {
    switch (followUp.type) {
      case FollowUpType.visite:
        return AppColors.success;
      case FollowUpType.appel:
        return AppColors.primary;
      case FollowUpType.priere:
        return AppColors.warning;
      default:
        return AppColors.accent;
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date).inDays;
    
    if (diff == 0) return 'Aujourd\'hui';
    if (diff == 1) return 'Hier';
    if (diff < 7) return 'Il y a $diff jours';
    
    return '${date.day}/${date.month}/${date.year}';
  }
}