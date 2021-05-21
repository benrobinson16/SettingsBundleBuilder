# SettingsBundleBuilder

`SettingsBundleBuilder` provides an easy way to produce settings bundles for iOS apps with a SwiftUI-like syntax.

## Motivation

Working with property list files is a nuisance - you might not know what key/values are required for each settings item. With a SwiftUI style syntax, there is the benefit of type-checking and autocomplete. You can then be told exactly where the errors are in your `plist` without running the app and inspecting it.

Additionally, property lists can become difficult to work with for large setting screens. Again, a SwiftUI style syntax drastically improves this because it is easier to see the hierachal view structure.

## Quick Start

1. Add a new Swift Package locally to your existing project.

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

> Don't forget to add `"SettingsBundleBuilder"` as a dependency to the main target in the package as well.

3. In `main.swift`, create your settings bundle using the `makeSettingsBundle` method. A quick example:

```swift
import SettingsBundleBuilder

makeSettingsBundle {
    Group("Main settings:") {
        TextField("Name", key: "username")
        Toggle("Personalized features", key: "personalization", defaultValue: false)
    }
}
```

4. Run the Swift Package (`⌘ + R`) which will generate the settings bundle and open it in a Finder window. Drag this into your main project and you're good to go!

## Example Usage

Below is an example of a complex settings bundle using every `SettingsBundleItem` in the package:

```swift
import SettingsBundleBuilder

makeSettingsBundle {
    Group("Main settings:") {
        TextField("Name", key: "username")
        MultiValue(
            "Background music",
            key: "background_music",
            defaultValue: "ocean",
            possibleValues: ["ocean", "forest", "city", "cafe", "river"],
            readableVersions: ["Ocean", "Forest", "Bustling city", "Quiet cafe", "Gentle stream"]
        )
    }
    
    RadioGroup(
        "Color scheme:",
        key: "color_scheme",
        defaultValue: "blue",
        possibleValues: ["blue", "red", "green"],
        readableVersions: ["Blue", "Red", "Green"]
    )
    
    Group("Info") {
        Text("App name", constantValue: "My app")
        Text("App version", key: "version", defaultValue: "1.0.0")
        Page("Advanced") {
            Toggle("Experimental features", key: "experimental_features", defaultValue: false)
            Slider(key: "opacity", defaultValue: 50.0, min: 0.0, max: 100.0)
        }
    }
}
```

## SettingsBundleItem

There are many items provided in this package, each used to present a particular cell on the settings page. 

Some of the frequent properties used by the items are below:

- `title` - the string displayed to the user describing this setting/item
- `key` - the `UserDefaults` key to change when this setting is changed
- `defaultValue` - the value to provide to the UI when the key cannot be found in `UserDefaults`

> There are many other parameters but these are fairly straightforward and documented using Xcode's documentation tool. To access documentation, use `command + click` on a method/type.

The full list of items are:

- `Group`
- `MultiValue`
- `Page`
- `RadioGroup`
- `Slider`
- `Text`
- `TextField`
- `Toggle`

### MultiValue, RadioGroup and Text

The `MultiValue`, `RadioGroup` and `Text` items use a different strategy to display text to the user. To do so, they use these properties:

- `possibleValues` - the possible string values that could be stored in `UserDefaults` for the provided key
- `readableValues` - a mapping of the `possibleValues` to human readable versions; this array should be in the same order as the possible values

For `MultiValue` and `RadioGroup`, this is used to display the list of values a user can choose from.

For `Text`, this is used to display dynamic content based on a value in `UserDefaults`.

### Groups

A `Group` offers a way to organise multiple items. Optionally provide header and footer text.

Note that groups cannot be nested inside one another. The `RadioGroup` item acts like a group in the UI so cannot be placed inside a `Group`.

**NOTE**: If an non-group item is placed at the root level after a `Group`, it will appear in the group in the UI due to the formatting of a `.plist` settings bundle. To avoid this, embed this item in a group.

### Pages

A `Page` can offer nested pages of settings. Simply provide the `title` and `content`.

To split code apart for clarity, use something similar to the following:

```swift
@SettingsBundleBuilder
func mySecondPage() -> [SettingsBundleItem] {
    // second page content
}

makeSettingsBundle {
    Group("My Group") {
        Page("2nd page", content: mySecondPage)
    }
}
```

## Future Improvements

Future improvements I may make to this package in the future include:

- [ ] Support for localized strings
- [ ] Support for `SupportedUserInterfaceIdioms` to change settings bundle for iOS and iPadOS
- [ ] Ability to add a `MinimumValueImage` and `MaximumValueImage` for `Slider`

## Legal

Please see LICENSE.md for license details.
