# Plan de Construction UI - RuachConnect (KISS)

## 🎯 Objectif
Application mobile simple pour le recensement et suivi des nouveaux dans l'église Ruach.

## 📋 Étapes de Construction UI (Par Priorité)

### Phase 1 : Fondations (Priorité 1) 🟢
**Durée estimée : 3-5 jours**

#### 1.1 Setup de base
- [ ] Créer les styles globaux (`lib/utils/styles.dart`)
- [ ] Créer les constantes (`lib/common/constants/app_constants.dart`)
- [ ] Configurer Riverpod (`lib/main.dart`)
- [ ] Créer les modèles de base (`lib/models/`)

#### 1.2 Écrans essentiels
- [ ] Écran de connexion (`lib/presentation/screens/login_screen.dart`)
- [ ] Écran d'accueil principal (`lib/presentation/screens/home_screen.dart`)
- [ ] Contrôleurs correspondants (`lib/controllers/`)

#### 1.3 Module Accueil/Recensement (Priorité 1)
- [ ] Formulaire d'enregistrement rapide (`lib/presentation/screens/new_person_screen.dart`)
  - Nom, prénom, genre
  - Date naissance, contact, commune, quartier
  - Profession, statut marital
  - Première visite, comment connu l'église
  - Besoin prières, photo facultative
- [ ] Liste des nouveaux (`lib/presentation/screens/newcomers_list_screen.dart`)
- [ ] Widgets formulaire (`lib/widgets/forms/person_form.dart`)
- [ ] Contrôleur newcomers (`lib/controllers/newcomers_controller.dart`)

### Phase 2 : Suivi des Âmes (Priorité 1) 🟢
**Durée estimée : 4-6 jours**

#### 2.1 Module de Suivi
- [ ] Attribution encadreur (`lib/presentation/screens/assign_mentor_screen.dart`)
- [ ] Écran de détail personne (`lib/presentation/screens/person_detail_screen.dart`)
- [ ] Service de gestion statuts (`lib/services/person_status_service.dart`)
- [ ] Gestion des statuts :
  - À visiter, En suivi, Intégré(e), A réorienter, Absent(e) prolongé(e)

#### 2.2 Suivi actif
- [ ] Écran dates visites/appels (`lib/presentation/screens/follow_up_screen.dart`)
- [ ] Contrôleur suivi (`lib/controllers/follow_up_controller.dart`)
- [ ] Service historique (`lib/services/history_service.dart`)
- [ ] Notes de suivi encadreurs
- [ ] Historique des interactions

### Phase 3 : Gestion Utilisateurs (Priorité 1) 🟢
**Durée estimée : 2-3 jours**

#### 3.1 Types de comptes
- [ ] Comité d'Accueil des Nouveaux (CAN)
- [ ] Accueil général
- [ ] Encadreurs/responsables cellules
- [ ] Pasteurs

#### 3.2 Attribution automatique
- [ ] Système d'attribution nouveaux → suiveurs
- [ ] Interface de réattribution manuelle

### Phase 4 : Tableau de Bord (Priorité 1) 🟢
**Durée estimée : 3-4 jours**

#### 4.1 Statistiques essentielles
- [ ] Écran statistiques (`lib/presentation/screens/stats_screen.dart`)
- [ ] Contrôleur stats (`lib/controllers/stats_controller.dart`)
- [ ] Service statistiques (`lib/services/stats_service.dart`)
- [ ] Nouvelles personnes par période
- [ ] Répartition géographique
- [ ] Taux d'intégration
- [ ] Suiveurs actifs

#### 4.2 Export données
- [ ] Service export (`lib/services/export_service.dart`)
- [ ] Export Excel/PDF

### Phase 5 : Notifications (Priorité 1) 🟢
**Durée estimée : 2-3 jours**

#### 5.1 Système d'alertes
- [ ] Service notifications (`lib/services/notification_service.dart`)
- [ ] Alertes nouveaux à appeler
- [ ] Rappels visites en attente
- [ ] Relances automatiques après X jours

## 🏗️ Structure UI Simplifiée

### Architecture des Dossiers
```
lib/
├── presentation/               # Couche UI
│   ├── screens/               # Écrans complets
│   └── pages/                 # Composants de page
├── widgets/                   # Composants UI réutilisables
│   ├── common/               # Éléments de base
│   ├── forms/                # Widgets formulaire
│   └── lists/                # Widgets de liste
├── controllers/              # Logique des écrans
├── providers/                # État global Riverpod
├── services/                 # Logique métier & API
├── models/                   # Modèles de données
├── utils/                    # Utilitaires & thème
└── common/                   # Code partagé
    ├── constants/
    ├── extensions/
    └── helpers/
```

### Navigation Simple
```
MainStack:
├── Login
├── Home
├── NewPerson
├── NewcomersList  
├── PersonDetail
├── Stats
└── Profile
```

## 🎨 Charte Graphique KISS

### Couleurs Sobres (Cahier des Charges)
```dart
class AppColors {
  // Couleurs principales sobres pour contexte ecclésiastique
  static const Color primary = Color(0xFF2C3E50);      // Bleu marine profond
  static const Color secondary = Color(0xFF34495E);    // Gris-bleu sombre
  static const Color accent = Color(0xFF5D6D7E);       // Gris-bleu moyen
  
  // Couleurs fonctionnelles discrètes
  static const Color success = Color(0xFF27AE60);      // Vert discret
  static const Color warning = Color(0xFFE67E22);      // Orange sobre
  static const Color danger = Color(0xFFE74C3C);       // Rouge modéré
  
  // Neutres ecclésiastiques
  static const Color background = Color(0xFFF8F9FA);   // Blanc cassé
  static const Color surface = Color(0xFFFFFFFF);      // Blanc pur
  static const Color onSurface = Color(0xFF212529);    // Texte principal
}
```

## ⚡ Approche KISS

### Ce qu'on FAIT
- ✅ Riverpod pour state management simple
- ✅ Navigator 2.0 avec routes simples
- ✅ HTTP package pour API
- ✅ Styles centralisés avec ThemeData
- ✅ Services Dart pour logique métier
- ✅ Design responsive (smartphone + tablette)
- ✅ Couleurs sobres ecclésiastiques

### Ce qu'on ÉVITE (pour l'instant)
- ❌ Bloc pattern complexe
- ❌ Navigation complexe (BottomNavigationBar, Drawer)
- ❌ Packages UI externes (GetX, etc.)
- ❌ Animations complexes
- ❌ Tests unitaires (focus MVP d'abord)

## 🚀 Ordre de Développement

1. **Semaine 1** : Setup + Écrans base + Recensement
2. **Semaine 2** : Module suivi + Attribution encadreurs  
3. **Semaine 3** : Gestion comptes + Statistiques
4. **Semaine 4** : Notifications + Polissage UI

**Principe** : Une fonctionnalité complète avant de passer à la suivante.

## 🔧 Guide Riverpod KISS

### Quand utiliser Riverpod
- ✅ **État global simple** : Utilisateur connecté, configuration app
- ✅ **Listes de données** : Nouveaux, encadreurs, statistiques
- ✅ **Formulaires complexes** : Quand state local devient trop lourd
- ✅ **Cache API** : Éviter les appels redondants

### Quand NE PAS utiliser Riverpod
- ❌ **État local simple** : Compteurs, switches, animations
- ❌ **Navigation state** : Utiliser Navigator directement
- ❌ **Formulaires simples** : TextEditingController suffisant

### Structure Riverpod recommandée
```dart
lib/providers/
├── auth_provider.dart          # Authentification
├── newcomers_provider.dart     # Gestion nouveaux
├── users_provider.dart         # Gestion utilisateurs
└── stats_provider.dart         # Statistiques

// Exemple provider simple
final newcomersProvider = StateNotifierProvider<NewcomersNotifier, List<Person>>((ref) {
  return NewcomersNotifier();
});

// Utilisation dans widget
class NewcomersScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newcomers = ref.watch(newcomersProvider);
    return ListView.builder(...);
  }
}
```

### Règles KISS pour Riverpod
1. **Un provider = une responsabilité** (pas de mega-providers)
2. **StateNotifier pour listes**, **StateProvider pour valeurs simples**
3. **Pas de providers imbriqués** complexes
4. **Pas de combinaisons** multiples (keep it simple)
5. **AsyncValue uniquement** pour les appels API

## 📁 Guide des Dossiers

### `presentation/` - Interface Utilisateur
- **screens/**: Écrans complets avec Scaffold
- **pages/**: Composants de page pour écrans complexes

### `controllers/` - Logique des Écrans
- Logique spécifique à chaque écran
- Coordination entre UI et services
- Gestion des interactions utilisateur

### `widgets/` - Composants Réutilisables
- **common/**: Boutons, inputs, cartes de base
- **forms/**: Widgets spécifiques aux formulaires
- **lists/**: Éléments de liste personnalisés

### `providers/` - État Global
- Providers Riverpod pour données partagées
- Authentification, cache, configuration

### `services/` - Logique Métier
- Appels API, authentification
- Stockage local, notifications
- Logique métier pure

### `models/` - Structures de Données
- Classes de données avec JSON
- User, Person, Mentor, Stats

### `utils/` - Utilitaires
- Thème, constantes, validations
- **ResponsiveLayout** pour gestion tablette/mobile
- Fonctions helper globales

### `common/` - Code Partagé
- **constants/**: Constantes app
- **extensions/**: Extensions Dart
- **helpers/**: Fonctions utilitaires

## 📱 Exigences Cahier des Charges

### Design & Ergonomie (Priorité 1)
- ✅ **Interface simple et fluide** (approche KISS)
- ✅ **Compatible smartphone et tablette** (responsive design)
- ✅ **Couleurs sobres** adaptées à l'univers ecclésiastique
- ✅ **Utilisable par personnes peu techniques** (UX simplifiée)

### Architecture Responsive
```dart
// Adaptation automatique mobile/tablette
Widget build(BuildContext context) {
  return ResponsiveLayout.isTablet(context) 
    ? TabletLayout() 
    : MobileLayout();
}
```