// Copyright (c) 2021 Ben Robinson.
// All Rights Reserved.
//
// SettingsBundleBuilder
// Slider.swift

public struct Slider: SettingsBundleItem, NonGroupSettingsBundleItem {
    let key: String
    let defaultValue: Double
    let min: Double
    let max: Double
//    let minImage: String
//    let maxImage: String
    
    public init(
        key: String,
        defaultValue: Double,
        min: Double,
        max: Double
    ) {
        self.key = key
        self.defaultValue = defaultValue
        self.min = min
        self.max = max
    }
    
    public func makePlist() -> String {
        let entries: [KeyValuePair] = [
            StringPair("Type", value: "PSSliderSpecifier"),
            StringPair("Key", value: key),
            RealPair("DefaultValue", value: defaultValue),
            RealPair("MinimumValue", value: min),
            RealPair("MaximumValue", value: max)
        ]
        return entries.compactMap { $0.getXML() }
            .joined(separator: "\n")
            .makeDict()
    }
}
