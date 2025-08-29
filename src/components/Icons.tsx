import React from 'react';
import { View, StyleSheet } from 'react-native';
import { colors } from '../utils/styles';

interface IconProps {
  size?: number;
  color?: string;
}

export const PlusIcon = ({ size = 24, color = colors.primary }: IconProps) => (
  <View style={[styles.iconContainer, { width: size, height: size }]}>
    <View style={[styles.plusHorizontal, { backgroundColor: color, width: size * 0.6, height: size * 0.125 }]} />
    <View style={[styles.plusVertical, { backgroundColor: color, width: size * 0.125, height: size * 0.6 }]} />
  </View>
);

export const UsersIcon = ({ size = 24, color = colors.primary }: IconProps) => (
  <View style={[styles.iconContainer, { width: size, height: size }]}>
    <View style={[styles.userCircle, { 
      width: size * 0.35, 
      height: size * 0.35, 
      borderColor: color,
      top: size * 0.1,
      left: size * 0.15 
    }]} />
    <View style={[styles.userCircle, { 
      width: size * 0.35, 
      height: size * 0.35, 
      borderColor: color,
      top: size * 0.1,
      right: size * 0.15 
    }]} />
    <View style={[styles.userBody, { 
      width: size * 0.5, 
      height: size * 0.3, 
      borderColor: color,
      bottom: size * 0.1 
    }]} />
    <View style={[styles.userBody, { 
      width: size * 0.5, 
      height: size * 0.3, 
      borderColor: color,
      bottom: size * 0.1,
      right: size * 0.1 
    }]} />
  </View>
);

export const ChartIcon = ({ size = 24, color = colors.primary }: IconProps) => (
  <View style={[styles.iconContainer, { width: size, height: size }]}>
    <View style={[styles.chartBar, { 
      backgroundColor: color, 
      width: size * 0.15, 
      height: size * 0.3,
      bottom: 0,
      left: size * 0.1 
    }]} />
    <View style={[styles.chartBar, { 
      backgroundColor: color, 
      width: size * 0.15, 
      height: size * 0.5,
      bottom: 0,
      left: size * 0.35 
    }]} />
    <View style={[styles.chartBar, { 
      backgroundColor: color, 
      width: size * 0.15, 
      height: size * 0.7,
      bottom: 0,
      left: size * 0.6 
    }]} />
    <View style={[styles.chartLine, { 
      backgroundColor: color, 
      width: size * 0.8, 
      height: 2,
      bottom: 0,
      left: size * 0.1 
    }]} />
  </View>
);

export const BellIcon = ({ size = 24, color = colors.primary }: IconProps) => (
  <View style={[styles.iconContainer, { width: size, height: size }]}>
    <View style={[styles.bellBody, { 
      width: size * 0.6, 
      height: size * 0.6, 
      borderColor: color,
      borderRadius: size * 0.3,
      top: size * 0.1 
    }]} />
    <View style={[styles.bellTop, { 
      width: size * 0.2, 
      height: size * 0.15, 
      backgroundColor: color,
      borderRadius: size * 0.05,
      top: size * 0.05,
      left: size * 0.4 
    }]} />
    <View style={[styles.bellBottom, { 
      width: size * 0.8, 
      height: 2, 
      backgroundColor: color,
      bottom: size * 0.15 
    }]} />
  </View>
);

const styles = StyleSheet.create({
  iconContainer: {
    position: 'relative',
    justifyContent: 'center',
    alignItems: 'center',
  },
  plusHorizontal: {
    position: 'absolute',
    borderRadius: 2,
  },
  plusVertical: {
    position: 'absolute',
    borderRadius: 2,
  },
  userCircle: {
    position: 'absolute',
    borderWidth: 2,
    borderRadius: 50,
  },
  userBody: {
    position: 'absolute',
    borderWidth: 2,
    borderTopLeftRadius: 50,
    borderTopRightRadius: 50,
  },
  chartBar: {
    position: 'absolute',
    borderRadius: 2,
  },
  chartLine: {
    position: 'absolute',
  },
  bellBody: {
    position: 'absolute',
    borderWidth: 2.5,
  },
  bellTop: {
    position: 'absolute',
  },
  bellBottom: {
    position: 'absolute',
  },
});