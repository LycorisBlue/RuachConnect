import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/styles.dart';
import '../../utils/user_role_helper.dart';

class RoleBadge extends StatelessWidget {
  final String userType;
  final bool showIcon;
  final bool compact;

  const RoleBadge({
    super.key,
    required this.userType,
    this.showIcon = true,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = UserRole.getRoleColor(userType);
    final label = UserRole.getRoleLabel(userType);
    final icon = UserRole.getRoleIcon(userType);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 6.w : 8.w,
        vertical: compact ? 2.h : 4.h,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(compact ? 8 : 12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showIcon) ...[
            Icon(
              icon,
              color: Colors.white,
              size: compact ? 12.sp : 14.sp,
            ),
            SizedBox(width: 4.w),
          ],
          Text(
            compact ? _getCompactLabel(userType) : label,
            style: TextStyle(
              color: Colors.white,
              fontSize: compact ? 10.sp : 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  String _getCompactLabel(String userType) {
    switch (userType) {
      case 'CAN':
        return 'CAN';
      case 'ACCUEIL':
        return 'Accueil';
      case 'ENCADREUR':
        return 'Encadreur';
      case 'PASTEUR':
        return 'Pasteur';
      default:
        return userType;
    }
  }
}