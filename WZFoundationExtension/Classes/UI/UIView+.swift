//
//  UIView+.swift
//  Pods-WZUIExtension_Example
//
//  Created by xiaobin liu on 2020/8/21.
//

import UIKit

/// 圆角
public enum WZCornerRadii {
case topLeft(CGFloat)
case topRight(CGFloat)
case bottomLeft(CGFloat)
case bottomRight(CGFloat)
}

/// MARK: - UIView
public extension NamespaceWrappable where Base: UIView {

    /// 设置平滑圆角
    /// - Parameter radius: radius
    func cornerRadius(_ radius: CGFloat) {
        base.layer.cornerRadius = radius
        base.clipsToBounds = true
        if #available(iOS 13, *) {
            base.layer.cornerCurve = .continuous
        } else {
            base.layer.setValue(true, forKey: "continuousCorners")
        }
    }
    
    
    /// 圆角的设置
    /// - Parameters:
    ///   - corners: corners description
    ///   - radius: radius description
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
         let path = UIBezierPath(roundedRect: base.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
         let mask = CAShapeLayer()
         mask.path = path.cgPath
         base.layer.mask = mask
    }
    
    
    /// 切圆角函数绘制线条
    static func createPathWithRoundedRect(bounds:CGRect, topLeft: CGFloat = 0, topRight: CGFloat = 0, bottomLeft: CGFloat = 0, bottomRight: CGFloat = 0) -> CGPath {
        
        //虽然顺时针参数是YES，在iOS中的UIView中，这里实际是逆时针
        let path = CGMutablePath();
        let minX = bounds.minX
        let minY = bounds.minY
        let maxX = bounds.maxX
        let maxY = bounds.maxY
        
        let topLeftCenterX = minX + topLeft
        let topLeftCenterY = minY + topLeft
        path.addArc(center: CGPoint(x: topLeftCenterX, y: topLeftCenterY), radius: topLeft, startAngle: CGFloat.pi, endAngle: CGFloat.pi * 3 / 2, clockwise: false)
        
        let topRightCenterX = maxX - topRight
        let topRightCenterY = minY + topRight
        path.addArc(center: CGPoint(x: topRightCenterX, y: topRightCenterY), radius: topRight, startAngle: CGFloat.pi * 3 / 2, endAngle: 0, clockwise: false)
        
        let bottomRightCenterX = maxX - bottomLeft
        let bottomRightCenterY = maxY - bottomLeft
        //底右
        path.addArc(center: CGPoint(x: bottomRightCenterX, y: bottomRightCenterY), radius: bottomLeft, startAngle: 0, endAngle: CGFloat.pi / 2, clockwise: false)
        
        let bottomLeftCenterX = minX + bottomRight
        let bottomLeftCenterY = maxY - bottomRight
        //底左
        path.addArc(center: CGPoint(x: bottomLeftCenterX, y: bottomLeftCenterY), radius: bottomRight, startAngle: CGFloat.pi / 2, endAngle: CGFloat.pi, clockwise: false)
    
        path.closeSubpath()
        return path
    }
    
    /// 添加4个不同大小的圆角
    func addCorner(topLeft: CGFloat = 0, topRight: CGFloat = 0, bottomLeft: CGFloat = 0, bottomRight: CGFloat = 0) {
       let frame = base.bounds
       let path = UIView.wz.createPathWithRoundedRect(bounds: frame, topLeft: topLeft, topRight: topRight, bottomLeft: bottomLeft, bottomRight: bottomLeft)
       let shapLayer = CAShapeLayer()
       shapLayer.frame = frame
       shapLayer.path = path
        base.layer.mask = shapLayer
    }
    
    /// 移除所有子元素
    func removeAllSubviews() {
        base.subviews.forEach{
            $0.removeFromSuperview()
        }
    }
}

