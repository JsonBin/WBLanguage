//
//  WBLanguageExtension.swift
//  WBLanguage
//
//  Created by zwb on 2017/7/10.
//  Copyright © 2017年 HengSu Co., LTD. All rights reserved.
//

import UIKit

private var WBLanguageTypeKeys = ""

extension NSObject {
    
    public typealias LanguagePickers = [String: WBLanguagePicker]
    
    public var languagePickers: LanguagePickers {
        set{
            objc_setAssociatedObject(self, &WBLanguageTypeKeys, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            _removeLanguageNotification()
            if !newValue.isEmpty { _addLanguageNotificatoin() }
        }
        get{
            if let pickers = objc_getAssociatedObject(self, &WBLanguageTypeKeys) as? LanguagePickers {
                return pickers
            }
            let initValue = LanguagePickers()
            objc_setAssociatedObject(self, &WBLanguageTypeKeys, initValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return initValue
        }
    }
    
    public func performLanguage(_ selector: String, Picker picker: WBLanguagePicker?) {
        let sele = Selector(selector)
        let method = self.method(for: sele)
        guard responds(to: sele) else { return }
        guard let value = picker?.value() else { return }
        if let statePicker = picker as? WBLanguageStatePicker {
            let setState = unsafeBitCast(method, to: setValueForStateIMP.self)
            statePicker.values.forEach {
                guard let value = $1.value() else {
                    fatalError("you not set the localizable string for \($0) with \(self)")
                }
                setState(self, sele, value, WBLanguageControlState(rawValue: $0))
            }
        }
        else if let intPicker = picker as? WBLanguageIntPicker {
            let setInt = unsafeBitCast(method, to: setValueForIndexIMP.self)
            intPicker.values.forEach {
                guard let value = $1.value() else {
                    fatalError("you not set the localizable string for \($0) with \(self)")
                }
                setInt(self, sele, value, $0)
            }
        }
        else if picker is WBLanguageTextPicker {
            let setText = unsafeBitCast(method, to: setTextValueIMP.self)
            if let value = value as? String {
                setText(self, sele, value)
            }else{
                setText(self, sele, "")
            }
        }else{
            perform(sele, with: value)
        }
    }
    
    private typealias setTextValueIMP = @convention(c)(NSObject, Selector, String) -> Void
    private typealias setValueForStateIMP = @convention(c)(NSObject, Selector, Any, WBLanguageControlState) -> Void
    private typealias setValueForIndexIMP = @convention(c)(NSObject, Selector, Any, Int) -> Void
}

// MARK: - Extension NSObject Notification
public extension NSObject {
    
    /// Remove Notification
    fileprivate func _removeLanguageNotification() {
        NotificationCenter.default.removeObserver(self, name: .languageWillUpdate, object: nil)
    }
    
    /// Add Notification
    fileprivate func _addLanguageNotificatoin() {
        NotificationCenter.default.addObserver(self, selector: #selector(_updateLanguage), name: .languageWillUpdate, object: nil)
    }
    
    @objc private func _updateLanguage() {
        var pickers = languagePickers
        languagePickers.forEach { key, value in
            UIView.animate(withDuration: WBLanguageManager.duration, animations: {
                self.performLanguage(key, Picker: value)
            }) { _ in
                pickers.removeValue(forKey: key)
                // update complete.
                if pickers.isEmpty {
                    NotificationCenter.default.post(name: .languageDidUpdate, object: nil)
                }
            }
        }
    }
}
