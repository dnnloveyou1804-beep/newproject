import { StyleSheet, View, Text } from 'react-native';
import Animated, { useSharedValue, useAnimatedStyle, withRepeat, withTiming, Easing, withSpring } from 'react-native-reanimated';
import { useEffect } from 'react';

interface OptimizationRingProps {
  optimizing: boolean;
  score: number;
}

export function OptimizationRing({ optimizing, score }: OptimizationRingProps) {
  const rotation = useSharedValue(0);
  const scale = useSharedValue(1);

  useEffect(() => {
    if (optimizing) {
      rotation.value = withRepeat(
        withTiming(360, { duration: 1000, easing: Easing.linear }),
        -1
      );
      scale.value = withRepeat(
        withTiming(1.1, { duration: 500 }),
        -1,
        true
      );
    } else {
      rotation.value = withTiming(0);
      scale.value = withSpring(1);
    }
  }, [optimizing]);

  const animatedStyle = useAnimatedStyle(() => {
    return {
      transform: [
        { rotateZ: `${rotation.value}deg` },
        { scale: scale.value }
      ]
    };
  });

  return (
    <View style={styles.container}>
      <Animated.View style={[styles.ring, animatedStyle]} />
      <View style={styles.innerCircle}>
        <Text style={styles.scoreText}>{optimizing ? '...' : `${score}%`}</Text>
        <Text style={styles.scoreLabel}>Health</Text>
      </View>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    width: 200,
    height: 200,
    justifyContent: 'center',
    alignItems: 'center',
  },
  ring: {
    position: 'absolute',
    width: 200,
    height: 200,
    borderRadius: 100,
    borderWidth: 4,
    borderColor: '#00F0FF',
    borderStyle: 'dashed',
  },
  innerCircle: {
    width: 160,
    height: 160,
    borderRadius: 80,
    backgroundColor: 'rgba(0, 240, 255, 0.1)',
    justifyContent: 'center',
    alignItems: 'center',
    borderWidth: 1,
    borderColor: 'rgba(0, 240, 255, 0.3)',
  },
  scoreText: {
    fontSize: 48,
    fontWeight: 'bold',
    color: '#FFF',
  },
  scoreLabel: {
    fontSize: 14,
    color: '#00F0FF',
    letterSpacing: 2,
    textTransform: 'uppercase',
  }
});
