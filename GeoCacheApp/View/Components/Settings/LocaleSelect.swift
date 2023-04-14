import SwiftUI

struct LocaleSelect: View {
    @State private var selectedLocaleIdentifier: String = UserDefaults.standard.string(forKey: "selectedLocaleIdentifier") ?? "en"

    var body: some View {
        Picker("Select Language", selection: $selectedLocaleIdentifier.onChange(updateLocale)) {
            ForEach(Bundle.main.localizations, id: \.self) { localization in
                Text(LocalizedStringKey(localization)).tag(localization)
            }
        }.pickerStyle(MenuPickerStyle())
    }

    func updateLocale() {
        let localeIdentifier = selectedLocaleIdentifier
        UserDefaults.standard.set(localeIdentifier, forKey: "selectedLocaleIdentifier")
        UserDefaults.standard.set([localeIdentifier], forKey: "AppleLanguages")
        Bundle.swizzleLocalization()
    }
}

extension Binding {
    func onChange(_ handler: @escaping () -> Void) -> Binding<Value> {
        return Binding(
            get: { self.wrappedValue },
            set: { newValue in
                self.wrappedValue = newValue
                handler()
            }
        )
    }
}

extension Bundle {
    static func swizzleLocalization() {
        object_setClass(Bundle.main, CustomBundle.self)
    }
}

private class CustomBundle: Bundle {
    override func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        guard let bundlePath = Bundle.main.path(forResource: UserDefaults.standard.string(forKey: "selectedLocaleIdentifier"), ofType: "lproj"),
              let languageBundle = Bundle(path: bundlePath) else {
            return super.localizedString(forKey: key, value: value, table: tableName)
        }
        return languageBundle.localizedString(forKey: key, value: value, table: tableName)
    }
}

