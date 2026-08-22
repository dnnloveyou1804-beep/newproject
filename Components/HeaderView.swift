import SwiftUI

struct HeaderView: View {
    @EnvironmentObject var sysStats: SystemStatsManager
    @EnvironmentObject var lang: LanguageManager
    
    var body: some View {
        HStack {
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .frame(width: 44, height: 44)
                .foregroundColor(.gray)
            
            VStack(alignment: .leading, spacing: 4) {
                LocalizedText(key: "dashboard_title")
                    .font(.system(.title3, design: .rounded).bold())
                    .foregroundColor(.white)
                
                HStack(spacing: 4) {
                    Image(systemName: sysStats.isCharging ? "battery.100.bolt" : "battery.100")
                        .foregroundColor(sysStats.isCharging ? .green : .gray)
                    Text("\(lang.localizedString(for: "battery_level")): \(sysStats.batteryPercentageString) - \(sysStats.isCharging ? lang.localizedString(for: "charging") : lang.localizedString(for: "discharging"))")
                        .font(.caption2.weight(.medium))
                        .foregroundColor(.gray)
                }
            }
            Spacer()
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(20)
    }
}
