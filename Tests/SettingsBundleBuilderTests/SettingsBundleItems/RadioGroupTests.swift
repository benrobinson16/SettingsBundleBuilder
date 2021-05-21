// Copyright (c) 2021 Ben Robinson.
// All Rights Reserved.
//
// SettingsBundleBuilderTests
// RadioGroupTests.swift

import XCTest
@testable import SettingsBundleBuilder

class RadioGroupTests: XCTestCase {
    func test_makePlist_default() {
        let radioGroup = RadioGroup(
            "Test title",
            key: "radiogroupkey",
            defaultValue: "Default Radio Value",
            possibleValues: ["Val1", "Val2"],
            readableVersions: ["1", "2"]
        )
        let output = radioGroup.makePlist()
        
        let expectedOutput = """
            <dict>
            <key>Type</key>
            <string>PSRadioGroupSpecifier</string>
            <key>Title</key>
            <string>Test title</string>
            <key>Key</key>
            <string>radiogroupkey</string>
            <key>DefaultValue</key>
            <string>Default Radio Value</string>
            <key>Values</key>
            <array>
            <string>Val1</string>
            <string>Val2</string>
            </array>
            <key>Titles</key>
            <array>
            <string>1</string>
            <string>2</string>
            </array>
            </dict>
            """
        
        XCTAssertEqual(output, expectedOutput)
    }
    
    func test_makePlist_allProperties() {
        let radioGroup = RadioGroup(
            "Another title",
            key: "radiogroupkey2",
            defaultValue: "Default Val2",
            possibleValues: ["Val1"],
            readableVersions: ["1"],
            sortByTitle: true,
            footerText: "footertext example"
        )
        let output = radioGroup.makePlist()
        
        let expectedOutput = """
            <dict>
            <key>Type</key>
            <string>PSRadioGroupSpecifier</string>
            <key>Title</key>
            <string>Another title</string>
            <key>Key</key>
            <string>radiogroupkey2</string>
            <key>DefaultValue</key>
            <string>Default Val2</string>
            <key>Values</key>
            <array>
            <string>Val1</string>
            </array>
            <key>Titles</key>
            <array>
            <string>1</string>
            </array>
            <key>DisplaySortedByTitle</key>
            <true/>
            <key>FooterText</key>
            <string>footertext example</string>
            </dict>
            """
        
        XCTAssertEqual(output, expectedOutput)
    }
}
