// Copyright (c) 2021 Benjamin Robinson.
//
// SettingsBundleBuilder
// StringPair.swift

struct StringPair: KeyValuePair {
    let key: String
    let value: String?
    
    init(_ key: String, value: String?) {
        self.key = key
        self.value = value
    }
    
    func getXML() -> String? {
        guard let value = value else { return nil }
        
        return """
            <key>\(key)</key>
            <string>\(value)</string>
            """
    }
}
