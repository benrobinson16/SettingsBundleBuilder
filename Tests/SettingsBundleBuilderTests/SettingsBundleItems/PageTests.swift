// Copyright (c) 2021 Benjamin Robinson.
//
// SettingsBundleBuilderTests
// PageTests.swift

import XCTest
@testable import SettingsBundleBuilder

class PageTests: XCTestCase {
    func test_makePlist() {
        deletePriorBundle()
        
        let text = Text("Text example", key: "textkey", defaultValue: "Text default")
        let page = Page("Example Page Title") {
            text
        }
        let output = page.makePlist()
        
        let expectedPrefix = """
            <dict>
            <key>Type</key>
            <string>PSChildPaneSpecifier</string>
            <key>Title</key>
            <string>Example Page Title</string>
            <key>File</key>
            <string>
            """
            
        let expectedSuffix = """
            </string>
            </dict>
            """
        
        XCTAssertTrue(output.hasPrefix(expectedPrefix), "First half of output correct")
        XCTAssertTrue(output.hasSuffix(expectedSuffix), "Second half of output correct")
        
        let filename = output
            .components(separatedBy: "<key>File</key>\n<string>")[1]
            .components(separatedBy: "</string>")[0]
        
        let url = getBaseUrl()
            .appendingPathComponent("Settings.bundle")
            .appendingPathComponent(filename)
            .appendingPathExtension("plist")
        
        let exists = FileManager.default.fileExists(atPath: url.path)
        
        XCTAssertTrue(exists, "Second page file exists")
        
        let contents = try! String(contentsOf: url)
        
        let expectedContents = """
            <?xml version="1.0" encoding="UTF-8"?>
            <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
            <plist version="1.0">
            <dict>
            <key>StringsTable</key>
            <string>Root</string>
            <key>PreferenceSpecifiers</key>
            <array>
            \(text.makePlist())
            </array>
            </dict>
            </plist>
            """
        
        XCTAssertEqual(contents, expectedContents)
    }
    func test_namedPages() {
        deletePriorBundle()

        let expectedFilename = "TestPage"
        let text = Text("Text example", key: "textkey", defaultValue: "Text default")
        let page = Page("Example Page Title", filename: expectedFilename) {
            text
        }
        XCTAssertEqual(page.filename, expectedFilename)

        let output = page.makePlist()

        let filenameAsReference = output
            .components(separatedBy: "<key>File</key>\n<string>")[1]
            .components(separatedBy: "</string>")[0]

        XCTAssertEqual(filenameAsReference, expectedFilename)

        let url = getBaseUrl()
            .appendingPathComponent("Settings.bundle")
            .appendingPathComponent(expectedFilename)
            .appendingPathExtension("plist")

        let exists = FileManager.default.fileExists(atPath: url.path)
        XCTAssertTrue(exists, "Second page file exists")
    }
}
