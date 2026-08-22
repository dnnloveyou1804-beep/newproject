import { Tabs } from 'expo-router';
import { BlurView } from 'expo-blur';
import { StyleSheet, View } from 'react-native';
import { Ionicons } from '@expo/vector-icons';
import * as Haptics from 'expo-haptics';

export default function TabLayout() {
  return (
    <Tabs
      screenOptions={{
        tabBarActiveTintColor: '#00F0FF',
        tabBarInactiveTintColor: '#5A606A',
        headerShown: false,
        tabBarStyle: {
          position: 'absolute',
          backgroundColor: 'transparent',
          borderTopWidth: 0,
          elevation: 0,
          height: 60,
          bottom: 20,
          left: 20,
          right: 20,
          borderRadius: 30,
          overflow: 'hidden',
        },
        tabBarBackground: () => (
          <BlurView tint="dark" intensity={80} style={StyleSheet.absoluteFill} />
        ),
      }}
      screenListeners={{
        tabPress: () => {
          Haptics.selectionAsync();
        },
      }}>
      <Tabs.Screen
        name="index"
        options={{
          title: 'Dashboard',
          tabBarIcon: ({ color }) => <Ionicons name="speedometer-outline" size={24} color={color} />,
        }}
      />
      <Tabs.Screen
        name="performance"
        options={{
          title: 'Performance',
          tabBarIcon: ({ color }) => <Ionicons name="rocket-outline" size={24} color={color} />,
        }}
      />
      <Tabs.Screen
        name="network"
        options={{
          title: 'Network',
          tabBarIcon: ({ color }) => <Ionicons name="wifi-outline" size={24} color={color} />,
        }}
      />
      <Tabs.Screen
        name="gaming"
        options={{
          title: 'Gaming',
          tabBarIcon: ({ color }) => <Ionicons name="game-controller-outline" size={24} color={color} />,
        }}
      />
      <Tabs.Screen
        name="device"
        options={{
          title: 'Device',
          tabBarIcon: ({ color }) => <Ionicons name="hardware-chip-outline" size={24} color={color} />,
        }}
      />
      <Tabs.Screen
        name="settings"
        options={{
          title: 'Settings',
          tabBarIcon: ({ color }) => <Ionicons name="settings-outline" size={24} color={color} />,
        }}
      />
    </Tabs>
  );
}
