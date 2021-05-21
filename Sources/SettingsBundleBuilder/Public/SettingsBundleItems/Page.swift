// Copyright (c) 2021 Ben Robinson.
// All Rights Reserved.
//
// SettingsBundleBuilder
// Page.swift

import Foundation

public struct Page: SettingsBundleItem, NonGroupSettingsBundleItem {
    let title: String
    let items: [SettingsBundleItem]
    
    /// Makes a new `Page` item
    /// - Parameters:
    ///   - title: The title of the `NavigationLink` to the page
    ///   - content: The content of the new page
    public init(
        _ title: String,
        @SettingsBundleBuilder content: () -> [SettingsBundleItem]
    ) {
        self.title = title
        self.items = content()
    }
    
    public func makePlist() -> String {
        let filename = UUID().uuidString
        let plist = makePlistFile(contents: items)
        writePlist(contents: plist, filename: filename)
        
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
