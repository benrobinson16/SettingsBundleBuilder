// Copyright (c) 2021 Ben Robinson.
// All Rights Reserved.
//
// SettingsBundleBuilder
// Text.swift

import Foundation

public struct Text: SettingsBundleItem, NonGroupSettingsBundleItem {
    let key: String
    let defaultValue: String
    
    let title: String?
    let values: [String]?
    let readable: [String]?
    
    public init(
        _ title: String,
        key: String,
        defaultValue: String,
        possibleValues: [String],
        readableVersions: [String]
    ) {
        self.title = title
        self.key = key
        self.defaultValue = defaultValue
        self.values = possibleValues
        self.readable = readableVersions
    }
    
    public init(
        _ title: String,
        constantValue: String? = nil
    ) {
        self.title = title
        self.key = UUID().uuidString
        self.defaultValue = "default"
        self.values = ["default"]
        
        if let constantValue = constantValue {
            self.readable = [constantValue]
        } else {
            self.readable = [""]
        }
    }
    
    public func makePlist() -> String {
        let entries: [KeyValuePair] = [
            StringPair("Type", value: "PSTitleValueSpecifier"),
            StringPair("Title", value: title),
            StringPair("Key", value: key),
            StringPair("DefaultValue", value: defaultValue),
            ArrayPair("Values", values: values),
            ArrayPair("Titles", values: readable)
        ]
        return entries.compactMap { $0.getXML() }
            .joined(separator: "\n")
            .makeDict()
    }
}
