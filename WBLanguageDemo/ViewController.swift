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
//        label.lt.setPicker("Label")
        view.addSubview(label)
        
        //// Button
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 200, width: view.bounds.size.width, height: 30)
        button.backgroundColor = .orange
        view.addSubview(button)
        let picker = WBLanguageDictionaryPicker(dicts: ["picker": "Button", NSAttributedStringKey.foregroundColor: UIColor.black, NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 17), NSAttributedStringKey.strikethroughStyle:NSUnderlineStyle.styleDouble.rawValue])
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
        
        //// UIBarButtonItem
        let right = UIBarButtonItem(title: nil, style: .plain, target: self, action: #selector(rightClick))
        right.lt.setPicker("Change")
        navigationItem.rightBarButtonItem = right
    }
    
    @objc private func rightClick() {
        navigationController?.pushViewController(LanguageViewController(), animated: true)
    }
}

