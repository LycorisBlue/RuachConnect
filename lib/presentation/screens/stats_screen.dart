import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../controllers/stats_controller.dart';
import '../../services/stats_service.dart';
import '../../utils/styles.dart';
import '../../utils/status_helper.dart';

class StatsScreen extends ConsumerWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = StatsController(ref);
    
    if (!controller.canViewStats()) {
      return Scaffold(
        appBar: AppBar(title: const Text('Statistiques')),
        body: const Center(
          child: Text('Accès non autorisé'),
        ),
      );
    }

    final stats = controller.getStats();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistiques'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOverviewCards(stats),
            SizedBox(height: 24.h),
            _buildStatusChart(stats, controller),
            SizedBox(height: 24.h),
            _buildCommuneStats(stats, controller),
            SizedBox(height: 24.h),
            _buildMentorStats(stats),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewCards(StatsData stats) {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            title: 'Total',
            value: '${stats.totalNewcomers}',
            subtitle: 'Nouveaux',
            color: AppColors.primary,
            icon: Icons.people,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _StatCard(
            title: 'Cette semaine',
            value: '${stats.newThisWeek}',
            subtitle: 'Nouveaux',
            color: AppColors.success,
            icon: Icons.trending_up,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _StatCard(
            title: 'Intégration',
            value: '${stats.integrationRate.toStringAsFixed(1)}%',
            subtitle: 'Taux',
            color: AppColors.accent,
            icon: Icons.check_circle,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusChart(StatsData stats, StatsController controller) {
    final entries = controller.getSortedStatusDistribution(stats.statusDistribution);
    
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Répartition par statut', style: AppTextStyles.h2),
            SizedBox(height: 16.h),
            ...entries.map((entry) {
              final percentage = stats.totalNewcomers > 0 
                ? (entry.value / stats.totalNewcomers * 100)
                : 0.0;
              
              return Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 12.w,
                              height: 12.h,
                              decoration: BoxDecoration(
                                color: StatusHelper.getStatusColor(entry.key),
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              StatsService.getStatusLabel(entry.key),
                              style: AppTextStyles.body,
                            ),
                          ],
                        ),
                        Text(
                          '${entry.value} (${percentage.toStringAsFixed(1)}%)',
                          style: AppTextStyles.body.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    LinearProgressIndicator(
                      value: percentage / 100,
                      backgroundColor: AppColors.background,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        StatusHelper.getStatusColor(entry.key),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildCommuneStats(StatsData stats, StatsController controller) {
    final entries = controller.getSortedCommuneDistribution(stats.communeDistribution);
    
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Top Communes', style: AppTextStyles.h2),
            SizedBox(height: 16.h),
            if (entries.isEmpty)
              Text('Aucune donnée disponible', style: AppTextStyles.caption)
            else
              ...entries.map((entry) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(entry.key, style: AppTextStyles.body),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${entry.value}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
          ],
        ),
      ),
    );
  }

  Widget _buildMentorStats(StatsData stats) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Encadreurs actifs', style: AppTextStyles.h2),
            SizedBox(height: 16.h),
            if (stats.mentorAssignments.isEmpty)
              Text('Aucun encadreur assigné', style: AppTextStyles.caption)
            else
              ...stats.mentorAssignments.entries.map((entry) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(entry.key, style: AppTextStyles.body),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.success,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${entry.value} assigné${entry.value > 1 ? 's' : ''}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final Color color;
  final IconData icon;

  const _StatCard({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24.sp),
            SizedBox(height: 8.h),
            Text(
              value,
              style: AppTextStyles.h1.copyWith(
                color: color,
                fontSize: 24.sp,
              ),
            ),
            Text(subtitle, style: AppTextStyles.caption),
            Text(title, style: AppTextStyles.caption),
          ],
        ),
      ),
    );
  }
}