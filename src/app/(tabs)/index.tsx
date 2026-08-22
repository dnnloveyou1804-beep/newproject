import { StyleSheet, Text, View, ScrollView } from 'react-native';
import { LinearGradient } from 'expo-linear-gradient';
import * as Device from 'expo-device';
import * as Battery from 'expo-battery';
import { useState, useEffect } from 'react';
import { Card } from '@/components/Card';
import { NeonButton } from '@/components/NeonButton';
import { OptimizationRing } from '@/components/OptimizationRing';
import * as Haptics from 'expo-haptics';

export default function DashboardScreen() {
  const [batteryLevel, setBatteryLevel] = useState(1);
  const [isOptimizing, setIsOptimizing] = useState(false);
  const [optimized, setOptimized] = useState(false);

  useEffect(() => {
    (async () => {
      const level = await Battery.getBatteryLevelAsync();
      if (level > 0) setBatteryLevel(level);
    })();
  }, []);

  const handleOptimize = () => {
    Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Heavy);
    setIsOptimizing(true);
    setTimeout(() => {
      setIsOptimizing(false);
      setOptimized(true);
      Haptics.notificationAsync(Haptics.NotificationFeedbackType.Success);
    }, 2500);
  };

  return (
    <LinearGradient colors={['#0A0B10', '#13151F']} style={styles.container}>
      <ScrollView contentContainerStyle={styles.scroll}>
        <Text style={styles.title}>DNTWEAKS</Text>
        <Text style={styles.subtitle}>System Dashboard</Text>
        
        <View style={styles.ringContainer}>
          <OptimizationRing optimizing={isOptimizing} score={optimized ? 98 : 72} />
        </View>

        <NeonButton 
          title={isOptimizing ? "OPTIMIZING..." : (optimized ? "OPTIMIZED" : "OPTIMIZE NOW")} 
          onPress={handleOptimize} 
          disabled={isOptimizing || optimized}
        />

        <View style={styles.grid}>
          <Card title="Device" value={Device.modelName || 'Unknown'} icon="phone-portrait-outline" />
          <Card title="iOS Version" value={Device.osVersion || 'Unknown'} icon="logo-apple" />
          <Card title="Battery" value={`${Math.round(batteryLevel * 100)}%`} icon="battery-half-outline" />
          <Card title="Network" value="Connected" icon="pulse-outline" />
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
  ringContainer: { alignItems: 'center', marginVertical: 30 },
  grid: { flexDirection: 'row', flexWrap: 'wrap', justifyContent: 'space-between', marginTop: 30 }
});
