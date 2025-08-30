import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/styles.dart';
import '../../models/person.dart';

class PersonForm extends StatefulWidget {
  final Person? initialPerson;
  final Function(Person) onSubmit;

  const PersonForm({
    super.key,
    this.initialPerson,
    required this.onSubmit,
  });

  @override
  State<PersonForm> createState() => _PersonFormState();
}

class _PersonFormState extends State<PersonForm> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _communeController = TextEditingController();
  final _quartierController = TextEditingController();
  final _professionController = TextEditingController();
  final _prayerRequestController = TextEditingController();

  String _gender = 'Homme';
  String _maritalStatus = 'Célibataire';
  String _howKnownChurch = 'Invitation';
  bool _isFirstVisit = true;
  DateTime? _birthDate;

  final List<String> _genderOptions = ['Homme', 'Femme'];
  final List<String> _maritalOptions = ['Célibataire', 'Marié(e)', 'Divorcé(e)', 'Veuf(ve)'];
  final List<String> _howKnownOptions = [
    'Invitation',
    'Évènement',
    'Réseaux sociaux',
    'Évangélisation',
    'Autre'
  ];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _firstNameController,
                  decoration: const InputDecoration(labelText: 'Prénom'),
                  validator: (value) =>
                      value?.isEmpty == true ? 'Prénom requis' : null,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: TextFormField(
                  controller: _lastNameController,
                  decoration: const InputDecoration(labelText: 'Nom'),
                  validator: (value) =>
                      value?.isEmpty == true ? 'Nom requis' : null,
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          DropdownButtonFormField<String>(
            value: _gender,
            decoration: const InputDecoration(labelText: 'Genre'),
            items: _genderOptions.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (value) => setState(() => _gender = value!),
          ),

          SizedBox(height: 16.h),

          TextFormField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              labelText: 'Téléphone',
              prefixIcon: Icon(Icons.phone),
            ),
            validator: (value) =>
                value?.isEmpty == true ? 'Téléphone requis' : null,
          ),

          SizedBox(height: 16.h),

          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _communeController,
                  decoration: const InputDecoration(labelText: 'Commune'),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: TextFormField(
                  controller: _quartierController,
                  decoration: const InputDecoration(labelText: 'Quartier'),
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _professionController,
                  decoration: const InputDecoration(labelText: 'Profession'),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _maritalStatus,
                  decoration: const InputDecoration(labelText: 'Statut marital'),
                  items: _maritalOptions.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) => setState(() => _maritalStatus = value!),
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          SwitchListTile(
            title: const Text('Première visite'),
            value: _isFirstVisit,
            onChanged: (value) => setState(() => _isFirstVisit = value),
            contentPadding: EdgeInsets.zero,
          ),

          SizedBox(height: 16.h),

          DropdownButtonFormField<String>(
            value: _howKnownChurch,
            decoration: const InputDecoration(labelText: 'Comment avez-vous connu l\'église ?'),
            items: _howKnownOptions.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (value) => setState(() => _howKnownChurch = value!),
          ),

          SizedBox(height: 16.h),

          TextFormField(
            controller: _prayerRequestController,
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: 'Besoin de prières (optionnel)',
              alignLabelWithHint: true,
            ),
          ),

          SizedBox(height: 32.h),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _handleSubmit,
              child: const Text('Enregistrer'),
            ),
          ),
        ],
      ),
    );
  }

  void _handleSubmit() {
    if (!_formKey.currentState!.validate()) return;

    final person = Person(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      gender: _gender,
      birthDate: _birthDate,
      phone: _phoneController.text.trim(),
      commune: _communeController.text.trim(),
      quartier: _quartierController.text.trim(),
      profession: _professionController.text.trim(),
      maritalStatus: _maritalStatus,
      isFirstVisit: _isFirstVisit,
      howKnownChurch: _howKnownChurch,
      prayerRequest: _prayerRequestController.text.trim(),
      status: 'A_VISITER',
      createdAt: DateTime.now(),
    );

    widget.onSubmit(person);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _communeController.dispose();
    _quartierController.dispose();
    _professionController.dispose();
    _prayerRequestController.dispose();
    super.dispose();
  }
}