//
//  Bool+.swift
//  WZLY
//
//  Created by qiuqixiang on 2021/8/5.
//  Copyright © 2021 我主良缘. All rights reserved.
//

import Foundation

// MARK - 扩展
public extension NamespaceWrappable where Base == Bool {
    /// bool 值转Int
    var intValue: Int {
        return base == false ? 0 : 1
    }
}


