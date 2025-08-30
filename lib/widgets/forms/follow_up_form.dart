import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../models/follow_up.dart';
import '../../utils/styles.dart';

class FollowUpForm extends StatefulWidget {
  final Function(FollowUp) onSubmit;
  final String personId;
  final String mentorId;
  final String mentorName;

  const FollowUpForm({
    super.key,
    required this.onSubmit,
    required this.personId,
    required this.mentorId,
    required this.mentorName,
  });

  @override
  State<FollowUpForm> createState() => _FollowUpFormState();
}

class _FollowUpFormState extends State<FollowUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _notesController = TextEditingController();
  
  String _type = FollowUpType.visite;
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButtonFormField<String>(
            value: _type,
            decoration: InputDecoration(
              labelText: 'Type d\'interaction',
              prefixIcon: Icon(_getTypeIcon(_type)),
            ),
            items: FollowUpType.all.map((type) {
              return DropdownMenuItem<String>(
                value: type,
                child: Row(
                  children: [
                    Icon(_getTypeIcon(type), size: 20),
                    const SizedBox(width: 8),
                    Text(FollowUpType.getLabel(type)),
                  ],
                ),
              );
            }).toList(),
            onChanged: (value) => setState(() => _type = value!),
          ),

          SizedBox(height: 16.h),

          ListTile(
            leading: const Icon(Icons.calendar_today),
            title: const Text('Date'),
            subtitle: Text(_formatDate(_selectedDate)),
            onTap: _selectDate,
            contentPadding: EdgeInsets.zero,
          ),

          SizedBox(height: 16.h),

          TextFormField(
            controller: _notesController,
            maxLines: 4,
            decoration: const InputDecoration(
              labelText: 'Notes de suivi',
              alignLabelWithHint: true,
              prefixIcon: Icon(Icons.note),
            ),
            validator: (value) =>
                value?.trim().isEmpty == true ? 'Notes requises' : null,
          ),

          SizedBox(height: 24.h),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _handleSubmit,
              child: const Text('Ajouter Interaction'),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
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

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now(),
    );
    
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  void _handleSubmit() {
    if (!_formKey.currentState!.validate()) return;

    final followUp = FollowUp(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      personId: widget.personId,
      mentorId: widget.mentorId,
      mentorName: widget.mentorName,
      type: _type,
      notes: _notesController.text.trim(),
      date: _selectedDate,
    );

    widget.onSubmit(followUp);
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }
}