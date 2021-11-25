//
//  WBLanguagePicker.swift
//  WBLanguage
//
//  Created by zwb on 2017/7/10.
//  Copyright © 2017年 HengSu Co., LTD. All rights reserved.
//

import UIKit

// MARK: - Base Picker
public class WBLanguagePicker: NSObject, NSCopying {

    public typealias PickerValue = () -> Any?

    public let value: PickerValue
    
    public required init(_ value: @escaping PickerValue) {
        self.value = value
    }
    
    public func copy(with zone: NSZone?) -> Any {
        return type(of: self).init(self.value)
    }
}

// MARK: - Text Picker
public final class WBLanguageTextPicker: WBLanguagePicker, ExpressibleByStringLiteral {
    
    public convenience init(_ key: String) {
        self.init {
            WBLanguageManager.shared.localizedString(key)
        }
    }
    
    public required convenience init(stringLiteral value: String) {
        self.init(value)
    }
    
    public required convenience init(unicodeScalarLiteral value: String) {
        self.init(value)
    }
    
    public required convenience init(extendedGraphemeClusterLiteral value: String) {
        self.init(value)
    }
    
    public class func pickerForKey(_ key: String) -> Self {
        return Self(key)
    }
}

// MARK: - Dictionary Picker
/// NSAttributedString Picker. The dicts must contains ["picker": String...]
public final class WBLanguageDictionaryPicker: WBLanguagePicker, ExpressibleByArrayLiteral {
    
    public typealias ArrayLiteralElement = [AnyHashable: Any]

    public convenience init(_ dicts: ArrayLiteralElement...) {
        self.init {
            WBLanguageManager.shared.attributedString(dicts)
        }
    }
    
    public required convenience init(arrayLiteral elements: ArrayLiteralElement...) {
        self.init {
            WBLanguageManager.shared.attributedString(elements)
        }
    }
    
    public class func pickerWithDicts(_ dicts: [ArrayLiteralElement]) -> Self {
        return Self {
            WBLanguageManager.shared.attributedString(dicts)
        }
    }
}

// MARK: - State Picker
public final class WBLanguageStatePicker: WBLanguagePicker, ExpressibleByDictionaryLiteral {
    
    public typealias Key = UInt
    public typealias Value = WBLanguagePicker
    
    var values = [Key: Value]()
    
    public convenience init?(_ picker: Value?, forState state: WBLanguageControlState) {
        guard let picker = picker else {
            return nil
        }
        self.init { state.rawValue }
        self.values[state.rawValue] = picker
    }
    
    public required convenience init(dictionaryLiteral elements: (Key, Value)...) {
        self.init { elements.count }
        elements.forEach {
            self.values[$0.0] = $0.1
        }
    }
    
    public func setPicker(_ picker: Value?, forState state: WBLanguageControlState) -> Self {
        self.values[state.rawValue] = picker
        return self
    }
}

// MARK: - Int Picker
public final class WBLanguageIntPicker: WBLanguagePicker, ExpressibleByDictionaryLiteral {
    
    public typealias Key = Int
    public typealias Value = WBLanguagePicker
    
    var values = [Key: Value]()
    
    public convenience init?(_ picker: Value?, forIndex index: Int) {
        guard let picker = picker else {
            return nil
        }
        self.init { index }
        self.values[index] = picker
    }
    
    public required convenience init(dictionaryLiteral elements: (Key, Value)...) {
        self.init { elements.count }
        elements.forEach {
            self.values[$0.0] = $0.1
        }
    }
    
    public func setPicker(_ picker: Value?, forIndex index: Int) -> Self {
        self.values[index] = picker
        return self
    }
}
