//
//  WBLanguage.swift
//  WBLanguage
//
//  Created by zwb on 2017/7/10.
//  Copyright © 2017年 HengSu Co., LTD. All rights reserved.
//

import UIKit

public final class WBLanguage<T>{
    public let value: T
    public init(_ value: T) {
        self.value = value
    }
}

public protocol WBLanguageProtocol {
    associatedtype LanguageValue
    var lt: LanguageValue { get }
}

public extension WBLanguageProtocol {
    public var lt: WBLanguage<Self> {
        return WBLanguage(self)
    }
}

extension UILabel : WBLanguageProtocol {}

extension UITextField : WBLanguageProtocol {}

extension UITextView : WBLanguageProtocol {}

extension UISegmentedControl : WBLanguageProtocol {}

extension UIButton : WBLanguageProtocol {}

extension UIBarButtonItem : WBLanguageProtocol {}

extension UIViewController : WBLanguageProtocol {}
