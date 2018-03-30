//
//  YNSlack.swift
//  YNFoundation
//
//  Created by uneed-zwb on 2018/3/30.
//  Copyright © 2018年 com.uneed.yuni. All rights reserved.
//

import UIKit

/// 扩展TextField以及TextView的动态检测机制，根据注册的key完成对应的回调
//
// - Example:
//
//  let textField = UITextField()
//  textField.slack.make(key: "@", handler: { (make) in
//     make.push(string: "需要@人的名字")
//  }, complete: { (text) in
//     print("输入完成回调的字符串: \(text ?? "")")
//  }, delegate: <#T##YNSlackResponseProtocol?#>)
//
//  这里采用delegate的时候，需要遵守delegate协议并完成相应的方法
//
// - End
//
public protocol YNSlack {

    associatedtype Slack

    var slack: Slack { get }
}

public extension YNSlack {

    var slack: YNSlackProvider<Self> {
        return YNSlackProvider(self)
    }
}


extension UITextField: YNSlack {}

extension UITextView: YNSlack {}
