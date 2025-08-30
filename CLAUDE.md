# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview
RuachConnect is a Flutter mobile application for church newcomer registration and follow-up management (French church context). This is an MVP focused on simplicity and core functionality rather than complex features.

## Development Commands

### Essential Commands
- `flutter run` - Run the app in development mode with hot reload
- `flutter run -d ios` - Run on iOS simulator
- `flutter run -d android` - Run on Android emulator
- `flutter test` - Run all widget tests
- `flutter analyze` - Run static analysis and linting
- `flutter clean` - Clean build artifacts
- `flutter pub get` - Install dependencies
- `flutter pub upgrade` - Update dependencies

### Build Commands
- `flutter build apk` - Build Android APK
- `flutter build ios` - Build iOS app (requires macOS/Xcode)

## Architecture

### Current State
This is a fresh Flutter project with standard boilerplate. The actual application architecture is planned but not yet implemented.

### Planned Architecture (from PLAN-UI-KISS.md)
The project follows a KISS (Keep It Simple Stupid) approach with:

**State Management**: Riverpod (simple, minimal usage following KISS principles)
**Navigation**: Stack Navigator only (no tabs/drawer initially)
**Networking**: Native fetch API calls
**Styling**: Centralized styles with ThemeData in `lib/utils/styles.dart`
**Code Organization**: Services for business logic

### Directory Structure
```
lib/
├── main.dart                   # App entry point with Riverpod setup
├── presentation/              # UI Layer
│   ├── screens/              # Full-screen pages
│   │   ├── login_screen.dart
│   │   ├── home_screen.dart
│   │   ├── new_person_screen.dart
│   │   ├── newcomers_list_screen.dart
│   │   ├── person_detail_screen.dart
│   │   ├── assign_mentor_screen.dart
│   │   ├── follow_up_screen.dart
│   │   └── stats_screen.dart
│   └── pages/                # Page components for complex screens
├── widgets/                  # Reusable UI Components
│   ├── common/              # Basic UI elements
│   │   ├── custom_button.dart
│   │   ├── custom_input.dart
│   │   ├── custom_card.dart
│   │   └── custom_modal.dart
│   ├── forms/               # Form-specific widgets
│   │   ├── person_form.dart
│   │   └── follow_up_form.dart
│   └── lists/               # List item widgets
│       ├── person_card.dart
│       └── stat_card.dart
├── controllers/             # Screen Logic & State Management
│   ├── login_controller.dart
│   ├── home_controller.dart
│   ├── newcomers_controller.dart
│   └── stats_controller.dart
├── providers/               # Riverpod State Providers
│   ├── auth_provider.dart   # Authentication state
│   ├── newcomers_provider.dart # Newcomers data
│   ├── users_provider.dart  # User management
│   └── stats_provider.dart  # Statistics data
├── services/                # Business Logic & API
│   ├── api_service.dart     # HTTP calls
│   ├── auth_service.dart    # Authentication logic
│   ├── database_service.dart # Local storage
│   └── notification_service.dart
├── models/                  # Data Models
│   ├── user.dart
│   ├── person.dart
│   ├── mentor.dart
│   └── stats.dart
├── utils/                   # Utilities & Helpers
│   ├── styles.dart          # Theme and colors
│   ├── constants.dart       # App constants
│   └── validators.dart      # Form validation
└── common/                  # Shared Code
    ├── constants/           # Global constants
    ├── extensions/          # Dart extensions
    └── helpers/             # Helper functions
```

## Directory Documentation

### `/presentation/` - UI Layer
**Purpose**: Contains all UI-related code following clean architecture
- `screens/`: Complete screen widgets (full-page views)
- `pages/`: Reusable page components for complex screens

### `/widgets/` - Reusable UI Components  
**Purpose**: Custom widgets used across multiple screens
- `common/`: Basic UI elements (buttons, inputs, cards)
- `forms/`: Form-specific widgets 
- `lists/`: List item and card widgets

### `/controllers/` - Screen Logic
**Purpose**: Business logic for each screen, handles user interactions
- Contains logic that coordinates between UI and services
- One controller per main screen for separation of concerns

### `/providers/` - Riverpod State Management
**Purpose**: Global state management using Riverpod
- Authentication state, data caching, app configuration
- Follow KISS principles: simple, focused providers only

### `/services/` - Business Logic & External APIs
**Purpose**: Core business logic and external integrations
- API calls, authentication logic, local storage
- Pure Dart classes independent of UI framework

### `/models/` - Data Models
**Purpose**: Data structure definitions
- User, Person, Mentor, Stats models
- JSON serialization/deserialization

### `/utils/` - Utilities & Helpers
**Purpose**: App-wide utilities and configuration
- Theming, constants, validation functions
- Pure functions with no side effects

### `/common/` - Shared Code
**Purpose**: Code shared across the entire app
- `constants/`: Global app constants
- `extensions/`: Dart language extensions
- `helpers/`: Utility functions

### Key Features (Planned)
1. **Newcomer Registration**: Simple form for church visitor registration
2. **Follow-up Management**: Track visitor status and assign mentors
3. **User Management**: Different account types (CAN committee, mentors, pastors)
4. **Statistics Dashboard**: Basic metrics and export functionality
5. **Notifications**: Reminders for follow-up visits

### Color Scheme (Ecclesiastical & Sober)
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
  
  // Neutres pour lisibilité
  static const Color background = Color(0xFFF8F9FA);   // Blanc cassé
  static const Color surface = Color(0xFFFFFFFF);      // Blanc pur
  static const Color onSurface = Color(0xFF212529);    // Noir doux
  static const Color onBackground = Color(0xFF495057); // Gris foncé
  static const Color divider = Color(0xFFDEE2E6);      // Gris très clair
}
```

### Responsive Design (Smartphone & Tablet)
```dart
class ResponsiveLayout {
  // Breakpoints pour responsive
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 1024;
  
  // Utilisation avec MediaQuery
  static bool isMobile(BuildContext context) => 
    MediaQuery.of(context).size.width < mobileBreakpoint;
    
  static bool isTablet(BuildContext context) => 
    MediaQuery.of(context).size.width >= mobileBreakpoint && 
    MediaQuery.of(context).size.width < tabletBreakpoint;
}
```

**Guidelines Tablet** :
- Layouts adaptatifs avec `LayoutBuilder`
- Navigation différente sur tablette (possibilité drawer/sidebar)
- Formulaires sur 2 colonnes sur tablette
- Listes avec plus de détails visibles

## Development Notes

### Current Status
- Fresh Flutter project with default counter app
- Directory structure created following clean architecture
- Riverpod installed for state management
- Development environment: Flutter 3.32.6 ready for iOS/Android

### Cahier des Charges Compliance
**Design & Ergonomie (Page 4 CDC)**:
- ✅ Interface simple et fluide (approche KISS implementée)
- ✅ Compatible smartphone et tablette (responsive design ajouté)
- ✅ Couleurs sobres ecclésiastiques (palette mise à jour)
- ✅ Utilisable par personnes peu techniques (UX simplifiée planifiée)

### Implementation Priority (from PLAN-UI-KISS.md)
1. **Phase 1**: Basic setup, login, and newcomer registration
2. **Phase 2**: Follow-up management and mentor assignment  
3. **Phase 3**: User management system
4. **Phase 4**: Statistics dashboard
5. **Phase 5**: Notification system

### State Management with Riverpod (KISS Approach)

**Installation**: `flutter pub add flutter_riverpod`

**KISS Usage Guidelines**:
- Use for **global state only**: user auth, data lists, app config
- Avoid for **local state**: form inputs, UI toggles, animations
- Keep providers **simple and focused** (one responsibility each)

**Provider Types to Use**:
- `StateProvider<T>` for simple values (user ID, settings)
- `StateNotifierProvider<N, T>` for lists and complex state
- `FutureProvider<T>` for API calls with caching

**Example Structure**:
```dart
// lib/providers/auth_provider.dart
final authProvider = StateProvider<User?>((ref) => null);

// lib/providers/newcomers_provider.dart  
final newcomersProvider = StateNotifierProvider<NewcomersNotifier, List<Person>>((ref) {
  return NewcomersNotifier();
});

// Usage in widgets
class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider);
    final newcomers = ref.watch(newcomersProvider);
    // Build UI...
  }
}
```

### Testing
- Uses standard Flutter testing framework
- Widget tests located in `test/` directory
- Run `flutter test` for all tests

### Code Quality
- Uses `flutter_lints` package for code standards
- Analysis options configured in `analysis_options.yaml`
- Run `flutter analyze` to check code quality