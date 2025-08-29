# Plan de Construction UI - RuachConnect (KISS)

## 🎯 Objectif
Application mobile simple pour le recensement et suivi des nouveaux dans l'église Ruach.

## 📋 Étapes de Construction UI (Par Priorité)

### Phase 1 : Fondations (Priorité 1) 🟢
**Durée estimée : 3-5 jours**

#### 1.1 Setup de base
- [ ] Créer les styles globaux (`src/utils/styles.ts`)
- [ ] Configurer la navigation Stack (`src/navigation/AppNavigator.tsx`)
- [ ] Créer le contexte global (`src/contexts/AppContext.tsx`)

#### 1.2 Écrans essentiels
- [ ] Écran de connexion (`src/screens/LoginScreen.tsx`)
- [ ] Écran d'accueil principal (`src/screens/HomeScreen.tsx`)

#### 1.3 Module Accueil/Recensement (Priorité 1)
- [ ] Formulaire d'enregistrement rapide (`src/screens/NewPersonScreen.tsx`)
  - Nom, prénom, genre
  - Date naissance, contact, commune, quartier
  - Profession, statut marital
  - Première visite, comment connu l'église
  - Besoin prières, photo facultative
- [ ] Liste des nouveaux (`src/screens/NewcomersListScreen.tsx`)

### Phase 2 : Suivi des Âmes (Priorité 1) 🟢
**Durée estimée : 4-6 jours**

#### 2.1 Module de Suivi
- [ ] Attribution encadreur (`src/screens/AssignMentorScreen.tsx`)
- [ ] Écran de détail personne (`src/screens/PersonDetailScreen.tsx`)
- [ ] Gestion des statuts :
  - À visiter
  - En suivi  
  - Intégré(e)
  - A réorienter
  - Absent(e) prolongé(e)

#### 2.2 Suivi actif
- [ ] Écran dates visites/appels (`src/screens/FollowUpScreen.tsx`)
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
- [ ] Écran statistiques (`src/screens/StatsScreen.tsx`)
- [ ] Nouvelles personnes par période
- [ ] Répartition géographique
- [ ] Taux d'intégration
- [ ] Suiveurs actifs

#### 4.2 Export données
- [ ] Export Excel/PDF

### Phase 5 : Notifications (Priorité 1) 🟢
**Durée estimée : 2-3 jours**

#### 5.1 Système d'alertes
- [ ] Hook notifications (`src/hooks/useNotifications.tsx`)
- [ ] Alertes nouveaux à appeler
- [ ] Rappels visites en attente
- [ ] Relances automatiques après X jours

## 🏗️ Structure UI Simplifiée

### Composants Essentiels
```
src/components/
├── common/
│   ├── Button.tsx          # Bouton standard
│   ├── Input.tsx           # Input texte/sélection
│   ├── Card.tsx            # Carte conteneur
│   └── Modal.tsx           # Modal simple
├── forms/
│   ├── PersonForm.tsx      # Formulaire personne
│   └── FollowUpForm.tsx    # Formulaire suivi
└── lists/
    ├── PersonCard.tsx      # Carte personne
    └── StatCard.tsx        # Carte statistique
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

### Couleurs Église
```typescript
colors = {
  primary: '#1E3A8A',      // Bleu église
  secondary: '#3B82F6',    // Bleu plus clair
  accent: '#10B981',       // Vert pour succès
  warning: '#F59E0B',      // Orange alertes
  danger: '#EF4444',       // Rouge urgent
  white: '#FFFFFF',
  dark: '#1F2937',
  gray: '#6B7280'
}
```

## ⚡ Approche KISS

### Ce qu'on FAIT
- ✅ React Context pour state global
- ✅ Stack Navigator uniquement  
- ✅ Fetch natif pour API
- ✅ Styles centralisés
- ✅ Custom hooks pour logique

### Ce qu'on ÉVITE (pour l'instant)
- ❌ Redux/Zustand
- ❌ Navigation complexe (tabs, drawer)
- ❌ Styled-components
- ❌ Animations complexes
- ❌ Tests unitaires (focus MVP d'abord)

## 🚀 Ordre de Développement

1. **Semaine 1** : Setup + Écrans base + Recensement
2. **Semaine 2** : Module suivi + Attribution encadreurs  
3. **Semaine 3** : Gestion comptes + Statistiques
4. **Semaine 4** : Notifications + Polissage UI

**Principe** : Une fonctionnalité complète avant de passer à la suivante.