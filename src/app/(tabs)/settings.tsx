import { StyleSheet, Text, View, ScrollView } from 'react-native';
import { LinearGradient } from 'expo-linear-gradient';
import { Card } from '@/components/Card';
import { NeonButton } from '@/components/NeonButton';
import * as Haptics from 'expo-haptics';
import { useState } from 'react';

export default function SettingsScreen() {
  const [resetting, setResetting] = useState(false);

  const handleReset = () => {
    Haptics.notificationAsync(Haptics.NotificationFeedbackType.Warning);
    setResetting(true);
    setTimeout(() => {
      setResetting(false);
      Haptics.notificationAsync(Haptics.NotificationFeedbackType.Success);
    }, 1500);
  };

  return (
    <LinearGradient colors={['#0A0B10', '#13151F']} style={styles.container}>
      <ScrollView contentContainerStyle={styles.scroll}>
        <Text style={styles.title}>Settings</Text>
        <Text style={styles.subtitle}>App Configuration</Text>
        
        <View style={styles.grid}>
          <Card title="Theme" value="Dark Futuristic" icon="color-palette-outline" width="100%" />
          <Card title="Haptics" value="Enabled" icon="radio-outline" />
          <Card title="Animations" value="Smooth" icon="aperture-outline" />
          <Card title="About" value="DNTWEAKS v1.0.0" icon="information-circle-outline" width="100%" />
        </View>

        <View style={{marginTop: 30}}>
          <NeonButton 
            title={resetting ? "RESETTING..." : "RESET DEFAULTS"} 
            onPress={handleReset} 
            disabled={resetting}
          />
        </View>
        <View style={{height: 100}} />
      </ScrollView>
    </LinearGradient>
  );
}

const styles = StyleSheet.create({
  container: { flex: 1 },
  scroll: { padding: 20, paddingTop: 60 },
  title: { fontSize: 32, fontWeight: 'bold', color: '#FFF', letterSpacing: 2 },
  subtitle: { fontSize: 16, color: '#00F0FF', marginBottom: 30, letterSpacing: 1 },
  grid: { flexDirection: 'row', flexWrap: 'wrap', justifyContent: 'space-between', marginTop: 10 }
});
