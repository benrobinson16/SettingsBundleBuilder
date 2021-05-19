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
    
    /// Makes a new `Text` item that displays a value in `UserDefaults`
    /// - Parameters:
    ///   - title: The string to display to the side of the text
    ///   - key: The key of the `UserDefaults` value to read
    ///   - defaultValue: The value to use if the key is not in `UserDefaults`
    ///   - possibleValues: The range of possible values the key in `UserDefaults` might take
    ///   - readableVersions: The readable versions of `possibleValues`; array should be in same order and of same length
    public init(
        _ title: String,
        key: String,
        defaultValue: String,
        possibleValues: [String]?,
        readableVersions: [String]?
    ) {
        self.title = title
        self.key = key
        self.defaultValue = defaultValue
        self.values = possibleValues
        self.readable = readableVersions
    }
    
    /// Makes a new `Text` item that displays a constant value
    /// - Parameters:
    ///   - title: The string to display to the side of the value (if any)
    ///   - constantValue: The value to display
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
