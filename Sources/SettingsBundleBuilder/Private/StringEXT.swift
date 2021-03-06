// Copyright (c) 2021 Benjamin Robinson.
//
// SettingsBundleBuilder
// StringEXT.swift

extension String {
    func makeDict() -> String {
        return "<dict>\n" + self + "\n</dict>"
    }
    
    func makeArray() -> String {
        return "<array>\n" + self + "\n</array>"
    }
}
