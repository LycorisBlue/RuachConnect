import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../models/person.dart';
import '../../models/follow_up.dart';
import '../../providers/follow_ups_provider.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/forms/follow_up_form.dart';
import '../../widgets/lists/interaction_card.dart';
import '../../utils/styles.dart';
import '../../utils/status_helper.dart';

class FollowUpScreen extends ConsumerWidget {
  final Person person;

  const FollowUpScreen({super.key, required this.person});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider);
    final followUps = ref.watch(followUpsProvider.notifier).getFollowUpsForPerson(person.id);

    return Scaffold(
      appBar: AppBar(
        title: Text('Suivi ${person.fullName}'),
      ),
      body: Column(
        children: [
          _buildPersonHeader(),
          Expanded(
            child: followUps.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: EdgeInsets.all(16.w),
                    itemCount: followUps.length,
                    itemBuilder: (context, index) {
                      return InteractionCard(followUp: followUps[index]);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddInteractionDialog(context, ref, user),
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildPersonHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(bottom: BorderSide(color: AppColors.divider)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: StatusHelper.getStatusColor(person.status),
            radius: 24.r,
            child: Text(
              person.firstName[0].toUpperCase(),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
              ),
            ),
          ),
          
          SizedBox(width: 16.w),
          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(person.fullName, style: AppTextStyles.h2),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: StatusHelper.getStatusColor(person.status),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        StatusHelper.getStatusLabel(person.status),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text('• ${person.phone}', style: AppTextStyles.caption),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.timeline,
            size: 64,
            color: AppColors.accent,
          ),
          const SizedBox(height: 16),
          Text(
            'Aucune interaction enregistrée',
            style: AppTextStyles.h2,
          ),
          const SizedBox(height: 8),
          Text(
            'Commencez le suivi en ajoutant une visite ou un appel',
            style: AppTextStyles.caption,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _showAddInteractionDialog(BuildContext context, WidgetRef ref, user) {
    if (user == null) return;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          left: 16.w,
          right: 16.w,
          top: 16.h,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16.h,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Nouvelle Interaction', style: AppTextStyles.h2),
            SizedBox(height: 16.h),
            FollowUpForm(
              personId: person.id,
              mentorId: user.id,
              mentorName: user.name,
              onSubmit: (followUp) {
                ref.read(followUpsProvider.notifier).addFollowUp(followUp);
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Interaction ajoutée')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}