# Commande - Analyse et développement RuachConnect

## Objectif
Analyser l'état actuel du projet RuachConnect, identifier la phase suivante selon PLAN-UI-KISS.md, proposer un plan de développement et l'implémenter.

## Instructions

**RESPECTER ABSOLUMENT** l'architecture Flutter existante et les conventions du projet.

### Format de commande
```
/analyze-and-develop
```

### 0. Analyse préalable OBLIGATOIRE
1. **Examiner `PLAN-UI-KISS.md`** pour identifier les phases développées et la prochaine à implémenter
2. **Vérifier `lib/`** pour voir l'état des controllers, providers, screens existants
3. **Observer `lib/models/`** pour comprendre la structure de données
4. **Regarder `lib/utils/`** pour identifier les helpers disponibles
5. **Vérifier `pubspec.yaml`** pour les dépendances installées
6. **Analyser les imports** dans les fichiers existants pour maintenir la cohérence

### RÈGLES STRICTES à respecter

#### ❌ NE JAMAIS faire :
- Ignorer les conventions existantes du projet
- Créer des structures différentes des fichiers existants
- Utiliser des dépendances non présentes dans pubspec.yaml
- Violer les principes KISS (Keep It Simple Stupid)
- Créer des fonctionnalités non demandées dans le cahier des charges
- Oublier les vérifications de permissions utilisateur

#### ✅ TOUJOURS faire :
- Suivre le pattern exact des fichiers existants (controllers, providers, screens)
- Réutiliser les mêmes imports et conventions de nommage
- Appliquer les permissions utilisateur avec UserRole.can*()
- Créer des UI sobres avec les couleurs ecclésiastiques
- Utiliser flutter_screenutil pour le responsive design
- Tester avec `flutter analyze` avant de terminer
- Respecter l'architecture MVC avec Riverpod
- Implémenter la gestion d'erreur avec try/catch et SnackBar

### Architecture de référence Flutter

#### Structure des providers
```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/model_name.dart';

class EntityNotifier extends StateNotifier<List<Entity>> {
  EntityNotifier() : super([]);
  
  void addEntity(Entity entity) {
    state = [...state, entity];
  }
  
  void updateEntity(Entity updatedEntity) {
    state = [
      for (final entity in state)
        if (entity.id == updatedEntity.id) updatedEntity else entity,
    ];
  }
}

final entityProvider = StateNotifierProvider<EntityNotifier, List<Entity>>((ref) {
  return EntityNotifier();
});
```

#### Structure des controllers
```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/provider_name.dart';
import '../utils/user_role_helper.dart';

class EntityController {
  final WidgetRef ref;

  EntityController(this.ref);

  void doAction(BuildContext context) {
    final user = ref.read(authProvider);
    if (user == null || !UserRole.canDoAction(user.type)) {
      _showPermissionDenied(context, 'Message d\'erreur approprié');
      return;
    }
    // Logique métier
  }

  void _showPermissionDenied(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.danger,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
```

#### Structure des screens
```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EntityScreen extends ConsumerWidget {
  const EntityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Titre')),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Contenu responsive avec .w .h .sp
          ],
        ),
      ),
    );
  }
}
```

### Structure des modèles
```dart
class Entity {
  final String id;
  final String name;
  final DateTime createdAt;

  Entity({
    required this.id,
    required this.name,
    required this.createdAt,
  });

  factory Entity.fromJson(Map<String, dynamic> json) {
    return Entity(
      id: json['id'],
      name: json['name'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
```

## Conventions du projet RuachConnect

- **State management** : Riverpod avec StateProvider et StateNotifierProvider
- **UI responsive** : flutter_screenutil avec .w .h .sp .r
- **Couleurs** : Schéma ecclésiastique sobre (AppColors)
- **Permissions** : UserRole helper avec vérifications systématiques
- **Navigation** : MaterialPageRoute avec controllers
- **Validation** : Méthodes de validation dans controllers
- **Gestion d'erreurs** : SnackBar pour feedback utilisateur
- **Architecture** : MVC avec separation controllers/, providers/, screens/

## Phases du développement (PLAN-UI-KISS.md)

### Phase 1 - Infrastructure ✅ COMPLÉTÉ
- 1.1 ✅ Configuration de base et styles
- 1.2 ✅ Authentification simple  
- 1.3 ✅ Écran d'accueil avec navigation

### Phase 2 - Gestion Nouveaux ✅ COMPLÉTÉ  
- 2.1 ✅ Module enregistrement nouveaux
- 2.2 ✅ Gestion statut et attribution encadreurs

### Phase 3 - Suivi Pastoral ✅ EN COURS
- 3.1 ✅ Système de permissions utilisateur
- 3.2 ✅ PROCHAINE PHASE - Gestion interactions et prières

### Phase 4 - Rapports et Export (À VENIR)
- 4.1 Module statistiques et rapports
- 4.2 Export données

### Phase 5 - Optimisations (À VENIR)
- 5.1 Performance et finalisation

## Processus de travail

### Étape 1 : Analyse complète
1. **Lire** PLAN-UI-KISS.md pour identifier la phase actuelle
2. **Vérifier** les todos existants et l'état du code
3. **Examiner** les fichiers récents pour comprendre les patterns
4. **Identifier** ce qui manque dans la phase courante ou suivante

### Étape 2 : Planification
- **Décomposer** la prochaine phase en tâches spécifiques
- **Créer** une todo list avec TodoWrite
- **Estimer** la complexité et les dépendances
- **Prioriser** les tâches par ordre logique

### Étape 3 : Implémentation
- **Suivre** l'architecture existante rigoureusement
- **Tester** chaque composant au fur et à mesure
- **Marquer** les todos completed immédiatement après terminer
- **Maintenir** la cohérence du code

### Étape 4 : Validation
- **Exécuter** `flutter analyze` pour vérifier la qualité du code
- **Corriger** toute erreur détectée
- **Tester** sur simulateur si nécessaire
- **Confirmer** que toutes les fonctionnalités marchent

## Spécificités RuachConnect

### Types d'utilisateurs et permissions
- **CAN** : Tous droits (Super Admin)
- **ACCUEIL** : Enregistrement + visualisation nouveaux
- **ENCADREUR** : Suivi pastoral de ses assignés 
- **PASTEUR** : Tous droits sauf technique

### Couleurs ecclésiastiques obligatoires
```dart
static const Color primary = Color(0xFF2C3E50);      // Bleu marine profond
static const Color secondary = Color(0xFF34495E);    // Gris-bleu sombre  
static const Color success = Color(0xFF27AE60);      // Vert olive
static const Color warning = Color(0xFFF39C12);      // Orange doré
static const Color danger = Color(0xFFE74C3C);       // Rouge bordeaux
static const Color accent = Color(0xFF8E44AD);       // Violet pourpre
```

### Modules obligatoires (selon cahier des charges)
1. **Authentification** multi-rôles
2. **Enregistrement** visiteurs avec formulaire complet
3. **Gestion statut** et attribution encadreurs
4. **Suivi pastoral** avec interactions (visite, appel, prière)
5. **Statistiques** et rapports
6. **Export** données

## Instructions de test final

Après chaque développement :

1. **Toujours exécuter** `flutter analyze`
2. **En cas d'erreur** : corriger immédiatement 
3. **Vérifier** que l'app compile et fonctionne
4. **Tester** les permissions utilisateur
5. **Confirmer** que l'UI respecte les couleurs sobres

Le processus n'est terminé que quand `flutter analyze` s'exécute sans erreur et que toutes les fonctionnalités de la phase sont opérationnelles.