// Copyright (c) 2021 Ben Robinson.
// All Rights Reserved.
//
// SettingsBundleBuilder
// MultiValue.swift

public struct RadioGroup: SettingsBundleItem, NonGroupSettingsBundleItem {
    let key: String
    let title: String
    let defaultValue: String
    let values: [String]
    let readable: [String]
    
    let sortByTitle: Bool?
    let footerText: String?
    
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
            BoolPair("DisplaySortedByTitle", value: sortByTitle)
        ]
        return entries.compactMap { $0.getXML() }
            .joined(separator: "\n")
            .makeDict()
    }
}
