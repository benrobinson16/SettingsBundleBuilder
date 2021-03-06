// Copyright (c) 2021 Benjamin Robinson.
//
// SettingsBundleBuilder
// Group.swift

public struct Group: SettingsBundleItem {
    let items: [NonGroupSettingsBundleItem]
    
    let title: String?
    let footerText: String?
    
    /// Makes a new `Group` item
    /// - Parameters:
    ///   - title: The title to display above the group
    ///   - footerText: The text to display below the group
    ///   - content: The content of the group
    public init(
        _ title: String? = nil,
        footerText: String? = nil,
        @NonGroupSettingsBundleBuilder content: () -> [NonGroupSettingsBundleItem]
    ) {
        self.title = title
        self.footerText = footerText
        self.items = content()
    }
    
    public func makePlist() -> String {
        let entries: [KeyValuePair] = [
            StringPair("Type", value: "PSGroupSpecifier"),
            StringPair("Title", value: title),
            StringPair("FooterText", value: footerText)
        ]
        let group = entries
            .compactMap { $0.getXML() }
            .joined(separator: "\n")
            .makeDict()
        let children = items
            .map { $0.makePlist() }
            .joined(separator: "\n")
        return group + "\n" + children
    }
}
