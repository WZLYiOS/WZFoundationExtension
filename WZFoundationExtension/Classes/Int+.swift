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

    
    /// 倒计时方法
    ///
    /// - Parameters:
    ///   - interval: 间隔
    ///   - executing: 执行
    ///   - completion: 完成
    @discardableResult
    func countdown(
        interval: Int,
        executing: @escaping (Int) -> Void,
        completion: @escaping () -> Void) -> DispatchSourceTimer {
        
        let timer = DispatchSource.makeTimerSource()
        timer.schedule(wallDeadline: .now(), repeating: Double(interval))
        var timeout = wrappedValue
        timer.setEventHandler(handler: {
            
            timeout -= interval
            guard timeout >= 1 else {
                timer.cancel()
                DispatchQueue.main.async {
                    completion()
                }
                return
            }
            DispatchQueue.main.async {
                executing(timeout)
            }
        })
        timer.resume()
        return timer
    }
}

