// Copyright (c) 2021 Ben Robinson.
// All Rights Reserved.
//
// SettingsBundleBuilder
// Toggle.swift

public struct Toggle: SettingsBundleItem, NonGroupSettingsBundleItem {
    let title: String
    let key: String
    let defaultValue: Bool
    
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
            StringPair("Key", value: key),
            StringPair("Title", value: title),
            BoolPair("DefaultValue", value: defaultValue)
        ]
        return entries.compactMap { $0.getXML() }
            .joined(separator: "\n")
            .makeDict()
    }
}
