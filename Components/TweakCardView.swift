import SwiftUI

struct TweakCardView: View {
    let tweak: TweakItem
    @State private var showDetail = false
    
    var body: some View {
        Button(action: { showDetail.toggle() }) {
            VStack(alignment: .leading, spacing: 12) {
                Image(systemName: tweak.icon)
                    .font(.title2)
                    .foregroundColor(.accentColor)
                
                Text(tweak.title)
                    .font(.system(.subheadline, design: .rounded).bold())
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.white.opacity(0.1), lineWidth: 1)
            )
        }
        .sheet(isPresented: $showDetail) {
            TweakDetailView(tweak: tweak)
        }
    }
}
