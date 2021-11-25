//
//  WBLanguagePicker+NSObject.swift
//  WBLanguage
//
//  Created by zwb on 2021/11/25.
//  Copyright © 2021 HengSu Co., LTD. All rights reserved.
//

import UIKit

extension NSObject {
    
    typealias LanguagePickers = [Selector: WBLanguagePicker]
    
    /// language pickers.
    var pickers: LanguagePickers {
        set {
            unregisterLanguageNotification()
            if !newValue.isEmpty {
                registerLanguageNotificatoin()
            }
            objc_setAssociatedObject(self, &languagePickerKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            if let pickers = objc_getAssociatedObject(self, &languagePickerKey) as? LanguagePickers {
                return pickers
            }
            let initValue = LanguagePickers()
            objc_setAssociatedObject(self, &languagePickerKey, initValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return initValue
        }
    }
}

// MARK: - Extension NSObject
extension NSObject {
    
    /// Remove Notification
    fileprivate func unregisterLanguageNotification() {
        NotificationCenter.default.removeObserver(self, name: .languageWillUpdate, object: nil)
    }
    
    /// Add Notification
    fileprivate func registerLanguageNotificatoin() {
        NotificationCenter.default.addObserver(self, selector: #selector(_updateLanguage), name: .languageWillUpdate, object: nil)
    }
    
    @objc private func _updateLanguage() {
        let duration = WBLanguageManager.shared.duration
        var pickers = self.pickers
        self.pickers.forEach { selector, picker in
            UIView.animate(withDuration: duration, animations: {
                self.performLanguage(selector, picker: picker)
            }) { _ in
                pickers.removeValue(forKey: selector)
                // update complete.
                if pickers.isEmpty {
                    NotificationCenter.default.post(name: .languageDidUpdate, object: nil)
                }
            }
        }
    }
    
    func performLanguage(_ selector: Selector, picker: WBLanguagePicker?) {
        let method = self.method(for: selector)
        guard self.responds(to: selector) else {
            fatalError("not found the `\(selector)` in \(self)")
        }
        guard let value = picker?.value() else {
            return
        }
        if let statePicker = picker as? WBLanguageStatePicker {
            let setState = unsafeBitCast(method, to: setValueForStateIMP.self)
            statePicker.values.forEach {
                guard let value = $1.value() else {
                    fatalError("you not set the localizable string for \($0) with \(self)")
                }
                setState(self, selector, value, WBLanguageControlState(rawValue: $0))
            }
            return
        }
        if let intPicker = picker as? WBLanguageIntPicker {
            let setInt = unsafeBitCast(method, to: setValueForIndexIMP.self)
            intPicker.values.forEach {
                guard let value = $1.value() else {
                    fatalError("you not set the localizable string for \($0) with \(self)")
                }
                setInt(self, selector, value, $0)
            }
            return
        }
        if picker is WBLanguageTextPicker {
            let setText = unsafeBitCast(method, to: setTextValueIMP.self)
            if let value = value as? String {
                setText(self, selector, value)
            } else {
                setText(self, selector, "")
            }
            return
        }
        self.perform(selector, with: value)
    }
    
    private typealias setTextValueIMP = @convention(c)(NSObject, Selector, String) -> Void
    private typealias setValueForStateIMP = @convention(c)(NSObject, Selector, Any, WBLanguageControlState) -> Void
    private typealias setValueForIndexIMP = @convention(c)(NSObject, Selector, Any, Int) -> Void
}
private var languagePickerKey = "com.wblanguage.picker"
private var languageClosureKey = "com.wblanguage.closure"
