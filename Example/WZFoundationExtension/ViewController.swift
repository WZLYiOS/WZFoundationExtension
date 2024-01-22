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
        label.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        label.backgroundColor = UIColor.red
        label.textColor = UIColor.white
        label.numberOfLines = 0
        let text = NSMutableAttributedString(string: "我们是一个非常好的人，所以我们要热爱大自然")
        text.wz.lineSpacing = 10
        text.wz.color = UIColor.orange
        text.wz.setKern(10, range: NSRange(location: 0, length: 1))
        text.wz.setMarn(space: 30, at: 3)
        label.attributedText = text
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

