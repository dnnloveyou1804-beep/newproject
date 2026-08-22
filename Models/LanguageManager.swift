import SwiftUI

enum AppLanguage: String, CaseIterable {
    case english = "en"
    case vietnamese = "vi"
    
    var displayName: String {
        switch self {
        case .english: return "English"
        case .vietnamese: return "Tiếng Việt"
        }
    }
}

class LanguageManager: ObservableObject {
    @AppStorage("AppLanguage") private var storedLanguage: String = AppLanguage.english.rawValue
    
    @Published var currentLanguage: AppLanguage = .english {
        didSet {
            storedLanguage = currentLanguage.rawValue
        }
    }
    
    init() {
        if let savedLang = AppLanguage(rawValue: storedLanguage) {
            currentLanguage = savedLang
        }
    }
    
    func localizedString(for key: String) -> String {
        let dict = Localization.translations[currentLanguage] ?? Localization.translations[.english]!
        return dict[key] ?? key
    }
}

// SwiftUI custom View Modifier to easily localize text
struct LocalizedText: View {
    let key: String
    @EnvironmentObject var lang: LanguageManager
    
    var body: some View {
        Text(lang.localizedString(for: key))
    }
}
