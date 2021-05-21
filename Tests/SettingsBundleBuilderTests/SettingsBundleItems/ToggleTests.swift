// Copyright (c) 2021 Benjamin Robinson.
//
// SettingsBundleBuilderTests
// ToggleTests.swift

import XCTest
@testable import SettingsBundleBuilder

class ToggleTests: XCTestCase {
    func test_makePlist_defaultValueFalse() {
        let toggle = Toggle("Test title", key: "testkey", defaultValue: false)
        let output = toggle.makePlist()
        
        let expectedOutput = """
            <dict>
            <key>Type</key>
            <string>PSToggleSwitchSpecifier</string>
            <key>Title</key>
            <string>Test title</string>
            <key>Key</key>
            <string>testkey</string>
            <key>DefaultValue</key>
            <false/>
            </dict>
            """
        
        XCTAssertEqual(output, expectedOutput)
    }
    
    func test_makePlist_defaultValueTrue() {
        let toggle = Toggle("Another test title", key: "testkey2", defaultValue: true)
        let output = toggle.makePlist()
        
        let expectedOutput = """
            <dict>
            <key>Type</key>
            <string>PSToggleSwitchSpecifier</string>
            <key>Title</key>
            <string>Another test title</string>
            <key>Key</key>
            <string>testkey2</string>
            <key>DefaultValue</key>
            <true/>
            </dict>
            """
        
        XCTAssertEqual(output, expectedOutput)
    }
}
