import { StyleSheet, Text, View, ScrollView, Switch } from 'react-native';
import { LinearGradient } from 'expo-linear-gradient';
import { useState } from 'react';
import * as Haptics from 'expo-haptics';
import { Card } from '@/components/Card';

export default function GamingScreen() {
  const [gamingMode, setGamingMode] = useState(false);

  const toggleGamingMode = (val: boolean) => {
    setGamingMode(val);
    if(val) {
      Haptics.notificationAsync(Haptics.NotificationFeedbackType.Success);
    } else {
      Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Light);
    }
  };

  return (
    <LinearGradient colors={['#0A0B10', '#13151F']} style={styles.container}>
      <ScrollView contentContainerStyle={styles.scroll}>
        <Text style={styles.title}>Gaming Mode</Text>
        <Text style={styles.subtitle}>Max Performance</Text>
        
        <View style={styles.switchContainer}>
          <Text style={styles.switchLabel}>Enable Gaming Mode</Text>
          <Switch 
            value={gamingMode} 
            onValueChange={toggleGamingMode} 
            trackColor={{ false: '#2A2E3D', true: '#00F0FF' }}
            thumbColor={gamingMode ? '#FFF' : '#A0AABF'}
          />
        </View>

        {gamingMode && (
          <View style={styles.activeContainer}>
            <Text style={styles.activeText}>GAMING MODE ACTIVE</Text>
            <View style={styles.grid}>
              <Card title="Background Tasks" value="Suspended" icon="pause-circle-outline" />
              <Card title="CPU Priority" value="Maximum" icon="flash-outline" />
              <Card title="Network Priority" value="High" icon="wifi-outline" />
              <Card title="Thermal Throttling" value="Optimized" icon="thermometer-outline" />
            </View>
          </View>
        )}
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
  switchContainer: { flexDirection: 'row', justifyContent: 'space-between', alignItems: 'center', backgroundColor: '#1A1D29', padding: 20, borderRadius: 20, borderWidth: 1, borderColor: '#2A2E3D' },
  switchLabel: { color: '#FFF', fontSize: 18, fontWeight: '600' },
  activeContainer: { marginTop: 30 },
  activeText: { color: '#00F0FF', fontSize: 16, fontWeight: 'bold', letterSpacing: 2, textAlign: 'center', marginBottom: 20 },
  grid: { flexDirection: 'row', flexWrap: 'wrap', justifyContent: 'space-between' }
});
