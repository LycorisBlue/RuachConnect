class AppConstants {
  static const String appName = 'RuachConnect';
  static const String appVersion = '1.0.0';
  
  // Routes
  static const String loginRoute = '/login';
  static const String homeRoute = '/home';
  static const String newPersonRoute = '/new-person';
  static const String newcomersListRoute = '/newcomers';
  static const String personDetailRoute = '/person-detail';
  
  // User Types
  static const String userTypeCAN = 'CAN';
  static const String userTypeAccueil = 'ACCUEIL';
  static const String userTypeEncadreur = 'ENCADREUR';
  static const String userTypePasteur = 'PASTEUR';
  
  // Person Status
  static const String statusNew = 'NOUVEAU';
  static const String statusToVisit = 'A_VISITER';
  static const String statusInFollow = 'EN_SUIVI';
  static const String statusIntegrated = 'INTEGRE';
  static const String statusReorient = 'A_REORIENTER';
  static const String statusAbsent = 'ABSENT_PROLONGE';
  
  // Form Validation
  static const int minNameLength = 2;
  static const int maxNameLength = 50;
  static const String phoneRegex = r'^\+?[0-9]{8,15}$';
  
  // UI
  static const double designWidth = 375;
  static const double designHeight = 812;
}