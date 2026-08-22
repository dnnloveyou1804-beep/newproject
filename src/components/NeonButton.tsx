import { StyleSheet, Text, Pressable } from 'react-native';
import { LinearGradient } from 'expo-linear-gradient';

interface NeonButtonProps {
  title: string;
  onPress: () => void;
  disabled?: boolean;
}

export function NeonButton({ title, onPress, disabled = false }: NeonButtonProps) {
  return (
    <Pressable onPress={onPress} disabled={disabled} style={({ pressed }) => [
      styles.button,
      pressed && styles.pressed,
      disabled && styles.disabled
    ]}>
      <LinearGradient
        colors={disabled ? ['#2A2E3D', '#1A1D29'] : ['#00F0FF', '#0088FF']}
        start={{ x: 0, y: 0 }}
        end={{ x: 1, y: 0 }}
        style={styles.gradient}
      >
        <Text style={[styles.text, disabled && styles.textDisabled]}>{title}</Text>
      </LinearGradient>
    </Pressable>
  );
}

const styles = StyleSheet.create({
  button: {
    width: '100%',
    height: 60,
    borderRadius: 30,
    overflow: 'hidden',
    shadowColor: '#00F0FF',
    shadowOffset: { width: 0, height: 0 },
    shadowOpacity: 0.5,
    shadowRadius: 10,
    elevation: 5,
  },
  pressed: {
    opacity: 0.8,
    transform: [{ scale: 0.98 }],
  },
  disabled: {
    shadowOpacity: 0,
    elevation: 0,
  },
  gradient: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },
  text: {
    color: '#000',
    fontSize: 18,
    fontWeight: 'bold',
    letterSpacing: 2,
  },
  textDisabled: {
    color: '#5A606A',
  }
});
