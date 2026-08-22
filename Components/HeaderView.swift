import SwiftUI

struct HeaderView: View {
    @EnvironmentObject var sysStats: SystemStatsManager
    @EnvironmentObject var lang: LanguageManager
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "cpu.fill")
                    .resizable()
                    .frame(width: 32, height: 32)
                    .foregroundColor(.accentColor)
                
                VStack(alignment: .leading, spacing: 2) {
                    LocalizedText(key: "dashboard_title")
                        .font(.system(.title3, design: .rounded).bold())
                        .foregroundColor(.white)
                    
                    Text("\(sysStats.deviceName) • iOS \(sysStats.osVersion)")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                Spacer()
            }
            
            Divider().background(Color.white.opacity(0.2))
            
            HStack(spacing: 16) {
                // Battery
                VStack(alignment: .leading) {
                    HStack(spacing: 4) {
                        Image(systemName: sysStats.isCharging ? "battery.100.bolt" : "battery.100")
                            .foregroundColor(sysStats.isCharging ? .green : .gray)
                        Text(lang.localizedString(for: "battery_level"))
                            .font(.caption2.weight(.medium))
                            .foregroundColor(.gray)
                    }
                    Text(sysStats.batteryPercentageString)
                        .font(.system(.body, design: .monospaced).bold())
                        .foregroundColor(.white)
                }
                
                // Storage
                VStack(alignment: .leading) {
                    HStack(spacing: 4) {
                        Image(systemName: "internaldrive.fill")
                            .foregroundColor(.gray)
                        Text(lang.localizedString(for: "storage"))
                            .font(.caption2.weight(.medium))
                            .foregroundColor(.gray)
                    }
                    Text("\(sysStats.freeStorage) \(lang.localizedString(for: "free_of")) \(sysStats.totalStorage)")
                        .font(.system(.caption, design: .monospaced).bold())
                        .foregroundColor(.white)
                }
                
                // RAM
                VStack(alignment: .leading) {
                    HStack(spacing: 4) {
                        Image(systemName: "memorychip")
                            .foregroundColor(.gray)
                        Text(lang.localizedString(for: "ram"))
                            .font(.caption2.weight(.medium))
                            .foregroundColor(.gray)
                    }
                    Text(sysStats.ramUsage)
                        .font(.system(.body, design: .monospaced).bold())
                        .foregroundColor(.white)
                }
            }
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(20)
    }
}
