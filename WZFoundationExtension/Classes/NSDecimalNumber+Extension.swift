//
//  NSDecimalNumber+Extension.swift
//  WZLY
//
//  Created by qiuqixiang on 2021/10/15.
//  Copyright © 2021 我主良缘. All rights reserved.
//

import Foundation

import WZNamespaceWrappable

extension Decimal: WZNamespaceCompatibleValue { }

// MARK - 资源
extension WZNamespaceWrappable where Base == Decimal {
   
    func price(format: String = "%.2f", unit: Int = 100, isOmit: Bool = true) -> String {
        let num = base/Decimal(unit) as NSNumber
        return isOmit ? num.stringValue : String(format: format, Double(truncating: num))
    }
}

