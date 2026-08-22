import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack {
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .frame(width: 44, height: 44)
                .foregroundColor(.gray)
            
            VStack(alignment: .leading) {
                Text("DN TWEAKS")
                    .font(.system(.title3, design: .rounded).bold())
                    .foregroundColor(.white)
                Text("DEMO MODE")
                    .font(.caption.weight(.heavy))
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(Color.red.opacity(0.8))
                    .cornerRadius(4)
                    .foregroundColor(.white)
            }
            Spacer()
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(20)
    }
}
