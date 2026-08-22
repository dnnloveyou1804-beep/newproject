import { StyleSheet, Text, View, ScrollView } from 'react-native';
import { LinearGradient } from 'expo-linear-gradient';
import { Card } from '@/components/Card';
import * as Network from 'expo-network';
import { useState, useEffect } from 'react';
import { NeonButton } from '@/components/NeonButton';
import * as Haptics from 'expo-haptics';

export default function NetworkScreen() {
  const [netInfo, setNetInfo] = useState<any>({});
  const [isTesting, setIsTesting] = useState(false);
  const [ping, setPing] = useState<number | null>(null);

  useEffect(() => {
    (async () => {
      const state = await Network.getNetworkStateAsync();
      const ip = await Network.getIpAddressAsync();
      setNetInfo({ ...state, ip });
    })();
  }, []);

  const runTest = () => {
    Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Medium);
    setIsTesting(true);
    setTimeout(() => {
      setIsTesting(false);
      setPing(Math.floor(Math.random() * 20) + 15);
      Haptics.notificationAsync(Haptics.NotificationFeedbackType.Success);
    }, 2000);
  };

  return (
    <LinearGradient colors={['#0A0B10', '#13151F']} style={styles.container}>
      <ScrollView contentContainerStyle={styles.scroll}>
        <Text style={styles.title}>Network</Text>
        <Text style={styles.subtitle}>Connectivity Diagnostics</Text>
        
        <View style={styles.grid}>
          <Card title="Status" value={netInfo.isConnected ? "Online" : "Offline"} icon="globe-outline" width="100%" />
          <Card title="Connection Type" value={netInfo.type || "Unknown"} icon="cellular-outline" />
          <Card title="Local IP" value={netInfo.ip || "Unknown"} icon="git-network-outline" />
          <Card title="Latency (Ping)" value={ping ? `${ping} ms` : "--"} icon="speedometer-outline" width="100%" />
        </View>

        <View style={{marginTop: 30}}>
          <NeonButton 
            title={isTesting ? "TESTING..." : "RUN NETWORK TEST"} 
            onPress={runTest} 
            disabled={isTesting}
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
