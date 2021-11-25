//
//  WBLanguage+UIKit.swift
//  WBLanguage
//
//  Created by zwb on 2017/7/10.
//  Copyright © 2017年 HengSu Co., LTD. All rights reserved.
//

import UIKit

// MARK: - UILabel
extension WBLanguage where T : UILabel {
    public var picker: WBLanguageTextPicker? {
        set {
            let selector = #selector(setter: T.text)
            setLanguagePicker(value, selector: selector, picker: newValue)
        }
        get {
            let selector = #selector(setter: T.text)
            return getLanguagePicker(value, selector: selector) as? WBLanguageTextPicker
        }
    }
    
    public var attributedPicker: WBLanguageDictionaryPicker? {
        set {
            let selector = #selector(setter: T.attributedText)
            setLanguagePicker(value, selector: selector, picker: newValue)
        }
        get {
            let selector = #selector(setter: T.attributedText)
            return getLanguagePicker(value, selector: selector) as? WBLanguageDictionaryPicker
        }
    }
    
    public func setPicker(_ picker: WBLanguageTextPicker?) {
        let selector = #selector(setter: T.text)
        setLanguagePicker(value, selector: selector, picker: picker)
    }
    
    public func setAttributedPicker(_ picker: WBLanguageDictionaryPicker?) {
        let selector = #selector(setter: T.attributedText)
        setLanguagePicker(value, selector: selector, picker: picker)
    }
}

// MARK: - UITextField
extension WBLanguage where T : UITextField {
    public var picker: WBLanguageTextPicker? {
        set {
            let selector = #selector(setter: T.text)
            setLanguagePicker(value, selector: selector, picker: newValue)
        }
        get {
            let selector = #selector(setter: T.text)
            return getLanguagePicker(value, selector: selector) as? WBLanguageTextPicker
        }
    }
    
    public var attributedPicker: WBLanguageDictionaryPicker? {
        set {
            let selector = #selector(setter: T.attributedText)
            setLanguagePicker(value, selector: selector, picker: newValue)
        }
        get {
            let selector = #selector(setter: T.attributedText)
            return getLanguagePicker(value, selector: selector) as? WBLanguageDictionaryPicker
        }
    }
    
    public var placeHolderPicker: WBLanguageTextPicker? {
        set {
            let selector = #selector(setter: T.placeholder)
            setLanguagePicker(value, selector: selector, picker: newValue)
        }
        get {
            let selector = #selector(setter: T.placeholder)
            return getLanguagePicker(value, selector: selector) as? WBLanguageTextPicker
        }
    }
    
    public var attributedPlaceHolderPicker: WBLanguageDictionaryPicker? {
        set {
            let selector = #selector(setter: T.attributedPlaceholder)
            setLanguagePicker(value, selector: selector, picker: picker)
        }
        get {
            let selector = #selector(setter: T.attributedPlaceholder)
            return getLanguagePicker(value, selector: selector) as? WBLanguageDictionaryPicker
        }
    }
    
    public func setPicker(_ picker: WBLanguageTextPicker?) {
        let selector = #selector(setter: T.text)
        setLanguagePicker(value, selector: selector, picker: picker)
    }
    
    public func setAttributedPicker(_ picker: WBLanguageDictionaryPicker?) {
        let selector = #selector(setter: T.attributedText)
        setLanguagePicker(value, selector: selector, picker: picker)
    }
    
    public func setPlaceHolderPicker(_ picker: WBLanguageTextPicker?) {
        let selector = #selector(setter: T.placeholder)
        setLanguagePicker(value, selector: selector, picker: picker)
    }
    
    public func setAttributedPlaceHolderPicker(_ picker: WBLanguageDictionaryPicker?) {
        let selector = #selector(setter: T.attributedPlaceholder)
        setLanguagePicker(value, selector: selector, picker: picker)
    }
}

// MARK: - UITextView
extension WBLanguage where T : UITextView {
    public var picker: WBLanguageTextPicker? {
        set {
            let selector = #selector(setter: T.text)
            setLanguagePicker(value, selector: selector, picker: newValue)
        }
        get {
            let selector = #selector(setter: T.text)
            return getLanguagePicker(value, selector: selector) as? WBLanguageTextPicker
        }
    }
    
    public var attributedPicker: WBLanguageDictionaryPicker? {
        set {
            let selector = #selector(setter: T.attributedText)
            setLanguagePicker(value, selector: selector, picker: newValue)
        }
        get {
            let selector = #selector(setter: T.attributedText)
            return getLanguagePicker(value, selector: selector) as? WBLanguageDictionaryPicker
        }
    }
    
    public func setPicker(_ picker: WBLanguageTextPicker?) {
        let selector = #selector(setter: T.text)
        setLanguagePicker(value, selector: selector, picker: picker)
    }
    
    public func setAttributedPicker(_ picker: WBLanguageDictionaryPicker?) {
        let selector = #selector(setter: T.attributedText)
        setLanguagePicker(value, selector: selector, picker: picker)
    }
}

// MARK: - UISegmentedControl
extension WBLanguage where T : UISegmentedControl {
    public func setPicker(_ picker: WBLanguageTextPicker?, forSegmentAt segment: Int) {
        let selector = #selector(T.setTitle(_:forSegmentAt:))
        let intPicker = setIntPicker(value, selector: selector, picker: picker, index: segment)
        setLanguagePicker(value, selector: selector, picker: intPicker)
    }
}

// MARK: - UIButton
extension WBLanguage where T : UIButton {
    public func setPicker(_ picker: WBLanguageTextPicker?, forState state: WBLanguageControlState) {
        let selector = #selector(T.setTitle(_:for:))
        let statePicker = setStatePicker(value, selector: selector, picker: picker, state: state)
        setLanguagePicker(value, selector: selector, picker: statePicker)
    }
    
    public func setAttributedPicker(_ picker: WBLanguageDictionaryPicker?, forState state: WBLanguageControlState) {
        let selector = #selector(T.setAttributedTitle(_:for:))
        let statePicker = setStatePicker(value, selector: selector, picker: picker, state: state)
        setLanguagePicker(value, selector: selector, picker: statePicker)
    }
}

// MARK: - UIBarButtonItem
extension WBLanguage where T : UIBarButtonItem {
    public var picker: WBLanguageTextPicker? {
        set {
            let selector = #selector(setter: T.title)
            setLanguagePicker(value, selector: selector, picker: newValue)
        }
        get {
            let selector = #selector(setter: T.title)
            return getLanguagePicker(value, selector: selector) as? WBLanguageTextPicker
        }
    }
    
    public func setPicker(_ picker: WBLanguageTextPicker?) {
        let selector = #selector(setter: T.title)
        setLanguagePicker(value, selector: selector, picker: picker)
    }
}

// MARK: - UIViewController
extension WBLanguage where T : UIViewController {
    public var picker: WBLanguageTextPicker? {
        set {
            let selector = #selector(setter: T.title)
            setLanguagePicker(value, selector: selector, picker: newValue)
        }
        get {
            let selector = #selector(setter: T.title)
            return getLanguagePicker(value, selector: selector) as? WBLanguageTextPicker
        }
    }
    
    public func setPicker(_ picker: WBLanguageTextPicker?) {
        let selector = #selector(setter: T.title)
        setLanguagePicker(value, selector: selector, picker: picker)
    }
}

// MARK: - Private
private func setLanguagePicker(
    _ object: NSObject,
    selector: Selector,
    picker: WBLanguagePicker?
) {
    object.pickers[selector] = picker
    object.performLanguage(selector, picker: picker)
}

private func getLanguagePicker(
    _ object: NSObject,
    selector: Selector
) -> WBLanguagePicker? {
    return object.pickers[selector]
}

private func setStatePicker(
    _ object: NSObject,
    selector: Selector,
    picker: WBLanguagePicker?,
    state: WBLanguageControlState)
-> WBLanguagePicker? {
    if let statePicker = object.pickers[selector] as? WBLanguageStatePicker {
        return statePicker.setPicker(picker, forState: state)
    }
    return WBLanguageStatePicker(picker, forState: state)
}

private func setIntPicker(
    _ object: NSObject,
    selector: Selector,
    picker: WBLanguagePicker?,
    index: Int)
-> WBLanguagePicker? {
    if let intPicker = object.pickers[selector] as? WBLanguageIntPicker {
        return intPicker.setPicker(picker, forIndex: index)
    }
    return WBLanguageIntPicker(picker, forIndex: index)
}
