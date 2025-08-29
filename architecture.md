# Architecture React Native Simple (Principe KISS)

## 📁 Structure de dossiers (20% qui fait 80%)

```
src/
├── screens/          # Tous vos écrans
│   ├── HomeScreen.tsx
│   ├── ProfileScreen.tsx
│   └── LoginScreen.tsx
├── components/       # Composants réutilisables
│   ├── Button.tsx
│   ├── Input.tsx
│   └── Card.tsx
├── hooks/           # Logique métier (custom hooks)
│   ├── useAuth.tsx
│   ├── useAPI.tsx
│   └── useStorage.tsx
├── utils/           # Fonctions utilitaires
│   ├── constants.ts
│   ├── helpers.ts
│   └── api.ts
└── navigation/      # Navigation
    └── AppNavigator.tsx
```

## 🎯 Règles d'or KISS

### 1. **Un seul state manager : React Context + useState**
```typescript
// contexts/AppContext.tsx
const AppContext = createContext();

export const AppProvider = ({ children }) => {
  const [user, setUser] = useState(null);
  const [loading, setLoading] = useState(false);
  
  return (
    <AppContext.Provider value={{ user, setUser, loading, setLoading }}>
      {children}
    </AppContext.Provider>
  );
};
```

### 2. **Navigation simple : Stack Navigator uniquement**
```typescript
// navigation/AppNavigator.tsx
import { createStackNavigator } from '@react-navigation/stack';

const Stack = createStackNavigator();

export const AppNavigator = () => (
  <Stack.Navigator>
    <Stack.Screen name="Home" component={HomeScreen} />
    <Stack.Screen name="Profile" component={ProfileScreen} />
  </Stack.Navigator>
);
```

### 3. **Styling : Un seul fichier de styles globaux**
```typescript
// utils/styles.ts
export const colors = {
  primary: '#007AFF',
  secondary: '#5856D6',
  success: '#34C759',
  danger: '#FF3B30',
  white: '#FFFFFF',
  black: '#000000',
  gray: '#8E8E93'
};

export const spacing = {
  xs: 4,
  sm: 8,
  md: 16,
  lg: 24,
  xl: 32
};

export const fonts = {
  small: 12,
  medium: 16,
  large: 20,
  xlarge: 24
};
```

### 4. **API : Un seul fichier avec fetch**
```typescript
// utils/api.ts
const BASE_URL = 'https://api.votreapp.com';

export const api = {
  get: async (endpoint: string) => {
    const response = await fetch(`${BASE_URL}${endpoint}`);
    return response.json();
  },
  
  post: async (endpoint: string, data: any) => {
    const response = await fetch(`${BASE_URL}${endpoint}`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(data)
    });
    return response.json();
  }
};
```

### 5. **Custom Hooks : Logique réutilisable**
```typescript
// hooks/useAuth.tsx
export const useAuth = () => {
  const [user, setUser] = useState(null);
  const [loading, setLoading] = useState(false);

  const login = async (email: string, password: string) => {
    setLoading(true);
    try {
      const userData = await api.post('/login', { email, password });
      setUser(userData);
    } catch (error) {
      console.error('Login failed:', error);
    } finally {
      setLoading(false);
    }
  };

  const logout = () => setUser(null);

  return { user, login, logout, loading };
};
```

## 🚀 Template d'écran standard

```typescript
// screens/HomeScreen.tsx
import React from 'react';
import { View, Text, StyleSheet } from 'react-native';
import { colors, spacing, fonts } from '../utils/styles';

const HomeScreen = () => {
  return (
    <View style={styles.container}>
      <Text style={styles.title}>Accueil</Text>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: spacing.md,
    backgroundColor: colors.white,
  },
  title: {
    fontSize: fonts.large,
    fontWeight: 'bold',
    color: colors.black,
    marginBottom: spacing.md,
  }
});

export default HomeScreen;
```

## 📦 Dépendances essentielles (maximum 5)

```json
{
  "@react-navigation/native": "^6.1.0",
  "@react-navigation/stack": "^6.3.0",
  "react-native-screens": "^3.25.0",
  "react-native-safe-area-context": "^4.7.0",
  "react-native-async-storage": "^1.19.0"
}
```

## 🎯 Principe 80/20 en action

**20% d'efforts qui donnent 80% de résultats :**
- ✅ Context API pour le state global
- ✅ Stack Navigator simple
- ✅ Custom hooks pour la logique
- ✅ Un fichier de styles global
- ✅ API centralisée avec fetch

**Éviter (complexité inutile) :**
- ❌ Redux/Zustand au début
- ❌ Multiple navigators complexes
- ❌ Styled-components
- ❌ GraphQL/Apollo
- ❌ Tests unitaires au début

## 🚀 Commencer maintenant

1. Créez la structure de dossiers
2. Configurez Context + Navigation
3. Créez vos premiers écrans
4. Ajoutez des features une par une

**Simple, efficace, évolutif !**