import React from 'react';
import { TouchableOpacity, View, Text, StyleSheet } from 'react-native';
import { colors, spacing, fonts, borderRadius, shadows } from '../utils/styles';

interface CardProps {
  title: string;
  subtitle?: string;
  onPress: () => void;
  icon?: string;
  color?: string;
}

const Card: React.FC<CardProps> = ({ 
  title, 
  subtitle, 
  onPress, 
  icon = '📋',
  color = colors.primary 
}) => {
  return (
    <TouchableOpacity style={styles.card} onPress={onPress}>
      <View style={[styles.iconContainer, { backgroundColor: color }]}>
        <Text style={styles.icon}>{icon}</Text>
      </View>
      <View style={styles.content}>
        <Text style={styles.title}>{title}</Text>
        {subtitle && <Text style={styles.subtitle}>{subtitle}</Text>}
      </View>
    </TouchableOpacity>
  );
};

const styles = StyleSheet.create({
  card: {
    backgroundColor: colors.white,
    borderRadius: borderRadius.large,
    padding: spacing.md,
    marginBottom: spacing.md,
    flexDirection: 'row',
    alignItems: 'center',
    ...shadows.small,
    borderWidth: 1,
    borderColor: colors.lightGray,
  },
  iconContainer: {
    width: 48,
    height: 48,
    borderRadius: borderRadius.medium,
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: spacing.md,
  },
  icon: {
    fontSize: 24,
  },
  content: {
    flex: 1,
  },
  title: {
    fontSize: fonts.medium,
    fontWeight: '600',
    color: colors.dark,
    marginBottom: spacing.xs,
  },
  subtitle: {
    fontSize: fonts.small,
    color: colors.gray,
  },
});

export default Card;