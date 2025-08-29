import React, { useState } from 'react';
import { 
  View, 
  Text, 
  StyleSheet, 
  Alert, 
  KeyboardAvoidingView, 
  Platform, 
  ScrollView,
} from 'react-native';
import { colors, spacing, fonts, shadows } from '../utils/styles';
import { useApp } from '../contexts/AppContext';
import Button from '../components/Button';
import Input from '../components/Input';


const LoginScreen = () => {
  const { setUser, loading, setLoading } = useApp();
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');

  const handleLogin = async () => {
    if (!email || !password) {
      Alert.alert('Erreur', 'Veuillez remplir tous les champs');
      return;
    }

    setLoading(true);
    
    try {
      // Simulation connexion (à remplacer par vraie API)
      setTimeout(() => {
        setUser({
          id: '1',
          name: 'Utilisateur Test',
          role: 'CAN'
        });
        setLoading(false);
      }, 1000);
    } catch (error) {
      setLoading(false);
      Alert.alert('Erreur', 'Connexion échouée');
    }
  };

  return (
    <KeyboardAvoidingView 
      style={styles.container}
      behavior={Platform.OS === 'ios' ? 'padding' : 'height'}
    >
      <ScrollView 
        contentContainerStyle={styles.scrollContainer}
        showsVerticalScrollIndicator={false}
      >
        {/* Header with logo */}
        <View style={styles.header}>
          <View style={styles.logoContainer}>
            <Text style={styles.logoText}>R</Text>
          </View>
          
          <Text style={styles.title}>RuachConnect</Text>
          <Text style={styles.subtitle}>
            Connectez-vous pour continuer
          </Text>
        </View>

        {/* Form section */}
        <View style={styles.form}>
          <Input
            label="Email"
            value={email}
            onChangeText={setEmail}
            keyboardType="email-address"
            autoCapitalize="none"
            required
            placeholder="exemple@email.com"
          />

          <Input
            label="Mot de passe"
            value={password}
            onChangeText={setPassword}
            secureTextEntry
            required
            placeholder="Entrez votre mot de passe"
          />

          <Button
            title="Se connecter"
            onPress={handleLogin}
            loading={loading}
          />
        </View>

        {/* Footer */}
        <View style={styles.footer}>
          <Text style={styles.footerText}>
            Première connexion ? Contactez votre administrateur
          </Text>
        </View>
      </ScrollView>
    </KeyboardAvoidingView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: colors.white,
  },
  scrollContainer: {
    flexGrow: 1,
    justifyContent: 'center',
    paddingVertical: spacing.xl,
    paddingHorizontal: spacing.lg,
  },
  header: {
    alignItems: 'center',
    marginBottom: spacing.xxl,
  },
  logoContainer: {
    width: 80,
    height: 80,
    borderRadius: 40,
    backgroundColor: colors.primary,
    justifyContent: 'center',
    alignItems: 'center',
    marginBottom: spacing.xl,
    ...shadows.medium,
  },
  logoText: {
    fontSize: 32,
    fontWeight: 'bold',
    color: colors.white,
  },
  title: {
    fontSize: fonts.xxlarge,
    fontWeight: '700',
    color: colors.primary,
    textAlign: 'center',
    marginBottom: spacing.sm,
    letterSpacing: 0.5,
  },
  subtitle: {
    fontSize: fonts.medium,
    color: colors.gray,
    textAlign: 'center',
    fontWeight: '400',
  },
  form: {
    marginTop: spacing.xl,
    marginBottom: spacing.xl,
  },
  footer: {
    alignItems: 'center',
    marginTop: spacing.lg,
  },
  footerText: {
    fontSize: fonts.small,
    color: colors.gray,
    textAlign: 'center',
    fontStyle: 'italic',
  },
});

export default LoginScreen;