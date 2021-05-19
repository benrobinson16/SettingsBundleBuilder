// Copyright (c) 2021 Ben Robinson.
// All Rights Reserved.
//
// SettingsBundleBuilder
// Toggle.swift

public struct Toggle: SettingsBundleItem {
    let title: String
    let key: String
    let defaultValue: Bool
    
    /// <#Description#>
    /// - Parameters:
    ///   - key: The `UserDefaults` property to read from/write to
    ///   - title: The title of the toggle
    ///   - defaultValue: The default value if not found in `UserDefaults`
    public init(_ key: String, title: String, defaultValue: Bool) {
        self.key = key
        self.title = title
        self.defaultValue = defaultValue
    }
    
    public func makePlist() -> String {
        let entries: [KeyValuePair] = [
            StringPair("Type", value: "PSToggleSwitchSpecifier"),
            StringPair("Title", value: title),
            BoolPair("DefaultValue", value: defaultValue)
        ]
        return entries.compactMap { $0.getXML() }.joined().makeDict()
    }
}
