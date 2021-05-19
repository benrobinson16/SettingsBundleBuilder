// Copyright (c) 2021 Ben Robinson.
// All Rights Reserved.
//
// SettingsBundleBuilder
// RealPair.swift

struct ArrayPair: KeyValuePair {
    let key: String
    let values: [String]?
    
    init(_ key: String, values: [String]?) {
        self.key = key
        self.values = values
    }
    
    func getXML() -> String? {
        guard let values = values else { return nil }
        
        return values
            .map { "<string>\($0)</string>" }
            .joined(separator: "\n")
            .makeArray()
    }
}
