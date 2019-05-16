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

    public typealias PickerType = () -> Any?

    public let value: PickerType
    
    required public init(ve: @escaping PickerType) {
        self.value = ve
    }
    
    public func copy(with zone: NSZone?) -> Any {
        return type(of: self).init(ve: value)
    }
}

// MARK: - Text Picker
public final class WBLanguageTextPicker: WBLanguagePicker, ExpressibleByStringLiteral {
    
    public convenience init(keyPath: String) {
        self.init(ve: { return WBLanguageManager.textForKey(keyPath) })
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
    
    public class func pickerForKeyPath(_ keyPath: String) -> WBLanguageTextPicker {
        return WBLanguageTextPicker(keyPath: keyPath)
    }
}

// MARK: - Dictionary Picker
/// NSAttributedString Picker. The dicts must contains ["picker": String...]
public final class WBLanguageDictionaryPicker: WBLanguagePicker, ExpressibleByArrayLiteral {

    public convenience init(dicts: [AnyHashable: Any]...) {
        self.init(ve: { return WBLanguageManager.attributedStringForDict(dicts) })
    }
    
    public required convenience init(arrayLiteral elements: [AnyHashable: Any]...) {
        self.init(ve: { return WBLanguageManager.attributedStringForDict(elements) })
    }
    
    public class func pickerWithDicts(_ dicts: [[AnyHashable: Any]]) -> WBLanguageDictionaryPicker {
        return WBLanguageDictionaryPicker(ve: { return WBLanguageManager.attributedStringForDict(dicts) })
    }
}

// MARK: - State Picker
public final class WBLanguageStatePicker: WBLanguagePicker {
    
    public typealias ValuesType = [UInt : WBLanguagePicker]
    
    public var values = ValuesType()
    
    public convenience init?(_ picker: WBLanguagePicker?, forState state: WBLanguageControlState) {
        guard let picker = picker else { return nil }
        self.init(ve: { return state.rawValue })
        values[state.rawValue] = picker
    }

    public func setPicker(_ picker: WBLanguagePicker?, forState state: WBLanguageControlState) -> Self {
        values[state.rawValue] = picker
        return self
    }
}

// MARK: - Int Picker
public final class WBLanguageIntPicker: WBLanguagePicker {
    
    public typealias IndexType = [Int: WBLanguagePicker]
    
    public var values = IndexType()
    
    public convenience init?(_ picker: WBLanguagePicker?, forIndex index: Int) {
        guard let picker = picker else { return nil }
        self.init(ve: { return index })
        values[index] = picker
    }
    
    public func setPicker(_ picker: WBLanguagePicker?, forIndex index: Int) -> Self {
        values[index] = picker
        return self
    }
}
