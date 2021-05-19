// Copyright (c) 2021 Ben Robinson.
// All Rights Reserved.
//
// SettingsBundleBuilder
// MakeSettingsBundle.swift

import Foundation

/// Actually makes the `Settings.bundle` folder.
/// - Parameters:
///   - path: The path from the root of the Xcode project to where you would like the bundle to be located. Do not include the filename of the settings bundle.
///   - content: The `SettingsBundleItem`s that you would like to add to the bundle.
public func makeSettingsBundle(
    path: String,
    @SettingsBundleBuilder _ content: () -> [SettingsBundleItem]
) {
    let contentplist = content().map { $0.makePlist() }.joined()
    let contents = """
        <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
        <plist version="1.0">
        <dict>
            <key>StringsTable</key>
            <string>Root</string>
            <key>PreferenceSpecifiers</key>
            <array>
                \(contentplist)
            </array>
        </dict>
        </plist>
        """
    
    let currentUrl = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
    try! FileManager.default.createDirectory(at: currentUrl, withIntermediateDirectories: true, attributes: nil)
    
    let baseUrl = currentUrl.appendingPathComponent("Settings Bundle")
    print(baseUrl.absoluteString)
    
    let bundleUrl = baseUrl.appendingPathComponent("Settings.bundle")
    print(bundleUrl.absoluteString)
    try! FileManager.default.createDirectory(at: bundleUrl, withIntermediateDirectories: true, attributes: nil)
    
    let plistUrl = bundleUrl.appendingPathComponent("Root.plist")
    print(plistUrl.absoluteString)
    try! contents.data(using: .utf8)?.write(to: plistUrl)
    
    shell("open", currentUrl.absoluteString)
}

@discardableResult
fileprivate func shell(_ args: String...) -> Int32 {
    let task = Process()
    task.launchPath = "/usr/bin/env"
    task.arguments = args
    task.launch()
    task.waitUntilExit()
    return task.terminationStatus
}
