//
//  UIDevice+.swift
//  Created on 2022/4/18
//  Description <#文件描述#>
//  PD <#产品文档地址#>
//  Design <#设计文档地址#>
//  Copyright © 2022 WZLY. All rights reserved.
//  @author 邱啟祥(739140860@qq.com)   
//

import Foundation

/// MARK - 扩展
public extension NamespaceWrappable where Base: UIDevice {
    
    /// 退出app
    static func exitApplication() {
        exit(0)
    }
}
