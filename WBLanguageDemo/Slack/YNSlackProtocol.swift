//
//  YNSlackProtocol.swift
//  YNFoundation
//
//  Created by uneed-zwb on 2018/3/30.
//  Copyright © 2018年 com.uneed.yuni. All rights reserved.
//

import UIKit

public protocol YNSlackProtocol {
    /// 更新数据与界面
    func update()
}

// MARK: - Base

public final class YNSlackProvider<T>: YNSlackProtocol {

    public let slack: T

    public private(set) var maker: YNSlackMaker!

    public init(_ slack: T) {
        self.slack = slack
        self.maker = YNSlackMaker([], self)
    }

    public func update() {
        if slack is UITextField {
            (self as? YNSlackProvider<UITextField>)?.update()
        }
        if slack is UITextView {
            (self as? YNSlackProvider<UITextView>)?.update()
        }
        // 如还有其他的，可在这里添加
        
    }

    deinit {
        NotificationCenter.default.removeObserver(slack)
    }

    // MARK: - Private

    /// 记录输入字符的位置，与删除有关
    public var _index = 0
    /// 记录需要动态绑定的key
    public var _key = ""
    /// 输入完成的key
    public let _completeKey = "_editEndComplete"
}
