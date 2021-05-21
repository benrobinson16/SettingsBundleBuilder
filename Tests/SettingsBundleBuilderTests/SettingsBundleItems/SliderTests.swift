// Copyright (c) 2021 Ben Robinson.
// All Rights Reserved.
//
// SettingsBundleBuilderTests
// SliderTests.swift

import XCTest
@testable import SettingsBundleBuilder

class SliderTests: XCTestCase {
    func test_makePlist() {
        let slider = Slider(key: "sliderkey", defaultValue: 5.0, min: 0.0, max: 100.0)
        let output = slider.makePlist()
        
        let expectedOutput = """
            <dict>
            <key>Type</key>
            <string>PSSliderSpecifier</string>
            <key>Key</key>
            <string>sliderkey</string>
            <key>DefaultValue</key>
            <real>5.0</real>
            <key>MinimumValue</key>
            <real>0.0</real>
            <key>MaximumValue</key>
            <real>100.0</real>
            </dict>
            """
        
        XCTAssertEqual(output, expectedOutput)
    }
}
