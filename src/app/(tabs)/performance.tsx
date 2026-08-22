import { StyleSheet, Text, View, ScrollView } from 'react-native';
import { LinearGradient } from 'expo-linear-gradient';
import { Card } from '@/components/Card';
import * as Device from 'expo-device';

export default function PerformanceScreen() {
  return (
    <LinearGradient colors={['#0A0B10', '#13151F']} style={styles.container}>
      <ScrollView contentContainerStyle={styles.scroll}>
        <Text style={styles.title}>Performance</Text>
        <Text style={styles.subtitle}>System Monitor</Text>
        
        <View style={styles.grid}>
          <Card title="Memory Status" value="Healthy" icon="hardware-chip-outline" width="100%" />
          <Card title="CPU Cores" value={Device.supportedCpuArchitectures?.length.toString() || 'Unknown'} icon="server-outline" />
          <Card title="Thermal State" value="Nominal" icon="thermometer-outline" />
          <Card title="Storage" value="Optimized" icon="save-outline" width="100%" />
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
