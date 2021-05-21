// Copyright (c) 2021 Ben Robinson.
// All Rights Reserved.
//
// SettingsBundleBuilder
// BoolPair.swift

struct BoolPair: KeyValuePair {
    let key: String
    let value: Bool?
    
    init(_ key: String, value: Bool?) {
        self.key = key
        self.value = value
    }
    
    func getXML() -> String? {
        guard let value = value else { return nil }
        
        if value {
            return """
                <key>\(key)</key>
                <true/>
                """
        }
        
        return """
            <key>\(key)</key>
            <false/>
            """
    }
}
