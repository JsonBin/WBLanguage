//
//  LanguageViewController.swift
//  WBLanguage
//
//  Created by zwb on 2017/7/10.
//  Copyright © 2017年 HengSu Co., LTD. All rights reserved.
//

import UIKit

class LanguageViewController: UIViewController {
    
    fileprivate var selectIndex = IndexPath(row: 0, section: 0)
    fileprivate let texts: [WBLanguageTextPicker] = ["English", "Russian", "French", "Italian", "German"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        lt.setPicker("Language")
        
        navigationController?.navigationBar.isTranslucent = false
        automaticallyAdjustsScrollViewInsets = false
        
        switch WBLanguageManager.type {
        case .en:
            selectIndex = IndexPath(row: 0, section: 0)
        case .ru:
            selectIndex = IndexPath(row: 1, section: 0)
        case .fr:
            selectIndex = IndexPath(row: 2, section: 0)
        case .it:
            selectIndex = IndexPath(row: 3, section: 0)
        case .de:
            selectIndex = IndexPath(row: 4, section: 0)
        }
        
        let tableview = UITableView(frame: view.bounds, style: .plain)
        tableview.backgroundColor = .white
        tableview.delegate = self
        tableview.dataSource = self
        tableview.tableFooterView = UIView()
        tableview.rowHeight = 50
        view.addSubview(tableview)
        
        let right = UIBarButtonItem(title: nil, style: .plain, target: self, action: #selector(rightClick))
        right.lt.setPicker("Button")
        navigationItem.rightBarButtonItem = right
    }
    
    @objc private func rightClick() {
        let type: LanguageType
        switch selectIndex.row {
        case 0:
            type = .en
        case 1:
            type = .ru
        case 2:
            type = .fr
        case 3:
            type = .it
        default:
            type = .de
        }
        WBLanguageManager.setLanguage(type)
    }
}

extension LanguageViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.lt.setPicker(texts[indexPath.row])
        if indexPath == selectIndex {
            cell?.accessoryType = .checkmark
        }else{
            cell?.accessoryType = .none
        }
        return cell!
    }
}

extension LanguageViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectIndex = indexPath
        tableView.reloadData()
    }
}
