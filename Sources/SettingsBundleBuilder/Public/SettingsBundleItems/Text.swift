// Copyright (c) 2021 Benjamin Robinson.
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
    ///   - possibleValues: The range of possible values the key in `UserDefaults` might take. If not provided, the raw value in `UserDefaults` will be presented
    ///   - readableVersions: The readable versions of `possibleValues`. Array should be in same order and of same length. If not provided, the raw value in `UserDefaults` will be presented
    public init(
        _ title: String,
        key: String,
        defaultValue: String,
        possibleValues: [String]? = nil,
        readableVersions: [String]? = nil
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
        self.defaultValue = constantValue ?? ""
        self.values = nil
        self.readable = nil
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
