//
//  PaddedLabel.swift
//  Created by ___ORGANIZATIONNAME___ on 2024/1/22
//  Description <#文件描述#>
//  PD <#产品文档地址#>
//  Design <#设计文档地址#>
//  Copyright © 2024. All rights reserved.
//  @author qiuqixiang(739140860@qq.com)   
//

import UIKit

// 内边距
open class PaddedLabel: UILabel {

    /// 设置内容边距
    public var textContainerInset: UIEdgeInsets = .zero {
        didSet {
            //每次重新设置初始化大小
            invalidateIntrinsicContentSize()
            //重绘
            setNeedsDisplay()
        }
    }
    
    open override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        var rect = super.textRect(forBounds: bounds.inset(by: textContainerInset), limitedToNumberOfLines: numberOfLines)
        rect.origin.x -= textContainerInset.left
        rect.origin.y -= textContainerInset.top
        rect.size.width += textContainerInset.left + textContainerInset.right
        rect.size.height += textContainerInset.top + textContainerInset.bottom
        return rect
    }
        
    open override func drawText(in rect: CGRect) {
        //文本的绘区域不变
        super.drawText(in: rect.inset(by: textContainerInset))
    }
    
}
