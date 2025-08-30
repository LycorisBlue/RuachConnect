import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../widgets/lists/person_card.dart';
import '../../providers/newcomers_provider.dart';
import '../../utils/styles.dart';
import 'new_person_screen.dart';
import 'person_detail_screen.dart';

class NewcomersListScreen extends ConsumerWidget {
  const NewcomersListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newcomers = ref.watch(newcomersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nouveaux Visiteurs'),
      ),
      body: newcomers.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: newcomers.length,
              itemBuilder: (context, index) {
                final person = newcomers[index];
                return PersonCard(
                  person: person,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => PersonDetailScreen(person: person),
                      ),
                    );
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const NewPersonScreen(),
            ),
          );
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.people_outline,
            size: 64,
            color: AppColors.accent,
          ),
          const SizedBox(height: 16),
          Text(
            'Aucun visiteur enregistré',
            style: AppTextStyles.h2,
          ),
          const SizedBox(height: 8),
          Text(
            'Appuyez sur + pour ajouter le premier visiteur',
            style: AppTextStyles.caption,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}