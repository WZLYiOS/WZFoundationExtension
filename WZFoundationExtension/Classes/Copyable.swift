//
//  Copyable.swift
//  WZLY
//
//  Created by xiaobin liu on 2021/11/17.
//  Copyright © 2021 我主良缘. All rights reserved.
//

import Foundation

public protocol Copyable {
    func wzCopy() -> Self
}

// MARK: - Codable
extension Copyable where Self: Codable {
    
    func wzCopy() -> Self {
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(self) else {
            fatalError("encode失败")
        }
        let decoder = JSONDecoder()
        guard let target = try? decoder.decode(Self.self, from: data) else {
           fatalError("decode失败")
        }
        return target
    }
}

