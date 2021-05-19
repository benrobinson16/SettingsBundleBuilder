// Copyright (c) 2021 Ben Robinson.
// All Rights Reserved.
//
// SettingsBundleBuilder
// Group.swift

public struct Group: SettingsBundleItem {
    var title: String?
    var footerText: String?
    
    let items: [SettingsBundleItem]
    
    /// Makes a new `Group` with multiple children
    /// - Parameters:
    ///   - title: The title of the group
    ///   - footerText: The footer of the group
    ///   - items: The items to display inside the group
    public init(title: String? = nil, footerText: String? = nil, @SettingsBundleBuilder items: () -> [SettingsBundleItem]) {
        self.title = title
        self.footerText = footerText
        self.items = items()
    }
    
    /// Makes a new `Group` with one child
    /// - Parameters:
    ///   - title: The title of the group
    ///   - footerText: The footer of the group
    ///   - item: The item to display inside the group
//    public init(title: String? = nil, footerText: String? = nil, item: () -> SettingsBundleItem) {
//        self.title = title
//        self.footerText = footerText
//        self.items = [item()]
//    }
    
    public func makePlist() -> String {
        let entries: [KeyValuePair] = [
            StringPair("Type", value: "PSGroupSpecifier"),
            StringPair("Title", value: title),
            StringPair("FooterText", value: footerText)
        ]
        let group = entries.compactMap { $0.getXML() }.joined().makeDict()
        let children = items.map { $0.makePlist() }.joined()
        return group + children
    }
}
