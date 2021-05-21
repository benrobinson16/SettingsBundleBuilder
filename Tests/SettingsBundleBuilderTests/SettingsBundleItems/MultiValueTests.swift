// Copyright (c) 2021 Ben Robinson.
// All Rights Reserved.
//
// SettingsBundleBuilderTests
// MultiValueTests.swift

import XCTest
@testable import SettingsBundleBuilder

class MultiValueTests: XCTestCase {
    func test_makePlist_default() {
        let multiValue = MultiValue(
            "Test title",
            key: "multivaluekey",
            defaultValue: "Val1",
            possibleValues: ["Val1", "Val2"],
            readableVersions: ["1", "2"]
        )
        let output = multiValue.makePlist()
        
        let expectedOuput = """
            <dict>
            <key>Type</key>
            <string>PSMultiValueSpecifier</string>
            <key>Title</key>
            <string>Test title</string>
            <key>Key</key>
            <string>multivaluekey</string>
            <key>DefaultValue</key>
            <string>Val1</string>
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
        
        XCTAssertEqual(output, expectedOuput)
    }
    
    func test_makePlist_allProperties() {
        let multiValue = MultiValue(
            "Another title",
            key: "multivaluekey2",
            defaultValue: "Val2",
            possibleValues: ["Val1", "Val2"],
            readableVersions: ["One", "Two"],
            shortVersions: ["1", "2"],
            sortByTitle: true
        )
        let output = multiValue.makePlist()
        
        let expectedOuput = """
            <dict>
            <key>Type</key>
            <string>PSMultiValueSpecifier</string>
            <key>Title</key>
            <string>Another title</string>
            <key>Key</key>
            <string>multivaluekey2</string>
            <key>DefaultValue</key>
            <string>Val2</string>
            <key>Values</key>
            <array>
            <string>Val1</string>
            <string>Val2</string>
            </array>
            <key>Titles</key>
            <array>
            <string>One</string>
            <string>Two</string>
            </array>
            <key>ShortTitles</key>
            <array>
            <string>1</string>
            <string>2</string>
            </array>
            <key>DisplaySortedByTitle</key>
            <true/>
            </dict>
            """
        
        XCTAssertEqual(output, expectedOuput)
    }
}
