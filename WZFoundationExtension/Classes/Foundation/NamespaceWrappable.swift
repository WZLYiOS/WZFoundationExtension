//
//  NamespaceWrappable.swift
//  Created by ___ORGANIZATIONNAME___ on 2024/3/25
//  Description <#文件描述#>
//  PD <#产品文档地址#>
//  Design <#设计文档地址#>
//  Copyright © 2024. All rights reserved.
//  @author qiuqixiang(739140860@qq.com)   
//

import Foundation
/// MARK - 定义个命名空间
/*
 在对 TypeWrapperProtocol 这个协议做 extension 时， where 后面的 WrappedType 约束可以使用 == 或者 :，两者是有区别的。如果扩展的是值类型，比如 String，Date 等，就必须使用 ==，如果扩展的是类，则两者都可以使用，区别是如果使用 == 来约束，则扩展方法只对本类生效，子类无法使用。如果想要在子类也使用扩展方法，则使用 : 来约束。
 还有一些注意的地方
 对类型扩展实现 NamespaceWrappable 协议，只需要写一次。如果对 UIView 已经写了 NamespaceWrappable 协议实现，则 UILabel 不需要再写。实际上写了之后，编译会报错。
 如果在实现的 func 前加上 static 关键字，可以扩展出静态方法。
 */
public struct NamespaceWrappable<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}
public protocol NamespaceCompatible: AnyObject { }
public protocol NamespaceCompatibleValue {}

extension NamespaceCompatible {
    public var wz: NamespaceWrappable<Self> {
        get { return NamespaceWrappable(self) }
        set { }
    }
    
    public static var wz: NamespaceWrappable<Self>.Type {
        return NamespaceWrappable<Self>.self
    }
}

/// 值类型
extension NamespaceCompatibleValue {
    public var wz: NamespaceWrappable<Self> {
        get { return NamespaceWrappable(self) }
        set { }
    }
    
    public static var wz: NamespaceWrappable<Self>.Type {
            return NamespaceWrappable<Self>.self
    }
}

extension NSObject: NamespaceCompatible { }
extension Int: NamespaceCompatibleValue { }
extension Data: NamespaceCompatibleValue { }
extension Date: NamespaceCompatibleValue { }
extension String: NamespaceCompatibleValue { }
extension Array: NamespaceCompatibleValue { }
extension Bool: NamespaceCompatibleValue { }
extension Dictionary: NamespaceCompatibleValue { }
extension Decimal: NamespaceCompatibleValue { }
