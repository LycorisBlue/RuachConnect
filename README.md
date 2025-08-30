# RuachConnect

Application mobile Flutter pour le recensement et suivi des nouveaux dans l'église Ruach.

## 🎯 Objectif

Application simple et efficace permettant de :
- Enregistrer les nouveaux visiteurs de l'église
- Assigner des encadreurs pour le suivi pastoral
- Suivre le processus d'intégration
- Générer des statistiques et rapports

## 🚀 Démarrage Rapide

### Prérequis
- Flutter 3.32+ 
- Dart 3.8+
- Android Studio / Xcode pour les simulateurs

### Installation
```bash
# Cloner le projet
git clone [repository-url]
cd ruachconnect

# Installer les dépendances
flutter pub get

# Lancer sur simulateur
flutter run -d ios        # iOS
flutter run -d android    # Android
```

## 🏗️ Architecture

### Approche KISS (Keep It Simple Stupid)
- **State Management**: Riverpod (minimal, ciblé)
- **Navigation**: Stack Navigator simple
- **API**: HTTP package natif
- **Styling**: ThemeData centralisé
- **Tests**: Focus sur l'essentiel

### Structure des Dossiers

#### `/presentation/` - Couche UI
- `screens/`: Écrans complets de l'application
- `pages/`: Composants de page réutilisables

#### `/widgets/` - Composants UI Réutilisables
- `common/`: Éléments UI de base (boutons, inputs)
- `forms/`: Widgets spécifiques aux formulaires
- `lists/`: Widgets d'éléments de liste

#### `/controllers/` - Logique des Écrans
- Logique métier pour chaque écran
- Coordination entre UI et services
- Un contrôleur par écran principal

#### `/providers/` - Gestion d'État Riverpod
- État global : authentification, cache données
- Providers simples et focalisés (principe KISS)

#### `/services/` - Logique Métier & APIs
- Appels API et authentification
- Logique métier pure (indépendante de l'UI)
- Stockage local et notifications

#### `/models/` - Modèles de Données
- Structures de données (User, Person, Mentor, Stats)
- Sérialisation/désérialisation JSON

#### `/utils/` - Utilitaires
- Thème et couleurs de l'app
- Constantes globales
- Fonctions de validation

#### `/common/` - Code Partagé
- Constantes globales
- Extensions Dart
- Fonctions utilitaires

## 🎨 Charte Graphique

### Couleurs Sobres (Contexte Ecclésiastique)
```dart
primary: #2C3E50      // Bleu marine profond
secondary: #34495E    // Gris-bleu sombre
accent: #5D6D7E       // Gris-bleu moyen
success: #27AE60      // Vert discret
warning: #E67E22      // Orange sobre
danger: #E74C3C       // Rouge modéré
```

### Design Responsive
**Compatible smartphone et tablette** selon cahier des charges :
- Breakpoints : Mobile (<600px), Tablet (600-1024px)
- Layouts adaptatifs avec `LayoutBuilder`
- Navigation adaptée selon la taille d'écran
- Formulaires 1 colonne (mobile) / 2 colonnes (tablette)

## 🔧 Commandes de Développement

```bash
# Tests et qualité
flutter test                 # Tous les tests
flutter analyze             # Analyse statique
flutter pub outdated        # Dépendances obsolètes

# Build
flutter build apk           # Build Android
flutter build ios          # Build iOS

# Utilitaires
flutter clean              # Nettoyer le cache
flutter pub upgrade        # Mettre à jour les dépendances
```
