import React from 'react';
import { View, Text, StyleSheet, ScrollView, Dimensions } from 'react-native';
import { colors, spacing, fonts, borderRadius, shadows } from '../utils/styles';
import { useApp } from '../contexts/AppContext';

const { width } = Dimensions.get('window');

const HomeScreen = () => {
  const { user } = useApp();


  return (
    <ScrollView style={styles.container} showsVerticalScrollIndicator={false}>
      {/* Hero Header */}
      <View style={styles.heroSection}>
        <View style={styles.userInfo}>
          <Text style={styles.greeting}>Bonjour 👋</Text>
          <Text style={styles.userName}>{user?.name || 'Utilisateur'}</Text>
        </View>
        
        {/* Bento Grid Stats */}
        <View style={styles.bentoGrid}>
          <View style={styles.mainStat}>
            <Text style={styles.mainStatNumber}>127</Text>
            <Text style={styles.mainStatLabel}>Total Nouveaux</Text>
            <Text style={styles.mainStatSubtext}>+12 cette semaine</Text>
          </View>
          
          <View style={styles.gridRight}>
            <View style={styles.miniStat}>
              <Text style={styles.miniStatNumber}>8</Text>
              <Text style={styles.miniStatLabel}>En suivi</Text>
            </View>
            <View style={styles.miniStat}>
              <Text style={styles.miniStatNumber}>94%</Text>
              <Text style={styles.miniStatLabel}>Intégrés</Text>
            </View>
          </View>
        </View>
      </View>

      {/* Quick Actions - Modern Card Grid */}
      <View style={styles.actionsSection}>
        <Text style={styles.sectionTitle}>Actions</Text>
        
        <View style={styles.actionGrid}>
          <View style={[styles.actionCard, styles.primaryAction]}>
            <View style={styles.actionIcon}>
              <Text style={styles.actionIconText}>+</Text>
            </View>
            <Text style={styles.actionTitle}>Nouveau</Text>
            <Text style={styles.actionSubtitle}>Visiteur</Text>
          </View>

          <View style={styles.actionCard}>
            <Text style={styles.actionEmoji}>👥</Text>
            <Text style={styles.actionTitle}>Suivis</Text>
            <Text style={styles.actionSubtitle}>Mes personnes</Text>
          </View>

          <View style={styles.actionCard}>
            <Text style={styles.actionEmoji}>📈</Text>
            <Text style={styles.actionTitle}>Stats</Text>
            <Text style={styles.actionSubtitle}>Rapports</Text>
          </View>

          <View style={styles.actionCard}>
            <Text style={styles.actionEmoji}>🔔</Text>
            <Text style={styles.actionTitle}>Alertes</Text>
            <Text style={styles.actionSubtitle}>3 nouvelles</Text>
          </View>
        </View>
      </View>

      {/* Recent Activity - Glass Cards */}
      <View style={styles.activitySection}>
        <Text style={styles.sectionTitle}>Aujourd'hui</Text>
        
        <View style={styles.activityCard}>
          <View style={styles.activityDot} />
          <View style={styles.activityContent}>
            <Text style={styles.activityTitle}>3 nouveaux ajoutés</Text>
            <Text style={styles.activityTime}>Il y a 1h</Text>
          </View>
          <Text style={styles.activityBadge}>+3</Text>
        </View>

        <View style={styles.activityCard}>
          <View style={[styles.activityDot, { backgroundColor: colors.warning }]} />
          <View style={styles.activityContent}>
            <Text style={styles.activityTitle}>Visites à programmer</Text>
            <Text style={styles.activityTime}>5 personnes</Text>
          </View>
          <Text style={[styles.activityBadge, { backgroundColor: colors.warning }]}>!</Text>
        </View>
      </View>
    </ScrollView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#FAFBFC',
  },
  heroSection: {
    paddingHorizontal: spacing.lg,
    paddingTop: spacing.xl,
    paddingBottom: spacing.lg,
  },
  userInfo: {
    marginBottom: spacing.xl,
  },
  greeting: {
    fontSize: fonts.medium,
    color: colors.gray,
    fontWeight: '400',
  },
  userName: {
    fontSize: fonts.xlarge,
    fontWeight: '700',
    color: colors.dark,
    marginTop: spacing.xs,
  },
  bentoGrid: {
    flexDirection: 'row',
    height: 120,
    gap: spacing.md,
  },
  mainStat: {
    flex: 2,
    backgroundColor: colors.primary,
    borderRadius: borderRadius.xl,
    padding: spacing.lg,
    justifyContent: 'center',
  },
  mainStatNumber: {
    fontSize: 36,
    fontWeight: '800',
    color: colors.white,
    lineHeight: 40,
  },
  mainStatLabel: {
    fontSize: fonts.small,
    color: colors.white,
    opacity: 0.9,
    marginTop: spacing.xs,
  },
  mainStatSubtext: {
    fontSize: 11,
    color: colors.white,
    opacity: 0.7,
    marginTop: 2,
  },
  gridRight: {
    flex: 1,
    gap: spacing.md,
  },
  miniStat: {
    flex: 1,
    backgroundColor: colors.white,
    borderRadius: borderRadius.large,
    padding: spacing.md,
    justifyContent: 'center',
    alignItems: 'center',
    ...shadows.small,
  },
  miniStatNumber: {
    fontSize: fonts.large,
    fontWeight: '700',
    color: colors.primary,
  },
  miniStatLabel: {
    fontSize: 11,
    color: colors.gray,
    marginTop: 2,
  },
  actionsSection: {
    paddingHorizontal: spacing.lg,
    marginBottom: spacing.xl,
  },
  sectionTitle: {
    fontSize: fonts.large,
    fontWeight: '600',
    color: colors.dark,
    marginBottom: spacing.lg,
  },
  actionGrid: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: spacing.md,
  },
  actionCard: {
    width: (width - spacing.lg * 2 - spacing.md) / 2,
    backgroundColor: colors.white,
    borderRadius: borderRadius.xl,
    padding: spacing.lg,
    alignItems: 'center',
    aspectRatio: 1.2,
    justifyContent: 'center',
    ...shadows.small,
  },
  primaryAction: {
    backgroundColor: colors.accent,
  },
  actionIcon: {
    width: 40,
    height: 40,
    borderRadius: 20,
    backgroundColor: colors.white,
    justifyContent: 'center',
    alignItems: 'center',
    marginBottom: spacing.sm,
  },
  actionIconText: {
    fontSize: 24,
    fontWeight: 'bold',
    color: colors.accent,
  },
  actionEmoji: {
    fontSize: 32,
    marginBottom: spacing.sm,
  },
  actionTitle: {
    fontSize: fonts.medium,
    fontWeight: '600',
    color: colors.dark,
    textAlign: 'center',
  },
  actionSubtitle: {
    fontSize: fonts.small,
    color: colors.gray,
    textAlign: 'center',
    marginTop: spacing.xs,
  },
  activitySection: {
    paddingHorizontal: spacing.lg,
    paddingBottom: spacing.xl,
  },
  activityCard: {
    backgroundColor: colors.white,
    borderRadius: borderRadius.large,
    padding: spacing.md,
    marginBottom: spacing.sm,
    flexDirection: 'row',
    alignItems: 'center',
    ...shadows.small,
  },
  activityDot: {
    width: 12,
    height: 12,
    borderRadius: 6,
    backgroundColor: colors.accent,
    marginRight: spacing.md,
  },
  activityContent: {
    flex: 1,
  },
  activityTitle: {
    fontSize: fonts.medium,
    fontWeight: '500',
    color: colors.dark,
  },
  activityTime: {
    fontSize: fonts.small,
    color: colors.gray,
    marginTop: 2,
  },
  activityBadge: {
    backgroundColor: colors.accent,
    color: colors.white,
    fontSize: fonts.small,
    fontWeight: 'bold',
    paddingHorizontal: spacing.sm,
    paddingVertical: 4,
    borderRadius: 12,
    textAlign: 'center',
    minWidth: 24,
  },
});

export default HomeScreen;