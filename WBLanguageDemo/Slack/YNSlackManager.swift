//
//  YNSlackManager.swift
//  YNFoundation
//
//  Created by uneed-zwb on 2018/3/30.
//  Copyright © 2018年 com.uneed.yuni. All rights reserved.
//

import UIKit

/// 动态检测Closure
public typealias YNSlackHandler = (YNSlackMaker) -> Void

/// 完成输入Closure
public typealias YNSlackComplete = (String?) -> Void

public protocol YNSlackResponseProtocol: class {

    /// 输入检测到需要响应的位置时回调
    ///
    /// - Parameters:
    ///   - maker: 绑定的maker
    ///   - key: 外部传入需要动态检测的key
    func ynSlackInputingWithMaker(_ maker: YNSlackMaker, slack key: String) -> Void

    // TODO: Optional

    /// 响应输入或传入完成之后的回调
    ///
    /// - Parameters:
    ///   - text: 回调完成之后的字符串
    ///   - key: 外部传入需要动态检测的key
    func ynSlackEndInput(end text: String?, slack key: String) -> Void
}

extension YNSlackResponseProtocol {
    func ynSlackEndInput(end text: String?, slack key: String) -> Void {}
}

// MARK: - Manager

public final class YNSlackManager {

    public static let shared = YNSlackManager()

    /// 提供一个为对象添加属性的方法
    ///
    /// - Parameters:
    ///   - object: 需要添加的对象，需要为UIResponder类
    ///   - key: 需要添加的key
    ///   - handler: 可选需要回调的closure
    ///   - delegate: 可选需要回调的delegate
    ///   - completeKey: 可选完成输入回调的key
    ///   - complete: 可选完成输入回调的closure
    public func make(_ object: UIResponder, _ key: String, _ handler: YNSlackHandler? = nil, _ delegate: YNSlackResponseProtocol? = nil, _ completeKey: String? = nil, _ complete: YNSlackComplete? = nil) {
        if let handler = handler {
            object.slacks?.updateValue(handler, forKey: key)
        }
        if let delegate = delegate {
            object.slacks?.updateValue(delegate, forKey: key)
        }
        if let complete = complete, let key = completeKey {
            object.slacks?.updateValue(complete, forKey: key)
        }
    }
}

// MARK: - UIResponder

public extension UIResponder {
    public var slacks: [String: Any]? {
        set {
            objc_setAssociatedObject(self, &UNSlackKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            if let values = objc_getAssociatedObject(self, &UNSlackKey) as? [String: Any] {
                return values
            }
            return [String: Any]()
        }
    }
}
private var UNSlackKey: Int8 = 0
