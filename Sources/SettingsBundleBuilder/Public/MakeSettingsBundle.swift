// Copyright (c) 2021 Ben Robinson.
// All Rights Reserved.
//
// SettingsBundleBuilder
// MakeSettingsBundle.swift

import Foundation

/// Makes and opens a new `Settings.bundle`
/// - Parameter content: The content of the bundle
public func makeSettingsBundle(@SettingsBundleBuilder _ content: () -> [SettingsBundleItem]) {
    deletePriorBundle()
    
    let plist = makePlistFile(contents: content())
    writePlist(contents: plist, filename: "Root")
    
    shell("open", getBaseUrl().path)
}
