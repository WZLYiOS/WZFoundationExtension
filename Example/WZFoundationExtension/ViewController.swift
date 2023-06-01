//
//  ViewController.swift
//  WZFoundationExtension
//
//  Created by LiuSky on 08/13/2020.
//  Copyright (c) 2020 LiuSky. All rights reserved.
//

import UIKit
import WZNamespaceWrappable

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        let xx = Date.wz.getSecondsFromString(timeString: "1小时")
        debugPrint(xx)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

