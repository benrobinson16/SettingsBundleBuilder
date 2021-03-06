// Copyright (c) 2021 Benjamin Robinson.
//
// SettingsBundleBuilder
// TextField.swift

public struct TextField: SettingsBundleItem, NonGroupSettingsBundleItem {
    let title: String
    let key: String
    
    let defaultValue: String?
    let isSecure: Bool?
    let keyboard: KeyboardType?
    let autocapitalization: AutocapitalizationType?
    let autocorrection: AutocorrectionType?
    
    /// Makes a new `TextField` item
    /// - Parameters:
    ///   - title: The string to display to the side of the text field
    ///   - key: The key of the `UserDefaults` value to change
    ///   - defaultValue: The value to use if the key is not in `UserDefaults`
    ///   - isSecure: Whether or not the `TextField` is for entering sensitive data
    ///   - keyboard: The keyboard to use (e.g. number pad)
    ///   - autocapitalization: The autocapitalization strategy to use (useful to change for emails, usernames, etc)
    ///   - autocorrection: The autocorrect strategy to use (useful to change for emails, usernames, etc)
    public init(
        _ title: String,
        key: String,
        defaultValue: String? = nil,
        isSecure: Bool? = nil,
        keyboard: KeyboardType? = nil,
        autocapitalization: AutocapitalizationType? = nil,
        autocorrection: AutocorrectionType? = nil
    ) {
        self.key = key
        self.title = title
        self.defaultValue = defaultValue
        self.isSecure = isSecure
        self.keyboard = keyboard
        self.autocapitalization = autocapitalization
        self.autocorrection = autocorrection
    }
    
    public func makePlist() -> String {
        let entries: [KeyValuePair] = [
            StringPair("Type", value: "PSTextFieldSpecifier"),
            StringPair("Title", value: title),
            StringPair("Key", value: key),
            StringPair("DefaultValue", value: defaultValue),
            BoolPair("IsSecure", value: isSecure),
            StringPair("KeyboardType", value: keyboard?.rawValue),
            StringPair("AutocapitalizationType", value: autocapitalization?.rawValue),
            StringPair("AutocorrectionType", value: autocorrection?.rawValue)
        ]
        return entries
            .compactMap { $0.getXML() }
            .joined(separator: "\n")
            .makeDict()
    }
}
