import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/follow_up.dart';

class FollowUpsNotifier extends StateNotifier<List<FollowUp>> {
  FollowUpsNotifier() : super([]);

  void addFollowUp(FollowUp followUp) {
    state = [...state, followUp];
  }

  List<FollowUp> getFollowUpsForPerson(String personId) {
    return state
        .where((followUp) => followUp.personId == personId)
        .toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }

  void removeFollowUp(String followUpId) {
    state = state.where((followUp) => followUp.id != followUpId).toList();
  }
}

final followUpsProvider = StateNotifierProvider<FollowUpsNotifier, List<FollowUp>>((ref) {
  return FollowUpsNotifier();
});