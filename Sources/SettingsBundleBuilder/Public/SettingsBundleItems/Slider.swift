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
    
    /// Makes a new `Slider` item
    /// - Parameters:
    ///   - key: The key of the `UserDefaults` value to change
    ///   - defaultValue: The value to use if the key is not in `UserDefaults`
    ///   - min: The minimum value of the slider
    ///   - max: The maximum value of the slider
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
