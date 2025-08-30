import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/follow_up.dart';
import '../models/person.dart';
import '../providers/follow_ups_provider.dart';
import '../presentation/screens/follow_up_screen.dart';

class FollowUpController {
  final WidgetRef ref;

  FollowUpController(this.ref);

  void addFollowUp(FollowUp followUp) {
    ref.read(followUpsProvider.notifier).addFollowUp(followUp);
  }

  List<FollowUp> getFollowUpsForPerson(String personId) {
    return ref.read(followUpsProvider.notifier).getFollowUpsForPerson(personId);
  }

  void goToFollowUpScreen(BuildContext context, Person person) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => FollowUpScreen(person: person),
      ),
    );
  }

  int getInteractionCount(String personId) {
    return ref.read(followUpsProvider.notifier).getFollowUpsForPerson(personId).length;
  }

  FollowUp? getLastInteraction(String personId) {
    final interactions = ref.read(followUpsProvider.notifier).getFollowUpsForPerson(personId);
    return interactions.isNotEmpty ? interactions.first : null;
  }
}