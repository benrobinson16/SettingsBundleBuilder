// Copyright (c) 2021 Ben Robinson.
// All Rights Reserved.
//
// SettingsBundleBuilder
// FileHandling.swift

import Foundation

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
