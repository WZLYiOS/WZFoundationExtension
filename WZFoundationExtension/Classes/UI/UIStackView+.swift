//
//  UIStackView+.swift
//  Created by ___ORGANIZATIONNAME___ on 2023/12/18
//  Description <#文件描述#>
//  PD <#产品文档地址#>
//  Design <#设计文档地址#>
//  Copyright © 2023. All rights reserved.
//  @author qiuqixiang(739140860@qq.com)   
//

import Foundation

/// MARK: - UIStackView
public extension NamespaceWrappable where Base: UIStackView {
    
    /// 添加视图
    func addSubviews(_ list: [UIView]) {
        base.arrangedSubviews.forEach{
            $0.removeFromSuperview()
        }
        list.forEach {
            base.addArrangedSubview($0)
        }
    }
}
