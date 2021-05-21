// Copyright (c) 2021 Ben Robinson.
// All Rights Reserved.
//
// SettingsBundleBuilder
// MakeSettingsBundle.swift

import Foundation

/// Makes and opens a new `Settings.bundle`
/// - Parameter content: The content of the bundle
public func makeSettingsBundle(
    @SettingsBundleBuilder _ content: () -> [SettingsBundleItem]
) {
    let baseUrl = URL(fileURLWithPath: FileManager.default.currentDirectoryPath).appendingPathComponent("Settings Bundle")
    try! FileManager.default.removeItem(at: baseUrl)
    
    makeAndWritePlist(contents: content(), filename: "Root")
    
    shell("open", baseUrl.absoluteString)
}
