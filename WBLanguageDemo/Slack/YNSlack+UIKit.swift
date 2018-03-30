//
//  YNSlack+UIKit.swift
//  YNFoundation
//
//  Created by uneed-zwb on 2018/3/30.
//  Copyright © 2018年 com.uneed.yuni. All rights reserved.
//

import UIKit

// MARK: - UITextField

public extension YNSlackProvider where T: UITextField {
    
    /// 注册TextField的动态检测字符以及响应的方法或回调
    ///
    /// - Parameters:
    ///   - string: 需要注册的key
    ///   - handler: 触发key的回调
    ///   - complete: 触发key的delegate
    ///   - delegate: 输入完成的回调
    public func make(key string: String, handler: YNSlackHandler? = nil, complete: YNSlackComplete? = nil, delegate: YNSlackResponseProtocol? = nil) -> Void {
        _key = string
        YNSlackManager.shared.make(slack, string, handler, delegate, _completeKey, complete)

        // 注册text改变的通知
        NotificationCenter.default.addObserver(forName: .UITextFieldTextDidChange, object: slack, queue: nil) { (_) in
            self.textFieldValueChange(self.slack as UITextField)
        }
        // 注册textField完成编辑的通知
        NotificationCenter.default.addObserver(forName: .UITextFieldTextDidEndEditing, object: slack, queue: nil) { (_) in
            let textField = self.slack as UITextField
            // 完成delegate
            let value = textField.slacks?[self._key]
            if value is YNSlackResponseProtocol {
                (value as? YNSlackResponseProtocol)?.ynSlackEndInput(end: textField.text, slack: self._key)
            }
            // 完成closure
            let complete = textField.slacks?[self._completeKey]
            if complete is YNSlackComplete {
                (complete as? YNSlackComplete)?(textField.text)
            }
        }
    }

    public func update() {
        #if DEBUG
            print("textField显示的textField需要改变")
        #endif
        let textField = slack as UITextField
        guard let _ = textField.text else { return }
        guard let last = maker.popLast() else { return }
        // 移除后面添加的几个字符
        maker.popEnd(count: _key.count)
        // 添加新的字符组合
        maker.push(string: "\(_key)\(last) ", false)
        let text = maker.vlaues.joined()
        textField.text = text
        // 更新index
        _index = text.count
    }

    private func textFieldValueChange(_ textField: UITextField) {
        guard let oldText = textField.text else { return }
        if oldText.count > _index {
            // 输入字符
            if let char = oldText.last {
                // 记录缓存
                let last = String(char)
                maker.push(string: last, false)
            }
            // 检测是否为需要的标志
            if oldText.count >= _key.count {
                let char = oldText.suffix(from: String.Index(encodedOffset: oldText.count - _key.count))
                let last = String(char)
                if let index = textField.slacks?.index(forKey: last) {
                    let value = textField.slacks?[index].value
                    if value is YNSlackHandler {
                        (value as? YNSlackHandler)?(maker)
                    }
                    if value is YNSlackResponseProtocol {
                        (value as? YNSlackResponseProtocol)?.ynSlackInputingWithMaker(maker, slack: _key)
                    }
                    return
                }
            }
            _index = oldText.count
        } else if oldText.count < _index {
            // 删除字符
            if oldText.isEmpty {
                // 这里为点击全删按钮
                maker.popAll()
                _index = oldText.count
                return
            }
            // 处理单个删除操作
            maker.popLast()
            let text = maker.vlaues.joined()
            textField.text = text
            _index = text.count
        }
    }
}

// MARK: - UITextView

public extension YNSlackProvider where T: UITextView {

    /// 注册TextView的动态检测字符以及响应的方法或回调
    ///
    /// - Parameters:
    ///   - string: 需要注册的key
    ///   - handler: 触发key的回调
    ///   - complete: 触发key的delegate
    ///   - delegate: 输入完成的回调
    public func make(key string: String, handler: YNSlackHandler? = nil, complete: YNSlackComplete? = nil, delegate: YNSlackResponseProtocol? = nil) -> Void {
        _key = string
        YNSlackManager.shared.make(slack, string, handler, delegate, _completeKey, complete)

        // 注册text改变的通知
        NotificationCenter.default.addObserver(forName: .UITextViewTextDidChange, object: slack, queue: nil) { (_) in
            self.textViewValueChange(self.slack as UITextView)
        }
        // 注册textField完成编辑的通知
        NotificationCenter.default.addObserver(forName: .UITextViewTextDidEndEditing, object: slack, queue: nil) { (_) in
            let textView = self.slack as UITextView
            // 完成delegate
            let value = textView.slacks?[self._key]
            if value is YNSlackResponseProtocol {
                (value as? YNSlackResponseProtocol)?.ynSlackEndInput(end: textView.text, slack: self._key)
            }
            // 完成closure
            let complete = textView.slacks?[self._completeKey]
            if complete is YNSlackComplete {
                (complete as? YNSlackComplete)?(textView.text)
            }
        }
    }

    public func update() {
        #if DEBUG
            print("textView显示的textView需要改变")
        #endif
        let textView = slack as UITextView
        guard let _ = textView.text else { return }
        guard let last = maker.popLast() else { return }
        // 移除后面添加的几个字符
        maker.popEnd(count: _key.count)
        // 添加新的字符组合
        maker.push(string: "\(_key)\(last) ", false)
        let text = maker.vlaues.joined()
        textView.text = text
        // 更新index
        _index = text.count
    }

    private func textViewValueChange(_ textView: UITextView) {
        guard let oldText = textView.text else { return }
        if oldText.count > _index {
            // 输入字符
            if let char = oldText.last {
                // 记录缓存
                let last = String(char)
                maker.push(string: last, false)
            }
            // 检测是否为需要的标志
            if oldText.count >= _key.count {
                let char = oldText.suffix(from: String.Index(encodedOffset: oldText.count - _key.count))
                let last = String(char)
                if let index = textView.slacks?.index(forKey: last) {
                    let value = textView.slacks?[index].value
                    if value is YNSlackHandler {
                        (value as? YNSlackHandler)?(maker)
                    }
                    if value is YNSlackResponseProtocol {
                        (value as? YNSlackResponseProtocol)?.ynSlackInputingWithMaker(maker, slack: _key)
                    }
                    return
                }
            }
            _index = oldText.count
        } else if oldText.count < _index {
            // 删除字符
            if oldText.isEmpty {
                // 这里为点击全删按钮
                maker.popAll()
                _index = oldText.count
                return
            }
            // 处理单个删除操作
            maker.popLast()
            let text = maker.vlaues.joined()
            textView.text = text
            _index = text.count
        }
    }
}
