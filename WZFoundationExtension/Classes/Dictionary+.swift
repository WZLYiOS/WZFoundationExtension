//
//  Dictionary+.swift
//  WZFoundationExtension_Example
//
//  Created by xiaobin liu on 2020/8/13.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import CommonCrypto
import WZNamespaceWrappable


extension Dictionary: WZNamespaceWrappable { }
public extension WZNamespaceWrapper where WrappedType == Dictionary<String, Any> {

    /// 合并
    /// - Parameter other: Dictionary<String, Any>
    /// - Returns: Dictionary<String, Any>
    func merge(_ other: Dictionary<String, Any>) -> Dictionary<String, Any> {
        var newDictionary = other
        for (k ,v) in wrappedValue {
            newDictionary[k] = v
        }
        return newDictionary
    }
}
