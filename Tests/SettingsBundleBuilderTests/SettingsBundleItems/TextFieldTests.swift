// Copyright (c) 2021 Ben Robinson.
// All Rights Reserved.
//
// SettingsBundleBuilderTests
// TextFieldTests.swift

import XCTest
@testable import SettingsBundleBuilder

class TextFieldTests: XCTestCase {
    func test_makePlist_default() {
        let textField = TextField("Test title", key: "textfieldkey")
        let output = textField.makePlist()
        
        let expectedOutput = """
            <dict>
            <key>Type</key>
            <string>PSTextFieldSpecifier</string>
            <key>Title</key>
            <string>Test title</string>
            <key>Key</key>
            <string>textfieldkey</string>
            </dict>
            """
        
        XCTAssertEqual(output, expectedOutput)
    }
    
    func test_makePlist_allProperties() {
        let textField = TextField(
            "Another title",
            key: "textfieldkey2",
            defaultValue: "testdefault",
            isSecure: false,
            keyboard: .numberPad,
            autocapitalization: .sentences,
            autocorrection: .no
        )
        let output = textField.makePlist()
        
        let expectedOutput = """
            <dict>
            <key>Type</key>
            <string>PSTextFieldSpecifier</string>
            <key>Title</key>
            <string>Another title</string>
            <key>Key</key>
            <string>textfieldkey2</string>
            <key>DefaultValue</key>
            <string>testdefault</string>
            <key>IsSecure</key>
            <false/>
            <key>KeyboardType</key>
            <string>NumberPad</string>
            <key>AutocapitalizationType</key>
            <string>Sentences</string>
            <key>AutocorrectionType</key>
            <string>No</string>
            </dict>
            """
        
        XCTAssertEqual(output, expectedOutput)
    }
}
