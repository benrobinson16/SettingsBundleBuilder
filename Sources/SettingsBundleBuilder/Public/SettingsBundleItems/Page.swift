// Copyright (c) 2021 Benjamin Robinson.
//
// SettingsBundleBuilder
// Page.swift

import Foundation

public struct Page: SettingsBundleItem, NonGroupSettingsBundleItem {
    let title: String
    let filename: String
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
        self.filename = UUID().uuidString
        self.items = content()
    }
    
    /// Makes a new `Page` item
    /// - Parameters:
    ///   - title: The title of the `NavigationLink` to the page
    ///   - filename: a fixed filename (no extension) for the descendant page. Make sure not to collide with other files!
    ///   - content: The content of the new page
    public init(
        _ title: String,
        filename: String,
        @SettingsBundleBuilder content: () -> [SettingsBundleItem]
    ) {
        self.title = title
        self.filename = filename
        self.items = content()
    }

    public func makePlist() -> String {
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
