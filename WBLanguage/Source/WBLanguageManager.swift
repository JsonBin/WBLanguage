//
//  WBLanguageManager.swift
//  WBLanguage
//
//  Created by zwb on 2017/7/10.
//  Copyright © 2017年 HengSu Co., LTD. All rights reserved.
//

import UIKit

public let LanguageNotification = "WBLanguageNotification"

// MARK: - Enum Language Types

public enum LanguageType {
    case en  // English
    case fr  // French
    case it  // Italian
    case de  // German
    case ru  // Russian
    
    public var rawValue: String {
        switch self {
        case .en: return "en"
        case .fr: return "fr"
        case .it: return "it"
        case .de: return "de"
        case .ru: return "ru"
        }
    }
    
    public init?(rawValue: String) {
        switch rawValue {
        case "en": self = .en
        case "fr": self = .fr
        case "it": self = .it
        case "de": self = .de
        case "ru": self = .ru
        default: self = .en   // default is english.
        }
    }
}

// MARK: - Language Manager

public class WBLanguageManager: NSObject {
    
    open static let shared = WBLanguageManager()
    
    // Change Text Duration
    open static var duration: CFTimeInterval = 0.25
    
    // Current Language Type. Default is English.
    open private(set) static var type = WBLanguageManager.shared.queryLanguageType()
    
    /// Change System Language Type
    ///
    /// - Parameter type: Support Language Type
    open class func setLanguage(_ type: LanguageType) -> Void {
        self.type = type
        WBLanguageManager.shared.saveLanguageType(type)
        NotificationCenter.default.post(name: Notification.Name(LanguageNotification), object: nil)
    }
    
    // MARK: - Get Text For Key
    
    open class func textForKey(_ key: String, value place: String? = nil) -> String? {
        guard let path = bundlePath?.path(forResource: type.rawValue, ofType: "lproj") else {
            return place
        }
        guard let bundle = Bundle(path: path) else{
            return place
        }
        let value = bundle.localizedString(forKey: key, value: place, table: nil)
        return Bundle.main.localizedString(forKey: key, value: value, table: nil)
    }
    
    /// Get AttributedString From Localizable strings. 
    /// The dic must contains ["picker": String...]
    open class func attributedStringForDict(_ dicts: [[AnyHashable: Any]]) -> NSAttributedString? {
        guard var dics = dicts.first else { return nil }
        var key: String?
        dics.keys.forEach { if $0 is String { key = $0 as? String } }
        guard let k = key, let text = textForKey(k) else { return nil }
        guard let attrs = dics.removeValue(forKey: k) as? [NSAttributedStringKey: Any] else { return NSAttributedString(string: text) }
        return NSAttributedString(string: text, attributes: attrs)
    }
    
    /// Texts From Localizable strings
    open class func textsForArray(_ strings: [String]) -> [String]? {
        var texts = [String]()
        strings.forEach {
            if let text = textForKey($0) {
                texts.append(text)
            }
        }
        return texts
    }
    
    // MARK: - Private
    
    private static var bundlePath: Bundle? {
        guard let path = Bundle(for: WBLanguageManager.self).path(forResource: "Language", ofType: "bundle") else {
            return nil
        }
        guard let bundle = Bundle(path: path) else {
            return nil
        }
        return bundle
    }
    
    // MARK: - Save To Plist & Query From Plist
    
    private func saveLanguageType(_ type: LanguageType) -> Void {
        UserDefaults.standard.set(type.rawValue, forKey: "WBCurrentLanguageType")
        UserDefaults.standard.synchronize()
    }
    
    private func queryLanguageType() -> LanguageType {
        guard let typeString = UserDefaults.standard.value(forKey: "WBCurrentLanguageType") as? String else {
            return .en
        }
        return LanguageType(rawValue: typeString)!
    }
}
