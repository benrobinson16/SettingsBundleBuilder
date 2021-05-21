// Copyright (c) 2021 Benjamin Robinson.
//
// SettingsBundleBuilderTests
// TextTests.swift

import XCTest
@testable import SettingsBundleBuilder

class TextTests: XCTestCase {
    func test_makePlist_constantValue() {
        let text = Text("Test title", constantValue: "a constant value")
        let output = text.makePlist()
        
        let expectedPrefix = """
            <dict>
            <key>Type</key>
            <string>PSTitleValueSpecifier</string>
            <key>Title</key>
            <string>Test title</string>
            <key>Key</key>
            <string>
            """
        
        let expectedSuffix = """
            </string>
            <key>DefaultValue</key>
            <string>a constant value</string>
            </dict>
            """
        
        XCTAssertTrue(output.hasPrefix(expectedPrefix), "First half of output correct")
        XCTAssertTrue(output.hasSuffix(expectedSuffix), "Second half of output correct")
    }
    
    func test_makePlist_noValue() {
        let text = Text("Another test title")
        let output = text.makePlist()
        
        let expectedPrefix = """
            <dict>
            <key>Type</key>
            <string>PSTitleValueSpecifier</string>
            <key>Title</key>
            <string>Another test title</string>
            <key>Key</key>
            <string>
            """
        
        let expectedSuffix = """
            </string>
            <key>DefaultValue</key>
            <string></string>
            </dict>
            """
        
        XCTAssertTrue(output.hasPrefix(expectedPrefix), "First half of output correct")
        XCTAssertTrue(output.hasSuffix(expectedSuffix), "Second half of output correct")
    }
    
    func test_makePlist_key() {
        let text = Text("Yet another title", key: "textkey", defaultValue: "Default Text Value")
        let output = text.makePlist()
        
        let expectedOutput = """
            <dict>
            <key>Type</key>
            <string>PSTitleValueSpecifier</string>
            <key>Title</key>
            <string>Yet another title</string>
            <key>Key</key>
            <string>textkey</string>
            <key>DefaultValue</key>
            <string>Default Text Value</string>
            </dict>
            """
        
        XCTAssertEqual(output, expectedOutput)
    }
    
    func test_makePlist_keyArrays() {
        let text = Text(
            "Final title",
            key: "textkey2",
            defaultValue: "Default",
            possibleValues: ["Val1", "Val2"],
            readableVersions: ["1", "2"]
        )
        let output = text.makePlist()
        
        let expectedOutput = """
            <dict>
            <key>Type</key>
            <string>PSTitleValueSpecifier</string>
            <key>Title</key>
            <string>Final title</string>
            <key>Key</key>
            <string>textkey2</string>
            <key>DefaultValue</key>
            <string>Default</string>
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
}
