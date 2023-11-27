//
//  WZCAGradientView.swift
//  Created on 2022/12/8
//  Description <#文件描述#>
//  PD <#产品文档地址#>
//  Design <#设计文档地址#>
//  Copyright © 2022 WZLY. All rights reserved.
//  @author 邱啟祥(739140860@qq.com)   
//

import UIKit

/// 渐变视图
open class WZCAGradientView: UIView {
    
    private var topLeft: CGFloat = 0
    private var topRight: CGFloat = 0
    private var bottomLeft: CGFloat = 0
    private var bottomRight: CGFloat = 0
   
    /// 圆角
    private lazy var shapeLayer: CAShapeLayer = {
        return $0
    }(CAShapeLayer())
    
    /// 渐变层
    public lazy var gradientLayer: CAGradientLayer = {
        return $0
    }(CAGradientLayer())
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    /// 添加不同圆角
    public func addCorner(topLeft: CGFloat = 0, topRight: CGFloat = 0, bottomLeft: CGFloat = 0, bottomRight: CGFloat = 0) {
        self.topLeft = topLeft
        self.topRight = topRight
        self.bottomLeft = bottomLeft
        self.bottomRight = bottomRight
        gradientLayer.mask = shapeLayer
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = self.bounds
        if ((gradientLayer.mask as? CAShapeLayer) != nil) {
            shapeLayer.frame = self.bounds
            shapeLayer.path = UIView.wz.createPathWithRoundedRect(bounds: bounds,
                                                                  topLeft: topLeft,
                                                                  topRight: topRight,
                                                                  bottomLeft: bottomLeft,
                                                                bottomRight: bottomRight)
        }
        
    }
}

