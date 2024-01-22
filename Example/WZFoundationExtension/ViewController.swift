//
//  ViewController.swift
//  WZFoundationExtension
//
//  Created by LiuSky on 08/13/2020.
//  Copyright (c) 2020 LiuSky. All rights reserved.
//

import UIKit
import WZFoundationExtension

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
  
        let label = PaddedLabel()
        label.textContainerInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        label.backgroundColor = UIColor.red
        label.textColor = UIColor.white
        label.numberOfLines = 0
        label.text = "是是是是事实是是事实是萨回到家啊搭嘎即获得久啊都感觉阿萨德刚阿基德噶十多个啊时间的话国剧盛典个啊好多个几哈是的"
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.widthAnchor.constraint(equalToConstant: 300)
        ])
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

