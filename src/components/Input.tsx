import React from 'react';
import { TextInput, View, Text, StyleSheet, TextInputProps } from 'react-native';
import { colors, spacing, fonts, borderRadius } from '../utils/styles';

interface InputProps extends TextInputProps {
  label: string;
  error?: string;
  required?: boolean;
}

const Input: React.FC<InputProps> = ({ 
  label, 
  error, 
  required = false, 
  ...textInputProps 
}) => {
  return (
    <View style={styles.container}>
      <Text style={styles.label}>
        {label} {required && <Text style={styles.required}>*</Text>}
      </Text>
      <TextInput
        style={[
          styles.input,
          error ? styles.inputError : null
        ]}
        placeholderTextColor={colors.gray}
        {...textInputProps}
      />
      {error && (
        <Text style={styles.errorText}>{error}</Text>
      )}
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    marginBottom: spacing.md,
  },
  label: {
    fontSize: fonts.medium,
    color: colors.dark,
    marginBottom: spacing.xs,
    fontWeight: '500',
  },
  required: {
    color: colors.danger,
  },
  input: {
    borderWidth: 1,
    borderColor: colors.inputBorder,
    borderRadius: borderRadius.medium,
    paddingHorizontal: spacing.md,
    paddingVertical: spacing.md,
    fontSize: fonts.medium,
    backgroundColor: colors.white,
    minHeight: 52,
    color: colors.dark,
  },
  inputError: {
    borderColor: colors.danger,
  },
  errorText: {
    fontSize: fonts.small,
    color: colors.danger,
    marginTop: spacing.xs,
  },
});

export default Input;