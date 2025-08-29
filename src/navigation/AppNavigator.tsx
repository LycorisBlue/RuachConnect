import React from 'react';
import { createStackNavigator } from '@react-navigation/stack';
import { useApp } from '../contexts/AppContext';
import LoginScreen from '../screens/LoginScreen';
import HomeScreen from '../screens/HomeScreen';

const Stack = createStackNavigator();

export const AppNavigator = () => {
  const { user } = useApp();

  return (
    <Stack.Navigator
      initialRouteName={user ? "Home" : "Login"}
      screenOptions={{
        headerStyle: {
          backgroundColor: '#1E3A8A',
        },
        headerTintColor: '#FFFFFF',
        headerTitleStyle: {
          fontWeight: 'bold',
        },
      }}
    >
      {!user ? (
        <Stack.Screen 
          name="Login" 
          component={LoginScreen}
          options={{ 
            title: 'Connexion',
            headerShown: false 
          }}
        />
      ) : (
        <Stack.Screen 
          name="Home" 
          component={HomeScreen}
          options={{ title: 'RuachConnect' }}
        />
      )}
    </Stack.Navigator>
  );
};