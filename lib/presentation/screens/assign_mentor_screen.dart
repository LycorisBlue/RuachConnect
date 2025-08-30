import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../models/person.dart';
import '../../models/mentor.dart';
import '../../providers/newcomers_provider.dart';
import '../../providers/mentors_provider.dart';
import '../../utils/styles.dart';
import '../../utils/status_helper.dart';

class AssignMentorScreen extends ConsumerStatefulWidget {
  const AssignMentorScreen({super.key});

  @override
  ConsumerState<AssignMentorScreen> createState() => _AssignMentorScreenState();
}

class _AssignMentorScreenState extends ConsumerState<AssignMentorScreen> {
  final Map<String, String?> _assignments = {};

  @override
  Widget build(BuildContext context) {
    final newcomers = ref.watch(newcomersProvider);
    final mentors = ref.watch(mentorsProvider);
    
    final unassignedPersons = newcomers.where((person) => 
      person.assignedMentorId == null || person.assignedMentorId!.isEmpty
    ).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Attribution Encadreurs'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () => _saveAssignments(unassignedPersons),
          ),
        ],
      ),
      body: unassignedPersons.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: EdgeInsets.all(16.w),
              itemCount: unassignedPersons.length,
              itemBuilder: (context, index) {
                final person = unassignedPersons[index];
                return _buildPersonAssignmentCard(person, mentors);
              },
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.assignment_turned_in,
            size: 64,
            color: AppColors.success,
          ),
          const SizedBox(height: 16),
          Text(
            'Tous les visiteurs ont un encadreur',
            style: AppTextStyles.h2,
          ),
          const SizedBox(height: 8),
          Text(
            'Parfait ! Tous les nouveaux sont suivis',
            style: AppTextStyles.caption,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPersonAssignmentCard(Person person, List<Mentor> mentors) {
    return Card(
      margin: EdgeInsets.only(bottom: 12.h),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: StatusHelper.getStatusColor(person.status),
                  child: Text(
                    person.firstName[0].toUpperCase(),
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(person.fullName, style: AppTextStyles.h2.copyWith(fontSize: 16.sp)),
                      Text('${person.commune} • ${person.phone}', style: AppTextStyles.caption),
                    ],
                  ),
                ),
              ],
            ),
            
            SizedBox(height: 16.h),
            
            DropdownButtonFormField<String>(
              value: _assignments[person.id],
              decoration: const InputDecoration(
                labelText: 'Assigner à un encadreur',
                prefixIcon: Icon(Icons.person),
              ),
              items: [
                const DropdownMenuItem<String>(
                  value: null,
                  child: Text('Sélectionner un encadreur'),
                ),
                ...mentors.map((mentor) {
                  return DropdownMenuItem<String>(
                    value: mentor.id,
                    child: Text('${mentor.name} (${mentor.type})'),
                  );
                }),
              ],
              onChanged: (value) {
                setState(() {
                  _assignments[person.id] = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  void _saveAssignments(List<Person> persons) {
    int assignedCount = 0;
    
    for (final person in persons) {
      final mentorId = _assignments[person.id];
      if (mentorId != null) {
        final updatedPerson = Person(
          id: person.id,
          firstName: person.firstName,
          lastName: person.lastName,
          gender: person.gender,
          birthDate: person.birthDate,
          phone: person.phone,
          commune: person.commune,
          quartier: person.quartier,
          profession: person.profession,
          maritalStatus: person.maritalStatus,
          isFirstVisit: person.isFirstVisit,
          howKnownChurch: person.howKnownChurch,
          prayerRequest: person.prayerRequest,
          status: person.status,
          assignedMentorId: mentorId,
          createdAt: person.createdAt,
        );
        
        ref.read(newcomersProvider.notifier).updatePerson(updatedPerson);
        assignedCount++;
      }
    }

    if (assignedCount > 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$assignedCount encadreur(s) assigné(s)')),
      );
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Aucune attribution sélectionnée')),
      );
    }
  }
}