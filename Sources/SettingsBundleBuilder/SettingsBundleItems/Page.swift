// Copyright (c) 2021 Ben Robinson.
// All Rights Reserved.
//
// SettingsBundleBuilder
// Page.swift

import Foundation

public struct Page: SettingsBundleItem, NonGroupSettingsBundleItem {
    let title: String
    let items: [SettingsBundleItem]
    
    public init(
        _ title: String,
        @SettingsBundleBuilder items: () -> [SettingsBundleItem]
    ) {
        self.title = title
        self.items = items()
    }
    
    public func makePlist() -> String {
        let filename = UUID().uuidString
        makeAndWritePlist(contents: items, filename: filename)
        
        let entries: [KeyValuePair] = [
            StringPair("Type", value: "PSChildPaneSpecifier"),
            StringPair("Title", value: title),
            StringPair("File", value: filename)
        ]
        return entries
            .compactMap { $0.getXML() }
            .joined(separator: "\n")
            .makeDict()
    }
}