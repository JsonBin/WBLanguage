//
//  ViewController.swift
//  WBLanguage
//
//  Created by zwb on 2017/7/10.
//  Copyright © 2017年 HengSu Co., LTD. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        lt.setPicker("Title")
        
        /// Label
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 100, width: view.bounds.size.width, height: 30)
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .black
        label.lt.picker = "Label"
        label.lt.attributedPicker = WBLanguageDictionaryPicker(dicts: ["picker": "Label", WBLanguageStringKey.foregroundColor: UIColor.white, WBLanguageStringKey.font: UIFont.boldSystemFont(ofSize: 17)])
        if let text = WBLanguageManager.textForKey("Label") {
            let att = NSAttributedString(string: text, attributes: [.font: UIFont.boldSystemFont(ofSize: 17), .foregroundColor: UIColor.white])
            label.attributedText = att
        }
        view.addSubview(label)
        
        //// Button
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 200, width: view.bounds.size.width, height: 30)
        button.backgroundColor = .orange
        view.addSubview(button)
        button.lt.setPicker("Button", forState: .normal)
        #if swift(>=4.2)
        let picker = WBLanguageDictionaryPicker(dicts: ["picker": "Button", WBLanguageStringKey.foregroundColor: UIColor.black, WBLanguageStringKey.font: UIFont.boldSystemFont(ofSize: 17), WBLanguageStringKey.strikethroughStyle: NSUnderlineStyle.double.rawValue])
        #else
        let picker = WBLanguageDictionaryPicker(dicts: ["picker": "Button", WBLanguageStringKey.foregroundColor: UIColor.black, WBLanguageStringKey.font: UIFont.boldSystemFont(ofSize: 17), WBLanguageStringKey.strikethroughStyle: NSUnderlineStyle.styleDouble.rawValue])
        #endif
        button.lt.setAttributedPicker(picker, forState: .normal)
        
        //// SegmentControl
        let segment = UISegmentedControl(items: ["","","","",""])
        segment.backgroundColor = .lightGray
        segment.tintColor = .black
        segment.lt.setPicker("English", forSegmentAt: 0)
        segment.lt.setPicker("Russian", forSegmentAt: 1)
        segment.lt.setPicker("French", forSegmentAt: 2)
        segment.lt.setPicker("Italian", forSegmentAt: 3)
        segment.lt.setPicker("German", forSegmentAt: 4)
        segment.frame = CGRect(x: 0, y: 300, width: view.bounds.size.width, height: 30)
        view.addSubview(segment)
        
        //// UITextField
        let textfield = UITextField()
        textfield.lt.placeHolderPicker = "Label"
        textfield.lt.attributedPlaceHolderPicker = WBLanguageDictionaryPicker(dicts: ["picker": "Label", WBLanguageStringKey.foregroundColor: UIColor.black, WBLanguageStringKey.font: UIFont.boldSystemFont(ofSize: 17)])

        //// UIBarButtonItem
        let right = UIBarButtonItem(title: nil, style: .plain, target: self, action: #selector(rightClick))
        right.lt.setPicker("Change")
        navigationItem.rightBarButtonItem = right

        /**************************
        // 动态监测输入字符
        let textField = UITextField()
        textField.frame = CGRect(x: 100, y: 500, width: view.bounds.size.width - 200, height: 40)
        textField.borderStyle = .roundedRect
        textField.keyboardType = .default
        textField.textColor = .red
        textField.returnKeyType = .done
        textField.clearButtonMode = .whileEditing
        textField.font = UIFont.systemFont(ofSize: 17)
        textField.placeholder = "请输入文字"
        let text = "//"
        textField.slack.make(key: text, handler: { (make) in
            make.push(string: "remove")
        }, complete: { (text) in
            print("输入完成: \(text ?? "")")
        }, delegate: nil)
        /*textField.slack.make(key: text, delegate: self)*/
        view.addSubview(textField)
         ***************************/
    }
    
    @objc private func rightClick() {
        navigationController?.pushViewController(LanguageViewController(), animated: true)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}

/*
extension ViewController: YNSlackResponseProtocol {
    func ynSlackInputingWithMaker(_ maker: YNSlackMaker, slack key: String) {
        maker.push(string: "remove")
    }

    func ynSlackEndInput(end text: String?, slack key: String) {
        print("输入完成: \(text ?? ""), key: \(key)")
    }
}
*/
