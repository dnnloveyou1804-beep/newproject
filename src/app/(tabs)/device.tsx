import { StyleSheet, Text, View, ScrollView } from 'react-native';
import { LinearGradient } from 'expo-linear-gradient';
import { Card } from '@/components/Card';
import * as Device from 'expo-device';
import * as Battery from 'expo-battery';
import { useState, useEffect } from 'react';

export default function DeviceScreen() {
  const [batteryState, setBatteryState] = useState('Unknown');

  useEffect(() => {
    (async () => {
      const state = await Battery.getBatteryStateAsync();
      const stateMap: any = {
        [Battery.BatteryState.UNKNOWN]: 'Unknown',
        [Battery.BatteryState.UNPLUGGED]: 'Unplugged',
        [Battery.BatteryState.CHARGING]: 'Charging',
        [Battery.BatteryState.FULL]: 'Full',
      };
      setBatteryState(stateMap[state] || 'Unknown');
    })();
  }, []);

  return (
    <LinearGradient colors={['#0A0B10', '#13151F']} style={styles.container}>
      <ScrollView contentContainerStyle={styles.scroll}>
        <Text style={styles.title}>Device Info</Text>
        <Text style={styles.subtitle}>Hardware Details</Text>
        
        <View style={styles.grid}>
          <Card title="Model" value={Device.modelName || 'Unknown'} icon="phone-portrait-outline" width="100%" />
          <Card title="OS Version" value={Device.osVersion || 'Unknown'} icon="logo-apple" />
          <Card title="Architecture" value={Device.supportedCpuArchitectures?.[0] || 'Unknown'} icon="hardware-chip-outline" />
          <Card title="Brand" value={Device.brand || 'Apple'} icon="star-outline" />
          <Card title="Power State" value={batteryState} icon="battery-charging-outline" />
          <Card title="Design Name" value={Device.designName || 'Unknown'} icon="color-palette-outline" width="100%" />
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
