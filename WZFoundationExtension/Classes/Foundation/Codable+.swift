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

// MARK - 数据转换
public extension Encodable {
    
    func toData() -> Data? {
        let encoder = JSONEncoder()
        return try? encoder.encode(self)
    }
    
    func toString() -> String {
        guard let d = toData(), let json = String(data: d, encoding: .utf8) else {
            return ""
        }
        return json
    }
    
    func toDic() -> [String: Any] {
        guard let data = toData(), let dictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            return [:]
        }
        return dictionary
    }
}

