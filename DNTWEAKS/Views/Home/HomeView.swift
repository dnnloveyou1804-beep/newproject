//
//  HomeView.swift
//  DNTWEAKS IOS
//

import SwiftUI
import UniformTypeIdentifiers

struct HomeView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @StateObject private var viewModel = HomeViewModel()
    @StateObject private var settingsVM = SettingsViewModel()
    @State private var showSettings = false
    @State private var appear = false
    
    private let columns = [
        GridItem(.flexible(), spacing: 14),
        GridItem(.flexible(), spacing: 14)
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    // Header
                    headerSection
                        .padding(.horizontal, 20)
                        .padding(.top, 8)
                    
                    // Device Info Card
                    deviceInfoCard
                        .padding(.horizontal, 20)
                    
                    // App Info Card
                    appInfoCard
                        .padding(.horizontal, 20)
                    
                    // Admin Card
                    adminCard
                        .padding(.horizontal, 20)
                    
                    // Profiles Grid
                    profilesSection
                        .padding(.horizontal, 20)
                    
                    // Selected file / Active Code section
                    if viewModel.selectedFile != nil {
                        selectedFileSection
                            .padding(.horizontal, 20)
                            .transition(.asymmetric(
                                insertion: .move(edge: .bottom).combined(with: .opacity),
                                removal: .opacity
                            ))
                    }
                    
                    Spacer().frame(height: 40)
                }
                .padding(.bottom, 20)
            }
            .navigationBarHidden(true)
            .sheet(isPresented: $showSettings) {
                SettingsView()
                    .environmentObject(ThemeManager.shared)
            }
            .fileImporter(
                isPresented: $viewModel.showFilePicker,
                allowedContentTypes: [.item, .folder, .data, .content],
                allowsMultipleSelection: false
            ) { result in
                handleFileImport(result)
            }
            .onAppear {
                withAnimation(.spring(response: 0.6, dampingFraction: 0.8).delay(0.1)) {
                    appear = true
                }
            }
        }
    }
    
    // MARK: - Header
    private var headerSection: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("DNTWEAKS")
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .foregroundStyle(
                        LinearGradient(colors: [.neonPurple, .neonBlue], startPoint: .leading, endPoint: .trailing)
                    )
                Text("CONTROL CENTER")
                    .font(.system(size: 11, weight: .semibold, design: .monospaced))
                    .foregroundColor(.neonCyan)
                    .tracking(2)
            }
            
            Spacer()
            
            Button {
                showSettings = true
                HapticManager.shared.selection()
            } label: {
                Image(systemName: "gearshape.fill")
                    .font(.system(size: 20))
                    .foregroundColor(.neonPurple)
                    .padding(12)
                    .background(
                        Circle()
                            .fill(.ultraThinMaterial)
                            .overlay(Circle().stroke(Color.neonPurple.opacity(0.5), lineWidth: 1))
                    )
                    .neonGlow(color: .neonPurple, radius: 6)
            }
            
            Button {
                authViewModel.logout()
            } label: {
                Image(systemName: "rectangle.portrait.and.arrow.right")
                    .font(.system(size: 18))
                    .foregroundColor(.neonPink)
                    .padding(12)
                    .background(
                        Circle()
                            .fill(.ultraThinMaterial)
                            .overlay(Circle().stroke(Color.neonPink.opacity(0.5), lineWidth: 1))
                    )
            }
        }
        .opacity(appear ? 1 : 0)
        .offset(y: appear ? 0 : -20)
    }
    
    // MARK: - Device Info
    private var deviceInfoCard: some View {
        GlassCard {
            VStack(alignment: .leading, spacing: 14) {
                HStack {
                    Label("DEVICE", systemImage: "iphone")
                        .font(.system(size: 13, weight: .bold, design: .monospaced))
                        .foregroundColor(.neonCyan)
                        .tracking(1)
                    Spacer()
                    Button {
                        viewModel.refreshDeviceInfo()
                    } label: {
                        Image(systemName: "arrow.clockwise")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.neonBlue)
                    }
                }
                
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 12) {
                    infoRow(title: "Model", value: viewModel.deviceInfo.model, icon: "cpu")
                    infoRow(title: "Name", value: viewModel.deviceInfo.deviceName, icon: "iphone")
                    infoRow(title: "iOS", value: viewModel.deviceInfo.systemVersion, icon: "apple.logo")
                    infoRow(title: "Storage", value: viewModel.deviceInfo.totalStorage, icon: "internaldrive")
                    infoRow(title: "Free", value: viewModel.deviceInfo.freeStorage, icon: "externaldrive")
                    infoRow(title: "CPU", value: viewModel.deviceInfo.cpuInfo, icon: "bolt")
                    infoRow(title: "RAM", value: viewModel.deviceInfo.ramInfo, icon: "memorychip")
                    infoRow(title: "Battery", value: viewModel.deviceInfo.batteryLevel, icon: "battery.100")
                }
                
                HStack(spacing: 16) {
                    statusBadge(title: "Low Power", active: viewModel.deviceInfo.isLowPowerMode, color: .neonPink)
                    statusBadge(title: "Dark Mode", active: true, color: .neonPurple)
                }
            }
        }
        .opacity(appear ? 1 : 0)
        .offset(y: appear ? 0 : 30)
    }
    
    // MARK: - App Info
    private var appInfoCard: some View {
        GlassCard {
            VStack(alignment: .leading, spacing: 12) {
                Label("APPLICATION", systemImage: "app.badge")
                    .font(.system(size: 13, weight: .bold, design: .monospaced))
                    .foregroundColor(.neonBlue)
                    .tracking(1)
                
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                    infoRow(title: "Version", value: viewModel.deviceInfo.appVersion, icon: "number")
                    infoRow(title: "Build", value: viewModel.deviceInfo.buildNumber, icon: "hammer")
                    infoRow(title: "Bundle ID", value: viewModel.deviceInfo.bundleIdentifier, icon: "barcode")
                    infoRow(title: "Build Date", value: viewModel.deviceInfo.buildDate, icon: "calendar")
                }
            }
        }
        .opacity(appear ? 1 : 0)
        .offset(y: appear ? 0 : 30)
    }
    
    // MARK: - Admin Card
    private var adminCard: some View {
        GlassCard {
            VStack(alignment: .leading, spacing: 14) {
                Label("ADMIN", systemImage: "person.badge.shield.checkmark.fill")
                    .font(.system(size: 13, weight: .bold, design: .monospaced))
                    .foregroundColor(.neonPink)
                    .tracking(1)
                
                HStack {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Dinh Duc Nam")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                        
                        HStack(spacing: 6) {
                            Image(systemName: "paperplane.fill")
                                .foregroundColor(.neonBlue)
                            Text("@dntweaks")
                                .foregroundColor(.neonBlue)
                        }
                        .font(.system(size: 14, weight: .medium))
                        
                        HStack(spacing: 6) {
                            Image(systemName: "play.rectangle.fill")
                                .foregroundColor(.neonPink)
                            Text("@dnnnloveyou")
                                .foregroundColor(.neonPink)
                        }
                        .font(.system(size: 14, weight: .medium))
                        
                        HStack(spacing: 6) {
                            Image(systemName: "phone.fill")
                                .foregroundColor(.neonGreen)
                            Text("0395109314")
                                .foregroundColor(.neonGreen)
                        }
                        .font(.system(size: 14, weight: .medium))
                    }
                    
                    Spacer()
                }
                
                HStack(spacing: 10) {
                    Button {
                        settingsVM.copyToClipboard("0395109314")
                    } label: {
                        Label("Copy Zalo", systemImage: "doc.on.doc")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.neonGreen.opacity(0.25)))
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.neonGreen.opacity(0.5), lineWidth: 1))
                    }
                    
                    Button {
                        settingsVM.openTelegram()
                    } label: {
                        Label("Telegram", systemImage: "paperplane.fill")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.neonBlue.opacity(0.25)))
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.neonBlue.opacity(0.5), lineWidth: 1))
                    }
                    
                    Button {
                        settingsVM.openTikTok()
                    } label: {
                        Label("TikTok", systemImage: "play.rectangle.fill")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.neonPink.opacity(0.25)))
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.neonPink.opacity(0.5), lineWidth: 1))
                    }
                }
            }
        }
        .opacity(appear ? 1 : 0)
        .offset(y: appear ? 0 : 30)
    }
    
    // MARK: - Profiles
    private var profilesSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("PROFILES & TOOLS")
                .font(.system(size: 13, weight: .bold, design: .monospaced))
                .foregroundColor(.neonPurple)
                .tracking(1.5)
                .padding(.leading, 4)
            
            LazyVGrid(columns: columns, spacing: 14) {
                ForEach(ProfileType.allCases) { profile in
                    profileButton(profile)
                }
            }
        }
        .opacity(appear ? 1 : 0)
        .offset(y: appear ? 0 : 40)
    }
    
    private func profileButton(_ profile: ProfileType) -> some View {
        Button {
            viewModel.selectProfile(profile)
        } label: {
            VStack(spacing: 10) {
                Image(systemName: profile.icon)
                    .font(.system(size: 26, weight: .semibold))
                    .foregroundColor(profile.color)
                    .neonGlow(color: profile.color, radius: 8)
                
                Text(profile.rawValue.replacingOccurrences(of: " Profile", with: "").replacingOccurrences(of: " Config", with: ""))
                    .font(.system(size: 13, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .minimumScaleFactor(0.8)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 100)
            .background(
                RoundedRectangle(cornerRadius: 18)
                    .fill(.ultraThinMaterial)
                    .background(
                        RoundedRectangle(cornerRadius: 18)
                            .fill(profile.color.opacity(0.12))
                    )
            )
            .ledBorder(cornerRadius: 18, lineWidth: 2)
            .shadow(color: profile.color.opacity(0.3), radius: 10, y: 4)
        }
        .buttonStyle(.plain)
    }
    
    // MARK: - Selected File Section
    private var selectedFileSection: some View {
        GlassCard {
            VStack(spacing: 18) {
                HStack {
                    Image(systemName: "checkmark.seal.fill")
                        .foregroundColor(.neonGreen)
                    Text("Selected Successfully")
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .foregroundColor(.neonGreen)
                    Spacer()
                    Button {
                        viewModel.resetSelection()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.white.opacity(0.5))
                    }
                }
                
                if let file = viewModel.selectedFile {
                    VStack(alignment: .leading, spacing: 8) {
                        infoRow(title: "File", value: file.name, icon: "doc.fill")
                        infoRow(title: "Size", value: file.size, icon: "externaldrive")
                        infoRow(title: "Path", value: file.path, icon: "folder")
                    }
                }
                
                if viewModel.showActiveCode && !viewModel.isCompleted {
                    NeonButton("ACTIVE CODE", icon: "bolt.circle.fill", color: .neonGreen) {
                        viewModel.activateCode()
                    }
                }
                
                if viewModel.isProcessing || viewModel.isCompleted {
                    VStack(spacing: 16) {
                        ProgressRing(progress: viewModel.progress)
                        
                        Text(viewModel.statusMessage)
                            .font(.system(size: 15, weight: .semibold, design: .rounded))
                            .foregroundColor(viewModel.isCompleted ? .neonGreen : .neonCyan)
                        
                        if viewModel.isCompleted {
                            Text("Process finished (simulation only)")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(.white.opacity(0.5))
                        }
                    }
                    .padding(.top, 8)
                }
            }
        }
    }
    
    // MARK: - Helpers
    private func infoRow(title: String, value: String, icon: String) -> some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 12))
                .foregroundColor(.neonPurple.opacity(0.8))
                .frame(width: 18)
            VStack(alignment: .leading, spacing: 1) {
                Text(title)
                    .font(.system(size: 10, weight: .medium, design: .monospaced))
                    .foregroundColor(.white.opacity(0.45))
                Text(value)
                    .font(.system(size: 13, weight: .semibold, design: .rounded))
                    .foregroundColor(.white)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
            }
        }
    }
    
    private func statusBadge(title: String, active: Bool, color: Color) -> some View {
        HStack(spacing: 6) {
            Circle()
                .fill(active ? color : Color.gray)
                .frame(width: 8, height: 8)
                .shadow(color: active ? color : .clear, radius: 4)
            Text(title)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(active ? .white : .white.opacity(0.4))
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .background(
            Capsule()
                .fill(active ? color.opacity(0.2) : Color.white.opacity(0.05))
        )
    }
    
    private func handleFileImport(_ result: Result<[URL], Error>) {
        switch result {
        case .success(let urls):
            guard let url = urls.first else { return }
            // Security-scoped access
            let accessed = url.startAccessingSecurityScopedResource()
            defer { if accessed { url.stopAccessingSecurityScopedResource() } }
            
            let name = url.lastPathComponent
            var size: Int64 = 0
            if let attrs = try? FileManager.default.attributesOfItem(atPath: url.path),
               let fileSize = attrs[.size] as? Int64 {
                size = fileSize
            }
            let path = url.path
            
            viewModel.fileSelected(name: name, size: size, path: path)
            
        case .failure(let error):
            print("File import error: \(error.localizedDescription)")
            HapticManager.shared.notification(.error)
        }
    }
}
