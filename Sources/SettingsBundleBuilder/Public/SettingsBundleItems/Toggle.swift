// Copyright (c) 2021 Benjamin Robinson.
//
// SettingsBundleBuilder
// Toggle.swift

public struct Toggle: SettingsBundleItem, NonGroupSettingsBundleItem {
    let title: String
    let key: String
    let defaultValue: Bool
    
    /// Makes a new `Toggle` item
    /// - Parameters:
    ///   - title: The string to display to the side of the toggle
    ///   - key: The key of the `UserDefaults` value to change
    ///   - defaultValue: The value to use if the key is not in `UserDefaults`
    public init(
        _ title: String,
        key: String,
        defaultValue: Bool
    ) {
        self.key = key
        self.title = title
        self.defaultValue = defaultValue
    }
    
    public func makePlist() -> String {
        let entries: [KeyValuePair] = [
            StringPair("Type", value: "PSToggleSwitchSpecifier"),
            StringPair("Title", value: title),
            StringPair("Key", value: key),
            BoolPair("DefaultValue", value: defaultValue)
        ]
        return entries.compactMap { $0.getXML() }
            .joined(separator: "\n")
            .makeDict()
    }
}
