//
//  Double.swift
//  WZLY
//
//  Created by xiaobin liu on 2020/5/23.
//  Copyright © 2020 我主良缘. All rights reserved.
//

import Foundation

/// MARK - Double +
extension Double {
    
    ///四舍五入 到小数点后某一位
    func roundTo(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
