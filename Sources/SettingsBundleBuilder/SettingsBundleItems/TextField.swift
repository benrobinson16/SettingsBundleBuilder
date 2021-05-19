// Copyright (c) 2021 Ben Robinson.
// All Rights Reserved.
//
// SettingsBundleBuilder
// TextField.swift

public struct TextField: SettingsBundleItem {
    let title: String
    let key: String
    
    var defaultValue: String?
    var isSecure: Bool?
    var keyboard: KeyboardType?
    var autocapitalization: AutocapitalizationType?
    var autocorrection: AutocorrectionType?
    
    /// Makes a new `TextField` for a settings bundle
    /// - Parameters:
    ///   - key: The `UserDefaults` key to read/write data
    ///   - title: The title of the text field
    ///   - defaultValue: The default value in case it is not found in `UserDefaults`
    ///   - isSecure: Whether or not the text field should use secure password style
    ///   - keyboard: The keyboard to use for data entry
    ///   - autocapitalization: The autocapitalization rule
    ///   - autocorrection: The autocorrection rule
    public init(
        _ key: String,
        title: String,
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
        return entries.compactMap { $0.getXML() }.joined().makeDict()
    }
}
