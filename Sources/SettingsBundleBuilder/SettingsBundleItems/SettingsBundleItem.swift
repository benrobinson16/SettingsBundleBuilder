// Copyright (c) 2021 Ben Robinson.
// All Rights Reserved.
//
// SettingsBundleBuilder
// SettingsBundleItem.swift

public protocol SettingsBundleItem {
    func makePlist() -> String
}

public protocol NonGroupSettingsBundleItem {
    func makePlist() -> String
}
