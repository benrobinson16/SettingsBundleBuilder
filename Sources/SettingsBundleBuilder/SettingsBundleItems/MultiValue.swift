// Copyright (c) 2021 Ben Robinson.
// All Rights Reserved.
//
// SettingsBundleBuilder
// MultiValue.swift

public struct MultiValue: SettingsBundleItem, NonGroupSettingsBundleItem {
    let key: String
    let title: String
    let defaultValue: String
    let values: [String]
    let readable: [String]
    
    let shortReadable: [String]?
    let sortByTitle: Bool?
    
    public init(
        _ title: String,
        key: String,
        defaultValue: String,
        possibleValues: [String],
        readableVersions: [String],
        shortVersions: [String]? = nil,
        sortByTitle: Bool? = nil
    ) {
        self.key = key
        self.title = title
        self.defaultValue = defaultValue
        self.values = possibleValues
        self.readable = readableVersions
        self.shortReadable = shortVersions
        self.sortByTitle = sortByTitle
    }
    
    public func makePlist() -> String {
        let entries: [KeyValuePair] = [
            StringPair("Type", value: "PSMultiValueSpecifier"),
            StringPair("Title", value: title),
            StringPair("Key", value: key),
            StringPair("DefaultValue", value: defaultValue),
            ArrayPair("Values", values: values),
            ArrayPair("Titles", values: readable),
            ArrayPair("ShortTitles", values: shortReadable),
            BoolPair("DisplaySortedByTitle", value: sortByTitle)
        ]
        return entries.compactMap { $0.getXML() }
            .joined(separator: "\n")
            .makeDict()
    }
}
