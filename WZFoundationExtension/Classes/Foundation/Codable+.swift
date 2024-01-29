//
//  Codable+.swift
//  Created by ___ORGANIZATIONNAME___ on 2024/1/26
//  Description <#文件描述#>
//  PD <#产品文档地址#>
//  Design <#设计文档地址#>
//  Copyright © 2024. All rights reserved.
//  @author qiuqixiang(739140860@qq.com)   
//

import Foundation
import WZNamespaceWrappable

// MARK - 数据转换
public extension WZNamespaceWrappable where Base == Codable {
    
    /// data数据
    var data: Data? {
        return try? JSONEncoder().encode(base)
    }
    
    /// 转成json数据
    var dic: [String: Any] {
        guard let data = data, let dictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            return [:]
        }
        return dictionary
    }
    
    /// string
    var jsonString: String {
        guard let d = data, let json = String(data: d, encoding: .utf8) else {
            return ""
        }
        return json
    }
}

