import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../widgets/forms/person_form.dart';
import '../../providers/newcomers_provider.dart';
import '../../models/person.dart';

class NewPersonScreen extends ConsumerWidget {
  const NewPersonScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nouveau Visiteur'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: PersonForm(
          onSubmit: (person) {
            ref.read(newcomersProvider.notifier).addPerson(person);
            
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Visiteur enregistré avec succès')),
            );
            
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}