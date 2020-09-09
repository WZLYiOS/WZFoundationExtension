//
//  DefaultEnumCodable.swift
//  WZLY
//
//  Created by xiaobin liu on 2019/10/23.
//  Copyright © 2019 我主良缘. All rights reserved.
//

import Foundation


/// MARK - 枚举默认值
public protocol DefaultEnumCodable: RawRepresentable, Codable {
    
    static var defaultCase: Self { get }
}


public extension DefaultEnumCodable where Self.RawValue: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(RawValue.self)
        self = Self.init(rawValue: rawValue) ?? Self.defaultCase
    }
}
