//
//  WBLanguage+UIKit.swift
//  WBLanguage
//
//  Created by zwb on 2017/7/10.
//  Copyright © 2017年 HengSu Co., LTD. All rights reserved.
//

import UIKit

// MARK: - UILabel
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
// MARK: - UITextField
public extension WBLanguage where T : UITextField {
    public func setPicker(_ picker: WBLanguageTextPicker?) {
        setLanguagePicker(value, Selector: "setText:", Picker: picker)
    }
    public func setAttributedPicker(_ picker: WBLanguageDictionaryPicker?) {
        setLanguagePicker(value, Selector: "setAttributedText:", Picker: picker)
    }
    public func setPlaceHolderPicker(_ picker: WBLanguageTextPicker?) {
        setLanguagePicker(value, Selector: "setPlaceholder:", Picker: picker)
    }
    public func setAttributedPlaceHolderPicker(_ picker: WBLanguageDictionaryPicker?) {
        setLanguagePicker(value, Selector: "setAttributedPlaceholder:", Picker: picker)
    }
    public var picker: WBLanguageTextPicker? {
        set{ setLanguagePicker(value, Selector: "setText:", Picker: newValue) }
        get{ return getLanguagePicker(value, Selector: "setText:") as? WBLanguageTextPicker }
    }
    public var attributedPicker: WBLanguageDictionaryPicker? {
        set{ setLanguagePicker(value, Selector: "setAttributedText:", Picker: newValue) }
        get{ return getLanguagePicker(value, Selector: "setAttributedText:") as? WBLanguageDictionaryPicker }
    }
    public var placeHolderPicker: WBLanguageTextPicker? {
        set{ setLanguagePicker(value, Selector: "setPlaceholder:", Picker: newValue) }
        get{ return getLanguagePicker(value, Selector: "setPlaceholder:") as? WBLanguageTextPicker }
    }
    public var attributedPlaceHolderPicker: WBLanguageDictionaryPicker? {
        set { setLanguagePicker(value, Selector: "setAttributedPlaceholder:", Picker: picker) }
        get { return getLanguagePicker(value, Selector: "setAttributedPlaceholder:") as? WBLanguageDictionaryPicker }
    }
}
// MARK: - UITextView
public extension WBLanguage where T : UITextView {
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
// MARK: - UISegmentedControl
public extension WBLanguage where T : UISegmentedControl {
    public func setPicker(_ picker: WBLanguageTextPicker?, forSegmentAt segment: Int) {
        let intPicker = setIntPicker(value, Selector: "setTitle:forSegmentAtIndex:", Picker: picker, Index: segment)
        setLanguagePicker(value, Selector: "setTitle:forSegmentAtIndex:", Picker: intPicker)
    }
}
// MARK: - UIButton
public extension WBLanguage where T : UIButton {
    public func setPicker(_ picker: WBLanguageTextPicker?, forState state: UIControlState) {
        let statePicker = setStatePicker(value, Selector: "setTitle:forState:", Picker: picker, State: state)
        setLanguagePicker(value, Selector: "setTitle:forState:", Picker: statePicker)
    }
    public func setAttributedPicker(_ picker: WBLanguageDictionaryPicker?, forState state: UIControlState) {
        let statePicker = setStatePicker(value, Selector: "setAttributedTitle:forState:", Picker: picker, State: state)
        setLanguagePicker(value, Selector: "setAttributedTitle:forState:", Picker: statePicker)
    }
}
// MARK: - UIBarButtonItem
public extension WBLanguage where T : UIBarButtonItem {
    public func setPicker(_ picker: WBLanguageTextPicker?) {
        setLanguagePicker(value, Selector: "setTitle:", Picker: picker)
    }
    public var picker: WBLanguageTextPicker? {
        set{ setLanguagePicker(value, Selector: "setTitle:", Picker: newValue) }
        get{ return getLanguagePicker(value, Selector: "setTitle:") as? WBLanguageTextPicker }
    }
}
// MARK: - UIViewController
public extension WBLanguage where T : UIViewController {
    public func setPicker(_ picker: WBLanguageTextPicker?) {
        setLanguagePicker(value, Selector: "setTitle:", Picker: picker)
    }
    public var picker: WBLanguageTextPicker? {
        set{ setLanguagePicker(value, Selector: "setTitle:", Picker: newValue) }
        get{ return getLanguagePicker(value, Selector: "setTitle:") as? WBLanguageTextPicker }
    }
}

// MARK: - Private

private func setLanguagePicker(
    _ object: NSObject,
    Selector selector: String,
    Picker picker: WBLanguagePicker?
) {
    object.languagePickers[selector] = picker
    object.performLanguage(selector, Picker: picker)
}

private func getLanguagePicker(
    _ object: NSObject,
    Selector selector: String
) -> WBLanguagePicker? {
    return object.languagePickers[selector]
}

private func setStatePicker(
    _ object: NSObject,
    Selector selector: String,
    Picker picker: WBLanguagePicker?,
    State state: UIControlState
) -> WBLanguagePicker? {
    var picker = picker
    if let statePicker = object.languagePickers[selector] as? WBLanguageStatePicker {
        picker = statePicker.setPicker(picker, forState: state)
    }else {
        picker = WBLanguageStatePicker(picker, forState: state)
    }
    return picker
}

private func setIntPicker(
    _ object: NSObject,
    Selector selector: String,
    Picker picker: WBLanguagePicker?,
    Index index: Int
) -> WBLanguagePicker? {
    var picker = picker
    if let intPicker = object.languagePickers[selector] as? WBLanguageIntPicker {
        picker = intPicker.setPicker(picker, forIndex: index)
    }else{
        picker = WBLanguageIntPicker(picker, forIndex: index)
    }
    return picker
}
