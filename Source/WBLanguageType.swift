//
//  WBLanguageType.swift
//  WBLanguage
//
//  Created by zwb on 2021/11/25.
//  Copyright © 2021 HengSu Co., LTD. All rights reserved.
//

import Foundation

// MARK: - Enum Language Types
public enum LanguageType: Equatable {
    /// English
    case en
    /// French
    case fr
    /// Italian
    case it
    /// German
    case de
    /// Russian
    case ru
    /// 简体中文
    case zhHans
    /// 繁体中文
    case zhHant
    /// The custom other language types.
    case custom(type: String)
    
    public init(_ rawValue: String) {
        switch rawValue {
        case "en": self = .en
        case "fr": self = .fr
        case "it": self = .it
        case "de": self = .de
        case "ru": self = .ru
        case "zh-Hans": self = .zhHans
        case "zh-Hant": self = .zhHant
        default:   self = .custom(type: rawValue)
        }
    }
    
    public static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
}

extension LanguageType {
    public var rawValue: String {
        switch self {
        case .en: return "en"
        case .fr: return "fr"
        case .it: return "it"
        case .de: return "de"
        case .ru: return "ru"
        case .zhHans: return "zh-Hans"
        case .zhHant: return "zh-Hant"
        case .custom(let type):  return type
        }
    }
}
