//
//  WBLanguagePicker.swift
//  WBLanguage
//
//  Created by zwb on 2017/7/10.
//  Copyright © 2017年 HengSu Co., LTD. All rights reserved.
//

import UIKit

// MARK: - Base Picker

open class WBLanguagePicker: NSObject, NSCopying {

    public typealias PickerType = () -> Any?
    
    public var value: PickerType
    
    required public init(_ value: @escaping PickerType) {
        self.value = value
    }
    
    open func copy(with zone: NSZone? = nil) -> Any {
        return type(of: self).init(value)
    }
    
}

// MARK: - Text Picker

open class WBLanguageTextPicker: WBLanguagePicker, ExpressibleByStringLiteral {
    
    public convenience init(keyPath: String) {
        self.init({ return WBLanguageManager.textForKey(keyPath) })
    }
    
    public required convenience init(stringLiteral value: String) {
        self.init(keyPath: value)
    }
    
    public required convenience init(unicodeScalarLiteral value: String) {
        self.init(keyPath: value)
    }
    
    public required convenience init(extendedGraphemeClusterLiteral value: String) {
        self.init(keyPath: value)
    }
    
    open class func pickerForKeyPath(_ keyPath: String) -> WBLanguageTextPicker {
        return WBLanguageTextPicker(keyPath: keyPath)
    }
}

// MARK: - Dictionary Picker
/// NSAttributedString Picker. The dicts must contains ["picker": String...]
open class WBLanguageDictionaryPicker: WBLanguagePicker, ExpressibleByArrayLiteral {

    public convenience init(dicts: [AnyHashable: Any]...) {
        self.init ({ return WBLanguageManager.attributedStringForDict(dicts) })
    }
    
    public required convenience init(arrayLiteral elements: [AnyHashable: Any]...) {
        self.init({ return WBLanguageManager.attributedStringForDict(elements) })
    }
    
    open class func pickerWithDicts(_ dicts: [[AnyHashable: Any]]) -> WBLanguageDictionaryPicker {
        return WBLanguageDictionaryPicker( { return WBLanguageManager.attributedStringForDict(dicts) })
    }
}

// MARK: - State Picker

open class WBLanguageStatePicker: WBLanguagePicker {
    
    public typealias ValuesType = [UInt : WBLanguagePicker]
    
    open var values = ValuesType()
    
    public convenience init?(_ picker: WBLanguagePicker?, forState state: UIControlState) {
        guard let picker = picker else { return nil }
        self.init( { return 0 })
        values[state.rawValue] = picker
    }
    
    open func setPicker(_ picker: WBLanguagePicker?, forState state: UIControlState) -> Self {
        values[state.rawValue] = picker
        return self
    }
}

// MARK: - Int Picker

open class WBLanguageIntPicker: WBLanguagePicker {
    
    public typealias IndexType = [Int: WBLanguagePicker]
    
    open var values = IndexType()
    
    public convenience init?(_ picker: WBLanguagePicker?, forIndex index: Int) {
        guard let picker = picker else { return nil }
        self.init( { return 0 })
        values[index] = picker
    }
    
    open func setPicker(_ picker: WBLanguagePicker?, forIndex index: Int) -> Self {
        values[index] = picker
        return self
    }
}
