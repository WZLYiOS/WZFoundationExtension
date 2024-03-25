//
//  UIColor+.swift
//  Created on 2022/12/1
//  Description <#文件描述#>
//  PD <#产品文档地址#>
//  Design <#设计文档地址#>
//  Copyright © 2022 WZLY. All rights reserved.
//  @author 邱啟祥(739140860@qq.com)   
//

import Foundation

#if os(iOS)
import UIKit
public typealias Color = UIColor
#elseif os(OSX)
import AppKit
import WZLottie
public typealias Color = NSColor
#endif


// MARK: - 扩展16进制转换
public extension Int {
    var color: Color {
        let red = CGFloat(self as Int >> 16 & 0xff) / 255
        let green = CGFloat(self >> 8 & 0xff) / 255
        let blue  = CGFloat(self & 0xff) / 255
        return Color(red: red, green: green, blue: blue, alpha: 1)
    }
}

precedencegroup AlphaPrecedence {
    associativity: left
    higherThan: RangeFormationPrecedence
    lowerThan: AdditionPrecedence
}

infix operator ~ : AlphaPrecedence

public func ~ (color: Color, alpha: Int) -> Color {
    return color ~ CGFloat(alpha)
}
public func ~ (color: Color, alpha: Float) -> Color {
    return color ~ CGFloat(alpha)
}
public func ~ (color: Color, alpha: CGFloat) -> Color {
    return color.withAlphaComponent(alpha)
}

/// e.g. `50%`
postfix operator %
public postfix func % (percent: Int) -> CGFloat {
    return CGFloat(percent)%
}
public postfix func % (percent: Float) -> CGFloat {
    return CGFloat(percent)%
}
public postfix func % (percent: CGFloat) -> CGFloat {
    return percent / 100
}

// 颜色
public extension NamespaceWrappable where Base: UIColor {
    
    /// RGB
    static func rgb(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: alpha)
    }
    
    /// 16进制颜色方法
    /// - Parameter rgb: 16进制
    /// - Parameter alpha: 透明度
    static func hexadecimal(rgb: Int, alpha: Float = 1) -> UIColor {
        return rgb.color ~ alpha
    }
    
    /// 16进制颜色方法
    /// - Parameters:
    ///   - rgb: 16进制
    ///   - alpha: 透明度
    static func hexString(hex: String, alpha: Float = 1) -> UIColor {
        var cstr = hex.trimmingCharacters(in:  CharacterSet.whitespacesAndNewlines).uppercased() as NSString;
         if(cstr.length < 6){
             return UIColor.clear;
          }
         if(cstr.hasPrefix("0X")){
             cstr = cstr.substring(from: 2) as NSString
         }
         if(cstr.hasPrefix("#")){
           cstr = cstr.substring(from: 1) as NSString
         }
          if(cstr.length != 6){
           return UIColor.clear;
         }
         var range = NSRange.init()
         range.location = 0
         range.length = 2
         //r
         let rStr = cstr.substring(with: range);
         //g
         range.location = 2;
         let gStr = cstr.substring(with: range)
         //b
         range.location = 4;
         let bStr = cstr.substring(with: range)
         var r :UInt64 = 0x0;
         var g :UInt64 = 0x0;
         var b :UInt64 = 0x0;
         Scanner.init(string: rStr).scanHexInt64(&r);
         Scanner.init(string: gStr).scanHexInt64(&g);
         Scanner.init(string: bStr).scanHexInt64(&b);
        return UIColor.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: CGFloat(alpha));
    }
    
    /// 随机颜色
    static func randomColor() -> UIColor {
        let red = CGFloat(arc4random()%256)/255.0
        let green = CGFloat(arc4random()%256)/255.0
        let blue = CGFloat(arc4random()%256)/255.0
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
