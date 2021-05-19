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
    @SettingsBundleBuilder _ content: () -> [SettingsBundleItem]
) {
    let baseUrl = URL(fileURLWithPath: FileManager.default.currentDirectoryPath).appendingPathComponent("Settings Bundle")
    
//    var isDir: ObjCBool = true
//    if FileManager.default.fileExists(atPath: baseUrl.absoluteString, isDirectory: &isDir) {
        try! FileManager.default.removeItem(at: baseUrl)
//    }
    
    makeAndWritePlist(contents: content(), filename: "Root")
    
    shell("open", baseUrl.absoluteString)
}

func makeAndWritePlist(contents: [SettingsBundleItem], filename: String) {
    let contentplist = contents
        .map { $0.makePlist() }
        .joined(separator: "\n")
    
    let plist = """
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
    
    let baseUrl = URL(fileURLWithPath: FileManager.default.currentDirectoryPath).appendingPathComponent("Settings Bundle")
    let bundleUrl = baseUrl.appendingPathComponent("Settings.bundle")
    try! FileManager.default.createDirectory(at: bundleUrl, withIntermediateDirectories: true, attributes: nil)
    
    let plistUrl = bundleUrl.appendingPathComponent("\(filename).plist")
    try! plist.data(using: .utf8)?.write(to: plistUrl)
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
