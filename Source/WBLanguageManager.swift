//
//  WBLanguageManager.swift
//  WBLanguage
//
//  Created by zwb on 2017/7/10.
//  Copyright © 2017年 HengSu Co., LTD. All rights reserved.
//

import UIKit

// MARK: - Language Manager
public final class WBLanguageManager {
    
    public static let shared = WBLanguageManager()
    
    /// Change text animation duration.
    public var duration: CFTimeInterval = 0.25
    
    /// Current language type. Default is English.
    public private(set) var type: LanguageType
    
    /// Current language type Key
    private let oldKey: String
    private let languageKey: String
    /// cache language type for check.
    private let lastCacheKey: String
    /// Cache UserDefaults
    private let defaults: UserDefaults
    
    /// The language file bundle.
    private var languageBundle: Bundle?
    
    private init() {
        self.type = .en
        self.oldKey = "wblanguage.current.type"
        self.languageKey = "AppleLanguages"
        self.lastCacheKey = "com.wblanguage.last.cache"
        self.defaults = .standard
    }
    
    /// Whether has change system language for iPhone setting.
    /// When your app start up, you can check it to put up the
    /// current language set to server.
    public var hasDifferenceLanguage: Bool {
        let current = self.localLanguageType
        let last = self.defaults.stringArray(forKey: self.lastCacheKey)?.first
        let notSame = current.rawValue != last
        if notSame {
            self.defaults.set(current, forKey: self.lastCacheKey)
        }
        return notSame
    }
    
    /// Called when app start up.
    /// check the system language whether changed.
    public func startup() {
        let type = self.localLanguageType
        self.updateLanguage(type, startup: true)
    }
    
    /// Change System Language Type
    /// - Parameters:
    ///   - type: Support Language Type
    ///   - startup: called whether app start up.
    /// - Returns: None
    public func updateLanguage(_ type: LanguageType, startup: Bool = false) -> Void {
        // not startup and the type is same
        if !startup && self.type == type {
            return
        }
        self.type = type
        self.defaults.set([type.rawValue], forKey: self.languageKey)
        if !startup {
            self.defaults.set([type.rawValue], forKey: self.lastCacheKey)
        }
        self.defaults.synchronize()
        
        let bundle: Bundle?
        if let path = Bundle.main.path(forResource: "Language", ofType: "bundle") {
            // search from `Language.bundle`
            bundle = Bundle(path: path)
        } else {
            // search from main bundle.
            bundle = .main
        }
        self.languageBundle = nil
        if let path = bundle?.path(forResource: self.type.rawValue, ofType: "lproj") {
            self.languageBundle = Bundle(path: path)
        }
        
        NotificationCenter.default.post(name: .languageWillUpdate, object: nil)
    }
    
    /// Localized string from lproj files.
    /// - Parameters:
    ///   - key: The local key for language.
    ///   - place: The place value for key. use the key when it's nil.
    /// - Returns: The locallized string.
    public func localizedString(_ key: String, place: String? = nil) -> String? {
        let holder = place ?? key
        guard let bundle = self.languageBundle else {
            fatalError("you must add \(self.type.rawValue).lproj in bundle file.")
        }
        let value = bundle.localizedString(forKey: key, value: holder, table: nil)
        return Bundle.main.localizedString(forKey: key, value: value, table: nil)
    }
    
    /// Get attributedString from localizable strings.
    /// - Parameter dicts: The dic must contains ["picker": String...]
    /// - Returns: AttributeString or nil?
    public func attributedString(_ dicts: [[AnyHashable: Any]]) -> NSAttributedString? {
        guard let dics = dicts.first else {
            return nil
        }
        var key: String?
        #if swift(>=5.0)
        dics.keys.forEach {
            if let value = $0.base as? String {
                key = value
            }
        }
        #else
        dics.keys.forEach {
            if let value = $0 as? String {
                key = value
            }
        }
        #endif
        guard let key = key, let value = dics[key] as? String else {
            return nil
        }
        guard let text = self.localizedString(value) else {
            return nil
        }
        #if swift(>=4.2)
        let attrs = dics.filter { $0.key is NSAttributedString.Key } as? [NSAttributedString.Key: Any]
        #else
        let attrs = dics.filter { $0.key is NSAttributedStringKey } as? [NSAttributedStringKey: Any]
        #endif
        return NSAttributedString(string: text, attributes: attrs)
    }
    
    /// Texts from localizable strings
    public func localizedStrings(_ keys: [String]) -> [String] {
        return keys.compactMap {
            self.localizedString($0)
        }
    }
}

// MARK: - Deprecated
extension WBLanguageManager {
    @available(*, deprecated: 2.0, message: "use updateLanguage(_:) insted")
    public class func setLanguage(_ type: LanguageType) -> Void {
        WBLanguageManager.shared.updateLanguage(type)
    }
    @available(*, deprecated: 2.0, message: "use localizedString(_:place:) insted")
    public class func textForKey(_ key: String, value place: String? = nil) -> String? {
        return WBLanguageManager.shared.localizedString(key, place: place)
    }
    @available(*, deprecated: 2.0, message: "use attributedString(_:) insted")
    public class func attributedStringForDict(_ dicts: [[AnyHashable: Any]]) -> NSAttributedString? {
        return WBLanguageManager.shared.attributedString(dicts)
    }
    @available(*, deprecated: 2.0, message: "use localizedStrings(_:) insted")
    public class func textsForArray(_ strings: [String]) -> [String]? {
        return WBLanguageManager.shared.localizedStrings(strings)
    }
}

// MARK: - Private
extension WBLanguageManager {
    /// cache language type or system language type.
    private var localLanguageType: LanguageType {
        // migrate old value to new key
        if let value = self.defaults.stringArray(forKey: self.oldKey)?.first {
            self.defaults.set([value], forKey: self.languageKey)
            self.defaults.removeObject(forKey: self.oldKey)
            return LanguageType(value)
        }
        // cache language type
        if let value = UserDefaults.standard.stringArray(forKey: self.languageKey)?.first {
            return LanguageType(value)
        }
        // Get the iPhone local language, if not exist. The default is english.
        guard let language = Locale.preferredLanguages.first else {
            return .en
        }
        // en-Us, en-UK...
        if language.hasPrefix("en") {
            return .en
        }
        if language.hasPrefix("zh") {
            if language.range(of: "Hans") != nil {
                return .zhHans  // 简体中文
            }
            // zh-Hant/zh-HK/zh-TW
            return .zhHant  // 繁体中文
        }
        // default type is english.
        return .en
    }
}

// MARK: - Notification
extension Notification.Name {
    /// It would used in before change the language type.
    public static let languageWillUpdate = Notification.Name("WBLanguageWillUpdateNotification")

    /// When change the language complete, It would be called.
    public static let languageDidUpdate = Notification.Name("WBLanguageDidUpdateNotification")
}

@available(*, unavailable, message: "use .languageWillUpdate & .languageDidUpdate insted")
public let LanguageNotification = Notification.Name.languageWillUpdate.rawValue
