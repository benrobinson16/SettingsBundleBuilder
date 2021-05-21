// Copyright (c) 2021 Benjamin Robinson.
//
// SettingsBundleBuilder
// FileHandling.swift

import Foundation

func getBaseUrl() -> URL {
    return URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
        .appendingPathComponent("Settings Bundle")
}

func deletePriorBundle() {
    do {
        try FileManager.default.removeItem(at: getBaseUrl())
    } catch {
        print("Could not delete previous settings bundle. If this is the first run, please ignore.")
    }
}

func writePlist(contents: String, filename: String) {
    let baseUrl = getBaseUrl()
    let bundleUrl = baseUrl.appendingPathComponent("Settings.bundle")
    try! FileManager.default.createDirectory(at: bundleUrl, withIntermediateDirectories: true, attributes: nil)
    
    let plistUrl = bundleUrl.appendingPathComponent("\(filename).plist")
    try! contents.data(using: .utf8)?.write(to: plistUrl)
}
