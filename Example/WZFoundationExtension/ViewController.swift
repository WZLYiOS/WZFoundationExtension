//
//  ViewController.swift
//  WZFoundationExtension
//
//  Created by LiuSky on 08/13/2020.
//  Copyright (c) 2020 LiuSky. All rights reserved.
//

import UIKit
import WZFoundationExtension
import WZNamespaceWrappable

struct TestModel: Codable {
    let text: String
    
    init(text: String) {
        self.text = text
    }
}


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
  
        let label = PaddedLabel()
//        label.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        label.backgroundColor = UIColor.wz.hexString(hex: "#DD4BA8")
        label.textColor = UIColor.white
        label.numberOfLines = 0
        let text = NSMutableAttributedString(string: "10")
        text.wz.font = UIFont.systemFont(ofSize: 10)
//        text.wz.lineSpacing = 10
//        text.wz.color = UIColor.orange
//        text.wz.setKern(10, range: NSRange(location: 0, length: 1))
//        text.wz.setMarn(space: 30, at: 3)
        text.wz.appendImageAttachment(image: UIImage(named: "backpack_jibi"))
        text.wz.insertImageAttachment(image: UIImage(named: "backpack_jibi"), at: 1)
        label.attributedText = text
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.widthAnchor.constraint(equalToConstant: 300)
        ])
        
        let model = TestModel(text: "213")
        debugPrint(model.toString())
        
        debugPrint("1sdasdkaSJSDdjs".wz.md5)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


