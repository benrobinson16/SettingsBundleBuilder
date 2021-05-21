// Copyright (c) 2021 Benjamin Robinson.
//
// SettingsBundleBuilder
// MakePlist.swift

func makePlistFile(contents: [SettingsBundleItem]) -> String {
    let contentplist = contents
        .map { $0.makePlist() }
        .joined(separator: "\n")
    
    return """
        <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
        <plist version="1.0">
        <dict>
        <key>StringsTable</key>
        <string>Root</string>
        <key>PreferenceSpecifiers</key>
        <array>
        \(contentplist)
        </array>
        </dict>
        </plist>
        """
}
