import SwiftUI

struct AboutView: View {
    @EnvironmentObject var lang: LanguageManager
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Image(systemName: "cpu")
                    .font(.system(size: 60))
                    .foregroundColor(.accentColor)
                    .frame(maxWidth: .infinity)
                    .padding()
                
                LocalizedText(key: "about_title")
                    .font(.largeTitle).bold()
                    .frame(maxWidth: .infinity)
                
                LocalizedText(key: "about_desc")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding(.bottom)
                
                VStack(alignment: .leading, spacing: 12) {
                    LocalizedText(key: "features_title")
                        .font(.headline)
                        .foregroundColor(.green)
                    LocalizedText(key: "features_list")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.ultraThinMaterial)
                .cornerRadius(16)
            }
            .padding()
        }
        .navigationTitle(lang.localizedString(for: "about"))
    }
}
