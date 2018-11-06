WBLanguage
==========

[![Build Status](https://api.travis-ci.org/JsonBin/WBLanguage.svg?branch=master)](https://travis-ci.org/JsonBin/WBLanguage)
![Pod version](https://img.shields.io/cocoapods/v/WBLanguage.svg?style=flat)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Platform info](https://img.shields.io/cocoapods/p/WBLanguage.svg?style=flat)](http://cocoadocs.org/docsets/WBLanguage)

![gif](https://github.com/JsonBin/WBLanguage/blob/master/demo.gif "demogif")

## What

WBLanguage is a high level LanguageKit. It provides a High Level API set international language for your app.

## Features

* Less time to switch the language
* Set the language more convenient
* Supported languages: English/French/Italian/German/Russian/Chinese-Hans/Chinese-Hant
* Subsequent can add more national languages

## Installation
WBLanguage supports multiple methods for installing the library in a project.

## CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries like WBAlamofire in your projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

> CocoaPods 1.2.0+ is required to build WBLanguage.

#### Podfile

To integrate WBLanguage into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'

target 'TargetName' do
use_frameworks!

pod 'WBLanguage'

end
```

Then, run the following command:

```bash
$ pod install
```

## Carthage


[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate WBLanguage into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "JsonBin/WBLanguage"
```

Run `carthage` to build the framework and drag the built `WBLanguage.framework` into your Xcode project.
    
## Requirements

- iOS 8+
- Xcode 9.0+
- Swift 4.0+

| WBLanguage Version | Minimum iOS Target | Note |
|:------------------:|:-------------------:|:-----|
| 1.x | iOS 8 | Xcode 9+ is required. |

you must create a 'Language.bundle' resources in your project to hold the international language.

## Usage

### WBLanguageManager class

We can set WBLanguageManager's property at the beggining of app launching, the sample is below:

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        WBLanguageManager.duration = 2.0
        return true
    }
```

if you want to set a new language, you can use `setLanguage(_:)` to update the UI. And it will automatically save the language of your choice.

```swift
WBLanguageManager.setLanguage(type)
```

you can use `textForKey(_:, value:)` to get the local text from *.lproj.

```swift
let string = WBLanguageManager.textForKey("key")
```

### WBLanguage class

WBLanguage supports serializing and deserializing any custom type as long as it conforms to the `WBLanguageProtocol` protocol.

```swift
public extension WBLanguageProtocol {
    public var lt: WBLanguage<Self> {
        return WBLanguage(self)
    }
}

extension `yourCustom` : WBLanguageProtocol {}
```
Note: `WBLanguageProtocol` is a protocol that WBLanguage uses internally to directly. So you need to complete the language setting.

For example:

```swift

private func setLanguagePicker(
    _ object: NSObject,
    Selector selector: String,
    Picker picker: WBLanguagePicker?
) {
    object.languagePickers[selector] = picker
    object.performLanguage(selector, Picker: picker)
}

public extension WBLanguage where T : UILabel {
    public func setPicker(_ picker: WBLanguageTextPicker?) {
        setLanguagePicker(value, Selector: "setText:", Picker: picker)
    }
    public func setAttributedPicker(_ picker: WBLanguageDictionaryPicker?) {
        setLanguagePicker(value, Selector: "setAttributedText:", Picker: picker)
    }
    public var picker: WBLanguageTextPicker? {
        set{ setLanguagePicker(value, Selector: "setText:", Picker: newValue) }
        get{ return getLanguagePicker(value, Selector: "setText:") as? WBLanguageTextPicker }
    }
    public var attributedPicker: WBLanguageDictionaryPicker? {
        set{ setLanguagePicker(value, Selector: "setAttributedText:", Picker: newValue) }
        get{ return getLanguagePicker(value, Selector: "setAttributedText:") as? WBLanguageDictionaryPicker }
    }
}
```
 
## UIKit

### UILabel

```swift
let label = UILabel()
label.lt.picker = "Label"
```
`UILabel` can use `*.lt.picker` or `*.lt.setPicker(_:)` to load text.

Of course, if you want to add attributes to the font, you can use `WBLanguageDictionaryPicker` or `WBLanguageManager.textForKey("key")`

to take out the text first and then add attributes.

use `WBLanguageDictionaryPicker`:

```swift
label.lt.attributedPicker = WBLanguageDictionaryPicker(dicts: ["picker": "Label", NSAttributedStringKey.foregroundColor: UIColor.black, NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 17)])
```
another:

```swift
if let text = WBLanguageManager.textForKey("Label") {
    let att = NSAttributedString(string: text, attributes: [.font: UIFont.boldSystemFont(ofSize: 17), .foregroundColor: UIColor.black])
    label.attributedText = att
}
```

### UITextField

The use of the `UITextField` and `UILabel` is same, just more placeholder:

```swift
let textfield = UITextField()
textfield.lt.placeHolderPicker = "Label"
```

attribute picker:

```swift
textfield.lt.attributedPlaceHolderPicker = WBLanguageDictionaryPicker(dicts: ["picker": "Label", NSAttributedStringKey.foregroundColor: UIColor.black, NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 17)])
```

### UIButton

```swift
let button = UIButton(type: .system)
button.lt.setPicker("Button", forState: .normal)
```

attribute text:

```swift
let picker = WBLanguageDictionaryPicker(dicts: ["picker": "Button", NSAttributedStringKey.foregroundColor: UIColor.black, NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 17), NSAttributedStringKey.strikethroughStyle:NSUnderlineStyle.styleDouble.rawValue])
button.lt.setAttributedPicker(picker, forState: .normal)
```

### UISegmentedControl

```swift
let segment = UISegmentedControl(items: ["","","","",""])
segment.lt.setPicker("English", forSegmentAt: 0)
segment.lt.setPicker("Russian", forSegmentAt: 1)
segment.lt.setPicker("French", forSegmentAt: 2)
segment.lt.setPicker("Italian", forSegmentAt: 3)
segment.lt.setPicker("German", forSegmentAt: 4)
```
`UISegmentedControl` just has one method to set text picker.

## License

WBLanguage is available under the [MIT License](https://raw.github.com/rs/SDWebImage/master/LICENSE). See the LICENSE file for more info.
