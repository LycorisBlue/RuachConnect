import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../models/person.dart';
import '../../models/mentor.dart';
import '../../providers/newcomers_provider.dart';
import '../../providers/mentors_provider.dart';
import '../../utils/styles.dart';
import '../../utils/status_helper.dart';
import 'follow_up_screen.dart';

class PersonDetailScreen extends ConsumerStatefulWidget {
  final Person person;

  const PersonDetailScreen({super.key, required this.person});

  @override
  ConsumerState<PersonDetailScreen> createState() => _PersonDetailScreenState();
}

class _PersonDetailScreenState extends ConsumerState<PersonDetailScreen> {
  late String _currentStatus;
  String? _selectedMentorId;

  @override
  void initState() {
    super.initState();
    _currentStatus = widget.person.status;
    _selectedMentorId = widget.person.assignedMentorId;
  }

  @override
  Widget build(BuildContext context) {
    final mentors = ref.watch(mentorsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.person.fullName),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveChanges,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoSection(),
            SizedBox(height: 24.h),
            _buildStatusSection(),
            SizedBox(height: 24.h),
            _buildMentorSection(mentors),
            SizedBox(height: 24.h),
            _buildFollowUpSection(context),
            SizedBox(height: 24.h),
            _buildContactSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Informations personnelles', style: AppTextStyles.h2),
            SizedBox(height: 12.h),
            _buildInfoRow('Nom complet', widget.person.fullName),
            _buildInfoRow('Genre', widget.person.gender),
            _buildInfoRow('Téléphone', widget.person.phone),
            _buildInfoRow('Commune', widget.person.commune),
            _buildInfoRow('Quartier', widget.person.quartier),
            _buildInfoRow('Profession', widget.person.profession),
            _buildInfoRow('Statut marital', widget.person.maritalStatus),
            _buildInfoRow('Première visite', widget.person.isFirstVisit ? 'Oui' : 'Non'),
            _buildInfoRow('Comment connu l\'église', widget.person.howKnownChurch),
            if (widget.person.prayerRequest.isNotEmpty)
              _buildInfoRow('Besoin de prières', widget.person.prayerRequest),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120.w,
            child: Text(label, style: AppTextStyles.caption),
          ),
          Expanded(
            child: Text(value, style: AppTextStyles.body),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusSection() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Statut de suivi', style: AppTextStyles.h2),
            SizedBox(height: 12.h),
            DropdownButtonFormField<String>(
              value: _currentStatus,
              decoration: const InputDecoration(labelText: 'Statut'),
              items: StatusHelper.getStatusDropdownItems(),
              onChanged: (value) => setState(() => _currentStatus = value!),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMentorSection(List<Mentor> mentors) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Attribution encadreur', style: AppTextStyles.h2),
            SizedBox(height: 12.h),
            DropdownButtonFormField<String>(
              value: _selectedMentorId,
              decoration: const InputDecoration(labelText: 'Encadreur assigné'),
              items: [
                const DropdownMenuItem<String>(
                  value: null,
                  child: Text('Aucun encadreur'),
                ),
                ...mentors.map((mentor) {
                  return DropdownMenuItem<String>(
                    value: mentor.id,
                    child: Text('${mentor.name} (${mentor.type})'),
                  );
                }),
              ],
              onChanged: (value) => setState(() => _selectedMentorId = value),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactSection() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Actions rapides', style: AppTextStyles.h2),
            SizedBox(height: 12.h),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _callPerson(),
                    icon: const Icon(Icons.phone),
                    label: const Text('Appeler'),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _sendMessage(),
                    icon: const Icon(Icons.message),
                    label: const Text('WhatsApp'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFollowUpSection(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Suivi pastoral', style: AppTextStyles.h2),
                TextButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => FollowUpScreen(person: widget.person),
                      ),
                    );
                  },
                  icon: const Icon(Icons.timeline),
                  label: const Text('Voir historique'),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Text(
              'Dernière interaction: À implémenter',
              style: AppTextStyles.caption,
            ),
            Text(
              'Nombre d\'interactions: À implémenter',
              style: AppTextStyles.caption,
            ),
          ],
        ),
      ),
    );
  }

  void _callPerson() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Appel ${widget.person.phone} - À implémenter')),
    );
  }

  void _sendMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('WhatsApp ${widget.person.phone} - À implémenter')),
    );
  }

  void _saveChanges() {
    final updatedPerson = Person(
      id: widget.person.id,
      firstName: widget.person.firstName,
      lastName: widget.person.lastName,
      gender: widget.person.gender,
      birthDate: widget.person.birthDate,
      phone: widget.person.phone,
      commune: widget.person.commune,
      quartier: widget.person.quartier,
      profession: widget.person.profession,
      maritalStatus: widget.person.maritalStatus,
      isFirstVisit: widget.person.isFirstVisit,
      howKnownChurch: widget.person.howKnownChurch,
      prayerRequest: widget.person.prayerRequest,
      status: _currentStatus,
      assignedMentorId: _selectedMentorId,
      createdAt: widget.person.createdAt,
    );

    ref.read(newcomersProvider.notifier).updatePerson(updatedPerson);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Modifications enregistrées')),
    );

    Navigator.of(context).pop();
  }
}