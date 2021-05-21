// Copyright (c) 2021 Ben Robinson.
// All Rights Reserved.
//
// SettingsBundleBuilderTests
// GroupTests.swift

import XCTest
@testable import SettingsBundleBuilder

class GroupTests: XCTestCase {
    func test_makePlist_default() {
        let text = Text("Text example", key: "textkey", defaultValue: "Default text")
        let group = Group {
            text
        }
        let output = group.makePlist()
        
        let expectedOuput = """
            <dict>
            <key>Type</key>
            <string>PSGroupSpecifier</string>
            </dict>
            \(text.makePlist())
            """
        
        XCTAssertEqual(output, expectedOuput)
    }
    
    func test_makePlist_allProperties() {
        let text = Text("Text example", key: "textkey", defaultValue: "Default text")
        let group = Group("Test title", footerText: "Example footer") {
            text
        }
        let output = group.makePlist()
        
        let expectedOuput = """
            <dict>
            <key>Type</key>
            <string>PSGroupSpecifier</string>
            <key>Title</key>
            <string>Test title</string>
            <key>FooterText</key>
            <string>Example footer</string>
            </dict>
            \(text.makePlist())
            """
        
        XCTAssertEqual(output, expectedOuput)
    }
}
