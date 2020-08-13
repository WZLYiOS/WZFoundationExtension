//
//  Bundle+.swift
//  WZFoundationExtension_Example
//
//  Created by xiaobin liu on 2020/8/13.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import Foundation
import WZNamespaceWrappable

/// MARK - Bundle
public extension WZNamespaceWrapper where WrappedType == Bundle {
    
    enum InfoKey: String {
        case shortVersion = "CFBundleShortVersionString"
        case buildVersion = "CFBundleVersion"
    }
    
    subscript<T>(key: InfoKey) -> T {
        guard let value = wrappedValue.infoDictionary?[key.rawValue] as? T else {

            fatalError("资源找不到\(key.rawValue).")
        }
        return value
    }
}
