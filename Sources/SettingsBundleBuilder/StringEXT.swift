// Copyright (c) 2021 Ben Robinson.
// All Rights Reserved.
//
// SettingsBundleBuilder
// StringEXT.swift

extension String {
    func makeDict() -> String {
        return "<dict>" + self + "</dict>"
    }
    
    func makeArray() -> String {
        return "<array>" + self + "</array>"
    }
}
