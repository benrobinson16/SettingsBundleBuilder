// Copyright (c) 2021 Benjamin Robinson.
//
// SettingsBundleBuilder
// SettingsBundleItem.swift

public protocol SettingsBundleItem {
    func makePlist() -> String
}

public protocol NonGroupSettingsBundleItem {
    func makePlist() -> String
}
