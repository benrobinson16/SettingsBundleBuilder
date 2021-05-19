// Copyright (c) 2021 Ben Robinson.
// All Rights Reserved.
//
// SettingsBundleBuilder
// SettingsBundleItem.swift

/// Describes a type that can operate as an item in a settings bundle
public protocol SettingsBundleItem {
    func makePlist() -> String
}
