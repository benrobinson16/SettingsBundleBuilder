// Copyright (c) 2021 Ben Robinson.
// All Rights Reserved.
//
// SettingsBundleBuilder
// MultiValue.swift

public struct RadioGroup: SettingsBundleItem {
    let key: String
    let title: String
    let defaultValue: String
    let values: [String]
    let readable: [String]
    
    let sortByTitle: Bool?
    let footerText: String?
    
    /// Makes a new `RadioGroup` item
    /// - Parameters:
    ///   - title: The string to display above the group
    ///   - key: The key of the `UserDefaults` value to change
    ///   - defaultValue: The value to use if the key is not in `UserDefaults`
    ///   - possibleValues: The possible values for the `key` in `UserDefaults`
    ///   - readableVersions: Readable versions of the `possibleValues`; array should be same order and length
    ///   - sortByTitle: Whether or not the values should be sorted alphabetically
    ///   - footerText: The string to display beneath the group
    public init(
        _ title: String,
        key: String,
        defaultValue: String,
        possibleValues: [String],
        readableVersions: [String],
        sortByTitle: Bool? = nil,
        footerText: String? = nil
    ) {
        self.key = key
        self.title = title
        self.defaultValue = defaultValue
        self.values = possibleValues
        self.readable = readableVersions
        self.sortByTitle = sortByTitle
        self.footerText = footerText
    }
    
    public func makePlist() -> String {
        let entries: [KeyValuePair] = [
            StringPair("Type", value: "PSRadioGroupSpecifier"),
            StringPair("Title", value: title),
            StringPair("Key", value: key),
            StringPair("DefaultValue", value: defaultValue),
            ArrayPair("Values", values: values),
            ArrayPair("Titles", values: readable),
            BoolPair("DisplaySortedByTitle", value: sortByTitle),
            StringPair("FooterText", value: footerText)
        ]
        return entries.compactMap { $0.getXML() }
            .joined(separator: "\n")
            .makeDict()
    }
}
