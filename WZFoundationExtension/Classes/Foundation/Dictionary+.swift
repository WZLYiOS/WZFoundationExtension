//
//  Dictionary+.swift
//  WZFoundationExtension_Example
//
//  Created by xiaobin liu on 2020/8/13.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import CommonCrypto

/// 合并协议
public protocol Mergable {
    func merge(withOther:Self) -> Self
}

// MARK: - 字典合并
public extension Dictionary where Value : Mergable {
    func merge(withDictionary: Dictionary) -> Dictionary {
        var returnDictionary = withDictionary
        for (key, value) in self {
            if let withDictionaryValue = withDictionary[key] {
                returnDictionary[key] = value.merge(withOther: withDictionaryValue)
            } else {
                returnDictionary[key] = value
            }
        }
        return returnDictionary
    }
}


extension NamespaceWrappable where Base == Dictionary<AnyHashable, Any> {
    
    /// 转string
    var stringValue: String {
        if let jsonData = try? JSONSerialization.data(withJSONObject: base, options: []),
           let json = String(data: jsonData, encoding: .utf8) {
            return json
        }
        return ""
    }
    
    /// 合并
    func merge(withDictionary: Dictionary<AnyHashable, Any>) -> Dictionary<AnyHashable, Any> {
        var returnDictionary = withDictionary
        base.keys.forEach {returnDictionary[$0] = base[$0]}
        return returnDictionary
    }
}
