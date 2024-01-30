//
//  UIControl+.swift
//  Created on 2022/1/20
//  Description <#文件描述#>
//  PD <#产品文档地址#>
//  Design <#设计文档地址#>
//  Copyright © 2022 WZLY. All rights reserved.
//  @author 邱啟祥(739140860@qq.com)   
//

import Foundation
import WZNamespaceWrappable

/// 存储位置
private struct WZControlAssociatedKey {
    static var identifier: String = "com.wzly.UIControl.area.edge.key"
}

/// 扩展
public extension WZNamespaceWrappable where Base: UIControl {
    
    /// 响应边界
    var enarlgeAreEdge: UIEdgeInsets? {
        get {
            return objc_getAssociatedObject(base, WZControlAssociatedKey.identifier) as? UIEdgeInsets
        }
        set {
            objc_setAssociatedObject(base, WZControlAssociatedKey.identifier, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// 设置响应区域
    mutating func setEnlargeEdge(_ edge: CGFloat) {
        enarlgeAreEdge = UIEdgeInsets(top: edge, left: edge, bottom: edge, right: edge)
    }
    
    // 判断是否响应
    func getPoint(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let edge = enarlgeAreEdge ?? UIEdgeInsets.zero
        let area = CGRect.init(x: base.bounds.origin.x - edge.left, y: base.bounds.origin.y - edge.top, width: base.bounds.size.width + edge.left + edge.right, height: base.bounds.size.height + edge.top + edge.bottom)
        return area.contains(point)
    }
}

/// MARK - 扩展重写响应区域
extension UIControl {

    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if self.wz.enarlgeAreEdge == nil {
            return super.point(inside: point, with: event)
        }
        return self.wz.getPoint(inside: point, with: event)
    }
}
