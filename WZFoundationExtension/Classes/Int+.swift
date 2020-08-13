//
//  Int+.swift
//  WZFoundationExtension_Example
//
//  Created by xiaobin liu on 2020/8/13.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import Foundation
import WZNamespaceWrappable


extension Int: WZNamespaceWrappable { }
public extension WZNamespaceWrapper where WrappedType == Int {
    
    /// rgb
    var color: UIColor {
        
        let red = CGFloat(wrappedValue as Int >> 16 & 0xff) / 255
        let green = CGFloat(wrappedValue >> 8 & 0xff) / 255
        let blue  = CGFloat(wrappedValue & 0xff) / 255
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    
    
    /// 转换成CGflof
    var f: CGFloat {
        return CGFloat(wrappedValue)
    }
}

