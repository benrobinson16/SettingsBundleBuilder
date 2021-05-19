// Copyright (c) 2021 Ben Robinson.
// All Rights Reserved.
//
// SettingsBundleBuilder
// RealPair.swift

struct RealPair: KeyValuePair {
    let key: String
    let value: Double?
    
    init(_ key: String, value: Double?) {
        self.key = key
        self.value = value
    }
    
    func getXML() -> String? {
        guard let value = value else { return nil }
        
        return """
            <key>\(key)</key>
            <real>\(value)</real>
            """
    }
}
