export const colors = {
  primary: '#1E3A8A',      // Bleu église
  secondary: '#3B82F6',    // Bleu plus clair
  accent: '#10B981',       // Vert pour succès
  success: '#10B981',      // Vert succès
  warning: '#F59E0B',      // Orange alertes
  danger: '#EF4444',       // Rouge urgent
  white: '#FFFFFF',
  dark: '#111827',         // Plus foncé pour meilleur contraste
  gray: '#6B7280',
  lightGray: '#F9FAFB',    // Plus doux
  mediumGray: '#E5E7EB',   // Nouvelle couleur pour borders
  background: '#F8FAFC',   // Fond plus moderne
  // Couleurs sémantiques
  text: {
    primary: '#111827',
    secondary: '#4B5563',
    tertiary: '#9CA3AF'
  },
  surface: {
    primary: '#FFFFFF',
    secondary: '#F9FAFB',
    tertiary: '#F3F4F6'
  },
  // Input colors
  inputBorder: '#E5E7EB',
  inputFocus: '#3B82F6',
  inputBg: 'rgba(255, 255, 255, 0.9)'
};

export const spacing = {
  xs: 4,
  sm: 8,
  md: 16,
  lg: 24,
  xl: 32,
  xxl: 48,
  xxxl: 64
};

export const fonts = {
  small: 12,
  medium: 16,
  large: 20,
  xlarge: 24,
  xxlarge: 28,
  weights: {
    regular: '400',
    medium: '500',
    semibold: '600',
    bold: '700',
    heavy: '800'
  }
};

export const borderRadius = {
  small: 4,
  medium: 8,
  large: 12,
  xl: 16,
  xxl: 20,
  round: 50
};

export const shadows = {
  none: {},
  soft: {
    shadowColor: '#000',
    shadowOffset: {
      width: 0,
      height: 1,
    },
    shadowOpacity: 0.05,
    shadowRadius: 3,
    elevation: 1,
  },
  small: {
    shadowColor: '#000',
    shadowOffset: {
      width: 0,
      height: 2,
    },
    shadowOpacity: 0.06,
    shadowRadius: 6,
    elevation: 2,
  },
  medium: {
    shadowColor: '#000',
    shadowOffset: {
      width: 0,
      height: 4,
    },
    shadowOpacity: 0.08,
    shadowRadius: 8,
    elevation: 4,
  },
  large: {
    shadowColor: '#000',
    shadowOffset: {
      width: 0,
      height: 8,
    },
    shadowOpacity: 0.1,
    shadowRadius: 16,
    elevation: 8,
  },
  card: {
    shadowColor: '#000',
    shadowOffset: {
      width: 0,
      height: 1,
    },
    shadowOpacity: 0.04,
    shadowRadius: 4,
    elevation: 1,
  }
};