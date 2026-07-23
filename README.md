# DNTWEAKS IOS

**Cyberpunk / Sci-Fi / Future UI** – Complete SwiftUI iOS project.

## Requirements
- Xcode 15+ (or later)
- iOS 16.0+ deployment target
- macOS with full Apple development tools to build `.ipa`

## Bundle ID
`com.dntweaks.ios`

## Default Login
- Username: `ducnamtweaks`
- Password: `ducnam123`

## Features
- Fully custom Cyberpunk UI (Neon Purple / Blue Neon / Glassmorphism / LED borders / Particles / Animated Gradients)
- Splash → Login → Home flow
- Device info (safe public APIs only)
- Admin card with Telegram / TikTok / Zalo
- 8 Profile buttons → System File Picker → Simulated ACTIVE CODE progress
- Settings (Dark Mode, Accent, Animation Speed, About, Privacy, Reset)
- Haptic + System sound feedback
- MVVM architecture
- 60 FPS friendly animations

## Important Notes
All profile / ACTIVE CODE operations are **simulations only**.  
They never modify system settings and stay inside the iOS app sandbox.  
File access uses the official `fileImporter` with user permission.

## How to open & build
1. Unzip / open the folder `DNTWEAKS-IOS`
2. Double-click `DNTWEAKS.xcodeproj`
3. Select a development team in Signing & Capabilities
4. Build & Run on device / simulator
5. To produce `.ipa`: Product → Archive → Distribute App

## Project Structure
```
DNTWEAKS/
├── DNTWEAKSApp.swift
├── ContentView.swift
├── Models/
├── ViewModels/
├── Views/ (Splash, Login, Home, Settings, Profiles)
├── Components/ (NeonButton, GlassCard, LEDBorder, ParticleView, ProgressRing...)
├── Services/
├── Managers/
├── Extensions/
└── Assets.xcassets
```

Created by **Dinh Duc Nam** (@dntweaks)
