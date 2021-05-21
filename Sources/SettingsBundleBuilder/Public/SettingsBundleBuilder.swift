// Copyright (c) 2021 Ben Robinson.
// All Rights Reserved.
//
// SettingsBundleBuilder
// SettingsBundleBuilder.swift

import Foundation

@resultBuilder
public struct SettingsBundleBuilder {
    static public func buildBlock() -> [SettingsBundleItem] {
        return []
    }
    
    static public func buildBlock(_ items: SettingsBundleItem...) -> [SettingsBundleItem] {
        return items
    }
}

@resultBuilder
public struct NonGroupSettingsBundleBuilder {
    static public func buildBlock() -> [NonGroupSettingsBundleItem] {
        return []
    }
    
    static public func buildBlock(_ items: NonGroupSettingsBundleItem...) -> [NonGroupSettingsBundleItem] {
        return items
    }
}
