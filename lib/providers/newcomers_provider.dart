import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/person.dart';
import '../common/constants/app_constants.dart';

final List<Person> _initialPersons = [
  Person(
    id: '1',
    firstName: 'Marie',
    lastName: 'Dubois',
    gender: 'F',
    phone: '0123456789',
    commune: 'Paris 15e',
    quartier: 'Beaugrenelle',
    birthDate: DateTime(1985, 3, 15),
    profession: 'Infirmière',
    maritalStatus: 'Célibataire',
    isFirstVisit: false,
    howKnownChurch: 'Invitation d\'un ami',
    prayerRequest: 'Pour ma famille',
    status: AppConstants.statusNew,
    createdAt: DateTime.now().subtract(const Duration(days: 7)),
  ),
  Person(
    id: '2',
    firstName: 'Jean',
    lastName: 'Martin',
    gender: 'M',
    phone: '0987654321',
    commune: 'Lyon 3e',
    quartier: 'Part-Dieu',
    birthDate: DateTime(1978, 8, 22),
    profession: 'Enseignant',
    maritalStatus: 'Marié',
    isFirstVisit: true,
    howKnownChurch: 'Recherche internet',
    prayerRequest: 'Pour mon travail',
    status: AppConstants.statusNew,
    createdAt: DateTime.now().subtract(const Duration(days: 3)),
  ),
];

class NewcomersNotifier extends StateNotifier<List<Person>> {
  NewcomersNotifier() : super(_initialPersons);

  void addPerson(Person person) {
    state = [...state, person];
  }

  void updatePerson(Person updatedPerson) {
    state = [
      for (final person in state)
        if (person.id == updatedPerson.id) updatedPerson else person,
    ];
  }

  void removePerson(String personId) {
    state = state.where((person) => person.id != personId).toList();
  }
}

final newcomersProvider = StateNotifierProvider<NewcomersNotifier, List<Person>>((ref) {
  return NewcomersNotifier();
});