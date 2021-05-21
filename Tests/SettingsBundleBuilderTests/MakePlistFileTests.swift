// Copyright (c) 2021 Ben Robinson.
// All Rights Reserved.
//
// SettingsBundleBuilderTests
// MakePlistFileTests.swift

import XCTest
@testable import SettingsBundleBuilder

class MakePlistFileTests: XCTestCase {
    func test_prefix() {
        let contents: [SettingsBundleItem] = [
            Text("Test text"),
            Toggle("Test toggle", key: "togglekey", defaultValue: false)
        ]
        
        let expectedPrefix = """
            <?xml version="1.0" encoding="UTF-8"?>
            <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
            <plist version="1.0">
            <dict>
            <key>StringsTable</key>
            <string>Root</string>
            <key>PreferenceSpecifiers</key>
            <array>
            """
        
        let response = makePlistFile(contents: contents)
        let responseHasPrefix = response.hasPrefix(expectedPrefix)
        
        XCTAssertTrue(responseHasPrefix, "Prefix of makePlistFile output is in correct format")
    }
    
    func test_suffix() {
        let contents: [SettingsBundleItem] = [
            Text("Test text"),
            Toggle("Test toggle", key: "togglekey", defaultValue: false)
        ]
        
        let expectedSuffix = """
            </array>
            </dict>
            </plist>
            """
        
        let response = makePlistFile(contents: contents)
        let responseHasSuffix = response.hasSuffix(expectedSuffix)
        
        XCTAssertTrue(responseHasSuffix, "Suffix of makePlistFile output is in correct format")
    }
    
    func test_content() {
        let contents: [SettingsBundleItem] = [
            Text("Test text"),
            Toggle("Test toggle", key: "togglekey", defaultValue: false)
        ]
        
        let response = makePlistFile(contents: contents)
        
        XCTAssertTrue(response.contains("PSTitleValueSpecifier"), "makePlistFile returns text element specifier")
        XCTAssertTrue(response.contains("Test text"), "makePlistFile returns text element title")
        XCTAssertTrue(response.contains("PSToggleSwitchSpecifier"), "makePlistFile returns toggle element specifier")
        XCTAssertTrue(response.contains("Test toggle"), "makePlistFile returns toggle element title")
        XCTAssertTrue(response.contains("togglekey"), "makePlistFile returns toggle element key")
        XCTAssertTrue(response.contains("<false/>"), "makePlistFile returns toggle element default value")
    }
}
