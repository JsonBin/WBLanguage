//
//  WBLanguage.swift
//  WBLanguage
//
//  Created by zwb on 2017/7/10.
//  Copyright © 2017年 HengSu Co., LTD. All rights reserved.
//

import UIKit

#if swift(>=4.2)
    public typealias WBLanguageControlState = UIControl.State
    public typealias WBLanguageStringKey = NSAttributedString.Key
#else
    public typealias WBLanguageControlState = UIControlState
    public typealias WBLanguageStringKey = NSAttributedStringKey
#endif

public final class WBLanguage<T> {
    public let value: T
    
    public init(_ value: T) {
        self.value = value
    }
}

public protocol WBLanguageProtocol {
    associatedtype LanguageValue
    var lt: LanguageValue { get }
}

extension WBLanguageProtocol {
    public var lt: WBLanguage<Self> {
        return WBLanguage(self)
    }
}

extension UILabel: WBLanguageProtocol {}
extension UIButton: WBLanguageProtocol {}
extension UITextView: WBLanguageProtocol {}
extension UITextField: WBLanguageProtocol {}
extension UIBarButtonItem: WBLanguageProtocol {}
extension UIViewController: WBLanguageProtocol {}
extension UISegmentedControl: WBLanguageProtocol {}
