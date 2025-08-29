# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

RuachConnect is a React Native application (v0.81.1) built for iOS and Android platforms. The project follows a simple KISS (Keep It Simple, Stupid) architecture principle as outlined in `architecture.md`.

## Development Commands

### Setup
- **iOS dependencies**: `bundle exec pod install` (run from root after `bundle install`)
- **Start Metro server**: `npm start`
- **Run iOS**: `npm run ios`
- **Run Android**: `npm run android`

### Development
- **Lint**: `npm run lint` (ESLint)
- **Test**: `npm test` (Jest)

## Architecture Guidelines

### Folder Structure (from architecture.md)
The project follows a simple 20/80 principle structure:
- `src/screens/` - All application screens
- `src/components/` - Reusable UI components
- `src/hooks/` - Custom hooks for business logic
- `src/utils/` - Utility functions, constants, API helpers
- `src/navigation/` - Navigation configuration

**Note**: The `src/` directory doesn't exist yet - the project is currently using the default React Native structure with `App.tsx` in root.

### State Management
- Use React Context API + useState (no Redux/Zustand initially)
- Custom hooks for reusable business logic

### Navigation
- Stack Navigator only (keep it simple)
- Use `@react-navigation/native` and `@react-navigation/stack`

### Styling
- Single global styles file approach (`utils/styles.ts`)
- Define colors, spacing, fonts in centralized constants
- Use StyleSheet.create for component styles

### API Layer
- Centralized API utilities using native fetch
- No complex libraries like GraphQL/Apollo initially

## Key Dependencies

### Production
- `react`: 19.1.0
- `react-native`: 0.81.1
- `react-native-safe-area-context`: ^5.5.2 (already installed)

### Development
- TypeScript configuration extends `@react-native/typescript-config`
- ESLint configuration extends `@react-native/eslint-config`
- Jest for testing with `react-native` preset

## Platform-Specific Notes

### iOS
- Uses CocoaPods for dependency management
- Requires `bundle exec pod install` after native dependency changes
- Swift-based iOS project structure

### Android
- Uses Gradle build system
- Standard React Native Android setup

## Current State

The project is in initial setup phase with:
- Default React Native App.tsx using NewAppScreen component
- Basic iOS/Android project structure
- No custom src/ folder structure yet (follows architecture.md recommendations)