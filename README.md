# SettingsBundleBuilder

`SettingsBundleBuilder` provides an easy way to produce settings bundles for iOS apps with a SwiftUI-like syntax.

## Quick Start

1. Add a new Swift Package locally to your project. Follow [this] tutorial to see how to add this to an existing iOS app Xcode Project.

2. Mark the Swift Package as executable by changing the `Package.swift` file to list the following instead of a library:

```swift
products: [
    .executable(name: "PackageName", targets: ["PackageName"])
]
```

3. Add `SettingsBundleBuilder` as a dependency, by adding:

```swift
.package(
    name: "SettingsBundleBuilder", 
    url: "https://github.com/benrobinson16/SettingsBundleBuilder.git", 
    .upToNextMajor(from: "1.0.0")
)
```

> Don't forget to add `"SettingsBundleBuilder"` to the dependencies of your main target as well.

3. In `main.swift`, create your settings bundle using the `makeSettingsBundle` method. An example is below:

```swift
import SettingsBundleBuilder

makeSettingsBundle("Path/To/Bundle") {
    Group {
        TextField("username", title: "Enter username:", defaultValue: "")
        Toggle("personalization", title: "Enable personalization:", defaultValue: false)
    }
    
    Group("App Info") {
        Text("Version 1.0")
        Text("Build no. 123")
    }
}
```

4. Run the Swift Package which will generate the settings bundle at the specified path in your main project.

## In Depth

All public methods and types are documented so use `Command + click` to view quick help in Xcode.
