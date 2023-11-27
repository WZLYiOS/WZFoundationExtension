//
//  WZGradientButton.swift
//  Created on 2022/12/8
//  Description <#文件描述#>
//  PD <#产品文档地址#>
//  Design <#设计文档地址#>
//  Copyright © 2022 WZLY. All rights reserved.
//  @author 邱啟祥(739140860@qq.com)   
//

import UIKit

// MARK - 渐变视图
open class WZGradientButton: UIButton {

    /// 默认
    public lazy var nomarLayer: CAGradientLayer = {
        return $0
    }(CAGradientLayer())
    
    /// 选择
    public lazy var selectLayer: CAGradientLayer = {
        return $0
    }(CAGradientLayer())
    
    override open var isSelected: Bool {
        didSet {
            nomarLayer.isHidden = isSelected
            selectLayer.isHidden = !isSelected
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.addSublayer(selectLayer)
        layer.addSublayer(nomarLayer)
    }
        
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        nomarLayer.frame = bounds
        selectLayer.frame = bounds
    }
}

