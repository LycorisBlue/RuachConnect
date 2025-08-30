import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/person.dart';
import '../providers/newcomers_provider.dart';
import '../presentation/screens/new_person_screen.dart';
import '../presentation/screens/newcomers_list_screen.dart';

class NewcomersController {
  final WidgetRef ref;

  NewcomersController(this.ref);

  void addPerson(Person person) {
    ref.read(newcomersProvider.notifier).addPerson(person);
  }

  void updatePersonStatus(String personId, String newStatus) {
    final newcomers = ref.read(newcomersProvider);
    final person = newcomers.firstWhere((p) => p.id == personId);
    
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
      status: newStatus,
      assignedMentorId: person.assignedMentorId,
      createdAt: person.createdAt,
    );

    ref.read(newcomersProvider.notifier).updatePerson(updatedPerson);
  }

  void goToNewPersonScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const NewPersonScreen()),
    );
  }

  void goToNewcomersListScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const NewcomersListScreen()),
    );
  }

  List<Person> getNewcomers() {
    return ref.read(newcomersProvider);
  }
}