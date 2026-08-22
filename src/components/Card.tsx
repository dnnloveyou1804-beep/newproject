import { StyleSheet, Text, View } from 'react-native';
import { Ionicons } from '@expo/vector-icons';
import { BlurView } from 'expo-blur';

interface CardProps {
  title: string;
  value: string;
  icon: keyof typeof Ionicons.glyphMap;
  width?: '48%' | '100%';
}

export function Card({ title, value, icon, width = '48%' }: CardProps) {
  return (
    <View style={[styles.container, { width }]}>
      <BlurView intensity={20} tint="light" style={styles.blur}>
        <View style={styles.content}>
          <View style={styles.header}>
            <Ionicons name={icon} size={24} color="#00F0FF" />
            <Text style={styles.title}>{title}</Text>
          </View>
          <Text style={styles.value} numberOfLines={1} adjustsFontSizeToFit>{value}</Text>
        </View>
      </BlurView>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    marginBottom: 15,
    borderRadius: 20,
    overflow: 'hidden',
    borderWidth: 1,
    borderColor: '#2A2E3D',
    backgroundColor: 'rgba(26, 29, 41, 0.6)'
  },
  blur: {
    padding: 20,
  },
  content: {
    flex: 1,
  },
  header: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 10,
  },
  title: {
    color: '#A0AABF',
    fontSize: 14,
    marginLeft: 10,
    fontWeight: '500',
  },
  value: {
    color: '#FFF',
    fontSize: 20,
    fontWeight: 'bold',
  }
});
