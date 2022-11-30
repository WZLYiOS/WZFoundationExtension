//
//  String+MD5.swift
//  WZFoundationExtension_Example
//
//  Created by xiaobin liu on 2020/8/13.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import CommonCrypto
import WZNamespaceWrappable

public extension WZNamespaceWrappable where Base == String {
    
    var md5: String {
        let utf8 = base.cString(using: .utf8)
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5(utf8, CC_LONG(utf8!.count - 1), &digest)
        return digest.reduce("") { $0 + String(format:"%02X", $1) }
    }
}
