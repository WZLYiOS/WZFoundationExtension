//
//  URL+.swift
//  WZLY
//
//  Created by qiuqixiang on 2021/3/1.
//  Copyright © 2021 我主良缘. All rights reserved.
//

import Foundation

extension URL {

    var monkeykingQueryDictionary: [String: String] {
        guard
            let components = URLComponents(url: self, resolvingAgainstBaseURL: false),
            let queryItems = components.queryItems
        else {
            return [:]
        }
        let items = queryItems.compactMap { $0.value != nil ? ($0.name, $0.value!) : nil }
        let dict = Dictionary(items, uniquingKeysWith: { _, last in last })
        return dict
    }
}


extension URLComponents {

    func valueOfQueryItem(_ itemName: String) -> String? {
        queryItems?.first(where: { $0.name == itemName })?.value
    }
}



/// MARK - 扩展
public extension NamespaceWrappable where Base == URL {
    
    /// 获取url里参数
    var queryItemValues: [String: String] {
        guard let components = URLComponents(string: base.absoluteString), let queryItems = components.queryItems else {
            return [:]
        }
        var dic: [String: String] = [:]
        for item in queryItems {
            dic[item.name] = item.value
        }
        return dic
    }
}


