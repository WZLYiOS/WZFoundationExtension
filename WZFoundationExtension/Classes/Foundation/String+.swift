//
//  String.swift
//  WZLY
//
//  Created by xiaobin liu on 2020/3/6.
//  Copyright © 2020 我主良缘. All rights reserved.
//

import Foundation
import CommonCrypto
import WZNamespaceWrappable

// MARK - 扩展
public extension WZNamespaceWrappable where Base == String {
    
    /// 获取字符串宽高
    /// - Parameters:
    ///   - size: 限制宽度高度
    ///   - font: 字体大小
    func stringSize(width: CGFloat, font: UIFont) -> CGSize {
        return (base as NSString).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesFontLeading, attributes: [NSAttributedString.Key.font: font], context: nil).size
    }
    
    
    /// 字符串转中划线
    var  baselineSingleAttributed: NSMutableAttributedString {
        let text = NSMutableAttributedString(string: base)
        var priceAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.strikethroughStyle:
                                                                NSUnderlineStyle.single.rawValue,
                                                             NSAttributedString.Key.baselineOffset:
                                                                NSUnderlineStyle.single.rawValue]
                
         if #available(iOS 10.3, *) {
            priceAttribute[NSAttributedString.Key.baselineOffset] = 0
         }

        text.setAttributes(priceAttribute, range: NSRange(location: 0, length: base.count))
        return text
    }
    
    /// 匹配字符串
    func range(of: String) -> NSRange {
        return (base as NSString).range(of: of)
    }
    
    /// 添加钱符号
    var cny: String {
        return "¥"+base
    }
    
    // 返回高斯模糊地址
    func blur(radius: Int = 50, sigma: Int = 30) -> String {
        return base + "?imageMogr2/blur/\(radius)x\(sigma)"
    }
    
    /// 转Int
    var intValue: Int {
        return Int(base) ?? 0
    }
    
    ///  字符串装字典
    var dictionary: NSDictionary? {
        guard let jsonData = base.data(using: .utf8),
              let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as? NSDictionary else {
            return nil
        }
        return dict
    }
    
    /// MD5 sha256
    var md5: String {
//        let utf8 = base.cString(using: .utf8)
//        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
//        CC_MD5(utf8, CC_LONG(utf8!.count - 1), &digest)
//        return digest.reduce("") { $0 + String(format:"%02X", $1) }
        guard let data = base.data(using: .utf8) else { return "" }
        var digest = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
        _ = data.withUnsafeBytes { bytes in
            CC_SHA256(bytes.baseAddress, CC_LONG(data.count), &digest)
        }
        let hash = digest.map { String(format: "%02hhx", $0) }.joined()
        return hash
    }
}


